//
//  InputDataPresenter.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

protocol InputDataPresenterProtocol {
    init(viewController: InputDataViewControllerProtocol)
}

class InputDataPresenter:  InputDataPresenterProtocol {
    
    unowned let view: InputDataViewControllerProtocol
    
    required init(viewController: InputDataViewControllerProtocol) {
        self.view = viewController
    }
    
    func showAlertWarning(message: String){
        view.setAlertWarning(message: message)
    }
    
    func showShimmerWarning(textfieldType: InputDataTextField){
        view.setShimmerWarning(textfieldType: textfieldType)
    }
    
    func presentQuizViewController(generator: Generator){
        view.presentViewController(viewController: QuizViewController(generator: generator))
    }
}
