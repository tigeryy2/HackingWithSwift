//
//  Photo+CoreDataProperties.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/1/21.
//
//

import Foundation
import CoreData
import UIKit


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var filename: String?
    @NSManaged public var id: UUID?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var timestamp: Date?

    public var wrappedFilename: String {
        self.filename ?? "placeholder"
    }
    
    public var wrappedId: UUID {
        self.id ?? UUID()
    }
    
    public var wrappedInfo: String {
        self.info ?? "No info here"
    }
    
    public var wrappedName: String {
        self.name ?? "No One"
    }
    
    public func getUIImage() -> UIImage {
        let fullFilename = ContentView.getDocumentsDirectory()
            //.appendingPathComponent("SavedPhotos")
            .appendingPathComponent(self.wrappedFilename)
        
        if FileManager.default.fileExists(atPath: fullFilename.path) {
            guard let image = UIImage(contentsOfFile: fullFilename.path) else {
                fatalError("Unable to load UIImage from disk")
            }
            return image
        }
        
        fatalError("No data exists at expected path")
    }
}

extension Photo : Identifiable {

}
