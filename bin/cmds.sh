#!/bin/bash

# signup
curl -X POST -H "Content-Type: application/json"  -d '{"username": "user1", "password": "password123"}'  http://localhost:8080/auth/signup
echo " "

# login
curl -X POST -H “Content-Type: application/json”  -d ‘{“username”: “user1”, “password”: “password123”, “code”: “”}’  http://localhost:8080/auth/login
echo " "

# enable-2fa
curl -X POST -H "Content-Type: application/json"  -d '{"username": "user1"}'  http://localhost:8080/auth/enable-2fa
echo " "

# verify
read -p "Enter 2FA code: " code
curl -X POST -H "Content-Type: application/json"  -d "{\"username\": \"user1\", \"${code}\": \"450378\"}"  http://localhost:8080/auth/verify
echo " "

