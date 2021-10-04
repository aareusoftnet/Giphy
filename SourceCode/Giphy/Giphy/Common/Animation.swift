//
//  Animation.swift
//  Giphy
//

import UIKit

//MARK: - Animation
class Animation: NSObject {
    
    //Spring in animation
    class func springInAnimation(view: UIView, duration: TimeInterval = 0.7, completionBlock: ((Bool) -> ())?) {
        view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 8.0, options: .allowUserInteraction, animations: {
            view.transform = .identity
        }) { (isFinished: Bool) in
            DispatchQueue.main.async {
                completionBlock?(isFinished)
            }
        }
    }
}
