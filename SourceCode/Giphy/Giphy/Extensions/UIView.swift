//
//  UIView.swift
//  Giphy
//

import UIKit

//MARK: - UIView IBInspectable(s)
public extension UIView {

    /// `@IBInspectable cornerRadius` property is used to apply corner radius on selected `UIView`.
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
