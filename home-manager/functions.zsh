export RED="\033[1;31m"
export GREEN="\033[1;32m"
export YELLOW="\033[1;33m"
export BLUE="\033[1;34m"
export PURPLE="\033[1;35m"
export CYAN="\033[1;36m"
export GREY="\033[0;37m"

export RESET="\033[m"

if [[ $(hostname) == "polygon" ]]
then
    pritunl_account="0aabu6dkhxtzgakf"
elif [[ $(hostname) == "vertex" ]]
then
    pritunl_account="0aabu6dkhxtzgakf"
fi


function check_connection() {
    PRITUNL_JSON=$(pritunl-client list -j)
    ADDRESS=$(echo "${PRITUNL_JSON}" | jq -r '.[0] | .client_address')
    if [ "${ADDRESS}" != "" ]; then
        echo -e "$(echo "${PRITUNL_JSON}" | jq -r '.[0] | .status | "[+] \(env.GREEN)Active for \(.)"')"
        return 0
    fi
    return 1
}

function wait_connection() {
    echo -ne "[-] ${YELLOW}Connecting"
    while true; do
        ADDRESS=$(pritunl-client list -j | jq -r '.[0] | .client_address')
        if [ "${ADDRESS}" != "" ]; then
            echo -e "${RESET}\n[+] ${GREEN}Active${RESET}"
            break
        else
            echo -en "."
        fi
        sleep 1
    done
}

function vpn() {
    if [ -z "$1" ]; then
        echo -e "$(pritunl-client list -j | jq -r '.[] | [.run_state, .status] | if .[0] != "Active" then "[x] \(env.RED)Disconnected\(env.RESET)" else (if .[1] == "Connecting" then "[-] \(env.YELLOW)Connecting...\(env.RESET)" else "[+] \(env.GREEN)Active for \(.[1])" end) end')"
    elif [ "$1" = "up" ]; then
        if check_connection; then return; fi
        pritunl-client start $pritunl_account -m ovpn -p "$(pass otp vpn-worten)"
        wait_connection
    elif [ "$1" = "down" ]; then
        pritunl-client stop $pritunl_account
    elif [ "$1" = "-v" ]; then
        pritunl-client list -j | jq '.[0]'
    fi
}


function t() {
    tmux new -As $1
}

function tl() {
    tmux ls
}

function nvc() {
    nvim ~/.config/nvim/init.lua
}

function ush () {
 if [ -d ".venv" ]
 then
  $SHELL -c "source .venv/bin/activate && $SHELL"
 elif [ -d "venv" ]
 then
  $SHELL -c "source venv/bin/activate && $SHELL"
 else
  echo "No virtual environment found (looked for .venv and venv directories)"
  echo "Create a virtual environment first with: uv venv"
  return 1
 fi
}
