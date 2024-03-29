#!/bin/bash

# Exit script on any error
set -e

# Step 1: Download the package
wget https://assets.coreservice.io/public/package/68/gaganode_pro/0.0.300/gaganode_pro-0_0_300.tar.gz

# Step 2: Extract the package
tar xzvf gaganode_pro-0_0_300.tar.gz

# Step 3: Change directory
cd gaganode-linux-arm64

# Step 4: Update the configuration file with the token from environment variable
# Replace 'your_token_variable' with the actual name of your environment variable
sed -i "s/token='[^']*'/token='$TOKEN'/g" root_conf/default.toml

# Step 5: Run the gaganode process
# Here, I'm directly running the command without nohup. If you want this script to exit and leave gaganode running,
# you might consider different strategies depending on your Docker setup.
chmod +x gaganode
./gaganode &
