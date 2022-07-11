#!/bin/bash

echo -n "Is Golang Installed (command : go version)  (y/n)? "
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    	echo "Staring Installation"
    	present_dir=pwd
	echo "findomain installing"

	cd $present_dir/
	mkdir tools
	cd tools/

	echo "Findomain Installing"
	mkdir findomain
	cd findomain
	wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
	chmod +x findomain-linux
	cd ..

	echo "Amass Installing"
	mkdir amass
	cd amass
	wget https://github.com/OWASP/Amass/releases/download/v3.19.2/amass_linux_amd64.zip -O amass.zip
	unzip amass.zip
	chmod +x amass_linux_amd64/amass
	ln -s $present_dir/tools//amass/amass_linux_amd64/amass /usr/bin/amass 
	cd ..

	echo "Subfinder Installing"
	mkdir subfinder
	cd subfinder
	wget https://github.com/projectdiscovery/subfinder/releases/download/v2.5.1/subfinder_2.5.1_linux_amd64.zip -O subfinder.zip
	unzip subfinder.zip
	chmod +x subfinder
	ln -s $present_dir/tools/subfinder/subfinder /usr/bin/subfinder
	cd ..

	echo "Assetfinder Installing"
	mkdir assetfinder
	cd assetfinder
	wget https://github.com/tomnomnom/assetfinder/releases/download/v0.1.1/assetfinder-linux-amd64-0.1.1.tgz -O assetfinder.tgz
	tar zxvf assetfinder.tgz
	chmod +x assetfinder
	ln -s $present_dir/tools/assetfinder/assetfinder /usr/bin/assetfinder
	cd ..

	echo "Sublist3r Installing"
	git clone https://github.com/aboul3la/Sublist3r.git
	cd Sublist3r
	pip3 install -r requirements.txt
	cd ..
	
	echo "Anubis Installing"
	sudo apt-get install python3-pip python-dev libssl-dev libffi-dev -y
	pip3 install anubis-netsec
	
	echo "DNSX Installing"
	mkdir dnsx
	cd dnsx
	wget https://github.com/projectdiscovery/dnsx/releases/download/v1.1.0/dnsx_1.1.0_linux_amd64.zip -O dnsx.zip
	unzip dnsx.zip
	chmod +x dnsx
	ln -s $present_dir/tools/dnsx/dnsx /usr/bin/dnsx
	cd ..
	
	echo "HTTPX Installing"
	mkdir httpx
	cd httpx
	wget https://github.com/projectdiscovery/httpx/releases/download/v1.2.1/httpx_1.2.1_linux_amd64.zip -O httpx.zip
	unzip httpx.zip
	chmod +x httpx
	ln -s $present_dir/tools/httpx/httpx /usr/bin/httpx
	cd ..
	
	echo "Installing jq"
	apt-get install jq -y
else
	echo "Install Golang First"
fi
