# StealthPasswordSpray

## Overview

StealthPasswordSpray is a PowerShell script designed for stealthy password spraying attacks on Windows and Active Directory environments. The script automates the process of testing multiple user accounts against a list of potential passwords with the option to specify delays between attempts to evade detection mechanisms.

## Features

Enumerates users from Active Directory if a user list file is not provided.
Supports single password and password list testing.
Option to use usernames as passwords.
Configurable delays between password attempts to avoid account lockouts.
Option to output successful login attempts to a specified file.

## Usage
To run the StealthPasswordSpray script, execute it in PowerShell with the necessary parameters. Below is an example of how to run the script:

.\StealthPasswordSpray.ps1 -Password "password123" -TargetDomain "example.com" -MinDelay 30 -MaxDelay 30 -OutFile "C:\Path\To\Output.txt"

 ## Parameters

UserListPath (optional): Path to a file containing a list of usernames.
Password (optional): A single password to test against all usernames.
PasswordFile (optional): Path to a file containing a list of passwords.
TargetDomain (optional): The target domain for the password spray.
UseUserAsPass (optional): Use usernames as passwords.
MinDelay (optional): Minimum delay in seconds between password attempts.
MaxDelay (optional): Maximum delay in seconds between password attempts.
OutFile (optional): Path to a file where successful login attempts will be logged.

## Example Usage
### Using a single password with a specified delay and output file
.\StealthPasswordSpray.ps1 -Password "Winter2024!" -TargetDomain "yourdomain.com" -MinDelay 30 -MaxDelay 30 -OutFile "C:\Path\To\Output.txt"

### Using a list of passwords and enumerating users from the target domain
.\StealthPasswordSpray.ps1 -PasswordFile "C:\Path\To\Passwords.txt" -TargetDomain "example.com" -MinDelay 30 -MaxDelay 30 -OutFile "C:\Path\To\Output.txt"
Scripts
StealthPasswordSpray.ps1: The main script for performing stealthy password spray attacks.
Modules to load


## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any improvements, bug fixes, or suggestions.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Credits
Author: [Matan Bahar](https://www.linkedin.com/in/matan-bahar-66460a1b0/)
