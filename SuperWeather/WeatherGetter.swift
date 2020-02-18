//
//  WeatherGetter.swift
//  SuperWeather
//
//  Created by vrez on 04.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import Foundation


class WeatherGetter {

    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapKey = "4b0448e475b90f74791e1f6fe7ca5038"
    private var controller: ViewController? = nil
    init(controller: ViewController){
        self.controller = controller
    }
    
    func getWeather(city: String){
        
        let session = URLSession.shared
        let myWeather = "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapKey)&lang=ru&q=\(city)&units=metric"
        let weatherRequestURL = URL(string: myWeather.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
                
        let dataTask = session.dataTask(with: weatherRequestURL){
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error{
                print("Error:\n\(error)")
            } else {
                if let data = data {
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    print("All the weather data:\n\(dataString!)")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        as? NSDictionary{
                        if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary{
                            if let temperature = mainDictionary.value(forKey: "temp") as? Double{
                                DispatchQueue.main.async {
                                   self.controller?.weatherLabel.text = " \(temperature)°C"
                                }
                            }
                            if let humidity = mainDictionary.value(forKey: "humidity") as? Int{
                                DispatchQueue.main.async {
                                   self.controller?.humidityLabel.text = "Влажность: \(humidity)%"
                                }
                            }
                           
                        } else {
                             print("Error: unable to find temperature in dictionary")
                     }
                        if let town = jsonObj.value(forKey: "name") as? String{
                                                       DispatchQueue.main.async {
                                                           self.controller?.cityLabel.text = "\(town)"
                                                       }
                        }
                        if let windDictionary = jsonObj.value(forKey: "wind") as? NSDictionary{
                            if let windSpeed = windDictionary.value(forKey: "speed"){
                                DispatchQueue.main.async {
                                   self.controller?.windSpeedLabel.text = " Скорость ветра \(windSpeed) м/с"
                                }
                            }
                            
                        }
                        if let weatherDetails = jsonObj.value(forKey: "weather") as? Array<Any>{
                            if let weatherDesc = weatherDetails as? [[String: Any]] {
                                                       DispatchQueue.main.async {
                                                        self.controller?.WeatherDesc.text = "\(weatherDesc[0]["description"]!)"
                                                       }
                                                    }
                        }
                    } else {
                  print("Error: unable to convert json data")
                 }
                } else {
                 print("Error: did not receive data")
             }
          }
        }
     dataTask.resume()
    }
}
