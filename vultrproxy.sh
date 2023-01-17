#!/bin/bash

ifconfig

echo -e "Proxylerin portu kactan baslasýn ornek 30000";read port1

echo -e "Kac adet proxy kurcaksýnýz?";read adet

echo -e "Ýpv6 Girin";read ipv6

wget https://cdn.discordapp.com/attachments/707580649745285184/721786294145122324/random.sh

chmod +x random.sh

sed -e "s/MAXCOUNT=4200/MAXCOUNT=$adet/" /root/random.sh > /root/random1.sh

chmod +x random1.sh

sed -e "s/network=2001:470:1f0f:a7/network=$ipv6/" /root/random1.sh > /root/random2.sh

chmod +x random2.sh

./random2.sh > ip.list

echo "ipv4 adres:";read ipv4

echo "interfaces türü(eth0,ech1 vb)";read ipvtur

apt-get update
apt-get -y install gcc g++ git make bc pwgen
apt install unzip
apt-get install nano

cat >> /etc/sysctl.conf << END
net.ipv6.conf.all.proxy_ndp = 1
net.ipv6.conf.default.forwarding = 1
net.ipv6.conf.all.forwarding = 1
net.ipv6.ip_nonlocal_bind = 1
net.ipv6.route.max_size = 409600
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv6.neigh.default.gc_thresh3 = 102400
END

sysctl -p

cd ~
git clone https://github.com/DanielAdolfsson/ndppd.git
cd ~/ndppd
make all && make install

cat > ndppd.conf << END
route-ttl 30000
proxy $ipvtur {
   router no
   timeout 500
   ttl 30000
   rule $ipv6::/64 {
      static
   }
}
END

ndppd -d -c /root/ndppd/ndppd.conf

/sbin/ip -6 addr add $ipv6::2/64 dev $i
/sbin/ip -6 route add default via $ipv6::1
/sbin/ip -6 route add local $ipv6::/64 dev lo

cd ~
git clone https://github.com/z3APA3A/3proxy.git
cd 3proxy/
rm -r man
rm -r src
wget https://cdn.discordapp.com/attachments/730731887093350481/733589604896342067/eskiversiyonsrcman.zip
unzip eskiversiyonsrcman.zip
chmod +x bin/
touch bin/define.txt
echo "#define ANONYMOUS 1" > bin/define.txt
sed -i "31r bin/define.txt" bin/proxy.h
make -f Makefile.Linux

cat > 3proxy.sh << END
#!/bin/bash

echo daemon
echo maxconn 20000
echo nserver 198.153.192.1
echo nserver 198.153.194.1
echo nscache 65536
echo timeouts 1 5 30 60 180 1800 15 60
echo setgid 65535
echo setuid 65535
echo stacksize 6000
echo flush

port=$port1
count=1
for i in \$(cat /root/ip.list); do
    echo "proxy -6 -s0 -n -a -p\$port -i$ipv4 -e\$i"
    ((port+=1))
    ((count+=1))
    if [ \$count -eq 10001 ]; then
        exit
    fi
done
END

chmod +x 3proxy.sh

./3proxy.sh > 3proxy.cfg

ulimit -n 600000
ulimit -u 600000

cd

#!/bin/bash

portlarr=portt
cat > /root/2proxy.sh << END
#!/bin/bash

port=$port1
count=1
for i in \$(cat /root/ip.list); do
    echo "$ipv4:\$port"
    ((port+=1))
    ((count+=1))
    if [ \$count -eq 10001 ]; then
        exit
    fi
done
END

chmod +x /root/2proxy.sh

./2proxy.sh > /root/proxyler.txt

cat > /etc/rc.local << END
#!/bin/bash
ulimit -n 600000
ulimit -u 600000
/sbin/ip -6 addr add $ipv6::2/64 dev ens3
/sbin/ip -6 route add default via $ipv6::1
/sbin/ip -6 route add local $ipv6::/64 dev lo
/root/ndppd/ndppd -d -c /root/ndppd/ndppd.conf
/root/3proxy/bin/3proxy /root/3proxy/3proxy.cfg
exit 0
END

chmod +x /etc/rc.local
/usr/sbin/service rc.local restart

cd

echo -e "\033[31mNormel Proxy Kuruldu Rotate Ýcin Gerekli dosyalar indiriliyor..\033[0m"

wget https://cdn.discordapp.com/attachments/730731887093350481/733589453360201802/rotate.sh

chmod +x rotate.sh

echo -e "\033[31mRotate icin gerekli dosyalar indirildi tek yapmanýz gereken crontabý ayarlamak\033[0m"

rannn=$(tr </dev/urandom -dc A-Za-z0-9 | head -c6)

apt install rar

cd

wget https://cdn.discordapp.com/attachments/730731887093350481/733589485257752656/kurr.sh

cd

chmod +x kurr.sh

./kurr.sh

crontab -e

cd
