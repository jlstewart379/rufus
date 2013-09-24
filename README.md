PREREQUISITES 
--------------------------

Installing Node with Homebrew

- brew doctor
- brew install node
- curl https://npmjs.org/install.sh | sh
- export NODE_PATH="/usr/local/lib/node"
- export PATH="/usr/local/share/npm/bin:$PATH"
- node -v <= check to see that node installed correctly

Download appium

Navigate to project directory and issue command 
- git clone https://github.com/appium/appium.git
- appium -v <= check to see that appium installed correctly


CONFIGURING ENVIRONMENT 
--------------------------------------------

Rufus relies on a config.yml file to exists in the project's root directory. This is used to tell appium about the physical device and the software under test. Below is a typical configuration to run automated tests on the iPad.

browser: iOS
platform: Mac
version: 6.1
app:$HOME/Library/Developer/Xcode/DerivedData/**/Build/Products/Debug-iphoneos/YourApp.app 

STARTING APPIUM SERVER
-----------------------------------------
Open a separate terminal window and navigate to you appium installation.
Issue the following command to start the appium server
node server.js -U <UDID> --app <PATH_TO_APP>

The UDID is the unique identifier of your physical device. This can be found in Xcode. Navigate to Window > Organizer, select the target device and notice it's identifier. The PATH_TO_APP is the path to the compiled app that Xcode produces. It should be the same as the path configured in the config.yml

After issuing the command there should be a message stating that the appium server is listening. 

DEPLOYING TO DEVICE
----------------------------------








