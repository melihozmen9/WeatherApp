//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Kullanici on 14.12.2022.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel)
    func didFailWithError(error : Error)
}
struct WeatherManager {
    var delegate : WeatherManagerDelegate?

    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e05a8069baa54e66a78bab788129da43&units=metric&"
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)q=\(cityName)"
        performRequest(with: urlString)
    }
    func fetchWeather(latitude: CLLocationDegrees,longitude:CLLocationDegrees){
        let urlString = "\(weatherURL)lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString:String){
        // Create URL
        if let url = URL(string: urlString){
            // Create a URLSession
            let session = URLSession(configuration: .default)
            // Give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // Start the task
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            print("city : \(weather.cityName)")
            return weather
            
            
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
      
    }
       
  
}
