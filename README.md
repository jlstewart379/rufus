Last Updated: 9-24-2013

This project is intended to facilitate automated testing on iOS devices using cucumber and the Page Object pattern. 


QUICK START GUIDE
-----------------
1. gem install rufus
2. require 'rufus' in your Gemfile
3. Clone appium into project directory (where .xcodeproj resides). Repo located at: https://github.com/appium/appium.git
4. Create a config.yml in project directory with the following information:

browser: iOS
platform: Mac
version: 6.1
app:$HOME/Library/Developer/Xcode/DerivedData/<UNIQUE>/Build/Products/Debug-iphoneos/YourApp.app 

5. Start appium server using node
>appium -U DEVICE_UDID --app YourApp.app

6. Deploy to iOS device using libimobiledevice. Repo located at: https://github.com/benvium/libimobiledevice-macosx

7. Run tests
>bundle exec cucumber


#LONG START GUIDE
----------------

CONFIGURING ENVIRONMENT 
-----------------------
Rufus relies on a config.yml file to exists in the project's root directory. This is used to tell appium about the physical device and the software under test. Below is a typical configuration to run automated tests on the iPad.

````YAML
    browser: iOS
    platform: Mac
    version: 6.1
    app:$HOME/Library/Developer/Xcode/DerivedData/<UNIQUE_ID>/Build/Products/Debug-iphoneos/YourApp.app 
````

APPIUM
------

Appium must be installed to run it from the command line. The repository at https://github.com/appium/appium.git is included as a submodule to this project. To download the necessary files, issue the following in your project directory:

>git submodule init

>git submodule update

If you did not download the rufus source code, clone appium into your project directory. Either way, look into the appium directory to make sure there is a file server.js. 



STARTING APPIUM SERVER
-----------------------------------------
Open a separate terminal window and navigate to you appium installation. This will be the window that shows the appium server output. In this window issue the following command to start the appium server

>appium -U DEVICE_UDID --app YourApp.app

The UDID is the unique identifier of your physical device. This can be found in Xcode. Navigate to Window > Organizer, select the target device and notice it's identifier. The PATH_TO_APP is the path to the compiled app that Xcode produces. It should be the same as the path configured in the config.yml

After issuing the command there should be a message stating that the appium server is listening. 

DEPLOYING TO DEVICE WITHOUT USING XCODE
---------------------------------------

Rufus doesn't necessarily care how your app made it onto the device as long as selenium can see it, but I found the most consistent method to be through libimobiledevice. That project also is included as a submodule to this one. The original repository is https://github.com/benvium/libimobiledevice-macosx. Look at the libimobiledevice Readme in order to configure the environment variables your system needs to use this deployment mechanism. 

The only gotcha I ran into was generating the .ipa archive that libimobiledevice uses. Take the following steps to generate the .ipa archive.

1. Build the app for deployment to device
2. Navigate to the .app file that should be found in the ../Debug-iphoneos/ directory
3. Create a folder in that directory named 'Payload'. It must be named Payload.
4. Put a copy of the .app file in the Payload directory
5. Compress the directory into a .zip archive
6. Change the .zip extension to .ipa
7. Issue the command ideviceinstaller -i YourApp.ipa (This installs the app)


USING THE RUFUS IRB DRIVER
--------------------------
After installing the gem, open an irb session from the same directory as your config.yml. 

````ruby
    require 'rufus/driver'
    driver = Rufus.new
    driver.start (starts the app)
````

DEFINING A BUTTON SEQUENCE
--------------------------

Rufus doesn't mind the mindless work of pushing buttons in sequence. The following command will push the goodButton, badButton and sortaOkayButton in sequence 10 times in a row if such a sequence is possible. In this example, the goodButton must be available to be pressed after pushing the sortaOkayButton in order for the loop to continue. 

driver.sequence 'goodButton', 'badButton', 'sortaOkayButton', 10

OTHER DRIVER USE CASES
----------------------

Push a button by name

````ruby
    driver.push_button 'buttonName'
````

Get a list of all the button names

````ruby
    driver.buttons (example return: ['go', 'yesButton','noButton'])
````

Enter 'Hello' into text field

````ruby
    driver.type 'hello' 'textFieldName'
````
