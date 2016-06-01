# Welcome to Nicks app automation boilerplate

#### To get started please run the following:
* `bundle install` 
* `brew install ideviceinstaller`

#### Please make sure you have the following as well:
* `$ANDROID_HOME` set
* Android .apk file
* iphone .ipa file linked with calabash
* Ruby >= 2.2.0

#### Update the `cucumber.yml` file with:
* your apk/ipa path
* iphone device ip (hostname or IP - depends on your network)
* iphone UDID (found in xcode -> devices)
* iOS .app location 

#### To run the android app:
* first sign the .apk: `calabash resign [path/file.apk]`
* build the test server: `calabash build [path/file.apk]`
* run the tests inside project folder `cucumber -p android`

#### To run the ios app:
* run the tests inside project folder `cucumber -p ios`


##### Extra things you can run with:
* `-p verbose` for debug mode


#### Some things of note
* Page elements are validated depending on what their name starts with: images start with `img_`, text fields start with `input_text_`. This allows verbose element naming and content validation is broken up based on these names.