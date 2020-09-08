//
//  ViewController.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 18.07.20.
//

import Foundation
import UIKit
import ResearchKit
import Combine
import SwiftUI

struct DashboardView: View {
    let startSurvey: () -> Void
    @State var shareURL: URL? = nil
    @ObservedObject var dataSource: SurveyListDataSource
    
    var dateFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .full
        return formatter
    }
    
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    
    var body: some View {
        NavigationView {
            List(dataSource.surveys) { listItem in
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.dateFormatter.localizedString(for: listItem.creationDate ?? Date(), relativeTo: Date()).localizedCapitalized)
                        Text("\(listItem.id)")
                            .font(.caption)
                            .lineLimit(1)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    IconButton(systemName: "square.and.arrow.up") {
                        self.shareURL = listItem.fileURL
                    }
                }
            }
            .navigationBarTitle("Umfragen")
            .navigationBarItems(trailing:
                IconButton(systemName: "plus", action: startSurvey)
            )
            .sheet(item: $shareURL) { url in
                ShareSheet(activityItems: [url])
            }
            
            VStack {
                Group {
                    Text("✨")
                        .font(.system(.largeTitle))
                        .padding()
                    Text("Neue Umfrage")
                        .font(.system(.largeTitle))
                        .padding()
                    Text("Um eine neue Umfrage zu starten, klicke den Button unter diesem Text und gib dein Tablet an die Person weiter, welche teilnehmen möchte.")
                        .frame(maxWidth: 350)
                        .padding()
                    Button("Umfrage starten", action: startSurvey).padding()
                }
                Spacer()
                
                Divider()
                
                Spacer()
                Group {
                    Text("📡")
                        .font(.system(.largeTitle))
                        .padding()
                    Text("Hochladen")
                        .font(.system(.largeTitle))
                        .padding()
                    Text("Um eine Umfrage hochzuladen, klicke auf den Share Button links in der Liste und sende die Datei an eine der unten verlinkten Kontaktdaten!")
                        .frame(maxWidth: 350)
                        .padding()
                    Button("https://telegram.me/themegatb") {
                        UIApplication.shared.open(URL(string: "https://telegram.me/themegatb")!, options: [:], completionHandler: nil)
                    }.padding()
                    
                    Button("til.blechschmidt@nordakademie.de", action: {
                        UIApplication.shared.open(URL(string: "mailto://til.blechschmidt@nordakademie.de")!, options: [:], completionHandler: nil)
                    })
                }
                Spacer()
            }
        }
    }
}

extension URL: Identifiable {
    public var id: String {
        return self.absoluteString
    }
}
