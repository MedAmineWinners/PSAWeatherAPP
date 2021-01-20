//
//  DailyTableViewCell.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var dayWeatherVM: DayWeatherViewModel? {
        didSet {
            if let dayWeatherVM = dayWeatherVM {
                dayLabel.text = dayWeatherVM.day
                icon.image = UIImage(named: dayWeatherVM.icon)
                minTempLabel.text = dayWeatherVM.minTemperature
                maxTempLabel.text = dayWeatherVM.maxTemperature
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
