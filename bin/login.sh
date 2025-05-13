#!/bin/bash

# login
curl -X POST -H "Content-Type: application/json"  -d '{"username": "user1", "password": "password123", "code": ""}'  http://localhost:8080/auth/login
echo " "

