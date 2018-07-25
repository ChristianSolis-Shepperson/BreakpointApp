//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Christian Solis-Shepperson on 6/4/18.
//  Copyright © 2018 Christian Solis-Shepperson. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    //Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text
            , forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (success) in
                if success {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("There was an error!")
                }
            }
        }
        
    }
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
