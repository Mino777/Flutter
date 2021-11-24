//
//  ScreenRecordManager.swift
//  flutter_plugin_test_ios
//
//  Created by MiDASHnT on 2021/11/16.
//

import Foundation
import Flutter
import ReplayKit
import Photos

@available(iOS 10.0, *)
extension ScreenRecordingManager {
    enum State: String {
        case start
        case recroding
        case stop
        case saveVideo
        case completed
    }
    
    //    enum Status {
    //        static let startRecord = PublishSubject<Void>()
    //    }
}
@available(iOS 10.0, *)
class ScreenRecordingManager: NSObject, FlutterStreamHandler {
    
    var sink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        createDir()
        setupRecorder()
        start()
        sink = events
        print("start in iOS")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.stopRecording()
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        
        sink = nil
        print("onCancel Error in iOS")
        return nil
    }
    
    static let shared = ScreenRecordingManager()
    
    public let screenRecorder = RPScreenRecorder.shared()
    
    private var videoSavedPath: URL?
    private var assetWriter: AVAssetWriter?
    private var videoInput: AVAssetWriterInput?
    private var audioMicInput: AVAssetWriterInput?
    private var audioAppInput: AVAssetWriterInput?
    private var currentState: State = .start {
        didSet {
            currentStateHandler?(self.currentState)
        }
    }
    
    public var currentVideoUrl: URL?
    
    var startCompletedHandler: ((Error?) -> Void)?
    var currentStateHandler: ((State) -> Void)?
    var permissionHandler: (() -> Void)?
}

// MARK: - setup
@available(iOS 10.0, *)
extension ScreenRecordingManager {
    
