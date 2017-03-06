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

    let token:String = "9e304161-bb97-4210-b13d-c71eaf58961c"
    let coverage:String = "fr-idf"

    @objc(StopSchedulesBuilderWrapper:)
    func StopSchedulesBuilderWrapper(command: CDVInvokedUrlCommand) {
      self.commandDelegate!.run(inBackground: {
            var pluginResult = CDVPluginResult(
              status: CDVCommandStatus_ERROR
            )

          pluginResult?.setKeepCallbackAs(true)

          StopSchedulesBuilder(token: "9e304161-bb97-4210-b13d-c71eaf58961c", coverage: "fr-idf")
              .withCoords(Coord(lat: "2.37731", lon: "48.847002"))
              .withDistance(1000)
              .withCount(30)
              .build(callback: {
                  (stopSchedules:[StopSchedule]) -> Void in
                  pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_OK,
                    messageAs: [stopSchedules[0].stopPoint.label]
                  )
                  self.commandDelegate!.send(
                    pluginResult,
                    callbackId: command.callbackId
                  )
              })
      })
    }
}