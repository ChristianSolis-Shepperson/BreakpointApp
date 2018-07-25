//
//  GroupCell.swift
//  breakpoint
//
//  Created by Christian Solis-Shepperson on 6/9/18.
//  Copyright © 2018 Christian Solis-Shepperson. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    func configureCell(title: String, description:String, memberCount: Int){
        self.groupTitleLbl.text = title
        self.groupDescriptionLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members"
    }
}
