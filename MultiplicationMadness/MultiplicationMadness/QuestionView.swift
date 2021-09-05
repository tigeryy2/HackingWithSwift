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
    
    @State private var currentQuestion: Int = 0
    @State private var correctAnswers: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "\(questions[currentQuestion].multiplicand).circle")
                    .renderingMode(.original)
                    .padding()
                    .font(.system(size: 50.0, weight: .bold))
                Image(systemName: "multiply")
                    .renderingMode(.original)
                    .padding()
                    .font(.system(size: 50.0, weight: .bold))
                Image(systemName: "\(questions[currentQuestion].multiplier).circle")
                    .renderingMode(.original)
                    .padding()
                    .font(.system(size: 50.0, weight: .bold))
            }
            
            VStack {
                ForEach(0 ..< 4) { index in
                    Button(action: {
                        buttonPressed(buttonNumber: index)
                    }) {
                        NumberButton(buttonText: "\(questions[currentQuestion].answers[index])")
                            
                    }
                }
                .padding()
            }
            .padding()
            
            Spacer()
            Text("Score: \(correctAnswers)")
        }
    }
    
    func buttonPressed(buttonNumber: Int) {
        let thisQuestion = self.questions[currentQuestion]

        if thisQuestion.answers[buttonNumber] == thisQuestion.product {
            // correct answer was picked!
            self.correctAnswers += 1
            self.currentQuestion += 1
        } else {
            // incorrect answer
            self.currentQuestion += 1
        }
        
        if self.currentQuestion == self.numberQuestions {
            self.currentQuestion = 0
            self.correctAnswers = 0
            self.showingSettings = true
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
            numberQuestions: .constant(3))
    }
}
