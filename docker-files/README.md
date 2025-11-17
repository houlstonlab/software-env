# Docker Images Repository

This repository contains Docker images for various bioinformatics tools and utilities, with automated builds and deployment to Docker Hub.

## Purpose

Centralized repository for maintaining and distributing containerized versions of bioinformatics tools used in research workflows. Each tool is versioned and automatically built using GitHub Actions.

## Directory Structure

Tools are organized in directories following the pattern `toolname_version`:

```
├── bioconductor_4.0/
│   └── Dockerfile
├── mytool_1.2/
│   └── Dockerfile
└── anothertool_2.1/
    └── Dockerfile
```

## Automated Workflow

The GitHub Actions workflow automatically:
- Detects changes to any `toolname_version/Dockerfile`
- Builds the Docker image as `username/toolname:version`
- Pushes to Docker Hub

**Example**: `bioconductor_4.0/` → `mahshaaban/bioconductor:4.0`

## Setup

Add these GitHub repository secrets:
- `DOCKERHUB_USERNAME`: Your Docker Hub username  
- `DOCKERHUB_TOKEN`: Your Docker Hub access token

## Usage

1. Create a new directory: `toolname_version/`
2. Add your `Dockerfile`
3. Commit and push - the image will be automatically built and deployed

## Example Usage

1. Create a directory following the naming pattern:
2. Add your Dockerfile to the directory:
3. Commit and push:
4. The workflow will automatically build and push the image to Docker Hub.
