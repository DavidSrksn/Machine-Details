//
//  SaveFilesTableViewCell.swift
//  Machine Details
//
//  Created by David Sarkisyan on 19.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

class SaveFilesTableViewCell: UITableViewCell{
    let documentImage = UIImage(systemName: "doc.text")
    let documentImageView = UIImageView()
    let documentLabel = UILabel()
    
    var fileName: String = ""
    
    func setup(){
        setupDocumentImageView()
        setupDocumentLabel()
    }
    
    private func setupDocumentImageView(){
        addSubview(documentImageView)
        
        documentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        documentImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        documentImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        documentImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        documentImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        imageView?.image = documentImage
        imageView?.contentMode = .scaleAspectFit
    }
    
    private func setupDocumentLabel(){
        addSubview(documentLabel)
        
        documentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        documentLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        documentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        documentLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        documentLabel.leftAnchor.constraint(equalTo: documentImageView.rightAnchor).isActive = true
        
        documentLabel.text = fileName
        documentLabel.textAlignment = .center
    }
    
}

