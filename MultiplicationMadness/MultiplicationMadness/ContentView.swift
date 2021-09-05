//
//  ContentView.swift
//  MultiplicationMadness
//
//  Created by Tiger Yang on 9/2/21.
//

import SwiftUI

struct ContentView: View {
    // false when game is running, true during settings mode
    @State private var showingSettings: Bool = true
    // lowest number (need to + 1 for row to num conversion)
    @State private var tableLowerBound: Int = 1
    // highest number (need to + 1 for row to num conversion)
    @State private var tableHigherBound: Int = 6
    // max number of questions to ask
    @State private var numberQuestions: Int = 10
    @State private var questions: [Question] = [Question]()
    @State private var highScore: Int = 0
        
    var body: some View {
        if showingSettings {
            Group {
                SettingsView(
                    tableLowerBound: self.$tableLowerBound,
                    tableHigherBound: self.$tableHigherBound,
                    numberQuestions: self.$numberQuestions,
                    highScore: self.$highScore) {
                    // first, generate questions
                    questions = Question.generateQuestions(lowerBound: tableLowerBound + 1, higherBound: tableHigherBound + 1)
                    
                    // start the game
                    withAnimation {
                        showingSettings.toggle()
                    }
                }
            }
        } else {
            Group {
                QuestionView(
                    showingSettings: self.$showingSettings,
                    questions: self.$questions,
                    numberQuestions: self.$numberQuestions,
                    highScore: self.$highScore
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
