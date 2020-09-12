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
    Bookmark(title: "Dcuk Shop", url: .localResource("fake-dcuk")),
    Bookmark(title: "Heise", url: .online(URL(string: "https://www.heise.de/")!)),
    Bookmark(title: "UCI Kinowelt", url: .online(URL(string: "https://www.uci-kinowelt.de/")!)),
    Bookmark(title: "Der Postillion", url: .online(URL(string: "https://www.der-postillon.com/")!)),
    Bookmark(title: "Famila", url: .online(URL(string: "https://www.famila.de/")!)),
    Bookmark(title: "ING-DiBa", url: .online(URL(string: "https://ing.de/")!)),
].sorted { $0.title < $1.title }
