//
//  ResulModel.swift
//  Machine Details
//
//  Created by David Sarkisyan on 12.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

struct ResultModel {
    
    var gearbox: Gearbox = Gearbox()
    
    var chainTransmission: ChainTransmission? = nil
    
    var beltTransmission: BeltTransmission? = nil
    
    var consumerGenerator: Generator
    var sourceGenerator = Generator()
    
    func gearRatio(gearboxRatio: Double) -> Double{
        let chainTransmissionGearRatio: Double = chainTransmission?.gearRatio ?? 1
        let beltTransmissionGearRatio: Double = beltTransmission?.gearRatio ?? 1
        return gearboxRatio * chainTransmissionGearRatio * beltTransmissionGearRatio
    }
    
    func printResults(){
        printScheme()
        printType()
    }
    
    func printScheme(){
        var chainTransmissionText: String = ""
        var beltTransmissionText: String = ""
        if chainTransmission != nil{
            chainTransmissionText = "chainTransmission"
        }
        if beltTransmission != nil{
            beltTransmissionText = "beltTransmission"
        }
        print("scheme = gearbox + \(chainTransmissionText) + \(beltTransmissionText)")
    }
    
    func printType(){
        print("types :   \(gearbox.type)")
    }
    
}
