//
//  ShadowView.swift
//  breakpoint
//
//  Created by Christian Solis-Shepperson on 6/3/18.
//  Copyright © 2018 Christian Solis-Shepperson. All rights reserved.
//

import UIKit
@IBDesignable

class ShadowView: UIView {

    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    func setupView(){
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }

}
