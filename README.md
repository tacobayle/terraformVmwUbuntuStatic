# terraformVmwUbuntuStatic

## Goal
Spin up an Ubuntu host (through userdata) in vCenter from content library based on Terraform

## Prerequisites:
- Make sure terraform in installed in the orchestrator VM
- Make sure VMware credential/details are configured as environment variable for Vcenter:
```
TF_VAR_vsphere_username=******
TF_VAR_vsphere_server=******
TF_VAR_vsphere_password=******
```

## Environment:

Terraform Plan has/have been tested against:

### terraform

```
Terraform v0.13.1
+ provider registry.terraform.io/hashicorp/null v2.1.2
+ provider registry.terraform.io/hashicorp/template v2.1.2
+ provider registry.terraform.io/hashicorp/vsphere v1.24.0
+ provider registry.terraform.io/terraform-providers/nsxt v3.0.1
Your version of Terraform is out of date! The latest version is 0.13.2. You can update by downloading from https://www.terraform.io/downloads.html
```

### V-center/ESXi version:
```
vCSA - 7.0.0 Build 16749670
ESXi host - 7.0.0 Build 16324942
```

## Input/Parameters:

1. All the variables are stored in variables.tf

## Use the terraform script to:
- Spin up an ubuntu host based on content library based static IP

## Run the terraform plan:
```
git clone https://github.com/tacobayle/terraformVmwUbuntuStatic ; cd terraformVmwUbuntuStatic ; terraform init ; terraform apply -auto-approve
```
