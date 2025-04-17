import UIKit
import Flutter
#if canImport(CoinbaseWalletSDK)
import CoinbaseWalletSDK
#endif

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        #if canImport(CoinbaseWalletSDK)
        if #available(iOS 15.5, *) {
            if (try? CoinbaseWalletSDK.shared.handleResponse(url)) == true {
                return true
            }
        }
        #endif
        // handle other types of deep links
        return false
    }
    
    override func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        #if canImport(CoinbaseWalletSDK)
        if #available(iOS 15.5, *) {
            if let url = userActivity.webpageURL,
               (try? CoinbaseWalletSDK.shared.handleResponse(url)) == true {
                return true
            }
        }
        #endif
        // handle other types of deep links
        return false
    }
}
