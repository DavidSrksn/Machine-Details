//
//  PDFTextConfigurator.swift
//  Machine Details
//
//  Created by David Sarkisyan on 17.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

class PDFTextConfigurator {
    
    let leftTabSize = "\t"
    let rightTabSize = ":   "
    
    func setupPage(result: ResultModel) -> String{
        var body: String = ""
        
        body += setupScheme(result: result)
        body += setupGearboxCharactaristics(result: result)
        body += setupSchemeCharactaristics(result: result)
        body += setupGenerator(generator: result.sourceGenerator, header: "Источник")
        body += setupGenerator(generator: result.consumerGenerator, header: "Потребитель")
        
        return body
    }
    
    
    private func setupScheme(result: ResultModel) -> String{
        var scheme: String = "Итоговая рекомендуемая схема:" + rightTabSize + "\n" + "источник (электродвигатель)  ->  "
        
        scheme += String.resultScheme(result: result)
        scheme += "  ->  потребитель \n"
        
        return scheme + "\n"
    }
    
    private func setupGearboxCharactaristics(result: ResultModel) -> String{
        var charactaristics: String = "Характеристики редуктора: \n"
        
        charactaristics += leftTabSize + String.resultHeader(type: .gearType) + rightTabSize + String.resultGearType(result: result) + "\n"
        charactaristics += leftTabSize + "Количество ступеней" + rightTabSize + String.resultGearStage(result: result) + "\n"
        charactaristics += leftTabSize + "Передаточное отношение" + rightTabSize + "\(result.gearbox.gearRatio ?? 1)" + "\n"
        
        return charactaristics + "\n"
    }
    
    private func setupSchemeCharactaristics(result: ResultModel) -> String{
        var charactaristics: String = "Характеристики всей схемы: \n"
        if let gearboxGearRatio =  result.gearbox.gearRatio{
            let resultSchemeGearRatio = result.gearRatio(gearboxRatio: gearboxGearRatio)
            charactaristics += leftTabSize + String.resultHeader(type: .schemeGearRatio) + rightTabSize + "\(Int(resultSchemeGearRatio))" + "\n"
        }
        if let chainTransmission = result.chainTransmission{
            charactaristics += leftTabSize + "Рекомендуется применение цепной передачи  с передаточным отношением" + rightTabSize + "\(chainTransmission.gearRatio)" + "\n"
        }else if let beltTransmission = result.beltTransmission{
            charactaristics += leftTabSize + "Рекомендуется применение ремённой передачи  с передаточным отношением" + rightTabSize + "\(beltTransmission.gearRatio)" + "\n"
        }
        return charactaristics
    }
    
    private func setupGenerator(generator: Generator, header: String) -> String{
        var resultString: String = "\n"
        
        resultString += header + rightTabSize + "\n"
        
        guard let frequency = generator.frequency else{return resultString}
        resultString += leftTabSize + "Частота: " + String(frequency)  + "\n"
        
        guard let name = generator.name else{return resultString}
        resultString += leftTabSize + "Наименование: " + name  + "\n"
        
        return resultString
    }
}
