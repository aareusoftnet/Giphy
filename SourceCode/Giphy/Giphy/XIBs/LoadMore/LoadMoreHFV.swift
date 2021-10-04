//
//  LoadMoreHFV.swift
//  Giphy
//

import UIKit

//MARK: - Class LoadMoreHFV
class LoadMoreHFV: ParentHFV {
    @IBOutlet weak var viewActivityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// It will start activity indicator animation
    func startAnimation() {
        viewActivityIndicator.startAnimating()
    }
    
    /// It will stop activity indicator animation
    func stopAnimation() {
        viewActivityIndicator.stopAnimating()
    }
}
