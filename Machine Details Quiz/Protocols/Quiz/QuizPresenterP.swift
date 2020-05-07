//
//  QuizPresenter.swift
//  Machine Details
//
//  Created by David Sarkisyan on 09.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

protocol QuizPresenterProtocol {
    init(viewController: QuizViewControllerProtocol)
    
    func setupQuestionText(text: String)

    func changeQuestion()
}
