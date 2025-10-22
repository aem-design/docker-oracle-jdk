## Oracle JDK

[![build](https://github.com/aem-design/docker-oracle-jdk/actions/workflows/build.yml/badge.svg?branch=jdk17)](https://github.com/aem-design/docker-oracle-jdk/actions/workflows/build.yml)[![github license](https://img.shields.io/github/license/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![github issues](https://img.shields.io/github/issues/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![github last commit](https://img.shields.io/github/last-commit/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![github repo size](https://img.shields.io/github/repo-size/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![docker stars](https://img.shields.io/docker/stars/aemdesign/oracle-jdk)](https://hub.docker.com/r/aemdesign/oracle-jdk)
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/oracle-jdk)](https://hub.docker.com/r/aemdesign/oracle-jdk)
[![github release](https://img.shields.io/github/release/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)

This is docker image based on [aemdesign/tini](https://hub.docker.com/r/aemdesign/tini/) with Oracle JDK added.

Multi-architecture support (amd64/arm64).

## Docker Images

Images are available on both registries:
- **Docker Hub**: `aemdesign/oracle-jdk`
- **GitHub Container Registry**: `ghcr.io/aem-design/oracle-jdk`

### Tags

- `latest` - Latest build from main branch
- `jdk17` - JDK 17 branch
- Version tags (pushed when git tags are created)

### Included Packages

Following is the list of packages included

* jdk                   - Oracle JDK for Java processes

## Development

### CI/CD Pipeline

The project uses GitHub Actions for continuous integration and deployment:

- **Multi-platform builds**: Images are built for both `linux/amd64` and `linux/arm64`
- **Automated testing**: Each build is tested before pushing
- **Image analysis**: Uses `dive` for Docker image layer analysis
- **Dual registry push**: Automatically pushes to Docker Hub and GitHub Container Registry
- **Git tag versioning**: Pushing a git tag automatically creates a corresponding Docker image tag

### Monitoring Pipeline Status

The `get-action-logs.ps1` PowerShell script provides easy access to GitHub Actions workflow status and logs.

#### Prerequisites

- GitHub CLI (`gh`) must be installed and authenticated
- Install: `winget install --id GitHub.cli`
- Authenticate: `gh auth login`

#### Quick Start

```powershell
# Check current commit's pipeline status (saves logs to logs/ folder by default)
.\get-action-logs.ps1

# Wait for pipeline to complete
.\get-action-logs.ps1 -WaitForCompletion

# Show logs in console
.\get-action-logs.ps1 -ShowLogs

# Force re-download logs
.\get-action-logs.ps1 -Force
```

#### Advanced Options

```powershell
# View specific run's logs
.\get-action-logs.ps1 -RunId 12345678 -ViewLogs

# Download logs as zip
.\get-action-logs.ps1 -RunId 12345678 -Download

# Watch running workflow in real-time
.\get-action-logs.ps1 -Watch

# List recent runs
.\get-action-logs.ps1 -Limit 10

# Filter by status
.\get-action-logs.ps1 -Status failure

# Filter by workflow
.\get-action-logs.ps1 -Workflow "build.yml"

# Disable auto-save
.\get-action-logs.ps1 -SaveLogs:$false
```

#### Saved Logs

Logs are automatically saved to the `logs/` folder with the following naming convention:

```
logs/run-{runId}-{commitSha}-{workflowName}-{conclusion}.log
```

Example: `logs/run-18722094176-3415f7e-build-success.log`

**Note**: The script automatically detects if logs have already been downloaded and skips re-downloading them. Use `-Force` to re-download existing logs.

See full script documentation: `Get-Help .\get-action-logs.ps1 -Full`

### Creating a New Release

To create a new version release:

```bash
# Tag the commit
git tag 1.0.0
git push origin 1.0.0
```

This will automatically build and push versioned Docker images to both registries.
