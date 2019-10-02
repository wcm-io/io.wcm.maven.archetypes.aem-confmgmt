@Grab(group='io.wcm.devops.conga.plugins', module='conga-aem-crypto-cli', version='1.8.14')
import groovy.io.FileType
import java.util.regex.Pattern
import java.util.regex.Matcher
import java.nio.file.Files
import java.nio.file.StandardCopyOption
import io.wcm.devops.conga.plugins.aem.tooling.crypto.cli.CryptoKeys
import io.wcm.devops.conga.plugins.aem.tooling.crypto.cli.AnsibleVault

def rootDir = new File(request.getOutputDirectory() + "/" + request.getArtifactId())
def defaultFileReferenceDir = new File(request.getOutputDirectory())


// read parameters
def configurationManagementName = request.getProperties().get("configurationManagementName");
def ansibleVaultPassword = request.getProperties().get("ansibleVaultPassword");
def sshPublicKeyFile = request.getProperties().get("sshPublicKeyFile");
def aemLicensePropertiesFile = request.getProperties().get("aemLicensePropertiesFile");
def optionVagrant = request.getProperties().get("optionVagrant")
def optionTerraform = request.getProperties().get("optionTerraform")
def optionAnsible = request.getProperties().get("optionAnsible")

// validate parameters - throw exceptions for invalid combinations
if (optionVagrant == "y" && optionAnsible != "y") {
  throw new RuntimeException("Parameter optionVagrant='y' requires optionAnsible='y'.")
}


// remove root pom - not required
assert new File(rootDir, "pom.xml").delete()


if (optionAnsible == "y") {

  // copy AEM license file to ansible folder
  def aemLicensePropertiesFileObject = new File(defaultFileReferenceDir, aemLicensePropertiesFile);
  if (!aemLicensePropertiesFileObject.exists()) {
    throw new RuntimeException("aemLicensePropertiesFile not found in file system: " + aemLicensePropertiesFileObject.getCanonicalPath())
  }
  def aemLicensePropertiesFileContent = aemLicensePropertiesFileObject.getText("UTF-8");
  def targetFile = new File(rootDir, "ansible/files/license.properties")
  targetFile.newWriter("UTF-8").withWriter { w ->
    w << aemLicensePropertiesFileContent
  }

  // generate AEM crypto keys
  def cryptoKeysDir = new File(rootDir, "configuration/src/main/resources/crypto")
  cryptoKeysDir.mkdirs()
  CryptoKeys.generate(cryptoKeysDir, true, ansibleVaultPassword).forEach {}

  // encrypt senstive files with ansible vault
  AnsibleVault.encrypt(new File(rootDir, "ansible/files/license.properties"), ansibleVaultPassword)
  AnsibleVault.encrypt(new File(rootDir, "ansible/group_vars/all/vault_credentials.yml"), ansibleVaultPassword)

}


if (optionTerraform == "y") {

  // get SSH public key from keyfile and store it in terraform definition
  def sshPublicKeyFileObject = new File(defaultFileReferenceDir, sshPublicKeyFile);
  if (!sshPublicKeyFileObject.exists()) {
    throw new RuntimeException("sshPublicKeyFile not found in file system: " + sshPublicKeyFileObject.getCanonicalPath())
  }
  def sshPublicKey = sshPublicKeyFileObject.getText("UTF-8").trim();
  File keyParFile = new File(rootDir, "terraform/modules/global/key_pair/main.tf")
  def keyParFileContent = keyParFile.getText("UTF-8")
  keyParFileContent = keyParFileContent.replaceAll(Pattern.quote('${sshPublicKeyString}'), Matcher.quoteReplacement(sshPublicKey))
  keyParFile.newWriter("UTF-8").withWriter { w ->
    w << keyParFileContent
  }

  assert new File(rootDir, "ansible/inventory/dev").delete()
  assert new File(rootDir, "ansible/inventory/prod").delete()

}


// remove Terraform AWS files if not required
if (optionTerraform == "n") {
  assert new File(rootDir, "terraform").deleteDir()

  assert new File(rootDir, "ansible/inventory/ec2.ini").delete()
  assert new File(rootDir, "ansible/inventory/ec2.py").delete()
  assert new File(rootDir, "ansible/group_vars/ec2").deleteDir()
  assert new File(rootDir, "vagrant/shared/credentials.default").delete()
}
else {
  // set executable flag on ec2.py
  assert new File(rootDir, "ansible/inventory/ec2.py").setExecutable(true, false)
}

// remove Vagrant files if not required
if (optionVagrant == "n") {
  assert new File(rootDir, "vagrant").deleteDir()
  assert new File(rootDir, "ansible/group_vars/local/vagrant.yml").delete()
}

// remove Ansible files if not required
if (optionAnsible == "n") {
  assert new File(rootDir, "ansible").deleteDir()
}


// convert all line endings to unix-style
rootDir.eachFileRecurse(FileType.FILES) { file ->
  if (file.name =~ /(\.(cfg|conf|config|css|dtd|esp|ecma|groovy|hbrs|hbs|htm|html|java|jpage|js|json|jsp|md|mustache|tld|launch|log|php|pl|project|properties|props|py|sass|scss|sh|shtm|shtml|sql|svg|tf|txt|vm|xml|xsd|xsl|xslt|yml|yaml|ini|default)|local|Vagrantfile)$/) {
    def fileContent = file.getText("UTF-8").replaceAll('\r\n', '\n')
    file.newWriter("UTF-8").withWriter { w ->
      w << fileContent
    }
  }
}

// rename root folder
def newRootDir = new File(request.getOutputDirectory() + "/" + configurationManagementName)
Files.move(rootDir.toPath(), newRootDir.toPath(), StandardCopyOption.REPLACE_EXISTING)
assert newRootDir.exists()
