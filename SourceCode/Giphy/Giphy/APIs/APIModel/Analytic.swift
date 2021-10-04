//
//  Analytic.swift
//  Giphy
//

import Foundation

// MARK: - Struct Analytic
struct Analytic: Codable {
    let onload, onclick, onsent: AnalyticURL
}

// MARK: - Struct AnalyticURL
struct AnalyticURL: Codable {
    let url: String
}
