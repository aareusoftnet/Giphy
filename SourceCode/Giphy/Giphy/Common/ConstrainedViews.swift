//
//  ConstrainedViews.swift
//  Giphy
//

import UIKit

//MARK: - Class ParentCVC
/// It is a sub-class of `UICollectionViewCell` use to set as parent class.
open class ParentCVC: UICollectionViewCell {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * AppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * AppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - Class ParentHFV
/// It is a sub-class of `UITableViewHeaderFooterView` use to set as parent class.
open class ParentHFV: UITableViewHeaderFooterView {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {

        if let heightOfSperator = constraintHeightOfSeparator {
            heightOfSperator.constant = 0.5
        }
        
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * AppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * AppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - Class ParentTVC
/// It is a sub-class of `UITableViewCell` use to set as parent class.
open class ParentTVC: UITableViewCell {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {

        if let heightOfSperator = constraintHeightOfSeparator {
            heightOfSperator.constant = 0.67
        }
        
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * AppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * AppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - Class ParentView
/// It is a sub-class of `UIView` use to set as parent class.
open class ParentView: UIView {
    @IBOutlet public weak var viewContainer: UIView?
    @IBOutlet public var constraintHeightOfSeparator: NSLayoutConstraint?
    @IBOutlet public var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet public var verticalConstraints: [NSLayoutConstraint]?
    public static var identifier: String {return String(describing: self)}
    public static var nib: UINib {return UINib(nibName: identifier, bundle: nil)}

    open override func awakeFromNib() {
        super.awakeFromNib()
        constraintUpdate()
    }
    
    open override func layoutSubviews() {super.layoutSubviews()}

    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * AppConfig.widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * AppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}
