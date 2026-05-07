# KLI - Kubernetes CLI Interface

![Version](https://img.shields.io/badge/version-0.2.0-blue.svg)
![License](https://img.shields.io/badge/license-GPLv3-green.svg)
![Shell](https://img.shields.io/badge/shell-bash-orange.svg)

**KLI** is an interactive terminal interface for Kubernetes built on `fzf`. Navigate your cluster, inspect resources, stream logs, exec into containers and monitor live metrics — all from a keyboard-driven UI.

```
  _  ___      _____
 | |/ / |    |_   _|
 | ' /| |      | |
 | . \| |___  _| |_
 |_|\_\_____||_____|
```

## Prerequisites

### Required
- `kubectl` — Kubernetes CLI
- `fzf` — Fuzzy finder (**>= 0.36** required for live refresh)
- `curl` — Used for live data refresh (built-in on macOS)

### Optional
- `jq` — Node resource requests / limits breakdown
- **Metrics Server** — Required for `kli top` and `kli nodes`

## Installation

### Homebrew (Recommended)

```bash
brew tap DRINGOT/tap
brew install DRINGOT/tap/kli
```

### Quick Install

```bash
git clone https://github.com/DRINGOT/kli.git
cd kli
./install.sh
```

### Shell Completion

```bash
echo 'source /usr/local/bin/kli-completion' >> ~/.zshrc
# or for bash:
echo 'source /usr/local/bin/kli-completion' >> ~/.bashrc
```

### Manual Installation

```bash
sudo cp kli kli-ctx kli-ns kli-engine kli-ui \
        kli-top kli-node kli-find kli-completion VERSION \
        /usr/local/bin/
sudo chmod +x /usr/local/bin/kli{,-ctx,-ns,-engine,-top,-node,-find}
```

## Usage

### Interactive Mode

```bash
kli
```

Opens the home menu. Use `ctrl+h` at any time to display the help page.

### Direct Commands

```bash
kli ctx              # Switch cluster context
kli ns               # Switch active namespace
kli top              # Live pod CPU/MEM usage (all namespaces)
kli nodes            # Cluster node resource overview
kli find             # Search resources across all namespaces
kli find deployments # Search a specific resource type directly
```

### Options

```
kli [options] [command]

OPTIONS:
  -n, --namespace <ns>   Set initial namespace
  --explorer             Jump directly to resource explorer
  --pod <name>           Jump to action menu for a specific pod
  --resource <type>      Pre-select resource type (use with --instance)
  --instance <name>      Pre-select resource instance
  -h, --help             Show help
  -v, --version          Show version
```

## Features

### Home Menu
Central hub with live preview describing each module. Press `ctrl+h` for full help.

```
HOME
 ├── COMMAND EXPLORER   →  namespace → action → resource → instance
 ├── FINDER             →  resource type picker → all-namespaces search
 ├── SWITCH CONTEXT     →  browse & switch kubectl contexts
 ├── SWITCH NAMESPACE   →  change active namespace
 ├── TOP NODES          →  cluster node resource overview
 └── TOP RESOURCES      →  live pod CPU/MEM ranking
```

### Command Explorer
Full `kubectl` workflow in a guided fzf interface:

| Action | Description |
|---|---|
| `get` | List and filter resources |
| `describe` | Full details, events & conditions |
| `logs` | Stream container logs |
| `exec` | Open a shell inside a container |
| `port-forward` | Forward a local port to a pod / service |
| `edit` | Edit resource YAML in your editor |
| `top` | Live CPU & Memory metrics |
| `delete` | Delete a resource (with confirmation) |
| `scale` | Adjust replica count |
| `rollout` | Manage deployment rollouts (restart, status, history, undo) |
| `events` | Recent namespace events |
| `explain` | API documentation |

### Top Resources (`kli top`)
Live pod CPU/MEM ranking across all namespaces. **Auto-refreshes every 15s** with a countdown spinner.

| Key | Action |
|---|---|
| `tab` / `ctrl+t` | Toggle sort CPU ↔ MEM |
| `enter` | Jump to pod action menu |
| `ctrl+n` | Switch to node view |

### Top Nodes (`kli nodes`)
Cluster-level node dashboard with ASCII CPU/RAM bars showing used vs. allocatable. Drill into pods per node. **Auto-refreshes every 15s**.

| Key | Action |
|---|---|
| `enter` | View pods on selected node |
| `ctrl+p` | Switch to pod top view |

### Finder (`kli find`)
Cross-namespace resource search with an interactive resource type picker.

| Key | Action |
|---|---|
| `enter` | Jump to action menu for selected resource |
| `esc` | Change resource type |

### Smart Colorization

| Color | Status |
|---|---|
| Green | Running, Active, Ready, Succeeded, Bound |
| Yellow | Pending, ContainerCreating, Terminating |
| Red | Failed, Error, CrashLoopBackOff, OOMKilled, ImagePullBackOff |

## Global Keyboard Shortcuts

| Key | Action |
|---|---|
| `esc` | Return to previous screen |
| `ctrl+c` | Quit kli |
| `ctrl+h` | Open help page (from home menu) |

## Architecture

| File | Role |
|---|---|
| `kli` | Main entry point, home menu, explorer flow |
| `kli-ctx` | Context switcher |
| `kli-ns` | Namespace switcher |
| `kli-engine` | kubectl action engine with preview & colorization |
| `kli-ui` | Shared UI library (colors, symbols, fzf options, logo) |
| `kli-top` | Live pod resource usage dashboard |
| `kli-node` | Cluster node resource overview |
| `kli-find` | Cross-namespace resource finder |
| `kli-completion` | Shell completion (bash / zsh) |
| `VERSION` | Current version string |

## Troubleshooting

### Metrics not available

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### Cluster unreachable

```bash
kubectl cluster-info
kubectl config current-context
kli ctx   # switch context interactively
```

### fzf too old (live refresh not working)

```bash
brew upgrade fzf   # macOS
```

## License

GNU General Public License v3.0 — see [LICENSE](LICENSE).

## Author

**Donovan Ringot** — [@DRINGOT](https://github.com/DRINGOT)
