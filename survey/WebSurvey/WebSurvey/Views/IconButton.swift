//
//  IconButton.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 11.07.20.
//

import SwiftUI

struct IconButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: systemName)
                .font(.system(size: 18))
                .padding()
        })
    }
}
