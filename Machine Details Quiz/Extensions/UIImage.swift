//
//  Button.swift
//  Machine Details
//
//  Created by David Sarkisyan on 07.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

public enum ImageType{
    case next
    case back
    case unselected
    case selected
}

extension UIImage{
    
    static func setup(type: ImageType) -> UIImage{
        var image: UIImage{
            switch type{
            case .back:
                return UIImage(systemName: "arrow.left")!
            case .next:
                return UIImage(systemName: "arrow.right")!
            case .selected:
                return UIImage(systemName: "checkmark.circle")!
            case .unselected:
                return UIImage(systemName: "circle")!
            }
        }

        image.withRenderingMode(.alwaysTemplate)
        return image
    }
    
    static func makeScreenShot(view: UIView) -> UIImage?{
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else{return nil}
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
