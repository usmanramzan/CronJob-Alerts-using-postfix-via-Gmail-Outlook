# CronJob-Failure-Alerts-using-Gmail-Outlook-Ubuntu
This Repository guides you how to setup cron job failure alert by sending an email. This method is tested on Ubuntu for both Gmail and Outlook

Enter  the following command in the terminal

    crontab -e
You will be prompted with a choice to select a text editor for editing. After selecting the editor you will redirected to the crontab entry file.
Using the following line as a template you can setup a alerts for an a script that is setup in the cron job.

 

    * * * * * /bin/sh /home/usman/Desktop/Scripts/demo.sh > ~/job_fail.log 2>&1 ||  mail -s "Cron Job Failed" "recipient email" < ~/job_fail.log 

The above entry sends an email to the recipient email when the specified script fails. You can change the alert type and receive email for every cron job execution of the script by changing the **>**  redirection options. You can read more about redirection [here](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-3.html)

# Postfix Installation

Use the **postfix.sh** script to install and configure the postfix for sending the email. You'll need to run the script with **sudo** privileges. Before executing the script make sure that you change the respective email and password options.
