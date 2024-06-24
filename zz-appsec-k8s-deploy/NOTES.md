![alt text](image.png)

`export URL=$(sed 's/PORT//g' /etc/killercoda/host)`{{exec}}

`while true; do for ((n=0;n<50;n++)); do curl -s -o /dev/null -w "%{http_code}" "$URL/?q=cat+/etc/passwd"; echo; done | sort | uniq -c | sort; done`{{exec}}

