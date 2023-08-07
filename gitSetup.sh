#!/bin/bash

clear

echo "Please enter your GitHub Username"
read name

echo "Please enter your GitHub Email"
read email


echo "setting git config"
git config --global user.name $name
git config --global user.email $email

echo "Git config:"
git config -l --global


ssh-keygen -t rsa -b 4096 -C $email -f ~/.ssh/id_rsa -q -N ""

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    pbcopy < ~/.ssh/id_rsa.pub
elif [[ "$OSTYPE" == "cygwin"] || ["$OSTYPE" == "msys" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    cat ~/.ssh/id_rsa.pub | clip
fi

cat ~/.ssh/id_rsa.pub

echo "This is your key!"
echo "Press [Enter] to continue..."
read pause
echo ""
echo "DO NOT SKIP"
echo "You need to go to github at this point."
echo ""
echo "YOUR KEY HAS BEEN COPIED TO THE CLIPBOARD READY TO PASTE"
echo ""
echo "Next Steps:"
echo "1. Go to / Hold Ctrl + Click this link -> https://github.com/settings/ssh/new"
echo "2. Login to GitHub if needed"
echo "3. Name your key something in the top box to help you remember"
echo "   which key it is (you can have more than one)"
echo "4. Paste your key in the big text area"
echo "5. Click Save"
echo "6. Come back here and ..."
echo ""
echo "Press [Enter] when you have saved the new key to your github account"
read pause

# Final Check
echo "FINAL CHECK! Did it work?"
echo "If you see your username below you have setup github successfully"
ssh -T git@github.com
