//
//  QuestionView.swift
//  MultiplicationMadness
//
//  Created by Tiger Yang on 9/4/21.
//

import SwiftUI

struct QuestionView: View {
    @Binding var showingSettings: Bool
    @Binding var questions: [Question]
    @Binding var numberQuestions: Int
    @Binding var highScore: Int
    
    @State private var currentQuestion: Int = 0
    @State private var correctAnswers: Int = 0
    
    // true if the wrong answer was chosen. Triggers the "next" question button, and a special wrong answer animation
    @State private var showingWrongAnswer: Bool = false
    
    // answer button colors, to allow animation
    @State private var buttonColors: [Color] = [.green, .green, .green, .green]
    
    // controls fade in / out of the entire question
    @State private var questionFadeOut: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                // the _ x _ question
                Image(systemName: "\(questions[currentQuestion].multiplicand).circle")
                    .renderingMode(.original)
                    .padding()
                    .font(.system(size: 50.0, weight: .bold))
                    .opacity(questionFadeOut ? 0 : 1)
                    .animation(.easeOut(duration: 0.25))
                Image(systemName: "multiply")
                    .renderingMode(.original)
                    .padding()
                    .font(.system(size: 50.0, weight: .bold))
                Image(systemName: "\(questions[currentQuestion].multiplier).circle")
                    .renderingMode(.original)
                    .padding()
                    .font(.system(size: 50.0, weight: .bold))
                    .opacity(questionFadeOut ? 0 : 1)
                    .animation(.easeOut(duration: 0.25))
            }
            
            VStack {
                // the 4 answer choice buttons
                ForEach(0 ..< 4) { index in
                    Button(action: {
                        buttonPressed(buttonNumber: index)
                    }) {
                        NumberButton(buttonText: "\(questions[currentQuestion].answers[index])", buttonColor: self.$buttonColors[index])
                    }
                }
                .opacity(questionFadeOut ? 0 : 1)
                .padding()
            }
            
            Spacer()
            // conditionally show the "next question" button
            if self.showingWrongAnswer {
                Button(action: {
                    nextQuestion()
                }) {
                    Text("Next")
                }
            }
            
            Text("Score: \(correctAnswers)")
        }
        .transition(.opacity)
        .onAppear {
            if self.numberQuestions > self.questions.count {
                self.numberQuestions = self.questions.count
            }
        }
    }
    
    func buttonPressed(buttonNumber: Int) {
        let thisQuestion = self.questions[currentQuestion]

        if thisQuestion.answers[buttonNumber] == thisQuestion.product {
            // correct answer was picked!
            if !self.showingWrongAnswer {
                // only give points if this was the first try
                self.correctAnswers += 1
            }
            
            nextQuestion()
        } else {
            // incorrect answer
            showingWrongAnswer = true
            for index in 0 ... 3 {
                // for all the wrong answers, animate button color to red
                if thisQuestion.answers[index] != thisQuestion.product {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.buttonColors[index] = .red
                    }
                }
            }
            
        }
        
    }
    
    func nextQuestion() {
        // triggers transition to next question, with all necessary state resets
        self.showingWrongAnswer = false
        self.currentQuestion += 1
        self.buttonColors = [.green, .green, .green, .green]
        
        // END game conditions...
        // if max number of questions reached
        // or, if 0 ("all") questions chosen, wait until entire list of questions are exhausted
        // or, if all questions exhausted (asked for more than total variations)
        if (self.currentQuestion == self.numberQuestions) || (self.numberQuestions == 0 && self.currentQuestion == (self.questions.count - 1)){
            // if high score, record before clearing
            if self.correctAnswers > self.highScore {
                self.highScore = self.correctAnswers
            }
            self.currentQuestion = 0
            self.correctAnswers = 0
            
            withAnimation {
                self.showingSettings = true
            }
        }
        
        // fade out
        self.questionFadeOut.toggle()
        // delayed fade in
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            withAnimation {
                self.questionFadeOut.toggle()
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    @State static var questions: [Question] = [
        Question(multiplicand: 5, multiplier: 3, answers: [15, 13, 12, 65]),
        Question(multiplicand: 2, multiplier: 3, answers: [8, 6, 9, 23]),
        Question(multiplicand: 5, multiplier: 6, answers: [12, 25, 36, 30])
    ]
    
    static var previews: some View {
        QuestionView(
            showingSettings: .constant(false),
            questions: self.$questions,
            numberQuestions: .constant(3),
            highScore: .constant(3))
    }
}
