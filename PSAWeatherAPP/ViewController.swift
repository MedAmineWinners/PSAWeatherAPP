//
//  ViewController.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import PSAWeatherSDK
import UIKit

class ViewController: UIViewController {
    
    var citiesWeatherVM = CitiesWeatherListViewModel(citiesWeatherVM: [CityWeatherViewModel]())
    private var datasource: CitiesTableViewDataSource?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        PSAWeatherSDK.shared.configure(with: "216f0a6fde418838d9d47d4cb09238f5")
        PSAWeatherSDK.shared.delegate = self
        PSAWeatherSDK.shared.getSavedCitiesCurrentWeatherList()
        registerNibsForTableView()
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
    
}

extension ViewController: PSAWeatherSDKDelegate {
    func PSAWeatherSDKDidFinishWithSuccess<T>(result: T) {
        if let citiesWeather =  result as? [CurrentCityWeather] {
            self.citiesWeatherVM = CitiesWeatherListViewModel(citiesWeatherVM: citiesWeather.map(CityWeatherViewModel.init))
            self.datasource = CitiesTableViewDataSource(self.citiesWeatherVM)
            self.tableView.dataSource = datasource
            self.tableView.reloadData()
        }
    }
    
    func PSAWeatherSDKDidFailWithError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension ViewController: CurrentCityWeatherAdd {
    func currentCityWeatherAdded(cityWeatherVM: CityWeatherViewModel) {
        self.citiesWeatherVM.add(cityWeatherVM)
        self.datasource = CitiesTableViewDataSource(citiesWeatherVM)
        self.tableView.dataSource = datasource
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}


extension ViewController {
    func registerNibsForTableView() {
        tableView.register(UINib.init(nibName: "currentCityWeatherCell", bundle: nil), forCellReuseIdentifier: "currentCityWeatherCell")
    }
    
    func setAppearence() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
