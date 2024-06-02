#!/bin/bash

# Email address associated with your GitHub account
EMAIL="rockok10@gmail.com"

# Generate a new SSH key with 4096-bit RSA encryption (recommended)
ssh-keygen -t ed25519 -C "$EMAIL"

# Check if key generation was successful
if [ $? -eq 0 ]; then
  echo "SSH key generation successful!"
  echo

  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519

  # Display the public key
  echo "**Public Key:**"
  cat ~/.ssh/id_ed25519.pub

  echo

  # Instructions for adding the key to your GitHub account
  echo "**Steps to add the key to your GitHub account:**"
  echo "1. Copy the public key above (everything starting with ssh-rsa ...)"
  echo "2. Go to your GitHub account settings (https://github.com/settings/keys)"
  echo "3. Click on 'New SSH key' and paste the copied public key into the key field."
  echo "4. Give your key a descriptive title (e.g., 'Personal Laptop')"
  echo "5. Click 'Add SSH key'."

else
  echo "Error: SSH key generation failed!"
  exit 1
fi
