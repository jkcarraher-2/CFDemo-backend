# Demo of Adobe CF - based backend flow

This document is a walkthrough of my setup / learning process for Adobe CF as a "Backend" framework. Largely followed Cyrus' guide linked below. I am working off a Mac so commands are meant to be followed in MacOS.
There are 3 main steps to getting setup. Building a dev env with **Coldbox**, exporting and importing CFAdmin settings using **CFSetup**, and exporting / importing packages using **Coldfusion Package Manager**. 

## Prerequs
**CommandBox** -- a CLI tool similar to bun / pnpm / npm in nodejs environments. It's responsible for:
1. Package Management - Add / Remove community developed packages.
1.5. Dependency Management - Manage Package dependencies in box.json file (similar to package.json)
```
brew install commandbox
```

**CFSetup** -- a tool used for configuring, exporting and importing CFAdmin settings. It's already been installed with your CommandBox, all you need to do is find it.
To find where homebrew put your CommandBox instance run:
```
brew --prefix commandbox
```

From there you can 


## Running a local server
To start your own server run. This command should get you started from any directory
```
box server start port=8080 cfengine=adobe@2023
``` 

## Accessing Coldfusion Admin
Access the admin by using the following link:
```
http://localhost:8080/CFIDE/administrator/index.cfm
```
Then login with the default username and password:
U: `admin` P: `commandbox`

## Bugs

Running `box server start --port=8080` gives the following error:
```
nohup: /Users/chorne/commandbox-jre-darwin64-6.0.0/jre/Contents/Home/bin/java: No such file or directory
```
English: CommandBox doesn't know where you installed Java (I used Homebrew). So we must configure this manually (update server.json). 
https://commandbox.ortusbooks.com/embedded-server/configuring-your-server
I used `/usr/libexec/java_home -v 26` to find where mines installed locally, then I updated the server.json

## Useful Links

Cyrus' Coldbox Setup guide
https://docs.google.com/document/d/1tb1iIiYEYiY7b7hm_s6Z-Ez623cMSGqfsD_Zskn_X_8/edit?usp=sharing