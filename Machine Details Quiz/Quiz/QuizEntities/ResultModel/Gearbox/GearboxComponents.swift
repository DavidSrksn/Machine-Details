//
//  GearboxComponents.swift
//  Machine Details
//
//  Created by David Sarkisyan on 12.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

enum GearboxType {                // rawValue - average gear ratio
    case cylindrical   // цилиндрический
    case conical       // конический
    case worm          // червячный
    case wave          // волновой
    case planetary     // планетарный
    
    static let allCases: [GearboxType] = [.cylindrical, .conical, .worm, .wave, .planetary]
}

enum GearboxStage: Double {
    case one = 1
    case two = 2
    
    static let allCases: [GearboxStage] = [.one, .two]
}



extension GearboxType: RawRepresentable{
    
    typealias Range = (Double,Double)
    typealias RawValue = (Range,Range?)
    
    init?(rawValue: Self.RawValue) {
        switch rawValue{
        case ((1,6.3),  nil): self = .conical
        case ((1.6, 8),  (12.5, 31.5)? ): self = .cylindrical
        case ((3.15, 8),  (16, 63)? ): self = .planetary
        case ((70, 320), nil): self = .wave
        case ((8,63),  (63, 1000)? ): self = .worm
        case (_, _):
            return nil
        }
    }
    
    var rawValue: GearboxType.RawValue{
        switch self{
        case .conical: return ((1,6.3),  nil)
        case .cylindrical: return ((1.6, 8),  (12.5, 31.5))
        case .planetary: return ((3.15, 8),  (16, 63))
        case .wave: return ((70, 320), nil)
        case .worm: return ((8,63),  (63, 1000))
        }
    }
    
    public func isSuitable(resultModel: inout ResultModel) -> Bool{
        if calculateStageMaxAllowedFrequency(resultModel: &resultModel, stageRange: self.rawValue.0){
            return true
        }else if let twoStageRange = self.rawValue.1 {
            return calculateStageMaxAllowedFrequency(resultModel: &resultModel, stageRange: twoStageRange)
        }
        
        return false
    }
    
    private func calculateStageMaxAllowedFrequency(resultModel: inout ResultModel, stageRange: (Double, Double)) -> Bool{
        let consumerFrequency = resultModel.consumerGenerator.frequency!
        
        let minSourceFrequency: Double? = GeneratorFrequency.allGeneratorOptions().max { (a, b) -> Bool in
            a.0 > b.0
            }?.0
        let maxSourceFrequency: Double? = GeneratorFrequency.allGeneratorOptions().max { (a, b) -> Bool in
            a.0 < b.0
            }?.0
        let chainOrbelTransmissionGearRatio: Double = resultModel.chainTransmission?.gearRatio ?? resultModel.beltTransmission?.gearRatio ?? 1
        
        if let minSourceFrequency = minSourceFrequency, let maxSourceFrequency = maxSourceFrequency{
            let maxGearRatio = (consumerFrequency / minSourceFrequency) / chainOrbelTransmissionGearRatio
            let minGearRatio = (consumerFrequency / maxSourceFrequency) / chainOrbelTransmissionGearRatio
            
            if !(minGearRatio > stageRange.1 || maxGearRatio < stageRange.0){ // условие пересечения
                return true
            }
        }
        return false
    }
    
}
