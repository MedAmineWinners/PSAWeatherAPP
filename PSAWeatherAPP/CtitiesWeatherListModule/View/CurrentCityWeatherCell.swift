//
//  CurrentCityWeatherCell.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import UIKit

class CurrentCityWeatherCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var backgroundImgView: UIImageView!
    
    var cityWeatherVM: CityWeatherViewModel? {
        didSet {
            if let cityWeatherVM = cityWeatherVM {
                cityNameLabel.text = cityWeatherVM.cityName
                temperatureLabel.text = cityWeatherVM.temperature
                weatherDescriptionLabel.text = cityWeatherVM.description
                minTempLabel.text = cityWeatherVM.minTemperature
                maxTempLabel.text = cityWeatherVM.maxTemperature
                backgroundImgView.image = UIImage(named: cityWeatherVM.backgroundImage)
               // icon.image = UIImage(named: cityWeatherVM.icon)
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
