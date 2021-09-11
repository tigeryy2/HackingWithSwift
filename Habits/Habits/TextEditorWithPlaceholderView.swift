//
//  TextEditorWithPlaceholderView.swift
//  Habits
//
//  Created by Tiger Yang on 9/10/21.
//

import SwiftUI

struct TextEditorWithPlaceholderView: View {
    @Binding var textEditorText: String
    let defaultText: String
    
    var body: some View {
        ZStack {
            if textEditorText.isEmpty {
                HStack {
                    Text(self.defaultText)
                        .foregroundColor(.gray.opacity(0.70))
                    Spacer()
                }
            }
            TextEditor(text: $textEditorText)
        }
    }
}

struct TextEditorWithPlaceholderView_Previews: PreviewProvider {
    
    @State static var text: String = ""
    static var previews: some View {
        Form {
            TextEditorWithPlaceholderView(
                textEditorText: self.$text,
                defaultText: "Description"
            )
        }
    }
}
