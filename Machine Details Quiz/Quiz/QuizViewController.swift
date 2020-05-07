//
//  ViewController.swift
//  Machine Details
//
//  Created by David Sarkisyan on 07.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, QuizViewControllerProtocol {

    init(generator: Generator) {
        self.result = ResultModel(consumerGenerator: generator)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var interactor: Interactor!
    var presenter: QuizPresenter!
    var router: QuizRouter!
    var questionModel: QuizQuestionModel!
    var result: ResultModel
    
    let buttonsStackView = UIStackView()
    let nextButton = UIButton()
    let backButton = UIButton()
    let finishButton = UIButton()
    
    let questionLabel = UILabel()
    let optionsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViper()
        router.navigationStack.append(QuizQuestionModel(type: .scheme, previousResult: result))
        self.questionModel = router.navigationStack[0]
        view.backgroundColor = .white
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureQuestionLabel()
        setupButtonsStackView()
        configureQuestionStackView()
    }
    
    func setupQuestionText(question: String){
        questionLabel.text = question
    }
    
    func setupViper(){
        let presenter = QuizPresenter(viewController: self)
        self.presenter = presenter
        
        let router = QuizRouter(viewController: self)
        self.router = router
        
        self.interactor = Interactor()
    }
    
    func configureNavigatingButton(button: UIButton, type: ImageType) -> UIButton{
        button.backgroundColor = UIColor.Customs.lightBlack
        
        button.tintColor = .white
        button.setImage(UIImage.setup(type: type), for: .normal)
        
        nextButton.addTarget(.none, action: #selector(changeToNextQuestion), for: .touchUpInside)
        backButton.addTarget(.none, action: #selector(changeToPreviousQuestion), for: .touchUpInside)
        
        return button
    }
    
    @objc func changeToNextQuestion(){
        if let _ = selectedCell(){
            interactor.changeResult(of: &questionModel, currentResult: &result)
            
            let questionModel: QuizQuestionModelProtocol? = self.questionModel.nextQuestion(previousResult: result)
            
            if let questionModel = questionModel as? QuizQuestionModel{
                router.presentNextQuestion(question: questionModel)
                presenter.changeQuestion()
            }else{
                self.presentAlert(type: .finish, titleAndCompletion: [
                    ("Отменить", {(action)-> Void in
                        self.result = self.questionModel.previousResult
                    }),
                    ("Ок", {(action)-> Void in
                        let navigationController = NavigationController(rootViewController: QuizFinalViewController(result: self.result))
                        self.presentFullscreen(viewController: navigationController)
                    })
                ])
            }
        }else{
            optionsTableView.visibleCells.forEach { (cell) in
                cell.warning()
            }
        }
    }
    
    @objc func changeToPreviousQuestion(){
        router.presentPreviousQuestion()
        result = questionModel.previousResult
        presenter.changeQuestion()
    }
    
    @objc func finishButtonAction(){
        self.presentAlert(type: .finish, titleAndCompletion: [
            ("Отменить", nil),
            ("Ок", {(action)-> Void in
                let navigationController = NavigationController(rootViewController: StartViewController())
                self.presentFullscreen(viewController: navigationController)
            })
        ])
    }
    
    func configureFinishButton() -> UIButton{
        finishButton.backgroundColor = UIColor.Customs.lightBlack
        
        finishButton.setTitle("Завершить", for: .normal)
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.layer.cornerRadius = 10
        
        finishButton.addTarget(nil, action: #selector(finishButtonAction), for: .touchUpInside)
        
        return finishButton
    }
    
    func setupButtonsStackView(){
        view.addSubview(buttonsStackView)
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsStackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        buttonsStackView.addArrangedSubview(configureNavigatingButton(button: backButton, type: .back))
        buttonsStackView.addArrangedSubview(configureFinishButton())
        buttonsStackView.addArrangedSubview(configureNavigatingButton(button: nextButton, type: .next))
    }
    
    func configureQuestionLabel(){
        view.addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        questionLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        questionLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont(name: "HelveticaNeue", size: 30)
        questionLabel.textAlignment = .center
        questionLabel.textColor = .black
        
        questionLabel.layer.borderColor = UIColor.black.cgColor
        questionLabel.layer.borderWidth = 0.5
        
        setupQuestionText(question: questionModel.text)
    }

    func configureQuestionStackView(){
        view.addSubview(optionsTableView)
        
        optionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        optionsTableView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor).isActive = true
        optionsTableView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -5).isActive = true
        optionsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        optionsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}


extension QuizViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellsCount: Int = questionModel.options.count
        let tableViewHeight = optionsTableView.frame.height
        
        return tableViewHeight / CGFloat(cellsCount)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QuizTableViewCell()
        let option = questionModel.options[indexPath.row]
        cell.setupCell(option: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell: QuizTableViewCell = tableView.cellForRow(at: indexPath) as? QuizTableViewCell{
            if !sameOptionSelected(didSelectCell: cell){
                router.deleteNavigation(after: questionModel)
            }
            cell.checkToUnselect(selectedCell: selectedCell())
            cell.setSelectced(selectedCell: selectedCell())
            questionModel.setOptionSelected(index: indexPath.row)
        }
        
        return
    }
    
    private func selectedCell() -> QuizTableViewCell?{
        if let tableViewCells = optionsTableView.visibleCells as? [QuizTableViewCell]{
            for cell in tableViewCells{
                if cell.status == .selected{
                    return cell
                }
            }
        }
        return nil
    }
    
    private func sameOptionSelected(didSelectCell: QuizTableViewCell) -> Bool{
        let selectedOptionIndex = questionModel.options.firstIndex { (option) -> Bool in
            option.isSelected
        }
        let selectedCellIndex = optionsTableView.visibleCells.firstIndex { (cell) -> Bool in
            cell as? QuizTableViewCell == didSelectCell
        }
        if selectedCellIndex == selectedOptionIndex{
            return true
        }
        return false
    }
    
}
