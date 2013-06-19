# One-liners (and other misc commands)
These are a collection of one-liners and other various commands that I've found useful at one point or another.

## List top 10 processes by percent of physical memory used
    ps aux | awk '{print $4 " " $2 " " $1 " " $11}' | uniq -c | awk '{print $2 "%\t" $3 "\t" $4 "\t" $5}' | sort -nr | head -n 10

## List top 10 processes by percent of CPU used
     ps aux | awk '{print $3 " " $2 " " $1 " " $11}' | uniq -c | awk '{print $2 "%\t" $3 "\t" $4 "\t" $5}' | sort -nr | head -n 10

## List all users' crontabs
    for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l; echo; done

## Print users (except root) with UID 0 or GID 0
    perl -lne 'print if $_ =~ /:0:/;' /etc/passwd | grep -v 'root'

## Copy SSH public key to a remote machine without ssh-copy-id (e.g. Mac OS X)
    cat ~/.ssh/id_rsa.pub | ssh user@machine "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"

## Generate 2048-bit CSR for Apache
    openssl req -new -newkey rsa:2048 -nodes -keyout fqdn.key -out fqdn.csr

## Remove password from private key
    openssl rsa -in priv.key.pem -out priv_nopass.key.pem

## Read and write SNMP
    snmpwalk -c read_community -v 1 [IP or hostname] [OID]
    snmpset -c write_community -v 1 [IP or hostname] sysLocation.0 string [value]

## Find and remove '\*.log' files older than 7 days
    find . -type f -name '*.log' -mtime +7 -exec rm -f {} \;

## Cisco IOS - list all interfaces and any ints with input errors
    sh int | in protocol | [1-9]+ input errors
