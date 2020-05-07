//
//  Text.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

extension String{
    public func isAllowed() -> Bool{
        var flag: Int = 0
        
        self.forEach({ (character) in
            let symbol = "\(character)"
            if !permittedSymbols.contains(symbol){
                flag = 1
            }
        })
        
        if flag == 1 || self == ""{
            return false
        }else{
            return true
        }
    }
}
