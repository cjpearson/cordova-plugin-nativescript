var exec = require('cordova/exec');
   
var NativeScript = function() {
};

NativeScript.evaluate = function(code, onSuccess, onError) {
    exec(onSuccess, onError, "nativescript", "evaluateNativeScript", [code]);
};

module.exports = NativeScript;
