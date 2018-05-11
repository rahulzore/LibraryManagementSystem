//
//  StudentBookTableViewCell.swift
//  
//
//  Created by Rahul Zore on 4/28/18.
//

import UIKit

class StudentBookTableViewCell: UITableViewCell {

    @IBOutlet weak var pendinglabel: UILabel!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
