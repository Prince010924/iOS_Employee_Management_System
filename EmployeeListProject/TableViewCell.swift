//
//  TableViewCell.swift
//  EmployeeListProject
//
//  Created by DA MAC M1 124 on 2023/05/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var empNumber: UILabel!
    
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
