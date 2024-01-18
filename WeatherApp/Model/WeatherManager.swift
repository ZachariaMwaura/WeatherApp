//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Zach Mwaura on 1/16/24.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=93732d82335eaa1ccf8377779444a3fb&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        // print(urlString) // check the url is correct
        performRequest(with: urlString)
    }
    
    // Networking
    func performRequest(with urlString: String) {
        // Create a URL
        if let url = URL(string: urlString) {
            // create a URL session
            let session = URLSession(configuration: .default)
            // give the session a task
            // take all the inputs
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!) // delegate the error
                    return // if error occurs
                }
                
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString)
                    //self.parseJSON(weatherData: safeData) // add self inside closure
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        // structure of the data
        let decoder = JSONDecoder()
        // use decoder
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //print(decodedData.weather[0].id)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            //print(weather.conditionName)
            //print(weather.temperatureString)
        } catch {
            self.delegate?.didFailWithError(error: error) // delegate the error
            return nil
        }
    }
}
