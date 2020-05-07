//
//  PDFViewController.swift
//  Machine Details
//
//  Created by David Sarkisyan on 16.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController{
    
    var showSaveNotification: Bool // показывать ли "Сохранено"
    let savedNotificationLabel = UILabel()
    
    var documentData: Data?
    let pdfView = PDFView()
    
    let shareButton = UIButton()
    
    init(documentData: Data?, showSaveNotification: Bool) {
        self.documentData = documentData
        self.showSaveNotification = showSaveNotification
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor = UIColor.Customs.lightBlack
        if let data = documentData {
          pdfView.document = PDFDocument(data: data)
          pdfView.autoScales = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pdfView.backgroundColor = .black
        setupPDFView()
        setupShareButton()
    }
    
    override func viewDidAppear(_ animated: Bool){
        if showSaveNotification{
//            setupSavedNotificationView()
        }
    }
    
    func setupPDFView(){
        view.addSubview(pdfView)
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        
        pdfView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pdfView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupShareButton(){
        view.addSubview(shareButton)
        shareButton.addTarget(nil, action: #selector(sharePDF), for: .touchUpInside)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.5).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        shareButton.setTitle("Поделиться", for: .normal)
        shareButton.setTitleColor( UIColor.Customs.lightBlack, for: .normal)
        
        shareButton.backgroundColor = .white
        shareButton.layer.cornerRadius = 20
    }
    
    @objc func sharePDF(){
        if let data = documentData{
        let activityController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        }
    }
    
}
