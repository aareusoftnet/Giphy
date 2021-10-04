//
//  DetailsVC.swift
//  Giphy
//

import UIKit
import CHTCollectionViewWaterfallLayout

//MARK: - Class DetailsVC
class DetailsVC: ParentVC {
    @IBOutlet weak var viewGiphyContainer: UIView!
    @IBOutlet weak var imgVwGiphy: UIImageView!
    @IBOutlet weak var conHeightViewGiphyContainer: NSLayoutConstraint!
    
    //Carried variable
    var vmDetails: DetailsVM!
}

// MARK: UIViewController method(s) & propertie(s)
extension DetailsVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIs()
    }

    override func navigationBarHandler() {
        viewNavigationBar?.actionHandlerWith({[weak self](navigationBar, navigationAction, tapButton) in
            guard let self = self else{return}
            switch navigationAction {
            case .favouriteUnFavourite:
                self.didTapOnFavouriteUnFavourite()
            case .dismissController:
                self.dismiss(animated: true, completion: nil)
            default: break
            }
        })
    }
}

//MARK: UIRelated
extension DetailsVC {
    
    /// It will prepare UIs.
    func prepareUIs() {
        prepareNavigationBarUIs()
        prepareGiphyContainerUIs()
        prepareGiphyUIs()
    }
    
    /// It will prepare navigation bar UIs.
    func prepareNavigationBarUIs() {
        prepareNavigationBarTitleUIs()
        prepareNavigationBarRightUIs()
    }
    
    /// It will prepare navigation bar title UIs.
    func prepareNavigationBarTitleUIs() {
        viewNavigationBar?.viewNavigationBar.lblTitle.attributedText = (vmDetails.giphy.title ?? "--").setString(.center, textFont: UIFont.robotoBold(ofSize: 18), foregroundColor: .whiteLightGrey)
    }
    
    /// It will prepare navigation bar right UIs.
    func prepareNavigationBarRightUIs() {
        viewNavigationBar?.viewNavigationBar.btnRight.setImage(UIImage(named: vmDetails.giphy.isFavourite ? "iconFavouriteSelected" : "iconFavourite"), for: .normal)
    }
    
    /// It will call when user tap on Favourite or Unfavourite button from NavigationBar.
    func didTapOnFavouriteUnFavourite() {
        if vmDetails.giphy.isFavourite {
            showConfirmationDialog()
        }else{
            vmDetails.giphy.setISFavourite()
            prepareNavigationBarRightUIs()
            Animation.springInAnimation(view: viewNavigationBar!.viewNavigationBar.btnRight, completionBlock: nil)
            completionBlock?(true,vmDetails.giphy,self)
        }
    }
    
    /// It will display confirmation alert before user's action.
    func showConfirmationDialog() {
        UIAlertController.show(title: "~Remove".localized, message: "~Are you sure to remove your favourite giphy from your list?".localized, style: .alert, buttons: ["~Remove".localized, "~Cancel".localized], controller: self) {[weak self](userAction) in
            guard let self = self else{return}
            if userAction == "~Remove".localized {
                self.vmDetails.giphy.setISFavourite()
                self.prepareNavigationBarRightUIs()
                Animation.springInAnimation(view: self.viewNavigationBar!.viewNavigationBar.btnRight, completionBlock: nil)
                self.completionBlock?(true, self.vmDetails.giphy, self)
            }
        }
    }
    
    /// It will prepare giphy container aspect ratio.
    func prepareGiphyContainerUIs() {
        conHeightViewGiphyContainer.constant = vmDetails.giphy.aspectRatioForOriginalSize.height
    }
    
    /// It will prepare giphy UIs.
    func prepareGiphyUIs() {
        imgVwGiphy.backgroundColor = UIColor.darkListingColors[String.random("0123", length: 1)]
        imgVwGiphy.setImageWith(vmDetails.giphy.originalURL)
    }
}
