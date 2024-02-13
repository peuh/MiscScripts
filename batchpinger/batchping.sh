 #!/bin/bash
# Program name: nettest.sh
# Ask for input config file and then 
# ping each ip in the config file to
# see if it is reachable.
#
# Show results in colored output based
# on status.

if [ $# -eq 0 ]
  then
    echo "Please provide the path to the host list"
    exit 1
fi


PATH=$(realpath "$1")



if [ -t 1 ] || [ "$FORCE_COLOR" -eq 1 ]; then
    # Our output is not being redirected, so we can use colors.
    C_RED="\033[1;31m"
    C_GREEN="\033[1;32m"
    C_YELLOW="\033[1;33m"
    C_BLUE="\033[1;34m"
    C_PURPLE="\033[1;35m"
    C_CYAN="\033[1;36m"
    C_RESET="$(tput sgr0)"
fi

C_OK="$C_GREEN"
C_NOK="$C_RED"

echo "Let's test the hosts defined in $PATH"
echo "=================== Results ===================="

IFS="="
while read -r name value
do
	/usr/bin/ping -c 1 -W 0.5 "$value" > /dev/null
    if [ $? -eq 0 ]; then
    echo -e "$C_OK $name at $value responded to ping \e[0m"
    else
    echo -e "$C_NOK $name at $value did not respond to ping\e[0m"
    fi
done < $PATH


echo "=================== End Results ===================="
