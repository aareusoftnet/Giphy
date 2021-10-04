//
//  DetailsVM.swift
//  Giphy
//

import UIKit

//MARK: - Class DetailsVM
class DetailsVM: NSObject {
    var giphy: GiphyVM!
    
    /// It will initialize **DetailsVM** object.
    /// - Parameter giphies: Define **GiphyVM** object.
    init(_ giphy: GiphyVM) {
        self.giphy = giphy
    }
}
