//
//  QuizCellView.swift
//  Machine Details
//
//  Created by David Sarkisyan on 07.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit

enum Status{
    case selected
    case unselected
}

class QuizTableViewCell: UITableViewCell {
    
    var status: Status = .unselected  // для анимации выбранной ячейки
    
    var markImageView = UIImageView()
    
    private func changeMark(){
        switch status{
        case .selected:
            markImageView.image = UIImage.setup(type: .selected)
        case .unselected:
            markImageView.image = UIImage.setup(type: .unselected)
        }
    }
    
    private func changeStatus(){
        switch status{
        case .selected:
            status = .unselected
        case .unselected:
            status = .selected
        }
    }
    
    public func checkToUnselect(selectedCell: QuizTableViewCell?){
        if selectedCell != nil{
            selectedCell?.selectingAnimation()
            selectedCell?.changeStatus()
            selectedCell?.changeMark()
        }
    }
    
    private func selectingAnimation(){
        UIView.animate(withDuration: 0.25) {
            switch self.status{
            case .selected:
                self.backgroundColor = .clear
            case .unselected:
                self.backgroundColor = UIColor.Customs.lightGreen
            }
        }
    }
    
    public func setSelectced(selectedCell: QuizTableViewCell?){
        selectingAnimation()
        changeStatus()
        changeMark()
    }
    
    private func setupMarkImage(){
        addSubview(markImageView)
        
        markImageView.translatesAutoresizingMaskIntoConstraints = false
        
        markImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        markImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        markImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        markImageView.widthAnchor.constraint(equalToConstant: bounds.width * 0.15).isActive = true
        
        markImageView.tintColor = .black
        markImageView.contentMode = .scaleAspectFit
        markImageView.image = UIImage.setup(type: .unselected)
    }
    
    public func setupCell(option: OptionViewModelProtocol){
        setupSelectedView()
        setupMarkImage()
        configureOption(option: option)
        
        if option.isSelected == true{
            setSelectced(selectedCell: self)
        }
    }
    
    private func configureOption(option: OptionViewModelProtocol){
        let optionView = option.view
        
        self.contentMode = .scaleAspectFit
        
        addSubview(optionView)
        
        optionView.translatesAutoresizingMaskIntoConstraints = false
        
        optionView.leftAnchor.constraint(equalTo: markImageView.rightAnchor, constant: 10).isActive = true
        optionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        optionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        optionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    private func setupSelectedView(){
        let selectedCellview = UIView()
        selectedCellview.backgroundColor = .clear
        self.selectedBackgroundView = selectedCellview
    }
    
}
