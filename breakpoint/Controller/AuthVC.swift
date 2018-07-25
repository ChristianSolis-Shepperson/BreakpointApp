//
//  AuthVC.swift
//  breakpoint
//
//  Created by Christian Solis-Shepperson on 6/3/18.
//  Copyright © 2018 Christian Solis-Shepperson. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func signInWithEmailBtnPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleSignInBtnPressed(_ sender: Any) {
    }
    
    @IBAction func facebookSignInBtnPressed(_ sender: Any) {
    }
    
    
    
    
    

}
