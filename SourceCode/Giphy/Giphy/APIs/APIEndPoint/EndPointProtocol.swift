//
//  EndPointProtocol.swift
//  Giphy
//

import Foundation
import Alamofire

//MARK: - Protocol EndPointProtocol
protocol EndPointProtocol {
    var host: String { get }
    var pathPrefix: String { get }
    var pathSuffix: String { get }
    var URL: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
    var apiKey: String { get }
}

//MARK: EndPointProtocol Extension(s)
extension EndPointProtocol {
    
    var host: String {
        switch APIEnvironment.current {
        case .production:
            return "https://api.giphy.com/"
        case .development:
            return "https://api.giphy.com/"
        case .mock:
            return "https://api.giphy.com/"
        }
    }
    
    var pathPrefix: String {
        return "v1/"
    }
    
    var URL: String {
        return host + pathPrefix + pathSuffix
    }
    
    var headers: HTTPHeaders? {
        return [
            HTTPHeader.contentType("application/json"),
            HTTPHeader.acceptLanguage(Locale.current.languageCode!),
        ]
    }
    
    var apiKey: String {
        return "ULF3HgOQULYJ53gF2rTUXRgeQhTrJmn3"
    }
}
