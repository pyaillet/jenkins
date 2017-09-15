def instance = jenkins.model.Jenkins.getInstance()
def userName = "admin"
def password = "password"

def hudsonRealm = new hudson.security.HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(userName, password)
instance.setSecurityRealm(hudsonRealm)
instance.save()