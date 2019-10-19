# gcloud-reference-arch
A gcloud reference architecture implementation using Terraform and Terragrunt

What you need to know:

Bootstrap - contains the minimal set of resources necessary to bootstrap an architecture such that terraform and terragrunt can be used to manage it.  It is a subset of the code in the gcloud-templates/root-folder template.  If you uncomment the `backend` block after running it, the state will be uploaded to the remote_state location where the root-template folder can find it, preventing the need to import 30 separate resources after running the bootstrap.

Folders - Is a directory subtree that manages the metadata for environments, service projects, and service accounts.

Environments - Is a directory subtree that manages the resources for the environments themselves - networks, compute resources, and managed services would all be managed within this tree.

At the time of writing, the Folders repo is mostly complete for dev.  I am waiting for project quota updates from google before bringing up prod and stage, since I was limited to 5 projects with billing.

Each environment has a VPC in an environment project which is a VPC host.  Each environment has a service-project which will be associated with environment-specific resources, and is a client to its own environment VPC.  There will also be a shared service-project where common resources for all environments can be declared, since that service-project will be client to all VPC host projects.

Additional shared projects can be created for isolating particular resources - a GKE cluster might gets its own service-project, which can be associated with one or more environments and their VPCs.

This repo has dependencies on the gcloud-templates repository, which contains template definitions and (eventually) tests for those templates. Once I find myself writing modules, I'll also involve the gcloud-modules repo, which is currently empty.

Templates and modules don't really vary, syntactically.  Conceptually, the difference is that a template has provider declarations and can have dependencies on other templates in the form of terraform_remote_state references.  Between the cascading yaml files and remote_state dependencies, the goal is for templates to be mostly relocatable within the architecture. Most of the values that change should be inherited from remote_state or the hierarchy of yaml files above the currently running template.

Long term, the goal is to construct a cli that knows how to drop templates into an architecture on-command, and which will query the user for values of any variables that are not picked up from the filesystem and remote_state contexts.