    func setupRecorder() {
        print(#function)
        if currentState == .recroding {
            self.stopCapture()
        }
        
        self.currentState = .start
        
        screenRecorder.isMicrophoneEnabled = true
        
        setupVideoAssetWriter()
    }
    
    private func setupVideoAssetWriter() {
        print(#function)
        videoSavedPath = createPath(to: "mp4")
        
        print("videoSavePath: \(videoSavedPath)")
        
        self.currentVideoUrl = videoSavedPath
        
        guard let path = videoSavedPath else { print("Error : Empty Paath"); return }
        
        print("video Saved path : \(path)")
        
        do {
            assetWriter = try AVAssetWriter(url: path, fileType: .mp4)
            createVideoInput()
            createAudioMicInput()
            createAudioAppInput()
        } catch {
            print("Failed starting screen capture: \(error.localizedDescription)")
        }
    }
    
    private func createVideoInput() {
        let videoCompressionProperties: Dictionary<String, Any> = [
            AVVideoAverageBitRateKey : 4500000, // youtube 1080p Quality (https://ko.wikipedia.org/wiki/비트레이트)
            AVVideoProfileLevelKey : AVVideoProfileLevelH264HighAutoLevel,
            AVVideoExpectedSourceFrameRateKey: 30
        ]
        
        if #available(iOS 11.0, *) {
            let videoSettings: [String : Any] = [
                AVVideoCodecKey  : AVVideoCodecType.h264,
                AVVideoWidthKey  : 1920,
                AVVideoHeightKey : 1080,
                AVVideoScalingModeKey : AVVideoScalingModeResizeAspectFill,
                AVVideoCompressionPropertiesKey : videoCompressionProperties
            ]
            
            self.videoInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
            self.videoInput?.expectsMediaDataInRealTime = true
            guard let videoInput = self.videoInput else { print("Video Input Empty"); return }
            self.assetWriter?.add(videoInput)
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    private func createAudioMicInput() {
        var audioMicSettings: [String : Any] = [:]
        audioMicSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC_HE
        audioMicSettings[AVSampleRateKey] = 44100
        audioMicSettings[AVEncoderBitRateKey] = 64000
        audioMicSettings[AVNumberOfChannelsKey] = 2
        
        self.audioMicInput = AVAssetWriterInput(mediaType: .audio, outputSettings: audioMicSettings)
        self.audioMicInput?.expectsMediaDataInRealTime = true
        
        guard let audioInput = self.audioMicInput else { print("AudioMic Input Empty"); return }
        self.assetWriter?.add(audioInput)
    }
    
    private func createAudioAppInput() {
        var audioAppSettings: [String : Any] = [:]
        audioAppSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC_HE
        audioAppSettings[AVSampleRateKey] = 44100
        audioAppSettings[AVEncoderBitRateKey] = 64000
        audioAppSettings[AVNumberOfChannelsKey] = 2
        
        self.audioAppInput = AVAssetWriterInput(mediaType: .audio, outputSettings: audioAppSettings)
        self.audioAppInput?.expectsMediaDataInRealTime = true
        
        guard let audioInput = self.audioAppInput else { print("AudioApp Input Empty"); return }
        self.assetWriter?.add(audioInput)
    }
}


@available(iOS 10.0, *)
extension ScreenRecordingManager {
    func start() {
        print(#function)
        
        if #available(iOS 11.0, *) {
            screenRecorder.startCapture(handler: { [weak self] (cmSampleBuffer, sampleType, error) in
                guard let self = self else { return }
                guard error == nil else { return }
                
                self.startSession(cmSampleBuffer, type: sampleType)
                
                switch sampleType {
                case .video:
                    guard self.videoInput?.isReadyForMoreMediaData ?? false else { return }
                    self.videoInput?.append(cmSampleBuffer)
                case .audioMic:
                    guard self.audioMicInput?.isReadyForMoreMediaData ?? false else { return }
                    self.audioMicInput?.append(cmSampleBuffer)
                case .audioApp:
                    guard self.audioAppInput?.isReadyForMoreMediaData ?? false else { return }
                    self.audioAppInput?.append(cmSampleBuffer)
                default: break
                    
                }
                
            }, completionHandler: { [weak self] error in
                self?.startCompletedHandler?(error)
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func startSession(_ sample: CMSampleBuffer, type: RPSampleBufferType) {
        guard let writer = self.assetWriter else { return }
        guard type == .video, writer.status == .unknown else { return }
        guard writer.startWriting() else { return }
        
        //        Status.startRecord.onNext(())
        
        let cmTime = CMSampleBufferGetPresentationTimeStamp(sample)
        self.assetWriter?.startSession(atSourceTime: cmTime)
        self.currentState = .recroding
        
    }
}

@available(iOS 10.0, *)
extension ScreenRecordingManager {
    private func stopCapture() {
        print(#function)
        if #available(iOS 11.0, *) {
            screenRecorder.stopCapture { error in
                guard error != nil else { return }
                self.currentState = .recroding
                
                self.currentState = .stop
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func stopRecording() {
        print(#function)
        stopCapture()
        self.finishWriting()
    }
    
    func finishWriting() {
        guard assetWriter?.status != .unknown else { return }
        videoInput?.markAsFinished()
        audioAppInput?.markAsFinished()
        audioMicInput?.markAsFinished()
        
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: self.currentVideoUrl!)
        })
        
        assetWriter?.finishWriting { [weak self] in
            self?.currentState = .saveVideo
        }
        
    }
    
    private func createDir() {
        let fileManager = FileManager.default
        
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        let filePath = documentsURL.appendingPathComponent("Flutter")
        
        if fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                print(filePath.path)
            } catch {
            }
        }
    }
    
    func createPath(to fileExtension: String) -> URL {
        let docuementPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Flutter")
        
        return docuementPath.appendingPathComponent("TEST".dateFileName(fileExtension))
    }
}

extension String {
    func dateFileName(_ fileExtension: String? = nil) -> String {
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        let dateString = formatter.string(from: now)
                
        let prefix = self
        
        if let fileExtension = fileExtension {
            return "\(prefix)_\(dateString.components(separatedBy: ["-"]).joined()).\(fileExtension)"
        }
        
        return "\(prefix)_\(dateString)"
    }
}
