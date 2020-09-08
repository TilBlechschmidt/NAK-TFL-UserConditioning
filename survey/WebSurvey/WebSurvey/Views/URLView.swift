//
//  URLView.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 11.07.20.
//

import SwiftUI

struct URLView: View {
    let path: String
    let isLoading: Bool
    let progress: Double
    
    var progressBar: some View {
        VStack {
            Spacer()
            if isLoading {
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(height: 2)
                    .scaleEffect(CGSize(width: progress, height: 1.0), anchor: .leading)
            }
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            Text(path).lineLimit(1)
            Spacer()
        }
            .padding(8)
            .background(Color("bar"))
            .overlay(progressBar)
            .cornerRadius(8)
            .padding()
    }
}
