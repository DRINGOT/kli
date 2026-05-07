#!/usr/bin/env bash
# install.sh - KLI Installation Script

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/kli-ui" || exit 1
VERSION=$(cat "$SCRIPT_DIR/VERSION" 2>/dev/null || echo "0.1.0")
INSTALL_DIR="/usr/local/bin"

draw_logo "$VERSION"
draw_status_bar "installation"

check_dependency() {
    if command -v "$1" &> /dev/null; then
        printf "  ${G}${ICON_OK}${NC}  %-10s ${D}%s${NC}\n" "$2" "$(command -v "$1")"
    else
        [[ "$3" == "true" ]] && (printf "  ${R}${ICON_ERR}${NC}  %-10s ${R}MISSING${NC}\n" "$2"; exit 1)
        printf "  ${Y}${ICON_WARN}${NC}  %-10s ${Y}OPTIONAL${NC}\n" "$2"
    fi
}

echo -e "${B}Checking system...${NC}"
check_dependency "kubectl" "kubectl" "true"
check_dependency "fzf"     "fzf"     "true"
check_dependency "jq"      "jq"      "false"

echo -e "\n${B}Installing binaries...${NC}"
SUDO=""; [[ ! -w "$INSTALL_DIR" ]] && SUDO="sudo"
[[ -n "$SUDO" ]] && echo -e "  ${Y}${ICON_WARN}${NC}  ${D}Requesting sudo privileges...${NC}"


FILES=("kli" "kli-engine" "kli-ui" "VERSION" "kli-ctx" "kli-ns" "kli-top" "kli-node" "kli-find" "kli-completion")

for f in "${FILES[@]}"; do
    if [[ -f "$SCRIPT_DIR/$f" ]]; then
        $SUDO cp -f "$SCRIPT_DIR/$f" "$INSTALL_DIR/$f"

        # LOGIQUE DYNAMIQUE : On chmod +x tout sauf la lib UI et le fichier VERSION
        if [[ "$f" != "kli-ui" && "$f" != "VERSION" && "$f" != "kli-completion" ]]; then
            $SUDO chmod +x "$INSTALL_DIR/$f"
        fi
    fi
done

# Feedback propre et aligné
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli${NC}\n" "kli" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-ctx${NC}\n" "kli-ctx" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-engine${NC}\n" "kli-engine" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-ns${NC}\n" "kli-ns" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-ui${NC}\n" "kli-ui" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-top${NC}\n" "kli-top" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-node${NC}\n" "kli-node" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-find${NC}\n" "kli-find" "$INSTALL_DIR"
printf "  ${G}${ICON_OK}${NC}  %-10s ${D}› %s/kli-completion${NC}\n" "completion" "$INSTALL_DIR"

echo -e "${D}──────────────────────────────────────────${NC}"
echo -e "${G}✔  Installation complete!${NC}\n"
echo -e "   ${B}Quick Start:${NC}"
echo -e "   ${G}›${NC} kli          ${D}# Launch interactive mode${NC}"
echo -e "   ${G}›${NC} kli ctx      ${D}# Fast Context Switch${NC}"
echo -e "   ${G}›${NC} kli ns       ${D}# Fast Namespace Switch${NC}"
echo -e "   ${G}›${NC} kli top      ${D}# Global resource usage (pods)${NC}
   ${G}›${NC} kli nodes    ${D}# Cluster node overview with CPU/RAM bars${NC}"
echo -e "   ${G}›${NC} kli find     ${D}# Find pods across namespaces${NC}"
echo -e "   ${G}›${NC} kli --help   ${D}# View all options${NC}"
echo -e "\n   ${D}Shell completion:${NC}"
echo -e "   ${G}›${NC} echo 'source $INSTALL_DIR/kli-completion' >> ~/.zshrc\n"
