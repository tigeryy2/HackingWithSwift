//
//  ContentView.swift
//  Instafilter
//
//  Created by Tiger Yang on 9/20/21.
//

import SwiftUI
import CoreData
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = .sepiaTone()
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    
    // creating context is expensive! Share and use on many images if necessary
    let imageContext = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        NavigationView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.secondary.opacity(0.45))
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)
                
                HStack {
                    Button("Change Filter") {
                        // change filter
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // save the picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: self.$showingImagePicker, onDismiss: self.loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }
    
    func loadImage() {
        // load the chosen image
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        self.currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        self.currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        //self.$currentFilter.intensity = Float(filterIntensity)
        
        guard let outputImage = self.currentFilter.outputImage else { return }
        
        if let cgimg = self.imageContext.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
