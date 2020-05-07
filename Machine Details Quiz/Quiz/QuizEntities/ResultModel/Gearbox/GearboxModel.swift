//
//  Gearbox.swift
//  Machine Details
//
//  Created by David Sarkisyan on 12.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//


struct Gearbox{
    
    var type: [GearboxType]
    
    var stageNumber: [GearboxStage]
    
    var gearRatio: Double?
    
    func calculateGearRatio(stageNumber: GearboxStage) -> Double {
        if let gearRatio = self.gearRatio{
            let gearboxGearRation: Double = gearRatio * stageNumber.rawValue
            return gearboxGearRation
        }
        return 1
    }
    
    init() {
        self.type = GearboxType.allCases
        self.stageNumber = GearboxStage.allCases
    }
}
