Last Updated: 01-30-2014

This project is intended to facilitate automated testing on iOS devices using cucumber, appium and the Page Object pattern. 

PREREQUISITES
--------------------------
-Ruby

-Homebrew

-Bundler

In order to use appium you'll first need to install node and npm. Perform the following steps in the terminal to retrieve the necessary items:

````
  $ brew install node
  $ curl https://npmjs.org/install.sh | sh
  $ export NODE_PATH="/usr/local/lib/node"
  $ export PATH="/usr/local/share/npm/bin:$PATH
  $ npm install -g appium
  $ npm install wd
````

QUICK START GUIDE
------------------------------
- gem install rufus
- require 'rufus' in your Gemfile
- In your env.rb, new up a rufus driver in a method that MUST be named selenium.

````ruby
    def selenium
       @driver ||= new Rufus::Driver.new
    end
````
- Create a config.yml in project directory (the one with .xcodeproj in it) with the following information:

````YAML
    browser: iOS
    platform: Mac
    version: 7.0
    app:$HOME/Library/Developer/Xcode/DerivedData/<UNIQUE>/Build/Products/Debug-iphoneos/YourApp.app 
    use_physical: false   #run on physical device?
    sim_app_path: $HOME/Library/Developer/Xcode/DerivedData/<UNIQUE>/Build/Products/Debug-iphonesimulator/YourApp.app
    device: iPhoneSimulator
    optimized: true  #use faster lookup strategy
````
- Start appium server in new terminal window

>appium -U DEVICE_UDID --app YourApp.app --native-instruments-lib #omit -U option for simulator

- Deploy to iOS device or simulator using XCode or libimobiledevice. Libimobiledevice repo located at: https://github.com/benvium/libimobiledevice-macosx

- Run tests 

>bundle exec cucumber

USING THE RUFUS IRB DRIVER
--------------------------
After installing the gem and starting the appium server, open an irb session from the same directory as your config.yml. 

````ruby
    require 'rufus/driver'
    driver = Rufus::Driver.new
    driver.start (starts the app)
````

DEFINING A BUTTON SEQUENCE
--------------------------

Rufus doesn't mind the mindless work of pushing buttons in sequence. The following command will push the goodButton, badButton and sortaOkayButton in sequence 10 times in a row if such a sequence is possible. In this example, the goodButton must be available to be pressed after pushing the sortaOkayButton in order for the loop to continue. This can be useful for finding strange behavior becuase of a memory leak, which can sometimes take hundreds of keystrokes before revealing itself. 

````ruby
    driver.sequence 'goodButton', 'badButton', 'sortaOkayButton', '10'
````

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
Get the view hierarchy

````ruby
    driver.page_source
````

DEPLOYING TO DEVICE WITHOUT USING XCODE
----------------------------------------------------------------------

I found the most consistent method to be through libimobiledevice. That project also is included as a submodule to this one. The original repository is https://github.com/benvium/libimobiledevice-macosx. Look at the libimobiledevice Readme in order to configure the environment variables your system needs to use this deployment mechanism. 

The only gotcha I ran into was generating the .ipa archive that libimobiledevice uses. Take the following steps to generate the .ipa archive.

1. Build the app for deployment to device
2. Navigate to the .app file that should be found in the ../Debug-iphoneos/ directory
3. Create a folder in that directory named 'Payload'. It must be named Payload.
4. Put a copy of the .app file in the Payload directory
5. Compress the directory into a .zip archive
6. Change the .zip extension to .ipa
7. Issue the command ideviceinstaller -i YourApp.ipa (This installs the app)


