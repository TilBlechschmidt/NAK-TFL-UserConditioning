//
//  QuestionView.swift
//  WebSurvey
//
//  Created by Til Blechschmidt on 11.07.20.
//

import SwiftUI

enum Occupation: String, CaseIterable {
    case Schüler
    case Student
    case Arbeitstätig
    case Rentner
}

extension Occupation: Identifiable {
    var id: String { rawValue }
}

struct QuestionView: View {
    @State var selected: Occupation?
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text("What describes your occupation best?")
                    .font(.largeTitle)
                    .padding()
                    .transition(.slide)
                
                ForEach(Occupation.allCases) { occupation in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(self.selected == occupation ? Color.accentColor : Color("bar"))
                        .padding()
                        .frame(width: 450, height: 100)
                        .overlay(Text(occupation.rawValue).font(.title))
                        .onTapGesture {
                            withAnimation {
                                self.selected = occupation
                            }
                        }
                }
                    .animation(Animation.default.delay(2))
                    .transition(.slide)
                
                if selected != nil {
                    Button("Submit", action: {}).font(.title)
                        .padding(.top, 20)
                }
                
                Spacer()
            }
            Spacer()
        }
            .background(Color("barBackground"))
            .edgesIgnoringSafeArea(.all)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
            .preferredColorScheme(.dark)
    }
}
