import subprocess

# Install Postfix and Dovecot
subprocess.run(["sudo", "apt", "update"])
subprocess.run(["sudo", "apt", "install", "postfix", "dovecot-imapd"])

# Configure Postfix
postfix_config = """\n
myorigin = bashaway2k23.net
inet_interfaces = all
mydestination = bashaway2k23.net, localhost
"""
with open('/etc/postfix/main.cf', 'a') as config_file:
    config_file.write(postfix_config)

# Configure Dovecot
dovecot_config = """\n
protocols = imap
mail_location = maildir:/var/mail/vhosts/%d/%n
"""
with open('/etc/dovecot/dovecot.conf', 'a') as config_file:
    config_file.write(dovecot_config)

# Create Mailbox Directory
subprocess.run(["sudo", "mkdir", "-p", "/var/mail/vhosts/bashaway2k23.net/inventor/Maildir"])
subprocess.run(["sudo", "chown", "-R", "vmail:vmail", "/var/mail"])

# Create Email Account
subprocess.run(["sudo", "doveadm", "user", "-c", "/etc/dovecot/dovecot.conf", "-a", "inventor@bashaway2k23.net"])

# Send the Email
email_content = "Technology knows no bounds"
subprocess.run(["echo", f"'{email_content}'", "|", "mail", "-s", "'Tech Baron's Email'", "inventor@bashaway2k23.net"])

# Restart Dovecot and Postfix
subprocess.run(["sudo", "systemctl", "restart", "dovecot"])
subprocess.run(["sudo", "systemctl", "restart", "postfix"])
