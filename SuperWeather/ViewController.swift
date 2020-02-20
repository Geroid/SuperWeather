//
//  ViewController.swift
//  SuperWeather
//
//  Created by vrez on 04.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapKey = "4b0448e475b90f74791e1f6fe7ca5038"
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var WeatherDesc: UILabel!
    @IBOutlet weak var chooseCityButton: UIButton!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    @IBAction func cityButtonTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(CityViewController(), animated: true)
    }
    


    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        let weather = WeatherGetter()
        weather.getWeather(city: "Таганрог", weatherHandler: { weather, error in
                           if let weather = weather{
                               self.weatherLabel.text = weather.temperature
                               self.humidityLabel.text = weather.humidity
                               self.cityLabel.text = weather.city
                               self.windSpeedLabel.text = weather.windSpeed
                               self.WeatherDesc.text = weather.weatherDesc
                           }
                           else {
                               self.WeatherDesc.text = "Error"
                           }
        })
//        self.navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "eberhard"))
        chooseCityButton.imageView?.contentMode = .scaleAspectFill
        
        let weather = WeatherGetter()
        weather.getWeather(city: "Таганрог", weatherHandler: { weather, error in
            if let weather = weather{
                self.weatherLabel.text = weather.temperature
                self.humidityLabel.text = weather.humidity
                self.cityLabel.text = weather.city
                self.windSpeedLabel.text = weather.windSpeed
                self.WeatherDesc.text = weather.weatherDesc
            }
            else {
                self.weatherLabel.text = "Error"
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

