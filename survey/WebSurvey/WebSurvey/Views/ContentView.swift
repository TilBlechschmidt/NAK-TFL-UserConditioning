//
//  ContentView.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 04.07.20.
//

import SwiftUI
import Combine

// Dcuk fake -> Preis der "Graduation Dinky Duck"
// Heise -> Author des Artikels zur Freigabe der Apple iOS 14 Public Beta vom 9.7.20
// Twitter -> Neuesten Trump Tweet
// Mindfactory -> Wie viele 128 GB Speichersticks (USB Sticks) sind aktuell im Sortiment
// Backblaze -> Preis des Personal Backup auf 2 Jahre
// IKEA -> RIBBA Schwarz 61x91cm Rahmen Preis

// NOTE: Shuffle at least a subset of the pages! User might get annoyed and just ignore them after a few rounds.
// low vs. high contrast
// banner height
// advanced settings prominence / complexity

let examples = [
    Assignment(task: "Who is the author of the Heise Article about the iOS 14 public beta release!", help: "You can find Heise in the list of bookmarks. From there you have to find the article about the first public beta release of iOS 14 by Apple. It was written on the 09.07.2020.", solutionLabel: "Author name"),
    Assignment(task: "How many kinds of 128GB Sticks are available at Mindfactory?", help: "If you go to Mindfactory by using the bookmarks, there are categories for every product. Under Hardware -> USB Sticks you can find the number of currently available models!", solutionLabel: "Model count"),
    Assignment(task: "How much does the 'Graduation Dinky Duck' cost?", help: "The bookmarks on the top left contain a shop for cute handmade ducks called Dcuk! They have special gifts for graduating students as a separate category.", solutionLabel: "Price in £"),
    Assignment(task: "What is the latest 🐦 by Uncle Donald (J. Trump)?", help: "In case you are out of the loop: Donald J. Trump, the POTUS (President of the United States) is really fond of Twitter, which you can find in the bookmarks. He posts really frequently so why not just take a look what the latest news is all about? In case you can't find him the Twitter handle @realDonaldTrump might help!", solutionLabel: "Tweet in one word"),
    Assignment(task: "What size is the HDD Backblaze can ship you?", help: "Backblaze provides an online personal backup solution. In order to restore files they can ship you either a USB stick or a Hard Disk. If you visit their site through the bookmarks and dig a little you can find the size of the restore drive they ship via FedEx for 189$!", solutionLabel: "Hard Disk size"),
    Assignment(task: "Find the price of Ribba 61x91 from IKEA!", help: "To view the IKEA catalogue, open the bookmarks. You should find the price of the RIBBA picture frame in black and with a size of 61x91, maybe the search helps?", solutionLabel: "Price in €"),
]

class AssignmentManager: ObservableObject {
    private let assignments: [Assignment] = examples
    
    @Published var overviewShown: Bool = false
    @Published private(set) var overviewIndex: Int? = 0
    @Published private(set) var currentIndex: Int? = nil
    
    var assignment: Assignment? {
        guard let currentIndex = currentIndex, currentIndex < assignments.count else {
            return nil
        }
        
        return assignments[currentIndex]
    }
    
    var nextAssignment: Assignment? {
        guard let nextIndex = overviewIndex, nextIndex < assignments.count else {
            return nil
        }
        
        return assignments[nextIndex]
    }
    
    func showNextOverview() {
        overviewIndex = currentIndex.flatMap { $0 + 1 } ?? 0
        overviewShown = true
    }
    
    func startNext() {
        if overviewShown {
            withAnimation {
                currentIndex = overviewIndex
                overviewShown = false
            }
        }
    }
    
    func finishCurrent() {
        showNextOverview()
    }
}

struct SomeThing: Identifiable {
    let id = UUID()
    let title: String
}

//struct ContentView: View {
//    @EnvironmentObject var assignmentManager: AssignmentManager
//    
//    @State var solution = ""
//    @State var solutionInputOpen = false
//    
//    var body: some View {
//        Group {
//            assignmentManager.assignment.flatMap { assignment in
//                AssignmentView(assignment: assignment, onSubmit: { assignmentManager.finishCurrent() }, solutionInputOpen: $solutionInputOpen, solution: $solution)
//            }
//        }.sheet(isPresented: .constant(assignmentManager.overviewShown)) {
//            ZStack {
//                assignmentManager.nextAssignment.flatMap {
//                    AssignmentOverview(number: assignmentManager.overviewIndex.flatMap { $0 + 1 } ?? 0, assignment: assignment, onSubmit: startNext)
//                }
//                
//                if assignmentManager.nextAssignment == nil {
//                    Text("You did it!")
//                }
//                
//                Text("Hi")
//            }
//        }.onAppear {
//            assignmentManager.showNextOverview()
//        }
//    }
//    
//    func startNext() {
//        solution = ""
//        solutionInputOpen = false
//        assignmentManager.startNext()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().preferredColorScheme(.dark)
//    }
//}

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
