//
//  BookTableViewCell.swift
//  LibraryManagementSystem
//
//  Created by Rahul Zore on 4/26/18.
//  Copyright © 2018 Rahul Zore. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookCellView: UIView!
    @IBOutlet weak var bookTitlelbl: UILabel!
    @IBOutlet weak var bookSubtitlelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
