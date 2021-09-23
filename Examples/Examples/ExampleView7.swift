//
//  ExampleView7.swift
//  Examples
//
//  Created by Tiger Yang on 9/22/21.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ExampleView7: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
    func loadImage2() {
        guard let inputImage = UIImage(named: "IMG_0068") else { return }
        
        // core image "image recipe"
        let beginImage = CIImage(image: inputImage)
        
        // setup filter and context
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        
        // new "swifted" api
        currentFilter.inputImage = beginImage
        // old api
        //currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        // filter intensity ranges 0-1
        currentFilter.radius = 100
        
        // get a CIImage from our filter or exit if that fails
        guard let outputImage = currentFilter.outputImage else { return }
        
        // attempt to get a CGImage from our CIImage
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            // convert that to a UIImage
            let uiImage = UIImage(cgImage: cgimg)
            
            // and convert that to a SwiftUI image
            image = Image(uiImage: uiImage)
        }
        
    }
}

struct ExampleView7_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView7()
    }
}
