LOGFILE=./config.log

export PATH=$PATH:./bin/

echo "--" >> $LOGFILE
echo "Reason: $reason" >> $LOGFILE
echo "TUNDEV: $TUNDEV" >> $LOGFILE
echo "VPNGATEWAY: $VPNGATEWAY" >> $LOGFILE
echo "INTERNAL_IP4_MTU: $INTERNAL_IP4_MTU" >> $LOGFILE
echo "CISCO_BANNER: $CISCO_BANNER" >> $LOGFILE
echo "CISCO_DEF_DOMAIN: $CISCO_DEF_DOMAIN" >> $LOGFILE
echo "CISCO_SPLIT_DNS: $CISCO_SPLIT_DNS" >> $LOGFILE
echo "CISCO_SPLIT_INC: $CISCO_SPLIT_INC" >> $LOGFILE
if [ "$reason" == "connect" ]; then
	echo "Adding IP address to interface" >> $LOGFILE
	netsh interface ip set address name="$TUNDEV" static $INTERNAL_IP4_ADDRESS $INTERNAL_IP4_NETMASK >> $LOGFILE
	for i in $(seq 1 $CISCO_SPLIT_INC); do
		echo "  $i:" >> $LOGFILE
		var="CISCO_SPLIT_INC_${i}_ADDR" 
		addr=${!var}
		echo "   ${var}: ${!var}" >> $LOGFILE
		var="CISCO_SPLIT_INC_${i}_MASK" 
		mask=${!var}
		echo "   ${var}: ${!var}" >> $LOGFILE
		var="CISCO_SPLIT_INC_${i}_MASKLEN" 
		echo "   ${var}: ${!var}" >> $LOGFILE
		var="CISCO_SPLIT_INC_${i}_PROTOCOL" 
		echo "   ${var}: ${!var}" >> $LOGFILE
		var="CISCO_SPLIT_INC_${i}_SPORT" 
		echo "   ${var}: ${!var}" >> $LOGFILE
		var="CISCO_SPLIT_INC_${i}_DPORT" 
		echo "   ${var}: ${!var}" >> $LOGFILE
		echo "    adding route to $addr via $INTERNAL_IP4_ADDRESS"
		route add $addr mask $mask $INTERNAL_IP4_ADDRESS
	done
fi
echo "CISCO_IPV6_SPLIT_INC: $CISCO_IPV6_SPLIT_INC" >> $LOGFILE
echo "INTERNAL_IP4_NBNS: $INTERNAL_IP4_NBNS" >> $LOGFILE
echo "INTERNAL_IP4_DNS: $INTERNAL_IP4_DNS" >> $LOGFILE
echo "INTERNAL_IP4_NETMASK: $INTERNAL_IP4_NETMASK" >> $LOGFILE
echo "INTERNAL_IP4_NETMASKLEN: $INTERNAL_IP4_NETMASKLEN" >> $LOGFILE
echo "INTERNAL_IP4_NETADDR: $INTERNAL_IP4_NETADDR" >> $LOGFILE
echo "INTERNAL_IP4_ADDRESS: $INTERNAL_IP4_ADDRESS" >> $LOGFILE
echo "INTERNAL_IP6_DNS: $INTERNAL_IP6_DNS" >> $LOGFILE
echo "INTERNAL_IP6_NETMASK: $INTERNAL_IP6_NETMASK" >> $LOGFILE
echo "INTERNAL_IP6_ADDRESS: $INTERNAL_IP6_ADDRESS" >> $LOGFILE


# TODO disconnect - remove routes, unset ip address

# cscript ./vpnc_script_win.js >> $LOGFILE

