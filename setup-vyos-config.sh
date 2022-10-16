#!/bin/bash
source /opt/vyatta/etc/functions/script-template
configure
set interface ethernet eth0 desc "Connecting to Host thru NAT"
set system syslog host 10.0.0.101 port 514
set system syslog host 10.0.0.101 facility syslog level notice
set protocols static route 0.0.0.0/0 next-hop <host-ip>

# I copy pasta this, hope it works, will test at later date
set firewall name protect-vyatta rule 2 action drop
set firewall name protect-vyatta rule 2 destination port 22
set firewall name protect-vyatta rule 2 protocol tcp
set firewall name protect-vyatta rule 2 recent count 3
set firewall name protect-vyatta rule 2 recent time 300
set firewall name protect-vyatta rule 2 state new enable
commit
exit
