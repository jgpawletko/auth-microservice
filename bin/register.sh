#!/bin/bash

# signup
curl -X POST -H "Content-Type: application/json"  -d '{"username": "user1", "password": "password123"}'  http://localhost:8080/auth/signup
echo " "
