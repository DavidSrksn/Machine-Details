//
//  QuizViewControllerProtocol.swift
//  Machine Details
//
//  Created by David Sarkisyan on 09.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

protocol QuizViewControllerProtocol: class{
    
    var presenter: QuizPresenter! {get set}
    
    var router: QuizRouter! {get}
    
    var questionModel: QuizQuestionModel! {get set}
    
    var optionsTableView: UITableView {get}
    
    func setupQuestionText(question: String)
    
}
