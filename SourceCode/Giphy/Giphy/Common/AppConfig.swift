//
//  AppConfig.swift
//  Giphy
//

import UIKit

//MARK: - Class AppConfig
public class AppConfig: NSObject {
    public static var appDelegate: UIApplicationDelegate {return UIApplication.shared.delegate!}
    public static var navigationBarHeight: CGFloat!
    public static var designWidth: CGFloat!
    public static var designHeight: CGFloat!
    public static let width: CGFloat = UIScreen.main.bounds.size.width
    public static let height: CGFloat = UIScreen.main.bounds.size.height
    public static var widthRatio: CGFloat {return width/designWidth}
    public static var heightRatio: CGFloat {return height/designHeight}
    public static var safeAreaInsets: UIEdgeInsets {return appDelegate.window!!.safeAreaInsets}
    public static var heightOfNavigationBar: CGFloat {return safeAreaInsets.top + navigationBarHeight}
    public static var heightOfStatusBar: CGFloat {return safeAreaInsets.top}
    
    /// It will configure application desired design Width, Height and Navigation Bar Height.
    /// - Parameters:
    ///   - designWidth: CGFloat type value to configure your application design width.
    ///   - designHeight: CGFloat type value to configure your application designheight.
    ///   - navigationBarHeight: CGFloat type value to configure your application design navigation bar height. Default value is **44**.
    public static func initialise(_ designWidth: CGFloat, designHeight: CGFloat, navigationBarHeight: CGFloat = 44) {
        AppConfig.designWidth = designWidth
        AppConfig.designHeight = designHeight
        AppConfig.navigationBarHeight =  navigationBarHeight
    }
}
