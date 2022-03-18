#!/bin/bash

function helpPanel() {
	echo "Usage ./autoScan.sh -i <ip>"
}

function main() {
	tput civis
	ports=$(nmap -p- --min-rate=1000 -T4 $host_ip | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
	nmap -p$ports -sC -sV -oN fullScan $host_ip
}

declare -i parameter_counter=0; while getopts ":i:h" arg; do
		case $arg in
			i) host_ip=$OPTARG; let parameter_counter+=1;;
			h) helpPanel;;
		esac
	done

	if [ $parameter_counter -lt 1 ]; then
		helpPanel
	else
		main
		tput cnorm
	fi
