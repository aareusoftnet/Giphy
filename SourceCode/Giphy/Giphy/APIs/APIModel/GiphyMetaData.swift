//
//  GiphyMetaData.swift
//  Giphy
//

import Foundation

// MARK: - Struct GiphyMetaData
struct GiphyMetaData: Codable {
    let status: Int
    let msg, responseID: String

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}
