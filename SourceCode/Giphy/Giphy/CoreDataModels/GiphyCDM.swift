//
//  GiphyCDM.swift
//  Giphy
//

import UIKit
import CoreData

//MARK: - Class GiphyCDM
class GiphyCDM: NSManagedObject, ParentMO {
    @NSManaged var index: Int64
    @NSManaged var id: String
    @NSManaged var title: String?
    @NSManaged var authorName: String?
    @NSManaged var trendingOn: String
    @NSManaged var isFavourite: Bool
    @NSManaged var original: GiphyImageSizeCDM?
    @NSManaged var small: GiphyImageSizeCDM?
    @NSManaged var date: Date?
    
    /// It is used to update existing prorperties.
    /// - Parameter giphyVM: It will represent **GiphyVM** object.
    func update(_ giphyVM: GiphyVM) {
        id = giphyVM.id
        title = giphyVM.title
        authorName = giphyVM.authorName
        trendingOn = giphyVM.trendingOn
        
        guard let originalImage = giphyVM.originalImage else{original = nil;return}
        let oID = "\(giphyVM.id)_O"
        let objGiphyImageSizeO = GiphyImageSizeCDM.getEntity("id", value: oID)
        objGiphyImageSizeO.update(oID, giphyImage: originalImage)
        original = objGiphyImageSizeO
        
        guard let smallImage = giphyVM.smallImage else{small = nil;return}
        let sID = "\(giphyVM.id)_S"
        let objGiphyImageSizeS = GiphyImageSizeCDM.getEntity("id", value: sID)
        objGiphyImageSizeS.update(sID, giphyImage: smallImage)
        small = objGiphyImageSizeS
    }

    /// It is used to update favurite property.
    /// - Parameter isFavourite: Boolean type value.
    func isFavourite(_ isFavourite: Bool) {
        self.isFavourite = isFavourite
        self.date = Date()
        if self.isFavourite == false {
            (AppConfig.appDelegate as! AppDelegate).persistentContainer.viewContext.delete(self)
        }
    }
}
