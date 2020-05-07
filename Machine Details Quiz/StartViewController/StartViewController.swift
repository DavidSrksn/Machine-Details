//
//  File.swift
//  Machine Details
//
//  Created by David Sarkisyan on 14.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

class StartViewController: UIViewController{
    var viewIsOpened: Bool = false
    
    let openExistingButton = UIButton()
    var openExistingButtonAnimator = UIDynamicAnimator()
    
    let startButton = UIButton()
    var startButtonAnimator = UIDynamicAnimator()
    
    let descriptionButton = UIButton()
    let descriptionLabel = UILabel()
    var descriptionButtonAnimator = UIDynamicAnimator()
    
    override func viewDidLoad() {
        setupDescriptionButton()
        setupOpenExistingButton()
        setupStartButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !viewIsOpened{
            let startButtonBottom = view.safeAreaLayoutGuide.layoutFrame.height/2
            setupButtonAnimator(animator: &startButtonAnimator,view: startButton, y: startButtonBottom)
            
            let openExistingButtonBottom = startButtonBottom + startButton.bounds.height + 30
            setupButtonAnimator(animator: &openExistingButtonAnimator,view: openExistingButton, y: openExistingButtonBottom)
            
            let descriptionButtonBottom = openExistingButtonBottom + openExistingButton.bounds.height + 30
            setupButtonAnimator(animator: &descriptionButtonAnimator,view: descriptionButton, y: descriptionButtonBottom)
            
            setupTickerView()
        }
        viewIsOpened = true
    }
    
    func setupTickerView(){
        let superView = UIView()
        let tickerLabel = UILabel()
        
        view.addSubview(superView)
         
        superView.frame = CGRect(x: 0, y: view.bounds.maxY - 50, width: view.bounds.width, height: 50)
        tickerLabel.frame = superView.bounds
        
        tickerLabel.text = "created by DavidS"
        tickerLabel.textAlignment = .center
        
        let tickerView = TickerView(duration: 5, tickerView: tickerLabel, superView: superView, interval: 30)
        tickerView.start()
    }
    
    func setupStartButton(){
        view.addSubview(startButton)
        
        startButton.addTarget(nil, action: #selector(startButtonAction), for: .touchUpInside)
        
        let width = view.frame.width * 0.65
        let height: CGFloat = 50
        let x = view.safeAreaLayoutGuide.layoutFrame.width/2 - width/2
        
        startButton.frame = CGRect(x: x, y: 0, width: width, height: height)
        
        startButton.backgroundColor = UIColor.Customs.lightBlack
        startButton.layer.cornerRadius = 20
        
        startButton.setTitle("Начать", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
    }

    @objc func startButtonAction(){
        self.presentFullscreen(viewController: InputDataViewController())
    }
    
    @objc func openExistingButtonAction(){
        let viewController = SavedFilesViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupOpenExistingButton(){
        view.addSubview(openExistingButton)
        
        openExistingButton.addTarget(nil, action: #selector(openExistingButtonAction), for: .touchUpInside)
        
        let width = view.frame.width * 0.8
        let height: CGFloat = 50
        let x = view.safeAreaLayoutGuide.layoutFrame.width/2 - width/2
        
        openExistingButton.frame = CGRect(x: x, y: 0, width: width, height: height)
        
        openExistingButton.backgroundColor = UIColor.Customs.lightBlack
        openExistingButton.layer.cornerRadius = 20
        
        openExistingButton.setTitle("Открыть имеющийся", for: .normal)
        openExistingButton.setTitleColor(.white, for: .normal)
    }
    
    func setupDescriptionButton(){
        view.addSubview(descriptionButton)
        
        descriptionButton.addTarget(nil, action: #selector(descriptionButtonAction), for: .touchUpInside)
        
        let width = view.frame.width * 0.4
        let height: CGFloat = 50
        let x = view.safeAreaLayoutGuide.layoutFrame.width/2 - width/2
        
        descriptionButton.frame = CGRect(x: x, y: 0, width: width, height: height)
        
        descriptionButton.backgroundColor = UIColor.Customs.lightBlack
        descriptionButton.layer.cornerRadius = 20
        
        descriptionButton.setTitle("Описание", for: .normal)
        descriptionButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func descriptionButtonAction(){
        if !view.subviews.contains(descriptionLabel){
            view.addSubview(descriptionLabel)
            
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor).isActive = true
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            
            let descriptionText: String = "Опсиание"
            descriptionLabel.text = descriptionText
            descriptionLabel.textAlignment = .center
            descriptionLabel.textColor = .black
        }else{
            descriptionLabel.removeFromSuperview()
        }
    }
    
    func setupButtonAnimator(animator: inout UIDynamicAnimator,view: UIView, y: CGFloat){
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let gravity = UIGravityBehavior(items: [view])
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [view])
        collision.addBoundary(withIdentifier: "Collision" as NSCopying, from: CGPoint(x: 0, y: y), to: CGPoint(x: self.view.bounds.width, y: y))
        animator.addBehavior(collision)
    }
    
}
