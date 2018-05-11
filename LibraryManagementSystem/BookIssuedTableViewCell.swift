//
//  BookIssuedTableViewCell.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/27/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit

class BookIssuedTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var bookNameLbl: UILabel!
    @IBOutlet weak var studentNamelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
