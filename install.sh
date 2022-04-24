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
	go install -v github.com/OWASP/Amass/v3/...@master

	echo "Subfinder Installing"
	go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

	echo "Assetfinder Installing"
	go get -u github.com/tomnomnom/assetfinder

	echo "Sublist3r Installing"
	git clone https://github.com/aboul3la/Sublist3r.git
	cd Sublist3r
	pip3 install -r requirements.txt
	cd ..
	
	echo "Anibus Installing"
	sudo apt-get install python3-pip python-dev libssl-dev libffi-dev
	pip3 install anubis-netsec
	
	echo "DNSX Installing"
	go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
	
	echo "HTTPX Installing"
	go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
else
	echo "Install Golang First"
fi
