//
//  SavedFileInteractorProtocol.swift
//  Machine Details
//
//  Created by David Sarkisyan on 19.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import Foundation

protocol SavedFilesInteractorProtocol {
    
    func fetchFiles() -> [(String, Data)]
    
    func deletePDF(index: Int)
    
}
