# check_server_scripts

This is the repository for checking health of some servers of ynu

### About this project

This repository contains some scripts for checking health of servers of yunnan university

### How to use

These operation can only be excuted by the adminstrators.

```bash
git clone https://github.com/ynu/check_server_scripts.git
cd check_server_scripts
# Use ssh-copy-id to config the client to access the server via PubkeyAuthentication
......
# check dns
./check_dns.sh
# check mail
./check_mail.sh
# check elearning
./check_elearning.sh
```

### License
GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007, http://www.gnu.org/licenses/