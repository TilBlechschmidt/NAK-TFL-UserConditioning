//
//  RecordingStep.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 18.07.20.
//

import Foundation
import ResearchKit
import SnapKit
import Combine

internal var activeRecorder: Recorder? = nil

class RecordingStep: ORKActiveStep {
    override func startsFinished() -> Bool {
        false
    }
    
    override func stepViewControllerClass() -> AnyClass {
        RecordingStepViewController.self
    }
    
    static var `default`: RecordingStep {
        let step = RecordingStep(identifier: "recordingStep")
        step.title = "Bildschirmaufzeichnung"
        step.text = "Um deine Umfrage präzise auswerten und nachvollziehen zu können beginnt mit Abschluss dieses Schritts eine Bildschirmaufzeichnung, die bei Abschluss oder Abbruch der Umfrage endet. Es werden sämtliche Interaktionen mit dem Bildschirm durch Finger oder Stift visualisiert.\n\nSolltest du die Anwendung verlassen oder andere Apps nebenbei öffnen, so wird die Bildschirmaufzeichnung zum Schutz deiner Privatsphäre beendet und die Umfrage abgebrochen!"
        
        step.shouldContinueOnFinish = true
        
        return step
    }
}

class RecordingStepViewController: ORKActiveStepViewController {
    private var cancellable: AnyCancellable?
    
    private let button = ORKContinueButton()
    private let loader = UIActivityIndicatorView()
    
    deinit {
        cancellable?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        button.setTitle("Aufzeichnung starten", for: .normal)

        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(view).inset(16)
            make.right.equalTo(view).inset(16)
            make.bottom.equalTo(view).inset(88)

            make.height.equalTo(50)
        }
        
        view.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.center.equalTo(button)
        }
        loader.hidesWhenStopped = true
    }
    
    override func start() {
        super.start()
        
        let file = outputDirectory?.appendingPathComponent("recording.mp4")
        let recorder = try! Recorder.startCapture(to: file!)
        
        cancellable = recorder.$status.receive(on: RunLoop.main).sink { status in
            switch status {
            case .recording:
                activeRecorder = recorder
                self.finish()
            case .failedToStart:
                self.delegate?.stepViewControllerDidFail(self, withError: recorder.error)
            case .startup:
                self.loader.startAnimating()
                self.button.isHidden = true
            default:
                break
            }
        }
        
        let fileResult = ORKFileResult(identifier: "videoRecordingOutput")
        fileResult.contentType = "video/mp4"
        fileResult.fileURL = file
        addResult(fileResult)
    }
}
