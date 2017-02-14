#!/usr/bin/sh
export https_proxy=jp-proxy.jp.oracle.com:80

curl_one () {
    curl --silent --insecure "https://oradocs-corp.documents.us2.oraclecloud.com/documents/api/1.1/folders/"$1"/items" \
	 -H "Authorization: Bearer $2" |
	jq -r '.items[] | .type+" "+.id+" "+.size+" "+.name' | dos2unix | sort |
	while read type id size name; do
	    if [ $type = 'file' ]; then
		printf "%8s  " $size && echo "$name"
	    elif [ $type = 'folder' ]; then
		name="$3>$name"
		echo "Folder: $name"
		curl_one $id $2 $name
		echo ""
	    fi
	done
}

curl_one $1 $2 ""
