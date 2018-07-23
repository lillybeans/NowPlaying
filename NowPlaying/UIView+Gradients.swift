//
//  UIView+Gradients.swift
//  NowPlaying
//
//  Created by Lilly Tong on 2018-07-22.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradientBackground(colorOne: UIColor, colorTwo: UIColor, location: NSNumber){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [location, 1] //starting point of gradient transition: between 0 and 1
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
