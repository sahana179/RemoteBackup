# RemoteBackup

### To create ssh connection between two servers follow the following steps. 

#### 1.Generate the SSH key on the source machine::
`ssh-keygen -t rsa -b 4096`

#### 2.Copy the generated public key
`cat ~/.ssh/id_rsa.pub`

#### 3.Login to Remote/Destination machine
`cd .ssh/`

#### 4.Append the copied public key to `authorized_keys` file

#### 5.Change permissions of the `authorized_keys` file to `644`
`chmod 644 authorized_keys`

#### 6.Go to source machine and create a "$HOME/.ssh/config" file and add the following content
**NOTE** Replace the values accordingly

```
host <some-name-to-remote>
hostname <remote-IP>
user <remote-user>
IdentityFile ~/.ssh/rsync.key
```

#### 7.Test the connecting by running the command on Source Machine
`ssh <some-name-to-remote>`

#### 8.Replace the given host name in the script to the variable BACKUP_HOST


### To backcup the files at every scheduled time, set up a cron job for it. Steps to follow.

#### 1.Place the backup script(backup.sh) in the /opt location of source machine.

#### 2.Run the 'cron.sh' script to configure the crontab. You can change the cron execution time in the `cron.sh` file.
**NOTE** The cron.sh will setup the cron job to run at midnight automatically.
