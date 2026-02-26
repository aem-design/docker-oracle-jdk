## Oracle JDK

[![build](https://github.com/aem-design/docker-oracle-jdk/actions/workflows/build.yml/badge.svg?branch=jdk21)](https://github.com/aem-design/docker-oracle-jdk/actions/workflows/build.yml)[![github license](https://img.shields.io/github/license/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![github issues](https://img.shields.io/github/issues/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![github last commit](https://img.shields.io/github/last-commit/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![github repo size](https://img.shields.io/github/repo-size/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)
[![docker stars](https://img.shields.io/docker/stars/aemdesign/oracle-jdk)](https://hub.docker.com/r/aemdesign/oracle-jdk)
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/oracle-jdk)](https://hub.docker.com/r/aemdesign/oracle-jdk)
[![github release](https://img.shields.io/github/release/aem-design/oracle-jdk)](https://github.com/aem-design/oracle-jdk)

This is docker image based on [aemdesign/tini](https://hub.docker.com/r/aemdesign/tini/) with Oracle JDK added.

Docker image for linux/amd64 (also runs on Apple Silicon via Rosetta 2).

## Docker Images

Images are available on both registries:
- **Docker Hub**: `aemdesign/oracle-jdk`
- **GitHub Container Registry**: `ghcr.io/aem-design/oracle-jdk`

### Tags

- `latest` - Latest build from main branch
- `jdk21` - JDK 21 branch
- Version tags (pushed when git tags are created)

### Included Packages

Following is the list of packages included

* jdk                   - Oracle JDK for Java processes

## Development

### CI/CD Pipeline

The project uses GitHub Actions for continuous integration and deployment:

- **Platform**: Images are built for `linux/amd64`
- **Apple Silicon support**: Works seamlessly on M1/M2/M3/M4 Macs via Docker Desktop's Rosetta 2 emulation
- **Automated testing**: Each build is tested before pushing
- **Image analysis**: Uses `dive` for Docker image layer analysis
- **Dual registry push**: Automatically pushes to Docker Hub and GitHub Container Registry
- **Git tag versioning**: Pushing a git tag automatically creates a corresponding Docker image tag

### Running on Apple Silicon Macs (M1/M2/M3/M4)

This image is built for `linux/amd64` architecture but runs seamlessly on Apple Silicon Macs through **Rosetta 2** emulation in Docker Desktop.

#### Prerequisites

1. **Docker Desktop for Mac** (version 4.25.0 or later recommended)
   - Download from: https://www.docker.com/products/docker-desktop

2. **Rosetta 2** (usually already installed on modern macOS)
   - To verify/install: `softwareupdate --install-rosetta`

#### Enable Rosetta 2 in Docker Desktop

1. Open **Docker Desktop**
2. Go to **Settings** (⚙️ icon) → **General**
3. Enable **"Use Rosetta for x86_64/amd64 emulation on Apple Silicon"**
4. Click **Apply & Restart**

![Docker Desktop Rosetta Setting](https://docs.docker.com/desktop/images/rosetta.png)

#### Verify It's Working

```bash
# Pull and run the image
docker pull aemdesign/oracle-jdk:latest
docker run --rm aemdesign/oracle-jdk:latest uname -m

# Expected output: x86_64 (running via Rosetta 2)
```

#### Performance Notes

- **Rosetta 2 emulation** provides near-native performance for most workloads
- First container start may be slightly slower (Rosetta translation cache warmup)
- Subsequent starts are fast
- **No code changes needed** - everything works transparently

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
