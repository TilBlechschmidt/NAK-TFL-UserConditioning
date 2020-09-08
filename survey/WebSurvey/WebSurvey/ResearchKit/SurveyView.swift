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

class ViewController: UIViewController, ORKTaskViewControllerDelegate {
//    private let startButton = UIButton()
    private var savingCancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let surveyView = DashboardView(startSurvey: startSurvey)
        let vc =

//        view.backgroundColor = .systemBackground
//
//        startButton.setTitle("Neue Umfrage starten", for: .normal)
//        startButton.addTarget(self, action: #selector(startSurvey), for: .touchUpInside)
//        startButton.setTitleColor(.label, for: .normal)
//
//        view.addSubview(startButton)
//        startButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addConstraints([
//            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
    }

    func startSurvey() {
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRun: nil)
        taskViewController.delegate = self
        taskViewController.outputDirectory = createOutputDirectory(for: taskViewController.taskRunUUID)
        taskViewController.showsProgressInNavigationBar = true
        present(taskViewController, animated: true, completion: nil)
    }

    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                self.showAlert(title: "Survey failed", message: "The survey was unable to continue due to the following error:\n\n\(error.localizedDescription)\n\nIf the problem persists, please contact the author.")
            }
        }

        activeRecorder?.stopCapture()

        savingCancellable = activeRecorder?.$status.receive(on: RunLoop.main).sink {
            if $0 == .saving {
                print("Saving \(Date())")
            } else if $0 == .finished {
                _ = try! taskViewController.result.archive(deleteOriginal: true)
                taskViewController.dismiss(animated: true, completion: nil)
            }
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func createOutputDirectory(for taskID: UUID) -> URL {
        let documents = getDocumentsDirectory()
        let outputDirectory = documents.appendingPathComponent("survey-\(taskID.uuidString)", isDirectory: true)
        try! FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)
        return outputDirectory
    }
}
