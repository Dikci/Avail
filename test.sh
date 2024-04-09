curl -sL1 avail.sh | bash

sudo apt install nano 
sudo apt install screen 

rm -rf /root/.avail/data

screen -S avail

echo '#!/bin/bash COMMAND="curl -sL1 avail.sh | bash" SESSION_NAME="avail_node_session"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then tmux new-session -d -s $SESSION_NAME fi

tmux send-keys -t $SESSION_NAME "while true; do bash -c '$COMMAND' & PID=$! wait 
? if [ $EXIT_STATUS -ne 0 ]; then sleep 10 fi done" C-m' > availscript.sh

cat .avail/identity/identity.toml

rm -rf /root/.avail/data/LOCK

bash availscript.sh

sudo apt install tmux 
chmod +x availscript.sh 
./availscript.sh 
tmux attach -t avail_node_session

curl -I "localhost:7000/health"
