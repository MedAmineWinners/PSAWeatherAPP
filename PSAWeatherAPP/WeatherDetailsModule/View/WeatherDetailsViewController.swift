//
//  WeatherDetailsViewController.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import UIKit
import PSAWeatherSDK

class WeatherDetailsViewController: UIViewController {
    var cityWeatherVM: CityWeatherViewModel?
    
    var tableViewdataSource: DailyTableViewDataSource?
    var collectionViewDataSource: HourlyCollectionViewDataSource?
    
    var weatherDetailsVM: WeatherDetailsViewModel?
    var dailyListVM = DailyWeatherListViewModel([DayWeatherViewModel]())
    var hourlyListVM = HourlyWeatherListViewModel([HourWeatherViewModel]())
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        PSAWeatherSDK.shared.delegate = self
        if let currentCityWeather = cityWeatherVM?.currentWeather {
            PSAWeatherSDK.shared.getCityWeatherDetails(of: currentCityWeather)
            setView()
        }
    }
    
    func setView()  {
        cityLabel.text = cityWeatherVM?.cityName
        descriptionLabel.text = cityWeatherVM?.description
        feelsLikeLabel.text = cityWeatherVM?.feelsLike
        backgroundImage.image = UIImage(named: Date().isDay() ? "clearSky" : "skyNight" )
        temperatureLabel.text = cityWeatherVM?.temperature
    }
    
    func setCurrentDayDetailsView(dayWeatherVM: DayWeatherViewModel?) {
        if let dayWeatherVM = dayWeatherVM {
            humidityLabel.text = dayWeatherVM.humidity
            pressureLabel.text = dayWeatherVM.pressure
            sunriseLabel.text = dayWeatherVM.sunrise
            sunsetLabel.text = dayWeatherVM.sunset
        }
    }
}

extension WeatherDetailsViewController: PSAWeatherSDKDelegate {
    func PSAWeatherSDKDidFinishWithSuccess<T>(result: T) {
        if let weatherDetails = result as? WeatherDetails {
            guard var dailyList = weatherDetails.dailyForcast?.allObjects as? [Daily] else {
                return
            }
            guard var hourlyList = weatherDetails.hourlyForcast?.allObjects as? [Hourly] else {
                return
            }
            
            dailyList.sort{ $0.date < $1.date }
            hourlyList.sort{ $0.date < $1.date }
            self.dailyListVM.list = dailyList.map(DayWeatherViewModel.init)
            self.hourlyListVM.list = hourlyList.map(HourWeatherViewModel.init)
            
            self.setCurrentDayDetailsView(dayWeatherVM: self.dailyListVM.list.first)
            self.tableViewdataSource = DailyTableViewDataSource(dailyListVM)
            self.collectionViewDataSource = HourlyCollectionViewDataSource(hourlyListVM)
            
            self.tableView.dataSource = self.tableViewdataSource
            self.collectionView.dataSource = self.collectionViewDataSource
            
            self.tableView.reloadData()
            self.collectionView.reloadData()
            
        }
    }
    
    func PSAWeatherSDKDidFailWithError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


