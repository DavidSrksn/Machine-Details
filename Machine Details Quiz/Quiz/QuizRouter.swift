//
//  QuizRouter.swift
//  Machine Details
//
//  Created by David Sarkisyan on 09.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

class QuizRouter: QuizRouterProtocol {

    var viewController: QuizViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController as! QuizViewController
    }
    
    var navigationStack: [QuizQuestionModel] = []
    
    func presentNextQuestion(question: QuizQuestionModel){
        let indexOfModel: Int? = navigationStack.firstIndex { (savedQuestion) -> Bool in
            savedQuestion.text == question.text
        }
        if let nextModelIndex = indexOfModel{
            viewController.questionModel = navigationStack[nextModelIndex]
        }else{
            animateTransition(duration: 0.3)
            navigationStack.append(question)
            viewController.questionModel = navigationStack.last!
        }
    }
    
    func presentPreviousQuestion(){
        let currentQuestionIndex: Int? = navigationStack.firstIndex { (question) -> Bool in
            question.text == viewController.questionModel.text
        }
        
        if let currentQuestionIndex = currentQuestionIndex{
            let previousIndex: Int = currentQuestionIndex - 1
            if previousIndex >= 0{
                viewController.questionModel = navigationStack[previousIndex]
            }
        }else{
            viewController.questionModel = navigationStack.last!
        }
    }
    
    public func deleteNavigation(after question: QuizQuestionModel){
        let indexToDeleteAfter: Int? = navigationStack.firstIndex { (questionModel) -> Bool in
            questionModel.text == question.text
        }
        
        if let indexToDeleteAfter = indexToDeleteAfter, indexToDeleteAfter + 1 <= navigationStack.count - 1 {
            for _ in indexToDeleteAfter + 1 ..< navigationStack.count {
                navigationStack.removeLast()
            }
        }
    }
    
    private func animateTransition(duration: Double){
        guard let image = UIImage.makeScreenShot(view: viewController.view) else {return}
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = viewController.view.bounds
        imageView.center = viewController.view.center
        
        viewController.view.addSubview(imageView)
        
        let transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        imageView.isOpaque = true
        UIView.animate(withDuration: duration, animations: {
            imageView.transform = transform
            imageView.alpha = 0
        }) { (bool) in
            imageView.removeFromSuperview()
        }
        
    }
    
}
