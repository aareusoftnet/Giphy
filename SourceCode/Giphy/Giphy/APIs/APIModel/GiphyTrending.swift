//
//  GiphyTrending.swift
//  Giphy
//

import Foundation

// MARK: - Struct GiphyTrending
struct GiphyTrending: Codable {
    let arrOfGiphies: [Giphy]
    let pagination: Pagination
    let meta: GiphyMetaData
    
    enum CodingKeys: String, CodingKey {
        case arrOfGiphies = "data"
        case pagination, meta
    }
}
