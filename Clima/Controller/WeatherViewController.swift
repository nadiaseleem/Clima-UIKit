//
//  ViewController.swift
//  Clima
//


import UIKit
import CoreLocation
class WeatherViewController: UIViewController {
    
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var weatherManager:WeatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
                locationManager.requestLocation()

    }
    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text!)
        
        searchTextField.endEditing(true)
    }
    
      @IBAction func getWeatherOfLocation(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()

        locationManager.requestLocation()
      }
    
}

    //MARK: - UITextFieldDelegate
extension WeatherViewController:UITextFieldDelegate{
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "enter a city name"
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            weatherManager.fetchWeather(in: city)
        }
        textField.text = ""
        textField.placeholder = "Search"
        
    }
}
//MARK: - WeatherManagerDelegate

extension WeatherViewController:WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager:WeatherManager,weather:WeatherModel){
        print(weather.temperatureString)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print("*******************************************")
        print(error)
        DispatchQueue.main.async {
            self.searchTextField.placeholder = "PLease enter a real city name"
        }
         }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController:CLLocationManagerDelegate{
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let location = locations.last{
            weatherManager.fetchWeather(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        }
        

                    
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
