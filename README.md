# StealthPasswordSpray

## Overview

StealthPasswordSpray is a PowerShell script designed for stealthy password spraying attacks on Windows and Active Directory environments. The script automates the process of testing multiple user accounts against a list of potential passwords with the option to specify delays between attempts to evade detection mechanisms.

## Features

Supports single password and password list testing.
Option to use usernames as passwords.
Configurable delays between password attempts to avoid account lockouts.
Option to output successful login attempts to a specified file.

## Parameters

**UserListPath (optional):** Path to a file containing a list of usernames.\n
**Password (optional):** A single password to test against all usernames.\n
**PasswordFile (optional):** Path to a file containing a list of passwords.\n
**TargetDomain (optional):** The target domain for the password spray.\n
**UseUserAsPass (optional):** Use usernames as passwords.\n
**MinDelay (optional):** Minimum delay in seconds between password attempts.\n
**MaxDelay (optional):** Maximum delay in seconds between password attempts.\n
**OutFile (optional):** Path to a file where successful login attempts will be logged.

## Example Usage
### Using a single password with a specified delay and output file
.\StealthPasswordSpray.ps1 -Password "Summer2024!" -TargetDomain "yourdomain.com" -MinDelay 30 -MaxDelay 30 -OutFile "C:\Path\To\Output.txt"

### Using a list of passwords and enumerating users from the target domain
.\StealthPasswordSpray.ps1 -PasswordFile "C:\Path\To\Passwords.txt" -TargetDomain "example.com" -MinDelay 30 -MaxDelay 30 -OutFile "C:\Path\To\Output.txt"

## Contributing
Contributions are welcome! Please feel free to submit a pull request or open an issue for any improvements, bug fixes, or suggestions.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Credits
Author: [Matan Bahar](https://www.linkedin.com/in/matan-bahar-66460a1b0/)
