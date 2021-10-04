//
//  TabBarVC.swift
//  Giphy
//

import UIKit

//MARK: - Class TabBarVC
class TabBarVC: UITabBarController {
    var viewTabBar: TabBarView!
    lazy var vcFeed: FeedVC = {
        return children[0] as! FeedVC
    }()
    lazy var vcFavourite: FavouriteVC = {
        return children[1] as! FavouriteVC
    }()

    deinit{
        vPrint("Deallocated: \(self.classForCoder)")
    }
}

// MARK: UIViewController method(s) & propertie(s)
extension TabBarVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUIs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBar.bringSubviewToFront(viewTabBar)
    }
}

// MARK: UIRelated
extension TabBarVC {
    
    func prepareUIs() {
        loadTabBarView()
        selectedIndex = 0
        tabBar.backgroundColor = .clear
    }
    
    func loadTabBarView() {
        guard viewTabBar == nil else { return }
        viewTabBar = Bundle.main.loadNibNamed("TabBarView", owner: self, options: nil)![0] as?
            TabBarView
        viewTabBar.delegate = self
        viewTabBar.frame = CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        tabBar.shadowImage = nil
        tabBar.clipsToBounds = true
        tabBar.addSubview(viewTabBar)
        tabBar.layoutIfNeeded()
    }
}

// MARK: TabBarDelegate
extension TabBarVC: TabBarDelegate {
    
    func didTapOnTab(_ option: TabBarOption?) {
        guard let option = option else { return }
        if option.rawValue == selectedIndex {vcFeed.scrollToTop()}
        selectedIndex = option.rawValue
    }
}
