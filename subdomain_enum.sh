#!/bin/bash

print_usage() {
  printf "Usage: ./sub -d domain"
}

name=''
while getopts 'd:' flag; do
case "${flag}" in
    d) name="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [[ $name == "" ]]; then
    echo "You must provide a -d tag";
    exit 1;
fi


presert_dir=pwd

echo "site name : $name"

mkdir $name

cd $name

mkdir subdomains

echo "finddomain Started...."

$presert_dir/tools/finddomain/findomain-linux --output --target $name

cat $name.txt >> subdomains/finddomainResult.txt

rm $name.txt

echo "Amass Started"

amass enum -passive -d $name -o subdomains/AmassResult.txt

echo "subfinder Started...."

subfinder -d $name -o subdomains/SubFinderResult.txt

echo "assetfinder Started...."

assetfinder --subs-only $name >> subdomains/assetfinderResult.txt

echo "Sublist3r Started...."

python3 $presert_dir/tools/Sublist3r/sublist3r.py -d  $name -o subdomains/Sublist3rResult.txt

echo "Curling Started...."

curl -s "http://web.archive.org/cdx/search/cdx?url=*.$name/*&output=text&fl=original&collapse=urlkey" | sed -e 's_https*://__' -e "s/\/.*//" | sort -u | tee subdomains/WaybackSub.txt

curl -s https://dns.bufferover.run/dns?q=.$name |jq -r .FDNS_A[]|cut -d',' -f2|sort -u | tee subdomains/BufferSub.txt

echo "Anibus Started...."

anubis -t $name |  grep "$name" | grep -v "Searching for"| tee subdomains/AnubisSub.txt

echo "Curling Started Again...."

curl -s "https://riddler.io/search/exportcsv?q=pld:$name" | grep -Po "(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u | tee subdomains/RiddlerSubs.txt

curl -s "https://crt.sh/?q=%25.$name&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee subdomains/crtSub.txt

curl -s "https://rapiddns.io/subdomain/$name?full=1#result" | grep "<td><a" | cut -d '"' -f 2 | grep http | cut -d '/' -f3 | sed 's/#results//g' | sort -u | tee subdomains/RapidSub.txt

echo "Compiling all subdomains..."

cat subdomains/*.txt |sort -u | grep $name | tee RawSub.txt

echo "Finding Live Subdomains Started...."

cat RawSub.txt | dnsx -resp -a -aaaa -cname -mx -ns -soa -txt | tee dnsInfo.txt

cat RawSub.txt | httpx | egrep -v "80|443" | sort -u | tee LiveSub.txt

echo "Everything Finished"
