//
//  LocationTableViewCell.swift
//  WeatherTalentoMobile
//
//  Created by Esther on 12/3/17.
//  Copyright © 2017 Esther. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLocation.font = Fonts.ListElement
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
