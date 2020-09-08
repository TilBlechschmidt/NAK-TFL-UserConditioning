//
//  WebPage.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 04.07.20.
//

import Foundation

enum WebURL: Equatable {
    case localResource(String)
    case online(URL)
}

struct ClickEvent: Codable {
    static let messageName = "ClickEvent"
    
    let id: String?
    let className: String?
    let outerHTML: String
    let serializedDocument: String
}
