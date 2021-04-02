//
//  NameCell.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 01/04/21.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var cellVIew: UIView!
    @IBOutlet weak var cityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
