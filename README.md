# iExpire

Mobile (iOS) app to help keep track of expiring items. 

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)

![Commit Activity](https://img.shields.io/github/commit-activity/m/Andy-Wu12/iExpire)

![Swift](https://img.shields.io/badge/swift-%23092E20.svg?style=for-the-badge&logo=swift&logoColor=red)
![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)

## Installation

**I am not enrolled in the Apple Developer Program and due to that, lack the option to distribute this app in the App Store.** 

However, you can 
1. Clone this repository
2. Open the project in XCode
3. Connect your Apple device to your computer with the device's charging cable.
4. Build the app, which XCode should then automatically install on your device and run.
    - You might need to enable "Developer Mode" on your device first, which you can read about [here](https://developer.apple.com/documentation/xcode/enabling-developer-mode-on-a-device)

## Features

- [x]  Item tracker
    - [x]  Create Item to track
        - [x]  Input for name, expiration date, and optional notes and image.
        - [x]  Integrate an API to automatically provide nutrition information based on food name input
    - [x]  View all tracked items
    - [x]  View details of tracked items
    - [x]  Edit details of tracked items
    - [x]  Delete tracked items
    - [x]  Delete all expired items at once
- [x]  User Settings and Data
    - [x]  Toggle Push Notification permissions
    - [x]  Export Item data into comma-separated values file
    - [x]  Clear / Reset all application data (tracked items, notifications)
- [x]  Local Push Notifications
    - [x]  Notifications scheduled and removed by (unique) expiration dates.
