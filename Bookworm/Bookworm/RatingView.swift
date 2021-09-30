//
//  RatingView.swift
//  Bookworm
//
//  Created by Tiger Yang on 9/14/21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor: Color = .gray
    var onColor: Color = .yellow
    
    var body: some View {
        HStack {
            if !self.label.isEmpty {
                Text(label)
            }
            
            ForEach(1 ..< self.maxRating + 1) {
                number in
                self.chooseImage(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
                    .accessibilityLabel(Text("\(number == 1 ? "1 star" : "\(number) stars")"))
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(number > self.rating ? .isButton : [.isButton, .isSelected])

            }
        }
    }
    
    func chooseImage(for number: Int) -> Image {
        if number > self.rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
