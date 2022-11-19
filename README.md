# Auto-Scale Self-Hosted GitHub Runners On AKS (Azure Kubernetes Service) 
[![DeployRunnerAKS](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployIaC.yaml/badge.svg)](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployIaC.yaml)
[![DeploySampleApp](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployApp.yaml/badge.svg)](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployApp.yaml)

This repo will demo shortly the following:
- Bicep deployment, which responsible to following tasks:
  - AKS deployment
  - Install [GitHub Actions Runner Controller (ARC)](https://github.com/actions-runner-controller/actions-runner-controller/blob/master/docs/detailed-docs.md) on AKS with auto-scale configuration
- Deploying sample app to AKS cluster without keeping Azure password in Github account

## Prerequisites
- Fork this repo to your github account
- In the forked repo [Configure OpenID Connect in Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux)
- Create additional GitHub Secrets in the repo: 
  - name: SSH_PUBLIC_KEY, value: [public key of ssh key which will be used during AKS creation]
  - name: RUNNER_TOKEN, value: Log-in to a GitHub account that has admin privileges for the repository, and [create a personal access token](https://github.com/settings/tokens/new) with the appropriate scopes - for this demo repository runner - need only repo (Full Control)


## Important Tweak 
In order to have the runner with AZ CLI and kubectl utilities already installed - I compiled a new image [yaronpr/actions-runner:latest](https://hub.docker.com/r/yaronpr/actions-runner) and update the [actions-runner-controller](runner/actions-runner-controller.yaml) in order to use it as one of the args for controller-manager 
<br>You have in the repo the [Dockerfile](Dockerfile) and the kubectl utility (v.1.25.4)

##### You can read more about it in [this](https://freshbrewed.science/2021/12/01/gh-actions.html) great blog post

## Deployment
### 1st Step - Use Bicep to deploy AKS and self-hosted Github Runners 
Deploy an AKS cluster and install Github Action Runners by triggering manually the GitHub action - DeployRunnerAKS 
- Change the resource group, region, cluster name and admin user name by modifiying [the action file](.github/workflows/deployIaC.yaml)
- Update the repo name in [runnerdeployment.yaml](runner/runnerdeployment.yaml) to yours or change it to work at organization level

### 2nd step - Deploy sample app using self-hosted runner 
The second step is to deploy the sample app by trigerring manually the Github action - DeploySampleApp.
You will notice that the deployment of the app done by the self-hosted GitHub runners.
In order to check the auto-scale - just trigger the 'DeploySampleApp' several times and you will notice that additional runners being added.

## Gaps
- Find a better way to wait for runner-controller to be on Running state