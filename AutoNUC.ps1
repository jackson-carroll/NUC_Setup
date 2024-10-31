#   ,---.  ,--. ,--.,--------. ,-----. ,--.  ,--.,--. ,--. ,-----. 
#  /  O  \ |  | |  |'--.  .--''  .-.  '|  ,'.|  ||  | |  |'  .--./ 
# |  .-.  ||  | |  |   |  |   |  | |  ||  |' '  ||  | |  ||  |     
# |  | |  |'  '-'  '   |  |   '  '-'  '|  | `   |'  '-'  ''  '--'\ 
# `--' `--' `-----'    `--'    `-----' `--'  `--' `-----'  `-----' 
#
# ┌----┐ © 2024 Avertium. All rights reserved.
# | Av | Credits: Jackson Carroll
# └----┘ Version: 1.0                                          

# This fixes the Windows Terminal "font not found" error for Nerdfonts
# Source: https://github.com/microsoft/terminal/issues/11583#issuecomment-1325923731
sc.exe stop "FontCache"
sc.exe config "FontCache" start=disabled

# Prompt the user for a Nessus Pro API key
$apiKey = Read-Host -Prompt "Please enter your Nessus Pro API key"

# Register the key and download the plugins
&"C:\Program Files\Tenable\Nessus\nessuscli.exe" fetch --register $apiKey

# TODO: make this non-interactive
&"C:\Program Files\Tenable\Nessus\nessuscli.exe" adduser --name=avertium

# Restart the service to apply the changes
net stop "Tenable Nessus"
net start "Tenable Nessus"

# Once Nessus is done downloading, shut down the machine
Stop-Computer -Confirm