//
//  SavedFilesViewControllerInteractor.swift
//  Machine Details
//
//  Created by David Sarkisyan on 19.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

class SavedFilesInteractor: SavedFilesInteractorProtocol {
    
    let viewController: SavedFilesViewControllerProtocol
    
    static let saveToPath: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    init(viewController: SavedFilesViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func fetchFiles() -> [(String, Data)]{
        let fm = FileManager.default
        let pdfPath: String = SavedFilesInteractor.saveToPath.path
        var items: [(String, Data)] = []
        do{
            let paths = try fm.contentsOfDirectory(atPath: pdfPath)
            
            for path in paths{
                if let item =  fm.contents(atPath: pdfPath + "/" + path){
                    let (fileName, data) = (path, item)
                    items.append((fileName, data))
                }
            }
            
            return items
        }catch {
            print(error.localizedDescription)
        }
        
        return items
    }
    
    func deletePDF(index: Int){
        let fm = FileManager.default
        let pdfPath: String = SavedFilesInteractor.saveToPath.path
        let dataPath: String = viewController.files[index].0
        
        do{
            try fm.removeItem(atPath: pdfPath + "/" + dataPath)
            viewController.viewDidLoad()
        }catch {
            print(error.localizedDescription)
        }
    }
    
}
