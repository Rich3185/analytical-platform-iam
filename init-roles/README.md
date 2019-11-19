## INIT-ROLES

Creates an IAM roles and policies to be used by the [role module](../modules/role) and codebuild

### Why

When the [role module](../modules/role) is invoked it attempts to assume the role created by this module and create the 
IAM resources it defines.

Note
----

This module must be invoked in all new and existing AWS accounts at least once before the main portion of this repository's 
resources will work.

### Usage

**Note** Requires an account with the necessary permissions to the target account

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```

__Local state only__