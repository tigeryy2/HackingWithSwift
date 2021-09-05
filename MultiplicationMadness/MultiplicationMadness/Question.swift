//
//  Question.swift
//  MultiplicationMadness
//
//  Created by Tiger Yang on 9/4/21.
//

import Foundation

struct Question {
    var multiplicand: Int
    var multiplier: Int
    var answers: [Int]
    
    var product: Int {
        multiplicand * multiplier
    }
    
    static func generateQuestions(lowerBound: Int, higherBound: Int) -> [Question] {
        var questions: [Question] = [Question]()
        
        // generate every possible combination and add to the list of questions
        for num1 in lowerBound ... higherBound {
            for num2 in lowerBound ... higherBound {
                let generatedAnswers = Question.generateAnswers(multiplicand: num1, multiplier: num2)
                let thisQuestion = Question(multiplicand: num1, multiplier: num2, answers: generatedAnswers)
                questions.append(thisQuestion)
            }
        }
        
        // scramble the order before returning
        return questions.shuffled()
    }
    
    static func generateAnswers(multiplicand: Int, multiplier: Int) -> [Int] {
        var answers: [Int] = [multiplicand * multiplier]
        
        for _ in 0 ... 2 {
            let useMultiplicand: Bool = Bool.random()
            
            if useMultiplicand {
                let answer = multiplicand * Int.random(in: 1 ... 12)
                answers.append(answer)
            } else {
                let answer = multiplier * Int.random(in: 1 ... 12)
                answers.append(answer)
            }
        }
        
        // scramble answers before return...
        return answers.shuffled()
    }
}
