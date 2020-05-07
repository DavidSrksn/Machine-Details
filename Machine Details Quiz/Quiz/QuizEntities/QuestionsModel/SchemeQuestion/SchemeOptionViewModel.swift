//
//  OptionA.swift
//  Machine Details
//
//  Created by David Sarkisyan on 08.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

/* Врианты:
 A - редуктор
 B - редуктор + цепная передача
 C - редуктор + ременная передача
 */
class SchemeOptionViewModel: OptionViewModelProtocol{
        
    var view = UIView()
    
    var isSelected: Bool = false
        
    public func result(resultModel: inout ResultModel, option: QuizOption) {
        switch option{
        case .A:
            return
        case .B:
            resultModel.chainTransmission = ChainTransmission()
        case .C:
            resultModel.beltTransmission = BeltTransmission()
        case .D:
            return
        }
    }
    
    public func setup(option: QuizOption){
        setupSchemeImageView(option: option)
    }
    
    private func setupSchemeImageView(option: QuizOption){
        let imageView: UIImageView? = UIImageView.scheme(option: option)
        
        if let imageView = imageView{
            view.addSubview(imageView)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
}
