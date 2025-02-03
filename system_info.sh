#!/bin/bash

# Skript pro zji�t�n� informac� o opera�n�m syst�mu

echo "======= Informace o syst�mu ======="

# N�zev stroje
echo "N�zev stroje: $(hostname)"

# Verze OS a distribuce
if [ -f /etc/os-release ]; then
  source /etc/os-release
  echo "Opera�n� syst�m: $PRETTY_NAME"
else
  echo "Opera�n� syst�m: Nelze zjistit"
fi

# Verze j�dra
echo "Verze j�dra: $(uname -r)"

# Architektura
echo "Architektura: $(uname -m)"

# Doba b�hu syst�mu
echo -n "Doba od spu�t�n�: "
uptime -p | sed 's/up //'

# Procesor
echo "Procesor: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | sed 's/^ //')"
echo "Po�et jader: $(nproc)"

# Vyu�it� pam�ti
echo "Pam� RAM:"
free -h | grep Mem | awk '{print "Celkem: " $2 ", Vyu�ito: " $3 ", Voln�: " $4}'

# M�sto na disku
echo -e "\nM�sto na disc�ch:"
df -h --output=source,target,pcent,avail | grep -v 'tmpfs\|udev\|loop'

# S�ov� rozhran�
echo -e "\nS�ov� rozhran�:"
ip -brief address | awk '{print $1 " | IP: " $3}'

# P�ihl�en� u�ivatel�
echo -e "\nAktivn� u�ivatel�:"
who

# N�ro�n� procesy
echo -e "\nNejn�ro�n�j�� procesy (CPU):"
ps aux --sort=-%cpu | head -n 6 | awk '{print $1, $2, $3"%", $4"%", $11}' | column -t