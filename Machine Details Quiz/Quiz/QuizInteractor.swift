//
//  Interactor.swift
//  Machine Details
//
//  Created by David Sarkisyan on 12.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

class Interactor{
    
    func changeResult(of questionModel: inout QuizQuestionModel, currentResult: inout ResultModel){
        questionModel.changeResult(result: &currentResult)
    }
    
}

