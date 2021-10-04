//
//  GiphyEndPoint.swift
//  Giphy
//

import Alamofire

//MARK: - Enum GiphyEndPoint
enum GiphyEndPoint {
    case trending(parameters: [String : Any])
    case search(authorization: [String : Any])
}

//MARK: GiphyEndPoint Extension(s)
extension GiphyEndPoint: EndPointProtocol {
    
    var pathSuffix: String {
        switch self {
        case .trending:
            return "gifs/trending"
        case .search:
            return "gifs/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .trending, .search:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .trending(let parameters):
            return parameters
        case .search(let authorization):
            return authorization
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .trending, .search:
            return URLEncoding.default
        }
    }
}
