var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, "HelloPluginCordovaSwift", "coolMethod", [arg0]);
};

exports.giveMeAnArray = function(arg0, success, error) {
    exec(success, error, "HelloPluginCordovaSwift", "giveMeAnArray", [arg0]);
};