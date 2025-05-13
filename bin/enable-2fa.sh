#!/bin/bash

# enable-2fa
curl -X POST -H "Content-Type: application/json"  -d '{"username": "user1"}'  http://localhost:8080/auth/enable-2fa
echo " "

