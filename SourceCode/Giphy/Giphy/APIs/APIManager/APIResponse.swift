//
//  APIResponse.swift
//  Giphy
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK: - Enum APIResponse
enum APIResponse {
    case success
    case failed(reason: String, statusCode: Int?)
    
    static let unknownErrorText: String = "Unknown error happend".localized
    
    init(response: AFDataResponse<Data>) {
        guard let request = response.request else {
            self = .failed(reason: Self.unknownErrorText, statusCode: nil)
            return
        }
        vPrint("Request URL: \(request.url!.absoluteString)")
        if let data = request.httpBody, let requestParameters = try? JSON(data: data).dictionary {
            vPrint("Parameters : \(String(describing: requestParameters))")
        }
        guard let statusCode = response.response?.statusCode else {
            self = .failed(reason: Self.unknownErrorText, statusCode: nil)
            return
        }
        vPrint("Response Code: \(statusCode)")
        guard let data = response.data else {
            self = .failed(reason: Self.unknownErrorText, statusCode: statusCode)
            return }
        let responseJSON = try? JSON(data: data).dictionaryValue
        vPrint("Response(\(request.url!.absoluteString)): \(String(describing: responseJSON))")
        
        switch statusCode {
        case 200..<300:
            self = .success
        case 401:
            self = .failed(reason: "Unauthorized", statusCode: statusCode)
        case 400...500:
            if let text = responseJSON?["title"]?.string,
               let status = responseJSON?["status"]?.int {
                self = .failed(reason: text, statusCode: status)
            }else {
                self = .failed(reason: Self.unknownErrorText, statusCode: statusCode)
            }
        default:
            self = .failed(reason: "Network request failed.", statusCode: statusCode)
        }
    }
}
