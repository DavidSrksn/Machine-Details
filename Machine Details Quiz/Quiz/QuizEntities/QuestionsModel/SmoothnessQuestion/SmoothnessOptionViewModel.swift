//
//  SmoothnessOptionViewModel.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

/* Варианты необходимости плавности движения
A - да
B - неважно
*/

class SmooothnessOptionViewModel: OptionViewModelProtocol{
    
    var view = UIView()
    
    var isSelected: Bool = false
    
    public func result(resultModel: inout ResultModel, option: QuizOption) {
        switch option{
        case .A:
            removeGearType(resultModel: &resultModel, gearTypes: [.conical, .cylindrical, .planetary])
        case .B:
            removeGearType(resultModel: &resultModel, gearTypes: [])
        case .C, .D:
            return
        }
    }
    
    private func removeGearType(resultModel: inout ResultModel, gearTypes toRemove: [GearboxType]) {
        for type in toRemove{
            resultModel.gearbox.type.removeAll { (gearType) -> Bool in
                gearType == type
            }
        }
    }
    
    public func setup(option: QuizOption){
        setupSchemeLabel(option: option)
    }
    
    private func setupSchemeLabel(option: QuizOption){
        let label: UILabel? = UILabel.smoothness(option: option)
        
        if let label = label{
            view.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
}

