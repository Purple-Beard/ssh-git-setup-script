#!/bin/bash

# main function wrapper
main(){
    # helper functions
    spacer(){
        echo ""
        echo ""
    }
    dividerBar(){
        echo "======================================================================"
    }
    welcomeMessage(){
        clear
        dividerBar
        spacer
        echo "Welcome to the PurpleBeard Cross Platform GitHub SSH Key Setup tool"
        spacer
        echo "Written By Dan Monaghan 2023"
        echo "purplebeard.co.uk"
        spacer
        dividerBar
    }
    
    waitForKey(){
        echo "Please press [Enter] to continue"
        read pause
    }
    
    displayVars(){
        welcomeMessage
        echo "      Current Values"
        dividerBar
        echo "Username: $name"
        echo "Email: $email"
    }
    
    # show the user the key to copy
    displayKey(){
        dividerBar
        echo "Your key starts from 'ssh-rsa'"
        dividerBar
        spacer
        cat ~/.ssh/id_rsa.pub
        spacer
        dividerBar
        echo "Your key finshes with $email"
        dividerBar
    }
    
    # ask for github username and email, trap the user in a loop until they enter something
    name=
    while [[ $name = "" ]]; do
        displayVars
        echo "STEP 1: Please enter your GitHub Username"
        read name
        clear
    done
    email=
    while [[ $email = "" ]]; do
        displayVars
        echo "STEP 2: Please enter your GitHub Email"
        read email
        clear
    done
    
        displayVars
    echo "STEP 3: Setting up git config with your username and email"
    git config --global user.name $name
    git config --global user.email $email
    spacer
    
    echo "New Git config:"
    git config -l --global
    echo "Done!"
    spacer
    
    
    
    echo "STEP 4: Generating a pair of SSH keys for authentication with your email '$email' as a comment."
    ssh-keygen -t rsa -b 4096 -C $email -f ~/.ssh/id_rsa -q -N ""
    echo "Done!"
    
    waitForKey
    clear

    echo "DO NOT SKIP!"
    dividerBar
    displayKey   
    spacer
    echo "Manual Steps:"
    echo "1. Go to / Hold Ctrl + Click this link -> https://github.com/settings/ssh/new"
    echo "2. Login to GitHub if needed"
    echo "3. Name your key something in the top box to help you remember"
    echo "   which key it is \(you can have more than one\)"
    echo "4. Copy your key from above and paste it in the big text area on GitHub"
    echo "5. Click Save"
    echo "   - At this stage you *may* be asked for your Password or a one time passcode"
    echo "6. Come back here when you have saved your new key to your GitHub Account"
    spacer
    dividerBar
    echo "DO NOT SKIP!"
    spacer
    
    waitForKey
    
    # Final Check
    echo "FINAL STEP! Did it work?"
    dividerBar
    ssh -T git@github.com
    spacer
    echo "If you see your GitHub Username above you have setup GitHub successfully! 🎈"
}

main
