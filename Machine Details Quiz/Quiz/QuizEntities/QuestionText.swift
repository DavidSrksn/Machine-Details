//
//  QuestionText.swift
//  Machine Details
//
//  Created by David Sarkisyan on 11.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

extension String{
    
    static func questionText(questionType: QuizQestion) -> String{
        switch questionType{
        case .scheme:
            return "Выберите тип расположения источника и потребителя"
        case .transmission:
            return "Выберите угол передачи движения в редукторе"
        case .smoothness:
            return "Требуется ли плавность хода?"
        case .cost:
            return "Что предпочтительнее?"
        }
    }
    
}
