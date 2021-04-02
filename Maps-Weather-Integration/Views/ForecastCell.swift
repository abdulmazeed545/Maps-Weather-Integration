//
//  ForecastCell.swift
//  Maps-Weather-Integration
//
//  Created by Shaik abdul mazeed on 01/04/21.
//

import UIKit

class ForecastCell: UICollectionViewCell {

    @IBOutlet weak var temparature: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var wind: UILabel!
    
    @IBOutlet weak var weather: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
