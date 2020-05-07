//
//  QuizFinalViewController.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit


class QuizFinalViewController: UIViewController{
    
    var result: ResultModel
    
    let resultHeaderLabel = UILabel()
    let resultStackView = UIStackView()
    let scrollView = UIScrollView()
    
    let savePDFButton = UIButton()
    let finishButton = UIButton()
    
    var resultGearDisplay = CADisplayLink()
    let startTime = Date()
    var resultGearRatioLabel = UILabel()
    
    init(result: ResultModel) {
        self.result = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        if let resultSourceGenerator = calculateSourceGenerator(){
            result.sourceGenerator.frequency = resultSourceGenerator.0
            result.sourceGenerator.name = resultSourceGenerator.1
            
            let schemeGearRatio: Double = (result.consumerGenerator.frequency ?? 0 ) / resultSourceGenerator.0
            result.gearbox.gearRatio = calculateGearboxGearRatio(schemeGearRatio: schemeGearRatio)
        }else{
            self.presentAlert(type: .error, titleAndCompletion: [
            ("Ok", nil)
            ])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.Customs.lightBlack
        setupScrollView()
        setupResultHeaderLabel()
        setupFinishButton()
        setupSavePDFButton()
        setupResultStackView()
        
        resultGearDisplay = CADisplayLink(target: self, selector: #selector(resultGearDisplayAction))
        resultGearDisplay.preferredFramesPerSecond = 50
        resultGearDisplay.add(to: .main, forMode: .default)
    }
    
    func calculateSourceGenerator() -> (Double, String)?{
        if let gearboxType = result.gearbox.type.first,
            let consumerFrequency = result.consumerGenerator.frequency{
            
            let (oneStageRange, twoStageRange) = gearboxType.rawValue
            
            if let oneStageParameters = calculateStageMaxAllowedFrequency(consumerFrequency: consumerFrequency, stageRange: oneStageRange){
                self.result.gearbox.stageNumber.removeLast()
                return oneStageParameters
            }else if let twoStageRange = twoStageRange, let twoStageParameters = calculateStageMaxAllowedFrequency(consumerFrequency: consumerFrequency, stageRange: twoStageRange){
                self.result.gearbox.stageNumber.removeFirst()
                return twoStageParameters
            }
        }
        return nil
    }
    
    func calculateStageMaxAllowedFrequency(consumerFrequency: Double, stageRange: (Double,Double)) -> (Double,String)?{
        let minSourceFrequency: Double = consumerFrequency / result.gearRatio(gearboxRatio: stageRange.1)
        let maxSourceFrequency: Double = consumerFrequency / result.gearRatio(gearboxRatio: stageRange.0)
        
        let allSourceOptions: [(Double, String)] = GeneratorFrequency.allGeneratorOptions()
        
        if !(minSourceFrequency > allSourceOptions.last!.0 || maxSourceFrequency < allSourceOptions.first!.0){ // условие пересечения
            if maxSourceFrequency < allSourceOptions.last!.0 {
                return searchNearestRight(to: maxSourceFrequency, in: allSourceOptions)
            }else{
                return allSourceOptions.last
            }
        }
        return nil
    }
    
    func searchNearestRight(to element: Double, in sequence: [(Double,String)]) -> (Double,String){
        var temp = sequence.max { (first, second) -> Bool in
            first.0 <= second.0
        }
        
        for unit in sequence{
            if unit.0 < temp!.0 && unit.0 >= element{
                temp = unit
            }
        }
        
        return temp!
    }
    
    func calculateGearboxGearRatio(schemeGearRatio: Double) -> Double{
        let chainTransmissionGearRatio: Double = result.chainTransmission?.gearRatio ?? 1
        let beltTransmissionGearRatio: Double = result.beltTransmission?.gearRatio ?? 1
        
        return schemeGearRatio / chainTransmissionGearRatio / beltTransmissionGearRatio
    }
    
    func setupResultHeaderLabel(){
        view.addSubview(resultHeaderLabel)
        
        resultHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        resultHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        resultHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        resultHeaderLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        resultHeaderLabel.textColor = .white
        resultHeaderLabel.font = UIFont(name: "HelveticaNeue", size: 40)
        resultHeaderLabel.numberOfLines = 0
        resultHeaderLabel.text = "Результаты"
        resultHeaderLabel.textAlignment = .center
    }
    
    @objc func savePDFButtonAction(){
        let pdfCreator = PDFConfigurator(result: result)
        let data = pdfCreator.createResultPDF()
        
        let viewController = PDFViewController(documentData: data, showSaveNotification: true)
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func setupSavePDFButton(){
        view.addSubview(savePDFButton)
        
        savePDFButton.addTarget(nil, action: #selector(savePDFButtonAction), for: .touchUpInside)
        
        savePDFButton.translatesAutoresizingMaskIntoConstraints = false
        
        savePDFButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        savePDFButton.bottomAnchor.constraint(equalTo: finishButton.topAnchor, constant: -7).isActive = true
        savePDFButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.65).isActive = true
        savePDFButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        savePDFButton.backgroundColor = .white
        savePDFButton.layer.cornerRadius = 20
        
        savePDFButton.setTitle("Сохранить в PDF", for: .normal)
        savePDFButton.setTitleColor(UIColor.Customs.lightBlack, for: .normal)
    }
    
    @objc func finishButtonAction(){
        let navigationController = NavigationController(rootViewController: StartViewController())
        self.presentFullscreen(viewController: navigationController)
    }
    
    func setupFinishButton(){
        view.addSubview(finishButton)
        
        finishButton.addTarget(nil, action: #selector(finishButtonAction), for: .touchUpInside)
        
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        
        finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        finishButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.55).isActive = true
        finishButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        finishButton.backgroundColor = UIColor.Customs.red
        finishButton.layer.cornerRadius = 20
        
        finishButton.setTitle("Завершить", for: .normal)
        finishButton.setTitleColor(UIColor.Customs.lightBlack, for: .normal)
    }
    
    @objc func resultGearDisplayAction(){
        let startValue: Double = 0
        let endValue: Double = result.gearRatio(gearboxRatio: result.gearbox.gearRatio ?? 0)
        
        let duration: Double = 1.5
        let now = Date()
        let passedTime = now.timeIntervalSince(startTime)
        
        if passedTime > duration{
            resultGearRatioLabel.text = String.resultShemeGearRatioFormula(result: result) + "\(round(endValue))"
            resultGearDisplay.invalidate()
        }else{
            let perc = passedTime / duration
            let value = startValue + perc * (endValue - startValue)
            resultGearRatioLabel.text =  String.resultShemeGearRatioFormula(result: result) + "\(round(value))"
        }
    }
    
    func setupScrollView(){
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.backgroundColor = .clear
    }
    
    func setupResultStackView(){
        resultStackView.axis = .vertical
        resultStackView.distribution = .fillEqually
        resultStackView.spacing = 50
        
        resultStackView.tintColor = .black
        
        scrollView.addSubview(resultStackView)
        
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        
        resultStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        resultStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        resultStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        resultStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        for type in ResultType.allCases{
            resultStackView.addArrangedSubview(componentStackView(headerLabel: UILabel.resultHeader(type: type), description: UILabel.resultLabel(type: type, result: result)))
        }
        
    }
    
    func componentStackView(headerLabel: UILabel, description: UILabel) -> UIStackView{
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.tintColor = .black
        
        if headerLabel.text == UILabel.resultHeader(type: .schemeGearRatio).text{
            resultGearRatioLabel = description
        }
        
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(description)
        
        return stackView
    }
    
}
