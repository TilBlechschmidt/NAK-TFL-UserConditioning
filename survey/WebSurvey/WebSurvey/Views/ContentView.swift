//
//  ContentView.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 04.07.20.
//

import SwiftUI
import Combine

struct AssignmentOverview: View {
    let number: Int
    let assignment: Assignment
    let onSubmit: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("#\(number)").font(.title).foregroundColor(Color.secondary)
            Text("Aufgabe").font(.largeTitle)
            Divider()
                .frame(maxWidth: 300)
                .padding(.bottom)
            Text(assignment.task)
                .font(.headline)
                .padding(.bottom)
            Text(assignment.help)
                .frame(maxWidth: 350)
                .padding(.bottom, 64)
            Button("Los gehts!", action: onSubmit)
            Spacer()
        }
    }
}
