//
//  GiphyFavouriteVM.swift
//  Giphy
//

import UIKit

//MARK: - Class GiphyFavouriteVM
class GiphyFavouriteVM: NSObject {

    /// It will fetch giphies based on searched query or trending giphies.
    /// - Parameters:
    ///   - query: It will represent **String** value.
    ///   - pagination: It will represent **APIPagination** object.
    ///   - completionBlock: It will represent completion block.
    func fetchGiphies(_ pagination: APIPagination? = nil, completionBlock:(([GiphyVM]?)-> ())? = nil) {
        let favouriteGiphies = fetch(pagination)
        var arrGiphies: [GiphyVM] = []
        favouriteGiphies?.forEach({ (objGiphyCDM) in
            arrGiphies.append(GiphyVM(objGiphyCDM))
        })
        completionBlock?(arrGiphies)
    }
    
    /// It is used to fetch stored giphy objects.
    /// - Parameters:
    ///   - isTrending: Bool type value to fetch only trending Giphies.
    ///   - pagination: APIPagination object to manage load more.
    /// - Returns: Collection of GiphyCDM objects.
    private func fetch(_ pagination: APIPagination? = nil) -> [GiphyCDM]? {
        return GiphyCDM.fetchDataFromEntity(pagination, sortDescs: [NSSortDescriptor(key: "date", ascending: false)])
    }
}
