//
//  Printers.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

extension String{
    
    static func resultHeader(type: ResultType) -> String{
        switch type{
        case .gearStage: return "Количество ступеней редуктора"
        case .gearType: return "Тип редуктора"
        case .scheme: return "Схема"
        case .sourceFrequency: return "Частота э/д"
        case .emty: return ""
        case .schemeGearRatio: return  "Передаточное отношение схемы"
        case .sourceName: return "Тип э/д"
        }
    }
    
    static func printResult(type: ResultType, result: ResultModel) -> String{
        switch type{
        case .gearStage:
            return resultGearStage(result: result)
        case .gearType:
            return resultGearType(result: result)
        case .scheme:
            return resultScheme(result: result)
        case .sourceFrequency:
            return resultFrequency(result: result)
        case .emty:
            return ""
        case .schemeGearRatio:
            return resultShemeGearRatioFormula(result: result)
        case .sourceName:
            return result.sourceGenerator.name ?? "Не найдено"
        }
    }
    
    static func resultShemeGearRatioFormula(result: ResultModel) -> String{
        var chainTransmissionText: String = ""
        var beltTransmissionText: String = ""
        
        if result.chainTransmission != nil{
            chainTransmissionText = "Uцеп"
            return "Uред x \(chainTransmissionText) = "
        }
        if result.beltTransmission != nil{
            beltTransmissionText = "Uрем"
            return "Uред x \(beltTransmissionText) = "
        }
        return "Uред = "
    }
    
    
    static func resultGearStage(result: ResultModel) -> String{
        let gearboxStage = result.gearbox.stageNumber.first
        
        var type: String{
            switch gearboxStage{
            case .one:
                return "одна"
            case .two:
                return "две"
            case .none:
                return ""
            }
        }
        return type
    }
    
    static func resultGearType(result: ResultModel) -> String{
        let gearboxType = result.gearbox.type.first
        
        var type: String{
            switch gearboxType{
            case .conical: return "конический"
            case .cylindrical: return "цилиндрический"
            case .planetary: return "планетарный"
            case .wave: return "волновой"
            case .worm: return "червячный"
            case .none:
                return ""
            }
        }
        return type
    }
    
    static func resultScheme(result: ResultModel) -> String{
        var chainTransmissionText: String = ""
        var beltTransmissionText: String = ""
        if result.chainTransmission != nil{
            chainTransmissionText = "+ цепная передача"
        }
        if result.beltTransmission != nil{
            beltTransmissionText = "+ ремённая передача"
        }
        return  ("редуктор  \(chainTransmissionText)  \(beltTransmissionText)")
    }
    
    static func resultFrequency(result: ResultModel) -> String{
        if let resultFrequency = result.sourceGenerator.frequency{
            return "\(resultFrequency)"
        }
        return "Ошибка"
    }
    
}
