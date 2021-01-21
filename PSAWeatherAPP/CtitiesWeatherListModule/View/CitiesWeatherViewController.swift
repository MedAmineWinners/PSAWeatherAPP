//
//  ViewController.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import PSAWeatherSDK
import UIKit

class CitiesWeatherViewController: UIViewController {
    
    var citiesWeatherVM = CitiesWeatherListViewModel(citiesWeatherVM: [CityWeatherViewModel]())
    private var datasource: CitiesTableViewDataSource?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        PSAWeatherSDK.shared.configure(with: "216f0a6fde418838d9d47d4cb09238f5")
        PSAWeatherSDK.shared.delegate = self
        PSAWeatherSDK.shared.getSavedCitiesCurrentWeatherList()
        setAppearence()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigation = segue.destination as? UINavigationController else {
            fatalError()
        }
        guard let addCityVC = navigation.viewControllers.first as? AddCityViewController else {
            fatalError()
        }
        addCityVC.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
}

extension CitiesWeatherViewController: PSAWeatherSDKDelegate {
    func PSAWeatherSDKDidFinishWithSuccess<T>(result: T) {
        if let citiesWeather =  result as? [CurrentCityWeather] {
            if citiesWeather.count > 0 {
                self.citiesWeatherVM = CitiesWeatherListViewModel(citiesWeatherVM: citiesWeather.map(CityWeatherViewModel.init))
                self.datasource = CitiesTableViewDataSource(self.citiesWeatherVM)
                self.datasource?.removeItemProtocol = self
                self.tableView.dataSource = datasource
                self.tableView.reloadData()
            } else {
                presentAddCityViewController()
            }
        }
    }
    
    func PSAWeatherSDKDidFailWithError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CitiesWeatherViewController: CurrentCityWeatherAdd {
    func currentCityWeatherAdded(cityWeatherVM: CityWeatherViewModel) {
        self.citiesWeatherVM.add(cityWeatherVM)
        self.datasource = CitiesTableViewDataSource(citiesWeatherVM)
        self.datasource?.removeItemProtocol = self
        self.tableView.dataSource = datasource
        self.tableView.reloadData()
    }
}

extension CitiesWeatherViewController: UITableViewDelegate, CitiesTableViewRemoveItemProtocol {
    
    func citiesTableViewDidRemove(currentCityWeatherVM: CityWeatherViewModel) {
        PSAWeatherSDK.shared.removeCurrentCityWeather(currentCityWeather: currentCityWeatherVM.currentWeather)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityWeatherVM = self.citiesWeatherVM.modelAt(indexPath.row)
        if let detailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailsViewController") as?  WeatherDetailsViewController {
            detailsVC.navigationController?.navigationBar.prefersLargeTitles = false
            detailsVC.cityWeatherVM = cityWeatherVM
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}


extension CitiesWeatherViewController {
    func setAppearence() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
    
    func presentAddCityViewController() {
        if let addCityVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCityViewController") as? AddCityViewController {
            addCityVC.delegate = self
            let nav = UINavigationController(rootViewController: addCityVC)
            self.navigationController?.present(nav, animated: true)
        }
    }
}
