//
//  Alert.swift
//  Machine Details
//
//  Created by David Sarkisyan on 14.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

extension UIViewController{
    func presentAlert(type: AlertType, titleAndCompletion: [(String,((UIAlertAction) -> Void)?)]){
        let alert = UIAlertController(type: type)
        alert.setupAlertAction(titleAndCompletion: titleAndCompletion)
        self.present(alert, animated: true, completion: nil)
    }
}

internal enum AlertType{
    case finish
    case error
}


extension UIAlertController{
    
    convenience init(type: AlertType) {
        let alertConfigurator = ALertComponentsConfigurator()
        let alertTitle: String = alertConfigurator.setupAlertTitle(type: type)
        let alertMessage: String = alertConfigurator.setupAlertMessage(type: type)
        
        self.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
    }
    
    func setupAlertAction(titleAndCompletion: [(String,((UIAlertAction) -> Void)?)] ){
        for (title,action) in titleAndCompletion{
            self.addAction(UIAlertAction(title: title, style: .default, handler: action))
        }
    }

}

class ALertComponentsConfigurator{
        
        fileprivate func setupAlertTitle(type: AlertType) -> String{
            switch type{
            case .finish:
                return "Предупреждение"
            case .error:
                return "Ошибка"
            }
        }
        
        fileprivate func setupAlertMessage(type: AlertType) -> String{
            switch type{
            case .finish:
                return "Вы уверены, что хотите завершить?"
            case .error:
                return "Программа не находит подходящих Вашему случаю решений"
            }
        }
    
}
