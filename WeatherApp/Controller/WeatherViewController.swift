//
//  ViewController.swift
//  WeatherApp
//
//  Created by Zach Mwaura on 1/14/24.
//

import UIKit
import CoreLocation

// delegate to allow class to manage editing and validation of TextField
class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // get city
    var weatherManager = WeatherManager()
    //getting current GPS location of the phone
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set current class as delegate
        weatherManager.delegate = self
        
        //location manager delegate
        locationManager.delegate = self
        // Ask user for permission to allow locationData
        locationManager.requestWhenInUseAuthorization()
        //request location once from user
        locationManager.requestLocation()
        
        // textField to report back to ViewController
        searchTextField.delegate = self
    }
    
    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        // Make searchField its done editing and dismiss the keyboard
        searchTextField.endEditing(true)
        // print(searchTextField.text!)
    }
    
    // process the pressing of return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Make searchField its done editing and dismiss the keyboard
        searchTextField.endEditing(true)
        // print(searchTextField.text!)
        return true
    }
    
    // when user stops using the TextField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false // continue editing
        }
    }
    
    // clear the textField once return button is touched
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTitleField to get the weather of that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = "" // puts an empty string to the textField
    }
}

 //MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async { // incase of poor connection
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

 //MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
