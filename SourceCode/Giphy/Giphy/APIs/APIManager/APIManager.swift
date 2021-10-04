//
//  APIManager.swift
//  Giphy
//

import Foundation
import Alamofire
import Combine

//MARK: - Enum Result<T>
enum Result<T>{
    case success(T)
    case failure(reason: String, statusCode: Int?)
}

//MARK: - Class APIManager
class APIManager {
    private let endPointProtocol: EndPointProtocol
    private var network: APIManager?
    private static var validationToast: ValidationToastView?
    private static var networkReachabilityManager = NetworkReachabilityManager.default!
    static var isInternetAvailable: Bool {networkReachabilityManager.isReachable}
    
    init(_ endPointProtocol: EndPointProtocol) {
        self.endPointProtocol = endPointProtocol
    }
    
    @discardableResult func callRequest(_ afDataResponse: @escaping ((AFDataResponse<Data>) -> Void)) -> DataRequest? {
        return AF.request(
            endPointProtocol.URL,
            method: endPointProtocol.httpMethod,
            parameters: endPointProtocol.parameters,
            encoding: endPointProtocol.parameterEncoding,
            headers: endPointProtocol.headers)
            .responseData(completionHandler: afDataResponse)
    }
    
    @discardableResult func call<T: Decodable>(decoderType: T.Type,_ result: @escaping (_ encodedData: Result<T>)->()) -> DataRequest?   {
        return callRequest { response in
            guard let _ = response.response?.statusCode else {return}
            let apiResponse = APIResponse(response: response)
            switch apiResponse {
            case .success:
                guard let data = response.data else {
                    result(.failure(reason: "Failed to parse data".localized, statusCode: nil))
                    return
                }
                do {
                    let codableData = try JSONDecoder().decode(decoderType.self, from: data)
                    result(.success(codableData))
                } catch let error as NSError {
                    vPrint(error)
                    result(.failure(reason: "Failed to parse data".localized, statusCode: nil))
                }
            case .failed(let reason, let statusCode):
                result(.failure(reason: reason, statusCode: statusCode))
            }
        }
    }
    
    @discardableResult func call(_ result: @escaping (_ encodedData: Result<Int>)->()) -> DataRequest? {
        return AF.request(
            endPointProtocol.URL,
            method: endPointProtocol.httpMethod,
            parameters: endPointProtocol.parameters,
            encoding: endPointProtocol.parameterEncoding,
            headers: endPointProtocol.headers)
            .responseData { [weak self] response in
                guard let _ = self, let statusCode = response.response?.statusCode else { return }
                let apiResponse = APIResponse(response: response)
                switch apiResponse {
                case .success:
                    guard let _ = response.data else { result(.success(statusCode)); return }
                    result(.success(statusCode))
                case .failed(let reason, let statusCode):
                    result(.failure(reason: reason, statusCode: statusCode))
                }
            }
    }
}

//MARK: Internet Availability
extension APIManager{
    
    static func addInterNetListner() {
        networkReachabilityManager.startListening {(status) in
            if case .reachable(_) = status {
                vPrint("INTERNET AVAILABLE.")
                _defaultCenter.post(name: nfInternetAvailable, object: nil, userInfo: nil)
                self.validationToast?.animateOut(0.3, delay: 0.0, completion: {
                    self.validationToast?.removeFromSuperview()
                })
            }else{
                vPrint("INTERNET NOT AVAILABLE.")
                _defaultCenter.post(name: nfInternetNotAvailable, object: nil, userInfo: nil)
                self.validationToast = ValidationToast.shared.show("~Your internet connection seems to be down.".localized, type: .error, autoHide: false)
            }
        }
    }
}
