# Step 3

While this homepage ([link]({{TRAFFIC_HOST1_80}})) works fine and reports you reverse proxy IP.

These are examples of attacks which are blocked by open-appsec:

* [SQL Injection]({{TRAFFIC_HOST1_80}}/?q=UNION+1=1)

* [Cross Site Scripting]({{TRAFFIC_HOST1_80}}/?q=<script>alert(1)</script>)

* [Shell command injection]({{TRAFFIC_HOST1_80}}/?shell_cmd=cat/etc/passwd)


This is how you can check open-appsec status:

```
docker exec appsec-agent open-appsec-ctl -s
```{{exec interrupt}}


This is how you can check open-appsec logs:

```
docker exec appsec-agent open-appsec-ctl -vl
```{{exec interrupt}}