//
//  InsetTextField.swift
//  breakpoint
//
//  Created by Christian Solis-Shepperson on 6/3/18.
//  Copyright © 2018 Christian Solis-Shepperson. All rights reserved.
//

import UIKit
@IBDesignable

class InsetTextField: UITextField {

    private var textPadding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return UIEdgeInsetsInsetRect(bounds, textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textPadding)
    }
    
    
    func setupView(){
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        self.attributedPlaceholder = placeholder
    }
    override func prepareForInterfaceBuilder() {
        setupView()
    }

}
