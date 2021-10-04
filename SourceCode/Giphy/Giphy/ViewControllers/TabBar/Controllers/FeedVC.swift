//
//  FeedVC.swift
//  Giphy
//

import UIKit

//MARK: - Class FeedVC
class FeedVC: ParentVC {
    @IBOutlet weak var viewSearchBar: UIView!
    @IBOutlet weak var viewSearchBarContainer: UIView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnClearTexts: UIButton!
    
    private var objPagination = APIPagination(0, limit: 20)
    private var vmGiphyFeed = GiphyFeedVM()
    private var arrOfGiphies: [GiphyVM] = []
    private var isSearching: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    deinit {
        removeObservers()
    }
}

// MARK: UIViewController method(s) & propertie(s)
extension FeedVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIs()
        addObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.details {
            let vcDetails = ((segue.destination as! NavigationVC).children.first as! DetailsVC)
            vcDetails.vmDetails = DetailsVM(sender as! GiphyVM)
            vcDetails.completionBlock = {[weak self](isFinish, anyObject, viewController) in
                guard let self = self else{return}
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: AddObserver(s)
extension FeedVC {
    
    func addObservers() {
        _defaultCenter.addObserver(self, selector: #selector(internetConnectionAvailable(_:)), name: nfInternetAvailable, object: nil)
    }
    
    @objc func internetConnectionAvailable(_ notification: Notification) {
        didRefresh(nil)
    }
    
    func removeObservers() {
        _defaultCenter.removeObserver(self, name: nfInternetAvailable, object: nil)
    }
}

//MARK: UIRelated
extension FeedVC {
    
    /// It will prepare UIs.
    func prepareUIs() {
        prepareSearchBarUIs()
        registerNIBs()
        addPullToRefresh()
        didRefresh(nil)
    }
    
    /// It will prepare search bar UIs.
    func prepareSearchBarUIs() {
        prepareSearchFieldUIs()
        hideOrShowClearButton()
    }
    
    /// It will prepare search bar textField UIs.
    func prepareSearchFieldUIs() {
        txtFieldSearch.setAttributed("~Search in giphies".localized, color: .whiteLightGrey, font: .robotoBold(ofSize: 16))
        txtFieldSearch.font = .robotoBold(ofSize: 16)
        txtFieldSearch.textColor = .whiteLightGrey
        txtFieldSearch.tintColor = .whiteLightGrey
        txtFieldSearch.keyboardType = .asciiCapable
        txtFieldSearch.keyboardAppearance = .dark
        txtFieldSearch.autocorrectionType = .no
        txtFieldSearch.returnKeyType = .search
        txtFieldSearch.enablesReturnKeyAutomatically = true
    }
    
    /// It will manage textField text clear button UIs.
    func hideOrShowClearButton() {
        btnClearTexts.isHidden = txtFieldSearch.text!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// It will register list of NIBs to table view.
    func registerNIBs() {
        tableView.register(SearchingTVC.nib, forCellReuseIdentifier: SearchingTVC.identifier)
        tableView.register(GiphyTVC.nib, forCellReuseIdentifier: GiphyTVC.identifier)
        tableView.register(LoadMoreHFV.nib, forHeaderFooterViewReuseIdentifier: LoadMoreHFV.identifier)
    }
    
    /// It will add pull to refresh control to table view.
    func addPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .whiteLightGrey
        refreshControl.addTarget(self, action: #selector(didRefresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    /// It will handle events when pull to refresh start.
    /// - Parameter refreshControl: It will represent **UIRefreshControl** object.
    @objc func didRefresh(_ refreshControl: UIRefreshControl? = nil) {
        fetchGiphies(false, refreshControl: refreshControl)
    }
    
    /// It will fetch giphies based search texts or trending giphies.
    /// - Parameters:
    ///   - isLoadMore: It will represent **Bool** value.
    ///   - refreshControl: It will represent **UIRefreshControl** value.
    func fetchGiphies(_ isLoadMore: Bool, refreshControl: UIRefreshControl?) {
        if isLoadMore == false || refreshControl != nil {objPagination = APIPagination(0, limit: 20)}
        if let searchTerm = txtFieldSearch.text, searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            fetchGiphies(searchTerm, refreshControl: refreshControl)
        }else{
            fetchGiphies(nil, refreshControl: refreshControl)
        }
    }
}

//MARK: UIButton IBAction(s)
extension FeedVC {
    
    @IBAction func onClearTexts(_ sender: UIButton) {
        txtFieldSearch.text = nil
        txtFieldSearch.resignFirstResponder()
        hideOrShowClearButton()
        arrOfGiphies = []
        tableView.reloadData()
        didRefresh(nil)
    }
}

//MARK: UITextFieldDelegate
extension FeedVC: UITextFieldDelegate {
    
    @IBAction func textFieldDidChangeText(_ textField: UITextField) {
        isSearching = true
        hideOrShowClearButton()
        didRefresh(nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

//MARK: UITableView method(s)
extension FeedVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        arrOfGiphies.isEmpty || isSearching ? .leastNonzeroMagnitude : 68
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        arrOfGiphies.isEmpty || isSearching ? nil : tableView.dequeueReusableHeaderFooterView(withIdentifier: LoadMoreHFV.identifier)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if view is LoadMoreHFV {
            let viewLoadMore = view as! LoadMoreHFV
            viewLoadMore.startAnimation()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? 1 : arrOfGiphies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        isSearching ? 44 : 132
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: isSearching ? SearchingTVC.identifier : GiphyTVC.identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is SearchingTVC {
            let cellSearching = cell as! SearchingTVC
            cellSearching.searchTerms = txtFieldSearch.text
        }else if cell is GiphyTVC {
            let cell = cell as! GiphyTVC
            cell.delegate = self
            cell.objGiphyVM = arrOfGiphies[indexPath.row]
            if indexPath.row == arrOfGiphies.count - 1  &&
                objPagination.isLoading == false &&
                objPagination.isAllLoaded == false {
                fetchGiphies(true, refreshControl: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.details, sender: arrOfGiphies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
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
                    DispatchQueue.main.async {self.updateFavouriteStatus(self.arrOfGiphies[indexPath.row], indexPath: indexPath)}
                }
                arrOfMenuElement.append(removeFromFavouriteMenu)
            }else{
                let addToFavouriteMenu = UIAction(title: "~Add to Favourite".localized, image: UIImage(systemName: "star"), identifier: UIAction.Identifier(rawValue: "star")) {[weak self] _ in
                    guard let self = self else{return}
                    DispatchQueue.main.async {self.updateFavouriteStatus(self.arrOfGiphies[indexPath.row], indexPath: indexPath)}
                }
                arrOfMenuElement.append(addToFavouriteMenu)
            }
            return UIMenu(title: "", image: nil, identifier: nil, children: arrOfMenuElement)
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: previewProvider, actionProvider: actionProvider)
    }
    
    /// It will scroll table view to top position.
    func scrollToTop() {
        if arrOfGiphies.isEmpty == false {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

//MARK: UserTapDelegate
extension FeedVC: UserTapDelegate {
    
    func didTapOn(_ text: String, tableCell: ParentTVC?, anyObject: Any?) {
        if let cellFeedTVC = tableCell as? GiphyTVC,
           let objGiphyVM = anyObject as? GiphyVM,
           let indexPath = tableView.indexPath(for: cellFeedTVC),
           text == "~Favourite".localized {
            updateFavouriteStatus(objGiphyVM, indexPath: indexPath)
        }
    }
    
    /// It will update cell UIs and object.
    /// - Parameters:
    ///   - giphyVM: Defines **GiphyVM** object.
    ///   - indexPath: Defines **IndexPath** object.
    func updateFavouriteStatus(_ giphyVM: GiphyVM, indexPath: IndexPath) {
        giphyVM.setISFavourite()
        if let cellFeed = tableView.cellForRow(at: indexPath) as? GiphyTVC {
            cellFeed.objGiphyVM = giphyVM
        }
    }
}

//MARK: Other(s)
extension FeedVC {
    
    /// It will fetch list of trending giphies.
    /// - Parameters:
    ///   - isIndicatorShow: It will represent Bool value to handle indicator is visible or not.
    ///   - refreshControl: It will represent UIRefreshControl object value.
    func fetchGiphies(_ searchTerms: String?, refreshControl: UIRefreshControl?) {
        if APIManager.isInternetAvailable {
            if arrOfGiphies.isEmpty {showIndicatorInCenter(.whiteLightGrey)}
            vmGiphyFeed.fetchGiphies(searchTerms, pagination: objPagination) {[weak self](storedGiphies, message) in
                guard let self = self else{return}
                refreshControl?.endRefreshing()
                self.hideIndicatorFromCenter()
                self.isSearching = false
                if let message = message {
                    vPrint(#function + " : " + message)
                }else if let storedGiphies = storedGiphies {
                    if self.objPagination.pageNumber == 0 {self.arrOfGiphies = []}
                    self.objPagination.increasePageNumberBy(1)
                    self.arrOfGiphies.append(contentsOf: storedGiphies)
                    self.tableView.reloadData()
                    vPrint(#function + " : \(self.arrOfGiphies.count)")
                }
            }
        }
    }
}
