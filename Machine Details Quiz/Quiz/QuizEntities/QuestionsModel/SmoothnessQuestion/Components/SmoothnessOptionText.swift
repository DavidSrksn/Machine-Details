//
//  SmoothnessOptionText.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

extension UILabel{
    static func smoothness(option: QuizOption) -> UILabel?{
        var label: UILabel?
        
        var text: String?{
            switch option{
            case .A:
                return "да"
            case .B:
                return "неважно"
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
