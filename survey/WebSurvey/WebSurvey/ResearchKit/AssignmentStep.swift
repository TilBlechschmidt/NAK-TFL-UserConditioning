//
//  AssignmentStep.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 18.07.20.
//

import Foundation
import ResearchKit
import SwiftUI
import SnapKit

class AssignmentStep: ORKActiveStep {
    let assigment: Assignment
    let index: Int
    
    override func startsFinished() -> Bool {
        false
    }
    
    override func stepViewControllerClass() -> AnyClass {
        AssignmentStepViewController.self
    }
    
    init(identifier: String, assigment: Assignment, index: Int) {
        self.assigment = assigment
        self.index = index
        super.init(identifier: identifier)
        
        title = assigment.task
        detailText = assigment.help
        
        shouldContinueOnFinish = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AssignmentStepViewController: ORKActiveStepViewController {
    private let button = ORKContinueButton()
    internal var assignmentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let assignmentStep = (step as! AssignmentStep)
        let assignment = assignmentStep.assigment
        let overview = AssignmentOverview(number: assignmentStep.index, assignment: assignment, onSubmit: {
            self.start()
        })
        
        let hostingView = UIHostingController(rootView: overview)
        view.addSubview(hostingView.view)
        hostingView.view.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    override func start() {
        super.start()
        
        let assignment = (step as! AssignmentStep).assigment
        let rootView = AssignmentWrapperView(assignment: assignment, onSubmit: {
            self.assignmentViewController?.dismiss(animated: true, completion: {
                self.finish()
            })
        })
        
        let vc = UIHostingController(rootView: rootView)
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
        assignmentViewController = vc
    }
}
