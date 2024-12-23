#!/bin/bash

usage() {
    echo "Usage: $0 -u <domain>"
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

while getopts ":u:" opt; do
    case ${opt} in
        u )
            domain=$OPTARG
            ;;
        \? )
            echo "Invalid option: $OPTARG" 1>&2
            usage
            ;;
        : )
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

if [ -z "$domain" ]; then
    echo "Domain is required"
    usage
fi

echo "[+] Step 1: Searching subdomains for $domain..."
assetfinder -subs-only "$domain" | uniq | sort > "$domain"
subfinder -d "$domain" -silent | sort -u >> "$domain"
sort -u "$domain" -o "$domain" # Keep only unique entries
echo "[+] Subdomains saved to $domain."

echo "[+] Step 2: Checking for live subdomains using httpx-toolkit..."
httpx-toolkit -l "$domain" -ports 80,443,8000,8080,8888 -threads 200 | \
sort -u | grep -Ev '\.[0-9]+$' > "$domain.tmp"
mv "$domain.tmp" "$domain" # Replace with final filtered results
echo "[+] Final live subdomains (excluding duplicates and numeric endings) saved to $domain."
