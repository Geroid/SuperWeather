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
    var temperature : String = "0.0"
    var humidity : String = "0%"
    var city: String = "Moscow"
    var windSpeed: String = "0"
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
                //let weather = Weather()
                //weatherHandler(weather, error)
                print("Error:\n\(error)")
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    var weather = Weather()
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        as? NSDictionary{
                        if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary{
                            if let temperature = mainDictionary.value(forKey: "temp") as? Double{
                                DispatchQueue.main.async {
                                    weather.temperature = "\(temperature)°C"
                                    weatherHandler(weather, error)
                                }
                            }
                            if let humidity = mainDictionary.value(forKey: "humidity") as? Int{
                                DispatchQueue.main.async {
                                    weather.humidity = "Влажность: \(humidity)%"
                                    weatherHandler(weather, error)
                                }
                            }
                           
                        } else {
                             print("Error: unable to find temperature in dictionary")
                     }
                        if let town = jsonObj.value(forKey: "name") as? String{
                            DispatchQueue.main.async {
                                weather.city = "\(town)"
                                weatherHandler(weather, error)
                            }
                        }
                        if let windDictionary = jsonObj.value(forKey: "wind") as? NSDictionary{
                            if let windSpeed = windDictionary.value(forKey: "speed"){
                                DispatchQueue.main.async {
                                    weather.windSpeed = "Скорость ветра \(windSpeed) м/с"
                                    weatherHandler(weather,error)
                                }
                            }
                            
                        }
                        if let weatherDetails = jsonObj.value(forKey: "weather") as? Array<Any>{
                            if let weatherDesc = weatherDetails as? [[String: Any]] {
                                DispatchQueue.main.async {
                                    weather.weatherDesc = "\(weatherDesc[0]["description"]!)"
                                    weatherHandler(weather, error)
                                }
                            }
                        }
                        
                    } else {
                  print("Error: unable to convert json data")
                        weatherHandler(weather, error)
                 }
                } else {
                 print("Error: did not receive data")
             }
          }
        }
     dataTask.resume()
    }
}
