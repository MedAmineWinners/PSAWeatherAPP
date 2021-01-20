//
//  HourlyCollectionViewCell.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var hourWeatherVM: HourWeatherViewModel? {
        didSet {
            if let hourWeatherVM = hourWeatherVM {
                hourLabel.text = hourWeatherVM.hour
                icon.image = UIImage(named: hourWeatherVM.icon)
                temperatureLabel.text = hourWeatherVM.temperature
            }
        }
    }
}
