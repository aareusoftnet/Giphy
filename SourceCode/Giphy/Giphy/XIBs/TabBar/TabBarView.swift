//
//  TabBarView.swift
//  Giphy
//

import UIKit

//MARK: - Enum TabBarOption
enum TabBarOption: Int {
    case trendingGiphy = 0
    case favouriteGiphy = 1
}

//MARK: - Protocol TabBarDelegate
protocol TabBarDelegate: class {
    func didTapOnTab(_ option: TabBarOption?)
}

// MARK: - Class TabBarView
class TabBarView: ParentView {
    @IBOutlet weak var viewTabBarContainer: UIStackView!
    @IBOutlet weak var viewTrendingStack: UIView!
    @IBOutlet weak var viewTrending: UIView!
    @IBOutlet weak var btnTrending: UIButton!
    @IBOutlet weak var lblTrending: UILabel!
    @IBOutlet weak var viewFavouriteStack: UIView!
    @IBOutlet weak var viewFavourite: UIView!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var lblFavourite: UILabel!
    
    var selectedTab: TabBarOption = .trendingGiphy
    weak var delegate: TabBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateTabUI()
    }
}

// MARK: UIRelated
extension TabBarView {

    /// It will prepare default state UIs.
    func prepareDefaultUIs() {
        btnTrending.tintColor = .whiteDarkGrey
        lblTrending.text = "~Trending".localized
        lblTrending.textColor = .whiteDarkGrey
        btnFavourite.tintColor = .whiteDarkGrey
        lblFavourite.text = "~Favourite".localized
        lblFavourite.textColor = .whiteDarkGrey
    }
    
    /// It will update TabUIs.
    func updateTabUI() {
        prepareDefaultUIs()
        switch selectedTab {
        case .trendingGiphy:
            btnTrending.tintColor = .reddish
            lblTrending.textColor = .reddish
        case .favouriteGiphy:
            btnFavourite.tintColor = .reddish
            lblFavourite.textColor = .reddish
        }
    }
}

// MARK: IBAction(s)
extension TabBarView {
    
    @IBAction func btnTabTap(_ sender: UIButton) {
        selectedTab = TabBarOption(rawValue: sender.tag)!
        updateTabUI()
        delegate?.didTapOnTab(selectedTab)
    }
}
