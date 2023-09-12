
Some helpful commands:

```
docker exec -it agent-container nginx -T
```{{exec}}

```
docker exec -it agent-container cpnano -s
```{{exec}}

```
docker logs -ft agent-container
```{{exec}}

```
docker exec -it agent-container tail -f /var/log/nano_agent/cp-nano-orchestration.dbg
```{{exec}}