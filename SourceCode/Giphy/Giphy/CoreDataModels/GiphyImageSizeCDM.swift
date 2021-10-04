//
//  GiphyImageSizeCDM.swift
//  Giphy
//

import UIKit
import CoreData

//MARK: - Class GiphyImageSizeCDM
class GiphyImageSizeCDM: NSManagedObject, ParentMO {
    @NSManaged var id: String
    @NSManaged var url: String?
    @NSManaged var width: String?
    @NSManaged var height: String?
    @NSManaged var size: String?
    @NSManaged var mp4Size: String?
    @NSManaged var mp4: String?
    @NSManaged var webpSize: String?
    @NSManaged var webp: String?
    @NSManaged var frames: String?
    @NSManaged var hashh: String?

    /// It will update **NSManagedObject** properties.
    /// - Parameters:
    ///   - id: Represent **String** value.
    ///   - giphyImage: Represent **ImageSkelaton** value.
    func update(_ id: String, giphyImage: ImageSkelaton) {
        self.id = id
        self.url = giphyImage.url
        self.width = giphyImage.width
        self.height = giphyImage.height
    }
}
