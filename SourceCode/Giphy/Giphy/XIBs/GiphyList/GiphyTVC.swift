//
//  GiphyTVC.swift
//  Giphy
//

import UIKit

//MARK: - Class GiphyTVC
class GiphyTVC: ParentTVC {
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var lblTrendingOn: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
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

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        backgroundColor = .black
    }
    
    /// It will prepare UIs.
    func prepareUIs() {
        if let objGiphyVM = objGiphyVM {
            imgVw.backgroundColor = UIColor.darkListingColors[String.random("0123", length: 1)]
            imgVw.setImageWith(objGiphyVM.smallURL)
            lblTrendingOn.text = objGiphyVM.displayTrendingOn
            lblTitle.text = objGiphyVM.title
            lblAuthor.text = objGiphyVM.displayAuthorName
            btnFavourite.setImage(UIImage(named: objGiphyVM.isFavourite ? "iconSmallFavouriteSelected" : "iconSmallFavourite"), for: .normal)
        }
    }
    
    @IBAction func onFavouriteTap(_ sender: UIButton) {
        guard let objGiphyVM = objGiphyVM else{return}
        Animation.springInAnimation(view: sender, completionBlock: nil)
        delegate?.didTapOn?("~Favourite".localized, tableCell: self, anyObject: objGiphyVM)
    }
}
