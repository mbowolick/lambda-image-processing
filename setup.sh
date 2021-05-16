
#!/usr/bin/env bash
# Installed python3.8 using MacOS Brew and invoked Python@3.8 as follows
/usr/local/opt/python@3.8/bin/python3 -m venv venv
. venv/bin/activate
pip3 install -r requirements.txt
printf "\n |-----------------------------------------------------------------------------| \n "
printf "|          RUN:         . venv/bin/activate                                   | \n "
printf "|-----------------------------------------------------------------------------| \n "
printf "\n"