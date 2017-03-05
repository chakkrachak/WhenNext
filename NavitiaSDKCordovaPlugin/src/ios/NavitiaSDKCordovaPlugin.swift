@objc(NavitiaSDKCordovaPlugin) class NavitiaSDKCordovaPlugin : CDVPlugin {
    @objc(coolMethod:)
    func coolMethod(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let msg = command.arguments[0] as? String ?? ""

    if msg.characters.count > 0 {
      let toastController: UIAlertController =
        UIAlertController(
          title: "",
          message: msg,
          preferredStyle: .alert
        )

      self.viewController?.present(
        toastController,
        animated: true,
        completion: nil
      )

      DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
        toastController.dismiss(
          animated: true,
          completion: nil
        )
      }

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
    }

    @objc(giveMeAnArray:)
    func giveMeAnArray(command: CDVInvokedUrlCommand) {
      var pluginResult = CDVPluginResult(
        status: CDVCommandStatus_ERROR
      )

      pluginResult = CDVPluginResult(
          status: CDVCommandStatus_OK,
          messageAs: ["TATA", "TOTO"]
      )

      self.commandDelegate!.send(
        pluginResult,
        callbackId: command.callbackId
      )
    }

    @objc(totoSwift:)
        func totoSwift(command: CDVInvokedUrlCommand) {
          var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
          )

          var coordsBuilder:CoordsBuilder = CoordsBuilder(token: "", coverage: "")

          pluginResult = CDVPluginResult(
              status: CDVCommandStatus_OK,
              messageAs: ["TATA", "TOTO"]
          )

          self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
          )
        }
}