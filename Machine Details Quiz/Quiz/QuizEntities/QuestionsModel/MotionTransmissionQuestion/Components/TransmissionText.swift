//
//  TransmissionText.swift
//  Machine Details
//
//  Created by David Sarkisyan on 09.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

extension UILabel{
    static func transmission(option: QuizOption) -> UILabel?{
        var label: UILabel?
        
        var text: String?{
            switch option{
            case .A:
                return "0°"
            case .B:
                return "90°"
            case .C, .D:
                return nil
            }
        }
        
        if let text = text{
            label = UILabel()
            label?.textAlignment = .center
            label?.font = UIFont(name: "HelveticaNeue", size: 25)
            label?.text = text
        }
        return label
    }
    
}
