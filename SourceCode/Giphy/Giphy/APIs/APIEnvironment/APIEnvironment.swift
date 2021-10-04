//
//  APIEnvironment.swift
//  Giphy
//

//MARK: - Enum APIEnvironment
enum APIEnvironment {
    case development
    case production
    case mock
    static var isMock = false
    static var current: APIEnvironment {
        guard !isMock else { return .mock }
        return BuildEnvironment.isProduction ? .production : .development
    }
}
