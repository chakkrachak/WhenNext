var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, "NavitiaSDKCordovaPlugin", "coolMethod", [arg0]);
};

exports.StopSchedulesBuilder = function(success, error) {
	exec(success, error, "NavitiaSDKCordovaPlugin", "StopSchedulesBuilderWrapper", [])
};