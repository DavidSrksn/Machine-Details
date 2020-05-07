//
//  QuestionsPresenter.swift
//  Machine Details
//
//  Created by David Sarkisyan on 07.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

class QuizPresenter:  QuizPresenterProtocol {
      
    unowned let view: QuizViewControllerProtocol
    
    required init(viewController: QuizViewControllerProtocol) {
        self.view = viewController
    }
    
    func setupQuestionText(text: String){
        view.setupQuestionText(question: text)
    }
    
    func changeQuestion() {
        view.optionsTableView.reloadData()
        view.setupQuestionText(question: view.questionModel.text)
    }
}
