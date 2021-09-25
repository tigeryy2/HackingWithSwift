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
    
    @State private var currentFilter: CIFilter = .sepiaTone()
    @State private var currentFilterName: String = "Sepia"
    @State private var filterAmount = 0.5
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var showingNoImageAlert = false
    @State private var showingImagePicker = false
    @State private var showingFiltersSheet = false
    
    // creating context is expensive! Share and use on many images if necessary
    let imageContext = CIContext()
    
    var body: some View {
        let filterAmountBinding = Binding<Double>(
            get: {
                self.filterAmount
            },
            set: {
                self.filterAmount = $0
                
                // reapply filter based on new intensity
                self.loadImage()
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
                        // image placeholder
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                HStack {
                    Text("Amount")
                    Slider(value: filterAmountBinding)
                }.padding(.vertical)
                
                HStack {
                    Button("\(self.currentFilterName) Filter") {
                        self.showingFiltersSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            // if no image is selected, trigger alert
                            self.showingNoImageAlert = true
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Image saved!")
                        }
                        imageSaver.errorHandler = {
                            print("Image save failure: \($0.localizedDescription)")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: self.$showingImagePicker, onDismiss: self.loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: self.$showingFiltersSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.currentFilterName = "Crystallize"
                        self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) {
                        self.currentFilterName = "Edges"
                        self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) {
                        self.currentFilterName = "Blur"
                        self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) {
                        self.currentFilterName = "Pixellate"
                        self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) {
                        self.currentFilterName = "Sepia"
                        self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) {
                        self.currentFilterName = "Unsharp Mask"
                        self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) {
                        self.currentFilterName = "Vignette"
                        self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
            .alert(isPresented: self.$showingNoImageAlert) {
                Alert(title: Text("Cannot Save Image"), message: Text("No image is selected"), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func loadImage() {
        // load the chosen image
        guard let inputImage = inputImage else { return }
        
        // conditional setting of filter parameters
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputAmountKey) {
            currentFilter.setValue(filterAmount, forKey: kCIInputAmountKey)
            print("has input amount")
        }
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterAmount, forKey: kCIInputIntensityKey)
            print("has intensity")
        }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterAmount * 200, forKey: kCIInputRadiusKey)
            print("has radius")
        }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterAmount * 100, forKey: kCIInputScaleKey)
            print("Has scale")
        }
        if inputKeys.contains(kCIInputSharpnessKey) {
            currentFilter.setValue(filterAmount, forKey: kCIInputSharpnessKey)
            print("has sharpness")
        }
        
        let beginImage = CIImage(image: inputImage)
        self.currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func applyProcessing() {
        guard let outputImage = self.currentFilter.outputImage else { return }
        
        if let cgimg = self.imageContext.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            self.image = Image(uiImage: uiImage)
            self.processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        // update filter and reload image
        self.currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
