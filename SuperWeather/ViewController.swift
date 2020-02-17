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
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var WeatherDesc: UILabel!
    @IBOutlet weak var chooseCityButton: UIButton!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
        let weather = WeatherGetter(controller: self)
        weather.getWeather(city: "Taganrog")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "eberhard"))
        //let icon = UIImage(named: "TownIcon")
        //chooseCityButton.setImage(icon, for: .normal)
        chooseCityButton.imageView?.contentMode = .scaleAspectFill
        // Do any additional setup after loading the view.
        let weather = WeatherGetter(controller: self)
        weather.getWeather(city: "Taganrog")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

