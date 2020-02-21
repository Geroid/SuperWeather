//
//  CityViewController.swift
//  SuperWeather
//
//  Created by vrez on 18.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBOutlet weak var cityTableView: UITableView!
    let textCellIdentifier = "TextCell"
    let myFavoutireCities = ["San Francisco", "Москва", "Berlin", "Prague", "Zurich", "Таганрог"]
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    var city: String = ""
    
    var cityHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "City"
        cityTableView.delegate = self as? UITableViewDelegate
        cityTableView.dataSource = self as? UITableViewDataSource
        let mainViewController = ViewController()
        mainViewController.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavoutireCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = myFavoutireCities[row]
        
        return cell
    }
    
        
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK:  UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        self.navigationController?.popViewController(animated: true)
        
        city = myFavoutireCities[row]
        cityHandler?(city)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
