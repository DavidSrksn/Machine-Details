//
//  Ticker.swift
//  Machine Details
//
//  Created by David Sarkisyan on 31.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

import UIKit
import CoreGraphics

class TickerView{
    let duration: Double
    let interval: CGFloat
    
    let superView: UIView
    
    let tickerImage: UIImage?
    let tickerViewframe: CGRect
    
    init(duration: Double, tickerView: UIView, superView: UIView, interval: CGFloat) {
        self.duration = duration
        self.superView = superView
        
        tickerView.sizeToFit()
        self.tickerViewframe = tickerView.frame
        
        self.tickerImage = UIImage.makeScreenShot(view: tickerView)
        self.interval = interval
    }
    
    public func start(){
        let view = setupTickerView()
        let nextItemPassingTime = calculateDurations(tickerView: view)
        tickerAnimation(view: view, nextItemPassingTime: nextItemPassingTime)
    }
    
    private func tickerAnimation(view: UIView, nextItemPassingTime: Double){
        UIView.animate(withDuration: duration, delay:  0.0, options: [.curveLinear], animations: {
            let animation = CGAffineTransform(translationX: -self.superView.bounds.width - view.bounds.width, y: 0)
            view.transform = animation
        }) { (bool) in
            view.removeFromSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + nextItemPassingTime) {
        self.start()
        }
    }
    
    private func setupTickerView() -> UIView{
        let tickerImageView = UIImageView()
        tickerImageView.image = tickerImage
        
        superView.addSubview(tickerImageView)
        
        tickerImageView.frame = tickerViewframe
        tickerImageView.frame.origin.x = superView.bounds.width
        
        return tickerImageView
    }
    
    private func calculateDurations(tickerView: UIView) -> Double{
        let nextItemPassingTime = duration * Double(tickerView.bounds.width + interval) / Double(superView.bounds.width)

        return nextItemPassingTime
    }
    
}
