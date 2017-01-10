var1="$(cut -d: -f2 ConfigFile.txt)"
hostname="$(echo var1 | cut -d" " -f1)"
AllIP="$(echo var1 | cut -d" " -f2)"
ip="$(echo AllIP | cut -d/ -f1)"
CIDR="$(echo AllIP | cut -d/ -f2)"

gateway="(echo var1 | cut -d" " -f3)"
services="(echo var1 | cut -d" " -f4)"

cat <<End>> /etc/binf/db.$hostname.project.fr

\$TTL 604800

@	IN	 SOA 	WSCP1SYS.$hostname.rattrapage.fr. root.$hostname.project.fr. (
			1
			604800
			86400
			2419200
			604800	)
@	IN 	NS	WSCP1SYS.$hostname.rattrapage.fr.

WSCP1SYS	IN	A	$ip

End

cat <<End2>> /etc/bind/named.conf.local

zone "$hostname.fr" IN {
	type master;
	file "etc/bind/WSCP1SYS.$hostname.project.fr";
}

End2

cat <<End3>> /etc/bind/named.conf.local

zone "0.168.192.in-addr.arpa" {
	type master;
	notify no;
	file "/etc/bind/db.$hostname.project.inv";
};

End3

cat <<End4>> /etc/bind/db.$hostname.project.inv

\$TTL 604800

@	IN	SOA	WSCP1SYS.$hostname.rattrapage.fr. root.$hostname.project.fr. (
			2
			604800
			86400
			2419200
			604800 )
@	IN	NS	WSCP1SYS.$hostname.rattrapage.fr.
0	IN	PTR	WSCP1SYS.$hostname.rattrapage.fr.
End4
