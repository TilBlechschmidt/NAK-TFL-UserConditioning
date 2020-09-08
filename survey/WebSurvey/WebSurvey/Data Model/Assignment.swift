//
//  Assignment.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 11.07.20.
//

import Foundation

struct Assignment: Identifiable {
    let id = UUID()
    let task: String
    let help: String
    let solutionLabel: String
}
