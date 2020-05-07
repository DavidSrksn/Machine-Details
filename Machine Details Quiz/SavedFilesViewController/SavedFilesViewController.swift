//
//  SavedFilesViewController.swift
//  Machine Details
//
//  Created by David Sarkisyan on 19.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit
import Foundation
import PDFKit

class SavedFilesViewController: UIViewController, SavedFilesViewControllerProtocol{
    
    var files: [(String, Data)] = []
    var interactor: SavedFilesInteractorProtocol!
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        setupArchitecture()
        
        self.files = interactor.fetchFiles()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
    }
    
    func setupArchitecture(){
        self.interactor = SavedFilesInteractor(viewController: self)
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        tableView.separatorInset = .zero
        tableView.separatorColor = .darkGray
    }
    
    func openPDF(index: Int){
        let data = files[index].1
        let viewController = PDFViewController(documentData: data, showSaveNotification: false)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}


extension SavedFilesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SaveFilesTableViewCell()
        let data = files[indexPath.row]
        cell.fileName = data.0
        cell.setup()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = tableView.bounds.height
        let filesNumber = CGFloat(files.count)
        
        return tableViewHeight / filesNumber
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openPDF(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            interactor.deletePDF(index: indexPath.row)
            tableView.reloadData()
        }
    }
}
