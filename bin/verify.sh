#!/bin/bash

# verify
#read -n 6 -p "Enter 2FA code: " code
read -p "Enter 2FA code: " code

curl -X POST -H "Content-Type: application/json"  -d "{\"username\": \"user1\", \"code\": \"${code}\"}"  http://localhost:8080/auth/verify
echo " "
