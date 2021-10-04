//
//  FavouriteVC.swift
//  Giphy
//

import UIKit
import CHTCollectionViewWaterfallLayout

//MARK: - Class FavouriteVC
class FavouriteVC: ParentVC {
    @IBOutlet weak var viewNoGiphyContainer: UIView!
    @IBOutlet weak var lblNoGiphy: UILabel!
    @IBOutlet weak var imgVwNoGiphy: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var vmFavouriteGiphy = GiphyFavouriteVM()
    private var arrOfGiphies: [GiphyVM] = []
}

// MARK: UIViewController method(s) & propertie(s)
extension FavouriteVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavouriteGiphies()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.details {
            let vcDetails = ((segue.destination as! NavigationVC).children.first as! DetailsVC)
            vcDetails.vmDetails = DetailsVM(sender as! GiphyVM)
            vcDetails.completionBlock = {[weak self](isFinish, anyObject, viewController) in
                guard let self = self else{return}
                self.fetchFavouriteGiphies()
            }
        }
    }
}

//MARK: UIRelated
extension FavouriteVC {
    
    /// It will prepare UIs.
    func prepareUIs() {
        prepareNavigationBarUIs()
        prepareNoGiphyUIs()
        configureCollectionViewLayout()
        registerNIBs()
        addPullToRefresh()
    }
    
    /// It will prepare navigation bar UIs.
    func prepareNavigationBarUIs() {
        viewNavigationBar?.viewNavigationBar.lblTitle.attributedText = "~Favourite Gihpies".localized.setString(.center, textFont: UIFont.robotoBold(ofSize: 18), foregroundColor: .whiteLightGrey)
    }
    
    /// It will prepare no giphy UIs.
    func prepareNoGiphyUIs() {
        viewNoGiphyContainer.isHidden = arrOfGiphies.isEmpty == false
        lblNoGiphy.text = "~You don’t have any Favourite Giphies".localized
        imgVwNoGiphy.image = UIImage(named: "imgNoFavouriteGiphy")
    }
    
    /// It will configure collection view layout.
    func configureCollectionViewLayout() {
        let layout = CHTCollectionViewWaterfallLayout()
        // Change individual layout attributes for the spacing between cells
        layout.minimumColumnSpacing = 6.0
        layout.minimumInteritemSpacing = 6.0

        // Collection view attributes
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.alwaysBounceVertical = true

        // Add the waterfall layout to your collection view
        collectionView.collectionViewLayout = layout
    }
    
    /// It will register list of NIBs to table view.
    func registerNIBs() {
        collectionView.register(GiphyCVC.nib, forCellWithReuseIdentifier: GiphyCVC.identifier)
    }
    
    /// It will add pull to refresh control to table view.
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .whiteLightGrey
        refreshControl.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    /// It will handle events when pull to refresh start.
    /// - Parameter refreshControl: It will represent **UIRefreshControl** object.
    @objc func didRefresh(_ refreshControl: UIRefreshControl? = nil) {
        fetchFavouriteGiphies(refreshControl)
    }
    
    /// It will display confirmation alert before user's action.
    /// - Parameters:
    ///   - cellFeed: Define **GiphyCVC** UIs Object.
    ///   - giphyVM: Define **GiphyVM** Object.
    ///   - indexPath: Define **IndexPath** Object.
    func showConfirmationDialog(_ cellFeed: GiphyCVC, giphyVM: GiphyVM, indexPath: IndexPath) {
        UIAlertController.show(title: "~Remove".localized, message: "~Are you sure to remove your favourite giphy from your list?".localized, style: .alert, buttons: ["~Remove".localized, "~Cancel".localized], controller: self) {[weak self](userAction) in
            guard let self = self else{return}
            if userAction == "~Remove".localized {
                giphyVM.setISFavourite()
                cellFeed.objGiphyVM = giphyVM
                self.prepareUIsAfterRemove(giphyVM, indexPath: indexPath)
            }
        }
    }
    
    /// It will prepare UIs after remove from favourite list.
    func prepareUIsAfterRemove(_ giphyVM: GiphyVM, indexPath: IndexPath?) {
        arrOfGiphies.remove(giphyVM)
        guard let indexPath = indexPath else{collectionView.reloadData();return}
        collectionView.deleteItems(at: [indexPath])
        prepareNoGiphyUIs()
    }
}

//MARK: UICollectionView
extension FavouriteVC: UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrOfGiphies.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        arrOfGiphies[indexPath.item].aspectRatioInSmallSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCVC.identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell is GiphyCVC {
            let cellGiphy = cell as! GiphyCVC
            cellGiphy.delegate = self
            cellGiphy.objGiphyVM = arrOfGiphies[indexPath.item]
//            if indexPath.row == arrOfGiphies.count - 1  &&
//                objPagination.isLoading == false &&
//                objPagination.isAllLoaded == false {
//                fetchFavouriteGiphies()
//            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.details, sender: arrOfGiphies[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let sbDetails = UIStoryboard(name: "Details", bundle: nil)
        let previewProvider: () -> DetailsVC = { [unowned self] in
            let vcDetails = sbDetails.instantiateViewController(identifier: "DetailsVC")  as! DetailsVC
            vcDetails.vmDetails = DetailsVM(arrOfGiphies[indexPath.item])
            return vcDetails
        }
        
        let actionProvider: ([UIMenuElement]) -> UIMenu? = { [weak self] _ in
            guard let self = self else{return nil}
            var arrOfMenuElement: [UIMenuElement] = []
            let shareMenu = UIAction(title: "~Share".localized, image: UIImage(systemName: "square.and.arrow.up"), identifier: UIAction.Identifier(rawValue: "share")) {[weak self] _ in
                guard let self = self else{return}
                DispatchQueue.main.async {self.openShareKit(self.arrOfGiphies[indexPath.item])}
            }
            arrOfMenuElement.append(shareMenu)
            if self.arrOfGiphies[indexPath.item].isFavourite {
                let removeFromFavouriteMenu = UIAction(title: "~Remove from Favourite".localized, image: UIImage(systemName: "star.fill"), identifier: UIAction.Identifier(rawValue: "star.fill")) {[weak self] _ in
                    guard let self = self else{return}
                    DispatchQueue.main.async {self.prepareUIsAfterRemove(self.arrOfGiphies[indexPath.item], indexPath: indexPath)}
                }
                arrOfMenuElement.append(removeFromFavouriteMenu)
            }
            return UIMenu(title: "", image: nil, identifier: nil, children: arrOfMenuElement)
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: previewProvider, actionProvider: actionProvider)
    }
}

//MARK: UserTapDelegate
extension FavouriteVC: UserTapDelegate {
    
    func didTapOn(_ text: String, collectionCell: ParentCVC?, anyObject: Any?) {
        if let cellFeed = collectionCell as? GiphyCVC,
           let objGiphyVM = anyObject as? GiphyVM,
           let indexPath = collectionView.indexPath(for: cellFeed),
           text == "~Favourite".localized {
            showConfirmationDialog(cellFeed, giphyVM: objGiphyVM, indexPath: indexPath)
        }
    }
}

//MARK: Other(s)
extension FavouriteVC {
    
    func fetchFavouriteGiphies(_ refreshControl: UIRefreshControl? = nil) {
        arrOfGiphies = []
        vmFavouriteGiphy.fetchGiphies(nil) {[weak self](giphies) in
            guard let self = self else{return}
            refreshControl?.endRefreshing()
            if let giphies = giphies {
                self.arrOfGiphies.append(contentsOf: giphies)
                self.collectionView.reloadData()
                self.prepareNoGiphyUIs()
            }
        }
    }
}
