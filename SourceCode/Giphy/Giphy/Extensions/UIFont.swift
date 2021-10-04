//
//  UIFont.swift
//  Giphy
//

import UIKit

//MARK: - UIFont Extension(s)
extension UIFont {
    
    //Font Family Name = [Roboto]
    //Font Names = [["Roboto-Regular", "Roboto-Medium", "Roboto-Bold"]]

    public static func robotoRegular(ofSize: CGFloat = 14) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: ofSize)!
    }
    
    public static func robotoMedium(ofSize: CGFloat = 14) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: ofSize)!
    }
    
    public static func robotoBold(ofSize: CGFloat = 14) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: ofSize)!
    }
}
