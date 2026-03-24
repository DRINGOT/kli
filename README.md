# KLI - Kubernetes Lens Interface

![Version](https://img.shields.io/badge/version-0.0.1-blue.svg)
![License](https://img.shields.io/badge/license-GPLv3-green.svg)
![Shell](https://img.shields.io/badge/shell-bash-orange.svg)

**KLI** is a modern and interactive command-line interface for Kubernetes, designed to simplify cluster navigation and management through a rich user interface based on `fzf`.

```
  _  ___      _____
 | |/ / |    |_   _|
 | ' /| |      | |
 | . \| |___  _| |_
 |_|\_\_____||_____|
```

## ✨ Features

- 🎯 **Smart Navigation** - Interactive interface with real-time preview
- 🔄 **Context Switching** - Quick switching between Kubernetes clusters
- 📦 **Resource Explorer** - Visualization and management of all K8s resources
- 🔍 **Live Preview** - Display logs, YAML and status in real-time
- ⚡ **Performance** - Optimal use of `fzf` for a smooth experience
- 🎨 **Modern UI** - Colorful interface with symbols and visual status
- 🛠️ **Kubectl Actions** - Execute kubectl commands (get, describe, logs, edit, delete, etc.)

## 📋 Prerequisites

### Required
- `kubectl` - Kubernetes CLI
- `fzf` - Fuzzy finder (>= 0.27.0 recommended)

### Optional
- `jq` - For advanced JSON parsing
- Metrics Server (for `top` commands)

## 🚀 Installation

### Quick Install

```bash
# Clone the repository
git clone https://github.com/DRINGOT/kli.git
cd kli

# Run the installation
./install.sh
```

The installation script will:
1. Check system dependencies
2. Copy binaries to `/usr/local/bin`
3. Configure appropriate permissions

### Manual Installation

```bash
# Copy files
sudo cp kli kli-ctx kli-engine kli-ns kli-run /usr/local/bin/
sudo cp kli-ui VERSION /usr/local/bin/

# Make scripts executable
sudo chmod +x /usr/local/bin/kli*
```

## 📖 Usage

### Main Interactive Mode

```bash
kli
```

Launches the main interface with the home menu allowing you to:
- Start the resource explorer
- Switch Kubernetes context
- Switch namespace
- Launch the initialization wizard

### Direct Commands

```bash
# Switch Kubernetes context
kli ctx

# Switch namespace
kli ns

# Launch the demo wizard
kli run

# Start explorer directly
kli --explorer

# Set initial namespace
kli -n monitoring
kli --namespace production
```

### Available Options

```
OPTIONS:
  -n, --namespace <ns>   Set initial namespace
  --explorer             Jump directly to resource explorer
  -h, --help             Show this help message
  -v, --version          Show version

COMMANDS:
  ctx                    Switch cluster context
  ns                     Quick namespace switch
  run                    Start the demo/wizard mode
```

## 🎮 User Interface

### Keyboard Navigation

- **ENTER** : Select / Validate
- **ESC** : Return to previous menu
- **Ctrl+C** : Exit cleanly
- **↑/↓** : Navigate through lists
- **Type to search** : Dynamic filtering

### Navigation Flow

```
HOME
 ├── START EXPLORER
 │    └── NAMESPACE
 │         └── ACTION (get, describe, logs, edit, etc.)
 │              └── RESOURCE (pods, services, deployments, etc.)
 │                   └── ITEM (specific selection)
 ├── SWITCH CONTEXT (kli-ctx)
 ├── SWITCH NAMESPACE (kli-ns)
 └── RUN WIZARD (kli-run)
```

## 🏗️ Architecture

The project consists of several modules:

- **`kli`** - Main entry point and orchestrator
- **`kli-ctx`** - Context switching module with node preview
- **`kli-ns`** - Namespace switching module with pod overview
- **`kli-engine`** - Kubectl action execution engine with colorization
- **`kli-run`** - Interactive wizard for onboarding
- **`kli-ui`** - Shared UI library (colors, symbols, rendering functions)

### File Structure

```
kli/
├── kli                 # Main binary
├── kli-ctx            # Context switcher
├── kli-ns             # Namespace switcher
├── kli-engine         # Data fetcher
├── kli-run            # Interactive wizard
├── kli-ui             # UI library
├── install.sh         # Installation script
├── VERSION            # Version file
├── LICENSE            # GPL v3 License
└── README.md          # Documentation
```

## 🎨 Visual Features

### Smart Colorization

Statuses are automatically colorized:
- 🟢 **Green** : Running, Active, Ready, Succeeded
- 🟡 **Yellow** : Pending, ContainerCreating, Progressing
- 🔴 **Red** : Failed, Error, CrashLoopBackOff, OOMKilled

### Real-Time Preview

- **Contexts** : Display nodes, endpoints and metrics
- **Namespaces** : List pods and their statuses
- **Resources** : Detailed YAML and recent logs

## 🔧 Configuration

KLI uses the standard kubectl configuration (`~/.kube/config`) and requires no additional configuration.

## 🐛 Troubleshooting

### "Cluster unreachable" Error

```bash
# Check cluster connection
kubectl cluster-info

# Check current context
kubectl config current-context

# Use kli ctx to switch context
kli ctx
```

### fzf not found

```bash
# macOS
brew install fzf

# Ubuntu/Debian
sudo apt install fzf

# Arch Linux
sudo pacman -S fzf
```

## 📝 Usage Examples

### Typical Workflow

```bash
# 1. Check/switch context
kli ctx

# 2. Select a namespace
kli ns

# 3. Explore resources
kli --explorer

# Or all in one command
kli -n production
```

### Available Actions in Explorer

- **get** - List resources
- **describe** - Complete details of a resource
- **logs** - View logs (pods)
- **edit** - Edit YAML configuration
- **top** - CPU/RAM metrics
- **delete** - Delete a resource
- **explain** - Resource documentation
- **rollout** - Manage deployments
- **scale** - Scale a resource

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Open issues to report bugs
- Submit pull requests for new features
- Improve documentation

## 📄 License

This project is distributed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for more details.

## 👤 Author

**Donovan Ringot**
- GitHub: [@DRINGOT](https://github.com/DRINGOT)

## 🙏 Acknowledgments

- [kubectl](https://kubernetes.io/docs/reference/kubectl/) - Official Kubernetes CLI
- [fzf](https://github.com/junegunn/fzf) - The fuzzy finder that makes this all possible
- The Kubernetes community

---

**KLI** - Making Kubernetes management interactive and enjoyable! 🚀
