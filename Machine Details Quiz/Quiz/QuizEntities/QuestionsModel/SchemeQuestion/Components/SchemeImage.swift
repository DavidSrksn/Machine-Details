//
//  SchemeImage.swift
//  Machine Details
//
//  Created by David Sarkisyan on 09.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

extension UIImageView{
    static func scheme(option: QuizOption) -> UIImageView?{
        var imageView: UIImageView? 
        
        var image: UIImage?{
        switch option{
        case .A:
            return UIImage(named: "GearScheme")
        case .B:
            return UIImage(named: "ChainTransmissionScheme")
        case .C:
            return UIImage(named: "BeltTransmissionScheme")
        case .D:
            return nil
        }
    }
        
        if let image = image{
            imageView = UIImageView()
            imageView?.contentMode = .scaleAspectFit
            imageView?.image = image
            return imageView
        }
        
        return imageView
    }
    
}
