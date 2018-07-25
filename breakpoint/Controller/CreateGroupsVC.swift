//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by Christian Solis-Shepperson on 6/7/18.
//  Copyright © 2018 Christian Solis-Shepperson. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {

    //Outlets
    @IBOutlet weak var titleTxtField: InsetTextField!
    @IBOutlet weak var descriptionTxtField: InsetTextField!
    @IBOutlet weak var emailTxtField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    //Variables
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailTxtField.delegate = self
        emailTxtField.addTarget(self, action: #selector (textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChange(){
        if emailTxtField.text == ""{
            emailArray =  []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailTxtField.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleTxtField.text != "" && descriptionTxtField.text != ""{
            DataService.instance.getIds(forUsernames: chosenUserArray) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.email)!)
                
                DataService.instance.createGroup(withTitle: self.titleTxtField.text!, andDescription: self.descriptionTxtField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated{
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("group could not be created. Please try again")
                    }
                })
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]){
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({$0 != cell.emailLbl.text})
            if chosenUserArray.count > 1{
                groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                groupMemberLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
    
}

extension CreateGroupsVC: UITextFieldDelegate{
    
}
