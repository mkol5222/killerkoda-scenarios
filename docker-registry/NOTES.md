# Private Docker registry

```shell
# direct link to findings
# https://portal.checkpoint.com/dashboard/cloudguard#/workload/images/generic?cloudAccountId=7f1fedb8-0584-4473-91c9-ff3b9047fe81&assetType=ShiftLeftImage&assetId=sha256%3A675eb396b32bb59364b89b3e05c198cbdd574eefc0ac9a0d2b9329b366da889f&tabName=overview&tabOnly=true&platform=shiftleft&drawer=undefined

# https://github.com/mkol5222/cloudguard-shiftleft-dockerext/blob/main/ui/src/App.tsx#L358


###
# API call to prev scan:

# https://github.com/mkol5222/docker-hooks/blob/6fe8aee79ec9d780ad779c1eff3904c93d657835/shiftleft.ts#L21
#         `https://${host}/v2/vulnerability/scan-metadata?EnvironmentId=${process.env.SHIFTLEFT_ENV}&EntityType=ShiftLeftImage&EntityId=${imageId}`;


```