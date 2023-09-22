
```bash
cat <<EOF > main.tf
variable "CPSERVER" {}
variable "CPKEY" {}


resource "checkpoint_management_kubernetes_data_center_server" "testKubernetes" {
  name       = "MyKubernetes"
  hostname   = file("~/.kube/k8s-api-url")
  token_file = filebase64("~/.kube/k8s-api-token")
  unsafe_auto_accept = true
  ignore_warnings = true
}

provider "checkpoint" {
  server   = var.CPSERVER
  api_key  = var.CPKEY
  context  = "web_api"
}

terraform {
  required_providers {
    checkpoint = {
      source  = "checkpointsw/checkpoint"
      version = "~> 1.6.0"
    }
  }
}

resource "checkpoint_management_host" "example" {
  name = "New Host 1"
  ipv4_address = "192.0.2.1"
}
EOF
```{{exec}}

```bash
export TF_VAR_CPSERVER="$CPSERVER"
export TF_VAR_CPKEY="$CPKEY"
terraform init
terraform plan
```{{exec}}