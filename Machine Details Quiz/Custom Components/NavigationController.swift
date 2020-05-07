//
//  NavigationController.swift
//  Machine Details
//
//  Created by David Sarkisyan on 18.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController{
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        self.navigationBar.barTintColor = UIColor.Customs.lightBlack
        self.navigationBar.isTranslucent = false
    }
}
