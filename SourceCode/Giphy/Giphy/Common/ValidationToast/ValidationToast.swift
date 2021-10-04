//
//  ValidationToast.swift
//  Voila
//
//  Created by The App Developers on 24/08/16.
//  Copyright © 2016 The App Developers All rights reserved.
//

import UIKit

//MARK: - Enum ValidationToastType
enum ValidationToastType {
    case error
    case success
}

//MARK: - Class ValidationToast
//It will use to display toast view with message
class ValidationToast {
    
    static var shared = ValidationToast()
    
    init() {}
    
    /// It will use to display toast message on status bar
    ///
    /// - Parameters:
    ///   - message: Message in string to display on status bar.
    ///   - font: Font to apply on toast message.
    ///   - color: UIColor for toast background.
    ///   - autoHide: Boolean value for toast is automatically hide or not. If yes then hide automatically else you need to manually hide using ValidationToast type object.
    /// - Returns: ValidationToast type object.
    @discardableResult func show(_ message: String, type: ValidationToastType = .error, font: UIFont = .robotoMedium(ofSize: 12), color: UIColor = .reddish, autoHide: Bool = true) -> ValidationToastView {
        var newFrame = CGRect.zero
        newFrame.size.width = AppConfig.width
        let messageHeight = message.heightForFixed(AppConfig.width - 16, font: font)
        let height: CGFloat = AppConfig.safeAreaInsets.top + messageHeight + 32
        newFrame.size.height = height
        
        let toast = UINib(nibName: "ValidationToastView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ValidationToastView
        toast.animatingViewBottomConstraint.constant = height
        toast.animatingView.backgroundColor = color
        toast.setToast(message, font: font)
        toast.frame = newFrame
        toast.layoutIfNeeded()
        toast.animateIn(0.2, delay: 0.2, completion: { () -> () in
            if autoHide {
                toast.animateOut(0.2, delay: 3.0, completion: { () -> () in
                    toast.removeFromSuperview()
                })
            }
        })
        (AppConfig.appDelegate as! AppDelegate).window?.addSubview(toast)
        return toast
    }
}

//MARK: - Class ValidationToastView
//It will graphics represented views.
class ValidationToastView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var animatingViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var animatingView: UIView!
    
    deinit {vPrint("ValidationToastView Deallocated")}
    
    /// It will set message on UILabel
    ///
    /// - Parameters:
    ///   - message: String type parameter
    ///   - font: UIFont type parameter
    func setToast(_ message: String, font: UIFont) {
        messageLabel.text = message
    }
    
    /// It will set message on UILabel
    ///
    /// - Parameters:
    ///   - message: NSAttributedString type value
    ///   - type: ValidationToastType type value
    func setToast(_ message: NSAttributedString, type: ValidationToastType) {
        messageLabel.attributedText = message
        switch type {
        case .error:
            animatingView.backgroundColor = .reddish
        case .success:
            animatingView.backgroundColor = .reddish
        }
    }
    
    /// It will display toast message with animation.
    ///
    /// - Parameters:
    ///   - duration: TimerInterval for animation execution
    ///   - delay: TimerInterval for start animation after some delay
    ///   - completion: Block handler
    func animateIn(_ duration: TimeInterval, delay: TimeInterval, completion: (() -> ())?) {
        animatingViewBottomConstraint.constant = 0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.layoutIfNeeded()
        }) { (completed) -> Void in
            completion?()
        }
    }
    
    /// It will hide toast message with animation.
    ///
    /// - Parameters:
    ///   - duration: TimerInterval for animation execution
    ///   - delay: TimerInterval for start animation after some delay
    ///   - completion: Block handler
    func animateOut(_ duration: TimeInterval, delay: TimeInterval, completion: (() -> ())?) {
        animatingViewBottomConstraint.constant = frame.size.height
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
            self.layoutIfNeeded()
        }) { (completed) -> Void in
            completion?()
        }
    }
}
