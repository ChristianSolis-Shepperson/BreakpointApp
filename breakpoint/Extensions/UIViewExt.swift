//
//  UIViewExt.swift
//  breakpoint
//
//  Created by Christian Solis-Shepperson on 6/4/18.
//  Copyright © 2018 Christian Solis-Shepperson. All rights reserved.
//

import UIKit

extension UIView{
    
    func bindToKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification){
        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
        
        if #available(iOS 11.0, *) {
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
                self.frame.origin.y += deltaY
                self.frame.origin.y += (self.window?.safeAreaInsets.bottom)!
            }, completion: nil)
        } else {
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
                self.frame.origin.y += deltaY
            }, completion: nil)
        }
    }
}
