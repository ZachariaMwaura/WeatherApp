//
//  ViewController.swift
//  WeatherApp
//
//  Created by Zach Mwaura on 1/14/24.
//

import UIKit

// delegate to allow class to manage editing and validation of TextField
class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // get city
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set current class as delegate
        weatherManager.delegate = self
        
        // textField to report back to ViewController
        searchTextField.delegate = self
    }

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
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.temperature)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

