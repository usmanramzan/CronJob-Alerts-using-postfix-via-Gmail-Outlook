#!/bin/bash

# Installing mailutils
sudo apt-get install -y mailutils

# Configuring and Installing Postfix
sudo debconf-set-selections <<< "postfix postfix/mailname string $HOSTNAME"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get install -y postfix

# for google 
#echo "[smtp.gmail.com]:587    inemail@domain.com:password" | sudo tee /etc/postfix/sasl/sasl_passwd

# for outlook you need to have a office365 account
echo "[smtp.office365.com]:587    email@domain.com:password" | sudo tee /etc/postfix/sasl/sasl_passwd
sudo postmap /etc/postfix/sasl/sasl_passwd
sudo chmod 600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db

# for gmail
#sudo sed -i '/relayhost =/c\relayhost = [smtp.gmail.com]:587' /etc/postfix/main.cf

# for outlook
sudo sed -i '/relayhost =/c\relayhost = [smtp.office365.com]:587' /etc/postfix/main.cf
echo "
# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" |sudo tee --append /etc/postfix/main.cf
sudo systemctl restart postfix

mail -s  "Testing Postfix" recipientemail < /dev/null
