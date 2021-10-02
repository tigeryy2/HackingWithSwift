//
//  PhotoDetailView.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/2/21.
//

import CoreData
import SwiftUI

struct PhotoDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let photo: Photo
    
    var body: some View {
        GeometryReader {
            geometry in
            VStack {
                Text(photo.wrappedName)
                    .font(.title)
                
                Text(photo.wrappedInfo)
                    .font(.body)
                
                Image(uiImage: photo.getUIImage())
                    .resizable()
                    .scaledToFit()
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                
                // Push everything up
                Spacer()
            }
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    // can create a static managed object context just for the preview
    static let previewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        PhotoDetailView(photo: Photo(context: previewContext))
    }
}
