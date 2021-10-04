//
//  Pagination.swift
//  Giphy
//

import Foundation

// MARK: - Struct Pagination
struct Pagination: Codable {
    let totalCount, count, offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}
