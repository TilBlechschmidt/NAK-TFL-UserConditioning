//
//  SurveyView.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 26.07.20.
//

import Foundation
import UIKit
import ResearchKit
import Combine
import SwiftUI
import SnapKit

class ViewController: UIViewController {
    private var savingCancellable: AnyCancellable?
    private let dataSource = SurveyListDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let surveyView = DashboardView(startSurvey: startSurvey, dataSource: dataSource)
        let vc = UIHostingController(rootView: surveyView)
        
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        vc.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    func startSurvey() {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = createOutputDirectory(for: taskViewController.taskRunUUID)
        taskViewController.showsProgressInNavigationBar = true
        present(taskViewController, animated: true, completion: nil)
    }
    
    func dismissSurvey(_ taskViewController: ORKTaskViewController) {
        dataSource.update()
        taskViewController.dismiss(animated: true, completion: nil)
    }

    func createOutputDirectory(for taskID: UUID) -> URL {
        let documents = getDocumentsDirectory()
        let outputDirectory = documents.appendingPathComponent("InProgressSurvey-\(taskID.uuidString)", isDirectory: true)
        try! FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)
        return outputDirectory
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                self.showAlert(title: "Survey failed", message: "The survey was unable to continue due to the following error:\n\n\(error.localizedDescription)\n\nIf the problem persists, please contact the author.")
            }
        }

        if let recorder = activeRecorder {
            recorder.stopCapture()

            savingCancellable = recorder.$status.receive(on: RunLoop.main).sink {
                if $0 == .saving {
                    print("Saving \(Date())")
                } else if $0 == .finished {
                    do {
                        _ = try taskViewController.result.archive(deleteOriginal: false)
                    } catch {
                        DispatchQueue.main.async {
                            self.showAlert(title: "Survey failed", message: "The survey was unable to continue due to the following error:\n\n\(error.localizedDescription)\n\nIf the problem persists, please contact the author.")
                        }
                    }
                    self.dismissSurvey(taskViewController)
                }
            }
        } else {
            dismissSurvey(taskViewController)
        }
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}
