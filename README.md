Last Updated: 9-24-2013

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

The most consistent method of deployment I found was through libimobiledevice which one can install by visiting https://github.com/benvium/libimobiledevice-macosx

The only gotcha I was generating the .ipa file that libimobiledevice parses for installation. Take the following steps to generate the .ipa archive.

1. Build the app for deployment to device
2. Navigate to the .app file that should be found in the ../Debug-iphoneos/ directory
3. Created a foldler in that directory named 'Payload'. It must be named Payload
4. Put a copy of the .app file in the Payload directory
5. Compress the directory into a .zip archive
6. Changed the .zip extension to .ipa
7. Issue the command ideviceinstaller -i YourApp.ipa









