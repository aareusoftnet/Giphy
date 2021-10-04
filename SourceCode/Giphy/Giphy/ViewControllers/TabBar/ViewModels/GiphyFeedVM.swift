//
//  GiphyFeedVM.swift
//  Giphy
//

import UIKit
import Alamofire

//MARK: - Class GiphyFeedVM
class GiphyFeedVM: NSObject {
    private var dataRequest: DataRequest?
    private var apiManager: APIManager?
    private var pagination: APIPagination!
    
    /// It will update existing request parameters.
    /// - Parameter parameters: It will represent **Dictionary<String,Any>** object.
    /// - Returns: It will return update requeset body parameters.
    private func getUpdateRequest(_ parameters: Dictionary<String,Any>?) -> Dictionary<String,Any> {
        var requestParameters: Dictionary<String, Any> = ["api_key" : GiphyAPIKey]
        requestParameters.merge(pagination.getRequestParameters())
        guard let parameters = parameters else {return requestParameters}
        requestParameters.merge(parameters)
        return requestParameters
    }
    
    /// It will fetch giphies based on search query.
    /// - Parameters:
    ///   - query: It will represent **String** value.
    ///   - pagination: It will represent **APIPagination** object.
    ///   - completionBlock: It will represent completion block.
    private func searchGiphies(_ query: String, pagination: APIPagination, completionBlock:(([GiphyVM]?, String?)-> ())? = nil) {
        self.pagination = pagination
        self.pagination.isLoading = true
        
        let parameters = getUpdateRequest(["q": query])
        apiManager = APIManager(GiphyEndPoint.search(authorization: parameters))
        dataRequest?.cancel()
        dataRequest = apiManager?.call(decoderType: GiphyTrending.self, {[weak self](result) in
            guard let self = self else{return}
            switch result {
            case .success(let trendingGiphy):
                self.handleGiphiesResponse(trendingGiphy, completionBlock: completionBlock)
            case .failure(let reason, let statusCode):
                vPrint("\(reason) : \(String(describing: statusCode))")
                DispatchQueue.main.async {
                    completionBlock?(nil, reason)
                    self.pagination.isLoading = false
                }
            }
        })
    }
    
    /// It will fetch trending giphies.
    /// - Parameters:
    ///   - pagination: It will represent **APIPagination** object.
    ///   - completionBlock: It will represent completion block.
    private func trendingGiphies(_ pagination: APIPagination, completionBlock:(([GiphyVM]?, String?)-> ())? = nil) {
        self.pagination = pagination
        self.pagination.isLoading = true
        
        let parameters = getUpdateRequest(nil)
        apiManager = APIManager(GiphyEndPoint.trending(parameters: parameters))
        dataRequest?.cancel()
        dataRequest = apiManager?.call(decoderType: GiphyTrending.self, {[weak self](result) in
            guard let self = self else{return}
            switch result {
            case .success(let trendingGiphy):
                self.handleGiphiesResponse(trendingGiphy, completionBlock: completionBlock)
            case .failure(let reason, let statusCode):
                vPrint("\(reason) : \(String(describing: statusCode))")
                DispatchQueue.main.async {
                    completionBlock?(nil, reason)
                    self.pagination.isLoading = false
                }
            }
        })
    }
    
    /// It will handle giphies response.
    /// - Parameters:
    ///   - giphiesTrending: It will represent **GiphyTrending** object.
    ///   - completionBlock: It will represent completion block.
    private func handleGiphiesResponse(_ giphiesTrending: GiphyTrending, completionBlock:(([GiphyVM]?, String?)-> ())? = nil) {
        pagination.setISAllLoaded(giphiesTrending.arrOfGiphies.count == giphiesTrending.pagination.totalCount)
        
        var arrOfGiphies: [GiphyVM] = []
        giphiesTrending.arrOfGiphies.forEach { (objGiphy) in arrOfGiphies.append(GiphyVM(objGiphy))}
        
        DispatchQueue.main.async {
            completionBlock?(arrOfGiphies,nil);
            self.pagination.isLoading = false
        }
    }

    /// It will fetch giphies based on searched query or trending giphies.
    /// - Parameters:
    ///   - query: It will represent **String** value.
    ///   - pagination: It will represent **APIPagination** object.
    ///   - completionBlock: It will represent completion block.
    func fetchGiphies(_ query: String? = nil, pagination: APIPagination, completionBlock:(([GiphyVM]?, String?)-> ())? = nil) {
        if let query = query,
           query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            searchGiphies(query, pagination: pagination, completionBlock: completionBlock)
        }else{
            trendingGiphies(pagination, completionBlock: completionBlock)
        }
    }
}
