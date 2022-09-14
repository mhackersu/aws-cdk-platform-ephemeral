# GitPod Base Workspace
FROM gitpod/workspace-full:latest

# Set Working Directory
WORKDIR /usr/src/app

# Install localstack
RUN pip install localstack awscli awscli-local