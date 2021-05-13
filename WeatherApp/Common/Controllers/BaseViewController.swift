//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

/// This is a base class for the view controllers, containing methods which are commanly used in adopting class
class BaseViewController: UIViewController {

    //MARK: - Local variables
    private var indicator: UIActivityIndicatorView!
    
    //MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureBase()
    }
    
    //MARK: - User defined methods
    
    /// This method is used to do the initial setup of base class
    func configureBase() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    /// This method is used to hide the keypad when user taps outside
    @objc func didTapView() { self.view.endEditing(true) }
    
    
    /// This method is used to show the alert message on click of ok user will be navigated back
    /// - Parameter msg: alert message as string
    func showBackAlert(with msg: String) {
        let alert = UIAlertController(title: Constants.appName, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This method is used for showing default activity indicator
    ///
    /// - Parameter viw: in which we need to show activity indicator
    func showActivity(viw:UIView) {
        indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.startAnimating()
        indicator.center = viw.center
        indicator.hidesWhenStopped = true
        indicator.color = .systemGreen
        viw.addSubview(indicator)
    }
    
    /// This method is used for stopping the activity indicator
    ///
    /// - Parameter viw: in which the activity is showing
    func hideActivity() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
}
