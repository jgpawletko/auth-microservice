# auth-microservice
Original Author: [Rabieh Fashwall](https://github.com/rfashwall)  
Original code: [here](https://github.com/rfashwall/auth-microservice)  
Article: [here](https://rfashwal.medium.com/strengthening-security-implementing-two-factor-authentication-with-go-f6b0c8221fa7)  

This service implements a basic user authentication and 2-factor authentication (2FA) system using the Gin web framework. It provides endpoints for user registration, login, 2FA enabling, and 2FA verification.

## Quickstart
**NOTE:**  the shell scripts in this repo assume that `curl` is installed and is available in the `$PATH`  


Install `qrencode`:
```
# --- On MacOS with Homebrew ---
$ brew install qrencode

# --- On Linux (with dnf) ---
# find the correct package
[root]$ dnf search qrencode

# install appropriate package, e.g., 
[root]$ dnf install qrencode.x86_64 -y
```

Fire up the application in one terminal window:
```
$ go run main.go
```

Run the scripts in another terminal window:
```
$ cd ./bin

# create a user
$ ./register.sh
{"message":"User created successfully"}


# log the user in
$ ./login.sh
{"message":"Login successful"} 


# enable 2FA 
$ ./enable-2fa.sh
{"message":"QR code created successfully, 2FA enabled","url":"http://localhost:8080/auth/qr/qr.png"} 


# get the QR code that was generated 
$ curl -O http://localhost:8080/auth/qr/qr.png


# open the downloaded file
# on MacOS this should open the file in Preview:
$ open qr.png


# open your authenticator app (e.g., Google Authenticator) 
# and add an account 
# (in Google Authenticator, this means pressing the + button)
# select the "Scan QR Code" option and scan the QR code 


# verify that 2FA is working by running the verify.sh script
# and entering the 6-digit code from your authenticator app
# e.g., 
$ ./verify.sh
Enter 2FA code: 799660
{"message":"2FA code is valid"} 
```
---
## User Representation

The `User` struct represents a user in the system. It stores the user's username, password, 2FA secret, and whether 2FA is enabled.

## User Storage

A map named `users` is used to store the user objects. The key of the map is the user's username, and the value is the user object.

## Authentication Endpoints

* `/auth/signup`: Handles user registration.

   * Creates a new user object if the username is not already taken.
   * Returns an error if the username is already taken or if there is an error creating the user object.

* `/auth/login`: Handles user login and 2FA verification.

   * Retrieves the user object for the provided username.
   * Verifies the user's password and 2FA code.
   * Returns an error if the username or password is incorrect or if the 2FA code is invalid.

## 2FA Endpoints

* `/auth/enable-2fa`: Enables 2FA for a user.

   * Generates a 2FA secret for the user.
   * Stores the secret and sets the user's 2FA enabled flag.
   * Returns the QR code URL for the 2FA secret.

* `/auth/verify`: Verifies a 2FA code for a user.

   * Retrieves the user object for the provided username.
   * Verifies the provided 2FA code against the user's secret.
   * Returns an error if the code is invalid.

```
sequenceDiagram
  participant User
  participant Server
  participant totp

  User->>Server: POST /verify { "username": "user1", "code": "123456" }

  Server->>totp: Verify 2FA code
  totp-->>Server: 2FA code Valid
  Server-->>User: 200 OK { "message": "2FA Code Valid" }
```

## Error Handling

The code uses the Gin framework's `ShouldBindJSON` method to validate the incoming JSON payload for each API endpoint. If validation fails, an error message is returned.

## Error Codes

The code uses standard HTTP status codes to indicate the success or failure of each API request. For example, a successful registration is indicated by a `201 Created` response, while an invalid login attempt returns a `401 Unauthorized` response.

## 2FA Implementation

The code uses the `totp` package to generate and verify TOTP (Time-based One-Time Password) codes for 2FA. TOTP is a common 2FA method that uses a secret key and the current time to generate a one-time code. The user can use this code to gain access to the system after logging in.

## Links of interest
[QR Code Generation on Linux](https://www.linux-magazine.com/Online/Features/Generating-QR-Codes-in-Linux)  
[Homebrew: The Missing Package Manager for macOS](https://brew.sh/)
