    //
    //  WeatherManager.swift
    //  Clima
    //
    //  Created by Nadia Seleem on 28/01/1442 AH.
    //
    
    import Foundation
    import CoreLocation
    
    protocol WeatherManagerDelegate {
        
        func didUpdateWeather(_ weatherManager:WeatherManager,weather:WeatherModel)
        func didFailWithError(error:Error )
    }
    
    struct WeatherManager{
        
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=0e548e1a663b4e8f89bf7d2e7be6a622"
        
        var delegate:WeatherManagerDelegate?
        
        
         func fetchWeather(in city:String){
            let urlCity = city.replaceWhitespace(with: "%20")
            let URLString = "\(weatherURL)&q=\(urlCity)"
            performRequest(with: URLString)
            
        }
        
        func fetchWeather(lat latitude:CLLocationDegrees,lon longitude:CLLocationDegrees ){
            let URLString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
            performRequest(with: URLString)

        }
        
         func performRequest(with urlString:String){
            if let url = URL(string: urlString){
                print(url)
                let task = URLSession(configuration: .default).dataTask(with: url) {
                    (data, response, error) in
                    if error != nil{
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    if let data = data {
                        if let weather = self.parseJSON(data){
                            print("completed")
                            self.delegate?.didUpdateWeather(self,weather:weather)}
                    }
                }
                task.resume()
            }else{
                print("error in url")

            }
            
        }
        
        
         func parseJSON(_ weatherData:Data)->WeatherModel?{
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let id = decodedData.weather[0].id
                let temp = decodedData.main.temp
                let name = decodedData.name
                let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
                return weather
               
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
            
        }
        
        
      
            

        
        
        
        
    }
    
    extension String {
         func replaceWhitespace(with value:String)->String{
            var string = self
            string = string.replacingOccurrences(of: " ", with: value)
            return string
        }
    }
    
 
    
