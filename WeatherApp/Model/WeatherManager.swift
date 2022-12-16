//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Kullanici on 14.12.2022.
//

import Foundation
struct WeatherManager {
    var situation = ""
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e05a8069baa54e66a78bab788129da43&units=metric&"
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString:String){
        // Create URL
        if let url = URL(string: urlString){
            // Create a URLSession
            let session = URLSession(configuration: .default)
            // Give URLSession a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                    let weatherVC = ViewController()
                    weatherVC.didUpdateWeather(weather: weather)
                        
                    }
                }
            }
            // Start the task
            task.resume()
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            print(weather.condition)
            print(weather.temperatureString)
            return weather
            
            
        }catch {
            print(error)
            return nil
        }
    }
       
  
}
