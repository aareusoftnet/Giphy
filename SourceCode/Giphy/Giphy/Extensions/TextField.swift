//
//  TextField.swift
//  Giphy
//

import UIKit

//MARK: - UITextField Extension
extension UITextField {

    /// It is used to set attributed place holder with given parameteres.
    /// - Parameters:
    ///   - placeHolder: `String` to define place holder texts.
    ///   - color: `UIColor` type object.
    ///   - font: `UIFont` type object.
    public func setAttributed(_ placeHolder: String?, color: UIColor, font: UIFont) {
        if let placeHolder = placeHolder {
            attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor:color, .font: font])
        }else if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor:color, .font: font])
        }else{
            attributedPlaceholder = nil
        }
    }
}
