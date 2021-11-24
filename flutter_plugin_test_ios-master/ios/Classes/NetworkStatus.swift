//
//  NetworkStatus.swift
//  flutter_plugin_test_ios
//
//  Created by MiDASHnT on 2021/11/15.
//

import Foundation
import Flutter
import Network

@available(iOS 12.0, *)
class NetworkStatus: NSObject, FlutterStreamHandler {
    var sink: FlutterEventSink?
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private(set) var isConnected: Bool = false
    private(set) var connectionType: ConnectionType = .unknown
    
    /// 연결타입
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    override init(){
        print("init 호출")
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        print("startMonitoring 호출")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            print("path :\(path)")
            
            guard let sink = self?.sink else {
                return
            }
            
            self?.isConnected = path.status == .satisfied
            self?.getConenctionType(path)
            
            if self?.isConnected == true{
                print("연결이된 상태임!")
                sink("On")
            }else{
                print("연결 안된 상태임!")
                sink("Off")
            }
        }
    }
    
    public func stopMonitoring(){
        print("stopMonitoring 호출")
        monitor.cancel()
    }
    
    private func getConenctionType(_ path: NWPath) {
        print("getConenctionType 호출")
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
            print("wifi에 연결")
            
        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
            print("cellular에 연결")
            
        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
            print("wiredEthernet에 연결")
            
        }else {
            connectionType = .unknown
            print("unknown ..")
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        startMonitoring()
        sink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        print("onCancel Error in iOS")
        return nil
    }
}
