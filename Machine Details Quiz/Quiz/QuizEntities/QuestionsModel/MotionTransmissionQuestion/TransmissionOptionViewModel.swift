//
//  TransmissionOptionViewModel.swift
//  Machine Details
//
//  Created by David Sarkisyan on 09.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

/* Варианты угла передачи движения в редукторе
A - 0 градусов
B - 90 градусов
*/

class TransmissionOptionViewModel: OptionViewModelProtocol{
    
    var view = UIView()
    
    var isSelected: Bool = false
    
    public func result(resultModel: inout ResultModel, option: QuizOption) {
        switch option{
        case .A:
            removeGearType(resultModel: &resultModel, gearTypes: [.worm, .conical])
        case .B:
            removeGearType(resultModel: &resultModel, gearTypes: [.cylindrical, .wave, .planetary])
        case .C, .D:
            return
        }
        checkGearboxTypeIsChoosed(resultModel: &resultModel)
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
        let label: UILabel? = UILabel.transmission(option: option)
        
        if let label = label{
            view.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    private func checkGearboxTypeIsChoosed(resultModel: inout ResultModel){
        let gearboxTypeOptions = resultModel.gearbox.type
        
        for type in gearboxTypeOptions{
            if !type.isSuitable(resultModel: &resultModel){
                removeGearType(resultModel: &resultModel, gearTypes: [type])
            }
        }
    }
    
}
