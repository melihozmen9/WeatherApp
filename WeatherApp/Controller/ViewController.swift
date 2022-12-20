//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kullanici on 13.12.2022.
//

import UIKit
import CoreLocation
class ViewController: UIViewController{
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temparatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
       
        searchTextField.delegate = self
        weatherManager.delegate = self
       
      
        
    }
    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
}
//MARK: - UITextFieldDelegate
extension ViewController:UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something here."
           return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}
//MARK: - WeatherManagerDelegate
extension ViewController : WeatherManagerDelegate {
   
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
           print("sıcaklık:\(weather.temperature)")
            self.temparatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.condition)
            self.cityLabel.text = weather.cityName
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - CLLocatinManagerDelegate
extension ViewController:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude : lat,longitude:lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

