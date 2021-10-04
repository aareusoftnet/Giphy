//
//  ParentVC.swift
//  Giphy
//

import UIKit

//MARK: - Class ParentVC
class ParentVC: UIViewController {
    //IBOutlet(s)
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewTopLayoutMargin: UIView?
    @IBOutlet var viewNavigationBar: NavigationBarContainer?
    @IBOutlet var viewBottomLayoutMargin: UIView?
    @IBOutlet var viewBottomBar: UIView?
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]?
    var completionBlock: ((_ isFinish: Bool, _ any: Any?, _ controller: UIViewController?)->())?
    var xActivityConstant: CGFloat!
    var yActivityConstant: CGFloat!
    
    //Lazy Variables
    lazy internal var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = UIColor.white
        return activity
    }()

    lazy internal var centralActivityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = UIColor.white
        return activity
    }()
    
    deinit{
        vPrint("Deallocated: \(self.classForCoder)")
    }
}

//MARK: UIViewController method(s) & Properties
extension ParentVC {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vPrint("Allocated: \(self.classForCoder)")
        constraintUpdate()
        navigationBarHandler()
    }
}

//MARK: ParentVC
extension ParentVC {
    
    @objc func navigationBarHandler() {
        viewNavigationBar?.actionHandlerWith({[weak self](navigationBar, navigationAction, tapButton) in
            guard let self = self else{return}
            switch navigationAction {
            case .popController:
                self.navigationController?.popViewController(animated: true)
            case .dismissController:
                self.dismiss(animated: true, completion: nil)
            default: break
            }
        })
    }
}

//MARK: - UIRelated
extension ParentVC {
    
    //This will update constaints and shrunk it as device screen goes lower.
    func constraintUpdate() {
        //Horizontal constraings
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * AppConfig.widthRatio
                const.constant = v2
            }
        }
        //Verticle constraings
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * AppConfig.heightRatio
                const.constant = v2
            }
        }
    }
}

//MARK: - UIActivityIndicator(s)
extension ParentVC {
    
    /// Show indicator in center of any view(which pass in this method as container)
    /// During activity it will disable user intraction
    ///
    /// - Parameters:
    ///   - container: Container view which contains, indicator view.
    ///   - control: Control which hides when indicator display.
    ///   - color: Color which apply on indicator.
    func showIndicatorIn(_ container: UIView, control: UIView, color: UIColor = .white) {
        activityIndicator.color = color
        container.addSubview(activityIndicator)
        let xConstraint = NSLayoutConstraint(item: self.activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: self.activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 0)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([xConstraint, yConstraint])
        self.activityIndicator.alpha = 0.0
        self.view.layoutIfNeeded()
        self.view.isUserInteractionEnabled = false
        self.activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.activityIndicator.alpha = 1.0
            control.alpha = 0.0
        }
    }
    
    /// Hide activity indicator from center of any view(which pass in this method as container)
    /// Enable user intraction after activity completed
    ///
    /// - Parameters:
    ///   - container: Container view which contains, indicator view.
    ///   - control: Control which hides when indicator display.
    func hideIndicatorFrom(_ container: UIView, control: UIView) {
        self.view.isUserInteractionEnabled = true
        self.activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            self.activityIndicator.alpha = 0.0
            control.alpha = 1.0
        }) { (isFinish) in
            self.activityIndicator.removeFromSuperview()
        }
    }

    
    /// Show indicator in center of view.
    /// During activity it will disable user intraction.
    ///
    /// - Parameters:
    ///   - color: Color which apply on indicator.
    func showIndicatorInCenter(_ color: UIColor = .white) {
        centralActivityIndicator.color = color
        view.addSubview(centralActivityIndicator)
        DispatchQueue.main.async {
            let xConstraint = NSLayoutConstraint(item: self.centralActivityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
            let yConstraint = NSLayoutConstraint(item: self.centralActivityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
            self.centralActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([xConstraint, yConstraint])
            self.centralActivityIndicator.alpha = 0.0
            self.view.layoutIfNeeded()
            self.view.isUserInteractionEnabled = false
            self.centralActivityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2) { () -> Void in
                self.centralActivityIndicator.alpha = 1.0
            }
        }
    }
    
    /// Hide custom activity indicator from center of any view.
    /// Enable user intraction after activity completed
    func hideIndicatorFromCenter() {
        view.isUserInteractionEnabled = true
        centralActivityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2, animations: {
            self.centralActivityIndicator.alpha = 0.0
        }) { (isFinish) in
            self.centralActivityIndicator.removeFromSuperview()
        }
    }
}

//MARK: - UIKeyboard
extension ParentVC {
    
    @objc func addKeyboardObserver() {
        _defaultCenter.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _defaultCenter.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        if let userInfo = notification.userInfo {
            if let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func removeKeyboardObserver() {
        _defaultCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        _defaultCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: Other(s)
extension ParentVC {
    
    func openShareKit(_ giphyVM: GiphyVM) {
        let activityViewController = UIActivityViewController(activityItems: [URL(string: giphyVM.originalImage!.url!)!], applicationActivities: nil)
        activityViewController.overrideUserInterfaceStyle = .dark
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        present(activityViewController, animated: true, completion: nil)
    }
}
