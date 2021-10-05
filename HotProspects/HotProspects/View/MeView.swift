//
//  MeView.swift
//  HotProspects
//
//  Created by Tiger Yang on 10/3/21.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = ""
    @State private var emailAddress = ""
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: self.$name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)
                
                TextField("Email address", text: self.$emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])
                
                Image(uiImage: generateQRCode(from: "\(self.name)\n\(self.emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Spacer()
            }
            .navigationBarTitle("Your code")
        }
    }
    
    /// Generate QR Code for the string input data
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        self.filter.setValue(data, forKey: "inputMessage")

        if let outputImage = self.filter.outputImage {
            if let cgimg = self.context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
