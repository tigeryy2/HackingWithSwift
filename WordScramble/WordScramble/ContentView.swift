//
//  ContentView.swift
//  WordScramble
//
//  Created by Tiger Yang on 8/25/21.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord: String = "Test"
    @State private var newWord: String = ""
    @State private var addedWords: [String] = [String]()
    
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // "addWord" closure called upon return key
                TextField("Enter a word", text: $newWord, onCommit: addWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                
                List(addedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: {
                startGame()
            })
            .alert(isPresented: $showingError, content: {
                Alert(
                    title: Text(errorTitle),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func addWord() {
        // clean up the word a little
        let wordToAdd = self.newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        // check that word has at least 1 letter
        guard wordToAdd.count > 0 else {
            return
        }
        
        guard isOriginal(word: wordToAdd) else {
            wordError(title: "Word has been added already", message: "Please be more original")
            return
        }
        
        guard isPossibleCombo(word: wordToAdd) else {
            wordError(title: "This is not a possible combination", message: "Try again")
            return
        }
        
        guard isWord(word: wordToAdd) else {
            wordError(title: "This is not a word", message: "Try again")
            return
        }
        
        self.addedWords.insert(wordToAdd, at: 0)
        self.newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        return !self.addedWords.contains(word)
    }
    
    func isPossibleCombo(word: String) -> Bool {
        // need to copy rootword so we can modify it
        var rootWordTemp = self.rootWord
        
        // for each letter, check that it exists in the root word
        // remove letter from the root after, to ensure no letter is used twice
        for letter in word {
            if let thisLetterIndex = rootWordTemp.firstIndex(of: letter) {
                rootWordTemp.remove(at: thisLetterIndex)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isWord(word: String) -> Bool {
        let checker = UITextChecker()
        let wordRange = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: wordRange, startingAt: 0, wrap: false, language: "en")
        
        // word is considered valid if spellcheck does not find any misspellings
        return misspelledRange.location == NSNotFound
    }
    
    func startGame() {
        // grabs start.txt, running code only if it works
        if let startTextUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // convert into string
            if let startWords = try? String(contentsOf: startTextUrl) {
                // the words are seperated by newline
                let allStartWords = startWords.components(separatedBy: "\n")
                
                // grab one random element, unpack the optional
                self.rootWord = allStartWords.randomElement() ?? "oops"
                
                // we should be good to go!
                return
            }
        }
        
        // somewhere, something broke. fatalerror ends the app
        fatalError("Could not load start.txt from app bundle")
    }
    
    func wordError(title: String, message: String) {
        self.errorTitle = title
        self.errorMessage = message
        self.showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
