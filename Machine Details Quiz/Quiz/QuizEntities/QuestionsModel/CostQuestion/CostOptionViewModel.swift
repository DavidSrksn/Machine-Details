//
//  CostOptionViewModel.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

/* Варианты предпочтений
A - цена
B - точность
*/

class CostOptionViewModel: OptionViewModelProtocol{
    
    var view = UIView()
    
    var isSelected: Bool = false
    
    public func result(resultModel: inout ResultModel, option: QuizOption) {
        switch option{
        case .A:
            removeGearType(resultModel: &resultModel, gearTypes: [.wave, .worm])
        case .B:
            removeGearType(resultModel: &resultModel, gearTypes: [.cylindrical, .conical])
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
        setupCostLabel(option: option)
    }
    
    private func setupCostLabel(option: QuizOption){
        let label: UILabel? = UILabel.cost(option: option)
        
        label?.numberOfLines = 0
        label?.textAlignment = .center
        
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
