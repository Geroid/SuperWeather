//
//  ViewController.swift
//  SuperWeather
//
//  Created by vrez on 04.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

enum weatherState: String {
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
    case clear = "Clear"
}

extension UIViewController {
    func changeBackgroud(weatherDescription: String) {
        switch weatherDescription {
        case weatherState.clouds.rawValue:
            view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "clouds"))
        case weatherState.rain.rawValue:
            view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "rain"))
        case weatherState.snow.rawValue:
            view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "snow"))
        case weatherState.clear.rawValue:
            view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "clear"))
        default:
           view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "eberhard"))
        }
    }
}

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
    
    weak var delegate: CityViewController!
    
    var city = "Таганрог"
    var mainDesc = ""
    let network = NetworkManager.sharedInstance
    
    
    @IBAction func cityButtonTapped(_ sender: UIButton) {
        let myCity = self.storyboard?.instantiateViewController(withIdentifier: "CityViewController") as! CityViewController
        myCity.cityHandler = { city in
            self.city = city
            self.weatherUpdate()
        }
        self.navigationController?.pushViewController(myCity, animated: true)
    }
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        weatherUpdate()
    }
    
    
    func weatherUpdate() {
        network.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
        
        let weather = WeatherGetter()
        weather.getWeather(city: city, weatherHandler: { weather, error in
            if let weather = weather{
                self.weatherLabel.text = "\(weather.temperature)°C"
                self.humidityLabel.text = "Влажность: \(weather.humidity)%"
                self.cityLabel.text = weather.city
                self.windSpeedLabel.text = "Скорость ветра: \(weather.windSpeed) м/с"
                self.WeatherDesc.text = (weather.weatherDesc)
                self.changeBackgroud(weatherDescription: weather.mainDesc)
            }
            else {
                self.WeatherDesc.text = "Error"
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseCityButton.imageView?.contentMode = .scaleAspectFill
        weatherUpdate()
        
        network.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
        
    }
    private func showOfflinePage() -> Void {
        let offlineScreen = self.storyboard?.instantiateViewController(withIdentifier: "OfflineViewController") as! OfflineViewController
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(offlineScreen, animated: true)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

