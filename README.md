# cordova-plugin-nativescript

A Cordova plugin to make calls to any native API using NativeScript. Currently only iOS is supported.

## Installation

   cordova plugin add https://github.com/cjpearson/cordova-plugin-nativescript

On iOS the metadata generation script has to run between compiling the app and deploying to the device. The after-compile hook does not work for this because it only runs if the CLI compile command was used. As a result, you have to make some changes to your iOS project.

* Open the project in XCode.
* Click the Project then select the main target
* Select the Build Phases tab
* Click the + icon and 'New Run Script Phase'
* Select `/bin/sh` as the shell and copy the following code into the body

    
        pushd ../../plugins/cordova-plugin-nativescript/src/ios/Scripts/metadataGenerator/bin
        ./metadata-generation-build-step.sh
        popd

## Methods

- `window.NativeScript.evaluate`

## window.NativeScript.evaluate

Evaluates a Javascript string asynchronously in the NativeScript runtime.

    window.NativeScript.evaluate(code, onSuccess, onError)

- __code__: The code to evaluate. _(String)_
- __onSuccess__: Callback to invoke when the code evaluates successfully. _(Function)_
- __onError__: Callback to invoke when there is an error evaluating the code. _(Function)_

### Example

    window.NativeScript.evaluate("var alert = new UIAlertView; \
    				      alert.title = 'NativeScript Test'; \
    				      alert.addButtonWithTitle('Ok'); \
    				      alert.show();")

### Supported Platforms

- iOS
