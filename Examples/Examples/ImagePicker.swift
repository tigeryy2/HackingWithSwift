//
//  ImagePicker.swift
//  Examples
//
//  Created by Tiger Yang on 9/22/21.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    // NSObject is parent of most UIKit classes
    // UIImagePickerControllerDelegate allows detection of image selection
    // UINavigationControllerDelegate allows detection of image picker navigation
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        // Coord needs access to parent struct's funcs and variables/bindings...
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // find selected image, pass it to parent's binding
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            // exit image picker view
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    // called by swift automatically
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        // designates a coordinator for this UIViewController
        // any actions/feedback is reported to the coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}


