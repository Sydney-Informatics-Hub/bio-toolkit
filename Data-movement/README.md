# Scripts for moving data to and from USyd RDS and National HPCs 

* Transfer between Usyd RDS and NCI Gadi
* Transfer between USyd RDS and Pawsey Nimbus
* Transfer between scratch and gdata on NCI Gadi 

## A note on passwordless transfers 

### SSH keys for HPC transfers 

The data transfer queue on Gadi is called ‘copyq’. You can easily use this queue to transfer data between Gadi and RDS (or other locations) by first setting up ssh keys for password-less transfers between Gadi and Artemis/RDS.

For transfer of large files, the use of ‘resumable’ rsync is recommended. As the USyd RDS servers only allow sftp connections, this method is not possible to run on Gadi’s copyq. Instead, the transfer can be initiated using Artemis ‘dtq’ and using Gadi’s ‘data mover’ node: `gadi-dm.nci.org.au`.

SSH key pairs are used for secure communication between two systems. The pair consists of a **private** key and a **public** key. The **private** key should remain private and only be known by the user. It is stored securely on the user's computer. The **public** key can be shared with any system the user wants to connect to. It is added to the remote system's authorized keys. When a connection is attempted, the remote system uses the public key to create a message for the user's system.

We will set up SSH keys to allow us to move data between USyd's HPC and RDS and Gadi. **You only need to do this once**.

1. Log into Gadi with your chosen method, e.g: 

```bash
ssh ab1234@gadi.nci.org.au
```

2. Move to your home directory: 

```bash
cd ~
```

3. Make a `.ssh` directory, if you don't already have one: 

```bash
mkdir -p .ssh 
```

4. Set suitable permissions for the `.ssh` directory and move into it:

```bash
chmod 700 .ssh
cd .ssh
```

5. Generate SSH key pair: 

```bash
ssh-keygen
```
Hit enter when prompted, saving the key in `~/.ssh/id_rsa` and enter for NO passphrase. A public key will be located in `~/.ssh/id_rsa.pub` and a private key in `~/.ssh/id_rsa`.

6. Set suitable permissions for the keys:

```bash
chmod 600 id_rsa
chmod 644 id_rsa.pub
```

7. Make an `authorized_keys` file if you don't already have one that can be transferred to USyd's Artemis/RDS system: 

```bash
touch -p ~/.ssh/authorized_keys
```

8. Copy the contents of the public key file (`~/.ssh/id_rsa.pub`) to the `authorized_keys` file to be transferred to USyd's Artemis/RDS system: 

```bash
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

9. Set permissions for the `authorized_keys` file to be transferred to USyd's Artemis/RDS system: 

```bash
chmod 600 ~/.ssh/authorized_keys
```

10. Connect to USyd's Artemis/RDS system using sftp and your unikey:

```bash
sftp <unikey>@research-data-ext.sydney.edu.au
```

Provide your password when prompted. Then make and move into a `.ssh` directory if you don't already have one: 

```bash
mkdir -p ~/.ssh
cd ~/.ssh
```

11. Transfer the `authorized_keys` file from Gadi to USyd's Artemis/RDS system: 

```bash 
put authorized_keys
```

Doing this will transfer authorized_keys on Gadi to your current directory. With sftp, it will look for the file relative to where you launched sftp. You can check where you are on Gadi using:

```bash
lls
```

12. Exit your sftp connection to USyd's Artemis/RDS system `ctrl + z` and test the passwordless connection: 

```bash
sftp <unikey>@research-data-ext.sydney.edu.au
```

This time, you shouldn't be prompted for a password. You can proceed to transfer data between Gadi and USyd's Artemis/RDS system now on the `copyq`. 

### Pem keys for Nimbus transfers 

* [Nimbus data transfer documentation](https://pawsey.atlassian.net/wiki/spaces/US/pages/51928050/Transfer+Your+Data)

When you create a new instance on Nimbus, you will be given a `.pem` key. This key is used to authenticate your connection to the instance. You can use this key to transfer data between your local machine (and Artemis/RDS) and the instance.