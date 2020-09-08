//
//  SurveyListDataSource.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 26.07.20.
//

import Foundation

struct SurveyListItem: Identifiable {
    let id: String
    let creationDate: Date?
    let fileURL: URL
}

class SurveyListDataSource: ObservableObject {
    @Published var surveys: [SurveyListItem] = []
    
    init() {
        update()
    }
    
    func update() {
        let contents = try! FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: [.addedToDirectoryDateKey], options: [.skipsHiddenFiles, .includesDirectoriesPostOrder, .skipsSubdirectoryDescendants, .skipsPackageDescendants])
        
        surveys = contents
            .filter {
                $0.lastPathComponent.starts(with: "WebSurvey-")
            }
            .map { url in
                let keys = try! url.resourceValues(forKeys: [.addedToDirectoryDateKey])
                let name = String(url.deletingPathExtension().lastPathComponent.dropFirst("WebSurvey-".count))
                return SurveyListItem(id: name, creationDate: keys.addedToDirectoryDate, fileURL: url)
            }
            .sorted { ($0.creationDate ?? Date()) > ($1.creationDate ?? Date()) }
    }
}
