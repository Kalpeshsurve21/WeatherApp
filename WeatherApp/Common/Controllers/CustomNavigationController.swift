//
//  CustomNavigationController.swift
//  WeatherApp
//
//  Created by Kalpesh Surve on 11/05/21.
//

import UIKit

/// This class is used to create custome navigation controller for all the screen
class CustomNavigationController: UINavigationController {
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()
    }
    
    //MARK: - User defined methods
    
    /// This method is used to create the transparent navigation bar
    func setNav() {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.backIndicatorImage = UIImage()
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.isUserInteractionEnabled = true
        self.navigationItem.hidesBackButton = true
    }
    
}
