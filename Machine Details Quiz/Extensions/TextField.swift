//
//  TextField.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit



extension String{
    public func isCorrect() -> Bool{
        if let number = Int(self), String.permittedInterval.contains(number){
            return true
        }else {
            return false
        }
    }
    
    static let permittedInterval: ClosedRange = 3000...1900000000
}

// MARK: TextField status

enum TextFieldStatus{
    case correct
    case incorrect
    case empty
}


enum AssociatedKeys {
    static var status: TextFieldStatus = .empty
}

extension UITextField{
     var status: TextFieldStatus {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.status) as? TextFieldStatus ?? TextFieldStatus.empty
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.status, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func changeStatus(textField: UITextField) {
        if self.text! == "" {
            self.status = .empty
        }else if self.text!.isAllowed(){
            self.status = .correct
        }else if !self.text!.isAllowed(){
            self.status = .incorrect
        }
    }
}
