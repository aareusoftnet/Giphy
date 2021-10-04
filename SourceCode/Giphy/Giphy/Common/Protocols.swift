//
//  Protocols.swift
//  Giphy
//

import UIKit


//MARK: - Class UserTapDelegate
/// It is used to get user tap event on text for tableCell, collectionCell, and headerFooter views.
@objc public protocol UserTapDelegate: class {
    @objc optional func didTapOn(_ text: String, tableCell: ParentTVC?, anyObject: Any?)
    @objc optional func didTapOn(_ text: String, collectionCell: ParentCVC?, anyObject: Any?)
}
