//
//  WeatherGetter.swift
//  SuperWeather
//
//  Created by vrez on 04.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation


struct Weather: Codable
{
    var temperature : Double = 0.0
    var humidity : Int = 0
    var city: String = "Moscow"
    var windSpeed: Double = 0.0
    var weatherDesc: String = "ясно"
}


class WeatherGetter {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapKey = "4b0448e475b90f74791e1f6fe7ca5038"
    init(){
    }
    
    func getWeather(city: String, weatherHandler: @escaping (Weather?, Error?) -> Void){
        
        let session = URLSession.shared
        let myWeather = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapKey)&lang=ru&q=\(city)&units=metric"
        let weatherRequestURL = URL(string: myWeather.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        let dataTask = session.dataTask(with: weatherRequestURL){
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print("Error:\n\(error)")
                return
            }
            
            guard let data = data  else {
                print("Error: did not receive data")
                return
            }
            
            //            let dataString = String(data: data, encoding: String.Encoding.utf8)
            //            print("All the weather data:\n\(dataString!)")
            var weather = Weather()
            
            guard let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                as? Dictionary<String, Any> else {
                    print("Error: unable to convert json data")
                    weatherHandler(weather, error)
                    return
            }
            
            guard
                let mainDictionary = jsonObj["main"] as? [String:Any],
                let temperature = mainDictionary["temp"] as? Double,
                let hum = mainDictionary["humidity"] as? Int
                else {
                    return
                }
            
            weather.temperature = temperature
            weather.humidity = hum
            
            guard let city = jsonObj["name"] as? String else {
                return
            }
            weather.city = city
            
            guard
                let windDictionary = jsonObj["wind"] as? [String: Any],
                let windSpeed = windDictionary["speed"] as? Double
                else {
                    return
                }

            weather.windSpeed = windSpeed
            
            guard
                let weatherDetails = jsonObj["weather"] as? [[String: Any]],
                let weatherDescription = weatherDetails[0]["description"] as? String
                else {
                    return
                }

            weather.weatherDesc = weatherDescription
            
            DispatchQueue.main.async {
                weatherHandler(weather, error)
            }
        }
        dataTask.resume()
    }
}

