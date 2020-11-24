//
//  TableViewCell.swift
//  WeatherAndGeo
//
//  Created by Радмир Юмагужин on 24.11.2020.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelCity: UILabel!
    
    @IBOutlet weak var labelTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
