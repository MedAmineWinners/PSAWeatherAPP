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
    
    weak var delegate: CurrentCityWeatherAdd?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCityTextField.delegate = self
        PSAWeatherSDK.shared.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        PSAWeatherSDK.shared.addCity(with: textField.text ?? "")
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
