//
//  AppGlobal.swift
//  Giphy
//

import UIKit

//MARK:- Global Variable(s)
let _defaultCenter          = NotificationCenter.default

//MARK: - Global Notification Name(s)
let nfInternetNotAvailable      = Notification.Name("InternetNotAvailable")
let nfInternetAvailable         = Notification.Name("InternetAvailable")


//MARK: - Global Method(s)
/// It is used to print logs in console.
/// - Parameter items: Items to represetn any objects.
func vPrint(_ items: Any...) {
    #if DEBUG
    for item in items {
        print(item)
    }
    #endif
}

/// It is used to font used in Fonts
/// - Parameter font: Object to represent UIFont.
func printFonts(_ font: UIFont?) {
    if let _ = font{
        vPrint("------------------------------")
        vPrint("Font Family Name = [\(font!.familyName)]")
        let names = UIFont.fontNames(forFamilyName: font!.familyName)
        vPrint("Font Names = [\(names)]")
    }else{
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            vPrint("------------------------------")
            vPrint("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            vPrint("Font Names = [\(names)]")
        }
    }
}
