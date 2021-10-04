//
//  GiphyImage.swift
//  Giphy
//

import Foundation

// MARK: - Struct GiphyImage
struct GiphyImage: Codable {
    let original: ImageSkelaton
    let downsized, downsizedLarge, downsizedMedium: ImageSkelaton
    let downsizedSmall: ImageSkelaton
    let downsizedStill: ImageSkelaton
    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: ImageSkelaton
    let fixedHeightSmallStill, fixedHeightStill: ImageSkelaton
    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: ImageSkelaton
    let fixedWidthSmallStill, fixedWidthStill: ImageSkelaton
    let looping: ImageSkelaton
    let originalStill: ImageSkelaton
    let originalMp4, preview: ImageSkelaton
    let previewGIF, the480WStill: ImageSkelaton
    let previewWebp: ImageSkelaton?
    let hd: ImageSkelaton?

    enum CodingKeys: String, CodingKey {
        case original, downsized
        case downsizedLarge = "downsized_large"
        case downsizedMedium = "downsized_medium"
        case downsizedSmall = "downsized_small"
        case downsizedStill = "downsized_still"
        case fixedHeight = "fixed_height"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case fixedHeightStill = "fixed_height_still"
        case fixedWidth = "fixed_width"
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidthSmall = "fixed_width_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedWidthStill = "fixed_width_still"
        case looping
        case originalStill = "original_still"
        case originalMp4 = "original_mp4"
        case preview
        case previewGIF = "preview_gif"
        case previewWebp = "preview_webp"
        case the480WStill = "480w_still"
        case hd
    }
}

// MARK: - Struct ImageSkelaton
struct ImageSkelaton: Codable {
    let height: String?
    let width: String?
    let size: String?
    let url: String?
    let mp4Size: String?
    let mp4: String?
    let webpSize: String?
    let webp: String?
    let frames: String?
    let hash: String?

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp, frames, hash
    }
    
    /// It will initialized **ImageSkelaton** object.
    /// - Parameter giphyCDM: It will represent **GiphyImageSizeCDM** object.
    init?(_ giphyCDM: GiphyImageSizeCDM?) {
        guard let giphyCDM = giphyCDM  else {return nil}
        height = giphyCDM.height
        width = giphyCDM.width
        size = giphyCDM.size
        url = giphyCDM.url
        mp4Size = giphyCDM.mp4Size
        mp4 = giphyCDM.mp4
        webpSize = giphyCDM.webpSize
        webp = giphyCDM.webp
        frames = giphyCDM.frames
        hash = giphyCDM.hashh
    }
}
