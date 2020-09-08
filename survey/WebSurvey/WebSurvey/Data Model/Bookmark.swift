//
//  Bookmark.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 11.07.20.
//

import Foundation

struct Bookmark {
    let title: String
    let url: WebURL
}

let defaultBookmarks = [
//    Bookmark(title: "Dcuk Shop", url: .localResource("fake-dcuk")),
    Bookmark(title: "Twitter", url: .online(URL(string: "https://twitter.com/explore")!)),
    Bookmark(title: "Mindfactory", url: .online(URL(string: "https://mindfactory.de/")!)),
    Bookmark(title: "Backblaze", url: .online(URL(string: "https://backblaze.com/")!)),
    Bookmark(title: "IKEA", url: .online(URL(string: "https://www.ikea.com/de/de/")!)),
    Bookmark(title: "Flüge.de", url: .online(URL(string: "https://fluege.de")!)),
    Bookmark(title: "Netflix", url: .online(URL(string: "https://www.netflix.com/de-de/")!))
].sorted { $0.title < $1.title }
