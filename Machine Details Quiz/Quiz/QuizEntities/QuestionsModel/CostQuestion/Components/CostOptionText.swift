//
//  CostOptionText.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

extension UILabel{
    static func cost(option: QuizOption) -> UILabel?{
        var label: UILabel?
        
        var text: String?{
            switch option{
            case .A:
                return "низкая цена"
            case .B:
                return "высокая точность"
            case .C, .D:
                return nil
            }
        }
        
        if let text = text{
            label = UILabel()
            label?.textAlignment = .center
            label?.font = UIFont(name: "HelveticaNeue", size: 40)
            label?.text = text
        }
        return label
    }
    
}
