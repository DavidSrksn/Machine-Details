//
//  SavedFilesViewController.swift
//  Machine Details
//
//  Created by David Sarkisyan on 19.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import Foundation

protocol SavedFilesViewControllerProtocol{
    
    var files: [(String, Data)] {get set}
    
    func viewDidLoad()
}
