import Flutter
import UIKit
import Network

public class SwiftFlutterPluginTestIosPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let eventChannel = FlutterEventChannel(name: "networkingCheck", binaryMessenger: registrar.messenger())
        let recordChannel = FlutterEventChannel(name: "record", binaryMessenger: registrar.messenger())
        if #available(iOS 12.0, *) {
            eventChannel.setStreamHandler(NetworkStatus())
            recordChannel.setStreamHandler(ScreenRecordingManager())
        } else {
            // Fallback on earlier versions
        }
    }
}

