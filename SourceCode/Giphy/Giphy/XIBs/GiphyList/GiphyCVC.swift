//
//  GiphyCVC.swift
//  Giphy
//

import UIKit

//MARK: - Class GiphyCVC
class GiphyCVC: ParentCVC {
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var viewGradientContainer: UIView!
    @IBOutlet weak var imgVwGradient: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    weak var delegate: UserTapDelegate?
    
    /// It will accept **GiphyVM** object.
    var objGiphyVM: GiphyVM? {
        didSet {
            prepareUIs()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// It will prepare UIs.
    func prepareUIs() {
        if let objGiphyVM = objGiphyVM {
            imgVw.backgroundColor = UIColor.darkListingColors[String.random("0123", length: 1)]
            imgVw.setImageWith(objGiphyVM.smallURL)
            lblTitle.text = objGiphyVM.title
            btnFavourite.setImage(UIImage(named: objGiphyVM.isFavourite ? "iconSmallFavouriteSelected" : "iconSmallFavourite"), for: .normal)
        }
    }
    
    @IBAction func onFavouriteTap(_ sender: UIButton) {
        guard let objGiphyVM = objGiphyVM else{return}
        delegate?.didTapOn?("~Favourite".localized, collectionCell: self, anyObject: objGiphyVM)
    }
}
