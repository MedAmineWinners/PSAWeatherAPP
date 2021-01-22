//
//  AddCityViewController.swift
//  PSAWeatherAPP
//
//  Created by Mohamed Lamine Belfekih on 19/01/2021.
//

import PSAWeatherSDK
import UIKit

class AddCityViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addCityTextField: UITextField!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    weak var delegate: CurrentCityWeatherAdd?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCityTextField.delegate = self
        PSAWeatherSDK.shared.delegate = self
        backgroundImageView.image = UIImage(named: Date().isDay() ? "clearSky" : "skyNight" )
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addCity()
        return true
    }
    
    @IBAction func addCitySelected(_ sender: Any) {
        addCity()
    }
    
    private func addCity() {
        if self.addCityTextField.isValidTextFieldContent() {
            PSAWeatherSDK.shared.addCity(with: self.addCityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension AddCityViewController: PSAWeatherSDKDelegate {
    func PSAWeatherSDKDidFinishWithSuccess<T>(result: T) {
        if let cityWeather =  result as? CurrentCityWeather {
            let cityWeatherVM = CityWeatherViewModel(currentCityWeather: cityWeather)
            self.delegate?.currentCityWeatherAdded(cityWeatherVM: cityWeatherVM)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func PSAWeatherSDKDidFailWithError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
