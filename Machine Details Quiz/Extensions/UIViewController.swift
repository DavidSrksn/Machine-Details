//
//  UIViewController.swift
//  Machine Details
//
//  Created by David Sarkisyan on 14.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

extension UIViewController{
    public func presentFullscreen(viewController: UIViewController){
        viewController.modalPresentationStyle = .fullScreen 
        self.present(viewController, animated: true, completion: nil)
    }
}
