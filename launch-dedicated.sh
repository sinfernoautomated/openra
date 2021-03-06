#!/bin/sh
# example launch script, see https://github.com/OpenRA/OpenRA/wiki/Dedicated for details

# Usage:
#  $ ./launch-dedicated.sh # Launch a dedicated server with default settings
#  $ Mod="d2k" ./launch-dedicated.sh # Launch a dedicated server with default settings but override the Mod
#  Read the file to see which settings you can override

Name="${Name:-"Dedicated Server 2019 playtest"}"
Mod="${Mod:-"ra"}"
ListenPort="${ListenPort:-"26968"}"
ExternalPort="${ExternalPort:-"26968"}"
AdvertiseOnline="${AdvertiseOnline:-"True"}"
EnableSingleplayer="${EnableSingleplayer:-"False"}"
Password="${Password:-""}"

while true; do
     mono --debug OpenRA.Server.exe Game.Mod=$Mod \
     Server.Name="$Name" Server.ListenPort=$ListenPort Server.ExternalPort=$ExternalPort \
     Server.AdvertiseOnline=$AdvertiseOnline \
     Server.EnableSingleplayer=$EnableSingleplayer Server.Password=$Password
done
