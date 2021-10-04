//
//  GiphyVM.swift
//  Giphy
//

import UIKit

//MARK: - GiphyVM
class GiphyVM: NSObject {
    let id: String
    let title: String?
    let trendingOn: String
    let authorName: String?
    let smallImage: ImageSkelaton?
    let originalImage: ImageSkelaton?
    
    //To display small gif image.
    var smallURL: URL? {
        return (smallImage == nil ? nil : (smallImage!.url == nil ? nil : URL(string: smallImage!.url!)))
    }
    
    //To display original gif image.
    var originalURL: URL? {
        return (originalImage == nil ? nil : (originalImage!.url == nil ? nil : URL(string: originalImage!.url!)))
    }

    //To display trending texts on UIs.
    var displayTrendingOn: String? {
        if let date = Date.dateFromServer(trendingOn, format: "yyyy-MM-dd HH:mm:ss") {
            return date.timeAgoSinceDate(true)
        }else{
            return nil
        }
    }
    
    //To display authorname texts on UIs.
    var displayAuthorName: String? {
        return "~Author: ".localized + (authorName == nil ? "--" : authorName!)
    }
    
    //To check it's favourite giphy or not.
    var isFavourite: Bool {
        let storedGiphies = GiphyCDM.fetchDataFromEntity()
        guard let objStoredGiphy = storedGiphies.filter({$0.id == id}).first
        else{return false}
        return objStoredGiphy.isFavourite
    }
    
    /// Provide aspect ration giphy image size.
    var aspectRatioInSmallSize: CGSize {
        guard let smallImage = smallImage,
              let smallImageHeight = smallImage.height,
              let smallImageHeightCGFloat = smallImageHeight.toCGFloat,
              let smallImageWidth = smallImage.width,
              let smallImageWidthCGFloat = smallImageWidth.toCGFloat
        else{return .zero}
        let fixedWidth: CGFloat = ((AppConfig.width - 22)/2)
        let aspectRatioHeight: CGFloat = (fixedWidth * (smallImageHeightCGFloat/smallImageWidthCGFloat))
        return CGSize(width: fixedWidth, height: aspectRatioHeight)
    }
    
    /// Provide aspect ration giphy image size.
    var aspectRatioForOriginalSize: CGSize {
        guard let originalImage = originalImage,
              let originalImageHeight = originalImage.height,
              let originalImageHeightCGFloat = originalImageHeight.toCGFloat,
              let originalImageWidth = originalImage.width,
              let originalImageWidthCGFloat = originalImageWidth.toCGFloat
        else{return .zero}
        let fixedWidth: CGFloat = AppConfig.width
        let aspectRatioHeight: CGFloat = (fixedWidth * (originalImageHeightCGFloat/originalImageWidthCGFloat))
        return CGSize(width: fixedWidth, height: aspectRatioHeight)
    }
    
    /// Provide aspect ration giphy image size.
    var aspectRatioOriginalImage: CGFloat {
        guard let originalImage = originalImage,
              let originalImageHeight = originalImage.height,
              let originalImageHeightCGFloat = originalImageHeight.toCGFloat,
              let originalImageWidth = originalImage.width,
              let originalImageWidthCGFloat = originalImageWidth.toCGFloat
        else{return .leastNonzeroMagnitude}
        return originalImageHeightCGFloat/originalImageWidthCGFloat
    }

    override func isEqual(_ object: Any?) -> Bool {
        super.isEqual(object)
        return (object as! GiphyVM).id == id
    }
    
    /// It will initialized object from **Giphy** model
    /// - Parameter giphy: It will represent **Giphy** object value.
    init(_ giphy: Giphy) {
        id = giphy.id
        trendingOn = giphy.trendingDatetime
        title = giphy.title
        authorName = giphy.user?.displayName
        originalImage = giphy.images.original
        smallImage = giphy.images.fixedWidth
    }
    
    /// It will initialized object from **GiphyCDM** model
    /// - Parameter giphy: It will represent **GiphyCDM** object value.
    init(_ giphyCDM: GiphyCDM) {
        id = giphyCDM.id
        trendingOn = giphyCDM.trendingOn
        title = giphyCDM.title
        authorName = giphyCDM.authorName
        originalImage = ImageSkelaton(giphyCDM.original)
        smallImage = ImageSkelaton(giphyCDM.small)
    }
    
    /// It will modify **isFavourite** property.
    func setISFavourite() {
        let objCDM = GiphyCDM.getEntity("id", value: id)
        objCDM.update(self)
        objCDM.isFavourite(!isFavourite)
        (AppConfig.appDelegate as! AppDelegate).saveContext()
    }
}
