//
//  QuizRouterP.swift
//  Machine Details
//
//  Created by David Sarkisyan on 09.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

protocol QuizRouterProtocol {
    init(viewController: UIViewController)
    
    var viewController: QuizViewController {get set}
    
    var navigationStack: [QuizQuestionModel] {get set}
        
    func presentNextQuestion(question: QuizQuestionModel)
    
    func presentPreviousQuestion()
    
}

extension QuizRouterProtocol{

}
