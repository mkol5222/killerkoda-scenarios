
<br>

### Service load distribution test

Get node IP address
`A=$(k get nodes -o jsonpath={.items[0].status.addresses[0].address})`{{exec}}

Get web service node port
`P=$(kubectl get svc web --output jsonpath={.spec.ports[*].nodePort})`{{exec}}

Try to access it
`echo "Checking $A:$P"; echo -n "Response: "; curl -s "$A:$P"`{{exec}}

And now see how target Pods share the load through Service
`for i in $(seq 50); do curl -s 172.30.1.2:$P; done | sort | uniq -c`{{exec}}

Try multiple times.

Well done.





