import UIKit
import Flutter
import MPGSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let methodChannel = FlutterMethodChannel(name: "credimax.channel.payment", binaryMessenger:controller.binaryMessenger)

      methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                  
            if call.method == "credimaxPayment" {
                
                let cardData = call.arguments as? Dictionary<String,Any> ?? ["":""]
                let gateway = Gateway(region: GatewayRegion.asiaPacific, merchantId: cardData["merchant"] as? String ?? "")
                var request = GatewayMap()
                request[at: "sourceOfFunds.provided.card.nameOnCard"] = cardData["nameOnCard"] as? String ?? ""
                request[at: "sourceOfFunds.provided.card.number"] = cardData["cardNumber"] as? String ?? ""
                request[at: "sourceOfFunds.provided.card.securityCode"] = cardData["securityCode"] as? String ?? ""
                request[at: "sourceOfFunds.provided.card.expiry.month"] = cardData["expiryMonth"] as? String ?? ""
                request[at: "sourceOfFunds.provided.card.expiry.year"] = cardData["expiryYear"] as? String ?? ""

                gateway.updateSession(cardData["id"] as? String ?? "", apiVersion: "56", payload: request) { (gatewayResult) in
                    
                    switch gatewayResult {
                    case .success(_):
                        methodChannel.invokeMethod("_didRecievePaymentUpdate", arguments: true)
                    case .error(_):
                        methodChannel.invokeMethod("_didRecievePaymentUpdate", arguments: false)
                    }
             
                }

              self.window.makeKeyAndVisible()
            } else {
              result(FlutterMethodNotImplemented)
              return
            }
          })
      
      
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
