# Auto-Scale GitHub Actions Runner Controller On AKS (Azure Kubernetes Service) 
[![DeployRunnerAKS](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/run.yaml/badge.svg)](https://github.com/yaronpri/GithubRunnerOnAKS/actions/workflows/run.yaml)

This repo will demo shortly the following:
- Bicep deployment, which responsible to the following:
  - AKS deployment
  - Install GitHub Actions Runner Controller (ARC) on AKS with auto-scale configuration
- Deploying sample app to AKS cluster using without keeping any Azure credentials in the Github account

## Prerequisites
- Fork this repo to your github account
- In the forked repo [Configure OpenID Connect in Azure](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-azure)
- Create additional GitHub Secrets in the repo: 
  - name: SSH_PUBLIC_KEY, value: [public key of ssh key which will be used during AKS creation]
  - name: RUNNER_TOKEN, value: Log-in to a GitHub account that has admin privileges for the repository, and [create a personal access token](https://github.com/settings/tokens/new) with the appropriate scopes - for this demo repository runner - need only repo (Full Control)

## Deploy AKS and Github Action runner with Bicep
First step is to deploy an AKS cluster and install Github Action Runner on it, in order to achieve it trigger manually the GitHub action - DeployRunnerAKS - you can change the resource group, cluster name and admin user name by modifiying [the action file](.github/workflows/run.yaml)