# Auto-Scale Self-Hosted GitHub Runners On AKS (Azure Kubernetes Service) 
[![DeployRunnerAKS](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployIaC.yaml/badge.svg)](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployIaC.yaml)
[![DeploySampleApp](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployApp.yaml/badge.svg)](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/deployApp.yaml)

This repo will demo shortly the following:
- Bicep deployment, which responsible to following tasks:
  - AKS deployment
  - Install [GitHub Actions Runner Controller (ARC)](https://github.com/actions-runner-controller/actions-runner-controller/blob/master/docs/detailed-docs.md) on AKS with auto-scale configuration
- Deploying sample app to AKS cluster using without keeping any Azure credentials in the Github account

## Prerequisites
- Fork this repo to your github account
- In the forked repo [Configure OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
- Create additional GitHub Secrets in the repo: 
  - name: SSH_PUBLIC_KEY, value: [public key of ssh key which will be used during AKS creation]
  - name: RUNNER_TOKEN, value: Log-in to a GitHub account that has admin privileges for the repository, and [create a personal access token](https://github.com/settings/tokens/new) with the appropriate scopes - for this demo repository runner - need only repo (Full Control)

## Deploy AKS and Github Action runner with Bicep
The first step is to deploy an AKS cluster and install Github Action Runners by triggering manually the GitHub action - DeployRunnerAKS - you can change the resource group, cluster name and admin user name by modifiying [the action file](.github/workflows/deployIaC.yaml)
The second step is to deploy the sample app by trigerring manually the Github action - DeploySampleApp

You will notice that the deployment of the app done by the self-hosted GitHub runners.
In order to check the auto-scale - just trigger the 'DeploySampleApp' several times and you will notice that additional runners being added.
