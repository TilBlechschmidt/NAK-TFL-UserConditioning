//
//  AssignmentView.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 11.07.20.
//

import SwiftUI
import Combine

struct AssignmentWrapperView: View {
    let assignment: Assignment
    let onSubmit: () -> Void
    
    @State var solutionInputOpen = false
    @State var solution = ""
    
    var body: some View {
        AssignmentView(assignment: assignment, onSubmit: onSubmit, solutionInputOpen: $solutionInputOpen, solution: $solution)
    }
}

struct AssignmentView: View {
    let assignment: Assignment
    let onSubmit: () -> Void
    let bookmarks = defaultBookmarks
    
    @State private var navigator = PassthroughSubject<WebURL, Never>()
    
    @State private var url: URL?
    @State private var isLoading = false
    @State private var progress = 0.0
    
    @State private var bookmarksOpen = false
    @State private var helpOpen = false
    
    @Binding var solutionInputOpen: Bool
    @Binding var solution: String
    
    private var path: String {
        if let url = url {
            let description = url.description
            
            if description.contains("fake-dcuk") {
                return "https://www.dcuk.com/"
            } else {
                return description
            }
        } else {
            return ""
        }
    }
    
    private var actionSheet: ActionSheet {
        ActionSheet(title: Text("Lesezeichen"), message: nil, buttons: bookmarks.map { bookmark in
            .default(Text(bookmark.title), action: {
                self.navigator.send(bookmark.url)
            })
        })
    }
    
    private var helpSheet: ActionSheet {
        ActionSheet(title: Text("Hilfestellung"), message: Text(assignment.help))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Spacer()
                IconButton(systemName: "book", action: { self.bookmarksOpen.toggle() })
                    .actionSheet(isPresented: $bookmarksOpen, content: { actionSheet })
                
                URLView(path: path, isLoading: isLoading, progress: progress)
                
                IconButton(systemName: "questionmark", action: { self.helpOpen.toggle() })
                    .actionSheet(isPresented: $helpOpen, content: { helpSheet })
                IconButton(systemName: "checkmark", action: { withAnimation { self.solutionInputOpen.toggle() } })
                Spacer()
            }
            
            Group {
                Text("Aufgabe")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(assignment.task)
                    .padding(.bottom, 10)
            }.onTapGesture {
                withAnimation {
                    self.solutionInputOpen.toggle()
                }
            }
            
            if solutionInputOpen {
                HStack {
                    Spacer()
                    VStack {
                        TextField(assignment.solutionLabel, text: $solution)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 350)
                        Button("Abschicken", action: { self.onSubmit() })
                    }
                    Spacer()
                }
                    .padding(.bottom, 10)
            }

            WebView(url: $url, progress: $progress, isLoading: $isLoading, navigator: navigator)
                .edgesIgnoringSafeArea(.bottom)
                .opacity(url == nil ? 0 : 1)
            
            if url == nil {
                GeometryReader { _ in
                    HStack {
                        Spacer()
                        Text("Wähle ein Lesezeichen oben links aus um zu beginnen")
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                }
            }
        }
            .background(
                Rectangle()
                    .fill(Color("barBackground"))
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

struct AssignmentView_Previews: PreviewProvider {
    static let assignment = Assignment(task: "Search for some random article on Heise!", help: "To visit Heise, open the bookmarks. From there just open a random article to complete this assignment!", solutionLabel: "Author name")
    
    static var previews: some View {
        AssignmentView(assignment: assignment, onSubmit: {}, solutionInputOpen: .constant(true), solution: .constant("Test"))
    }
}
