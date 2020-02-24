//
//  OfflineViewController.swift
//  SuperWeather
//
//  Created by vrez on 24.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class OfflineViewController: UIViewController {
    
    let network = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        network.reachability.whenReachable = { reachability in
            self.showMainController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func showMainController() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "mainScreen", sender: self)
        }
    }
    
}
