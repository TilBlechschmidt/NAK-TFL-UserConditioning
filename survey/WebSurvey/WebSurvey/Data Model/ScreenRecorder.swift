//
//  ScreenRecorder.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 04.07.20.
//

import Foundation
import AVFoundation
import CoreMedia
import ReplayKit

class Recorder: ObservableObject {
    private init(writer: AVAssetWriter, outputURL: URL) {
        self.writer = writer
        self.outputURL = outputURL
    }

    private let screenRecorder = RPScreenRecorder.shared()
    private let writer: AVAssetWriter
    public let outputURL: URL
    
    @Published var status: Status = .startup
    @Published var error: Error? = nil
    
    enum Status: CustomDebugStringConvertible {
        var debugDescription: String {
            switch self {
            case .startup:
                return "Startup"
            case .failedToStart:
                return "Failed to start"
            case .recording:
                return "Recording"
            case .saving:
                return "Saving"
            case .finished:
                return "Finished"
            }
        }
        
        case startup
        case failedToStart
        case recording
        case saving
        case finished
    }

    static func startCapture(to outputURL: URL) throws -> Recorder {
        let writer = try AVAssetWriter(outputURL: outputURL, fileType: .mov)
        let recorder = Recorder(writer: writer, outputURL: outputURL)

        recorder.screenRecorder.startCapture(handler: recorder.process, completionHandler: { error in
            if let error = error {
                recorder.status = .failedToStart
                recorder.error = error
            }
        })

        return recorder
    }

    private func process(sampleBuffer: CMSampleBuffer, sampleBufferType: RPSampleBufferType, error: Error?) {
        guard sampleBufferType == RPSampleBufferType.video else { return }

        if writer.inputs.count == 0 {
            let startTimeStamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer)

            let input = AVAssetWriterInput(mediaType: .video, outputSettings: [
                AVVideoCodecKey: AVVideoCodecType.hevc,
                AVVideoHeightKey: formatDescription?.dimensions.height ?? UIScreen.main.bounds.size.height,
                AVVideoWidthKey: formatDescription?.dimensions.width ?? UIScreen.main.bounds.size.width,
                AVVideoScalingModeKey: AVVideoScalingModeResizeAspect
            ])

            writer.add(input)
            writer.startWriting()
            writer.startSession(atSourceTime: startTimeStamp)
        }

        if let input = writer.inputs.first, input.isReadyForMoreMediaData {
            input.append(sampleBuffer)
            status = .recording
        } else {
            print("Input is not yet ready for data! Discarding \(sampleBuffer.numSamples) samples")
        }
    }

    func stopCapture() {
        guard status == .recording else {
            print("Attempted to stop a non-recording session")
            return
        }
        
        status = .saving
        
        screenRecorder.stopCapture(handler: { error in
            if let error = error {
                self.error = error
            }
            
            self.writer.finishWriting {
                self.status = .finished
            }
        })
    }
}
