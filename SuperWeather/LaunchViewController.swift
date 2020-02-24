//
//  LaunchViewController.swift
//  SuperWeather
//
//  Created by vrez on 24.02.2020.
//  Copyright © 2020 Viktor Rezvantsev. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    let network: NetworkManager = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.isUnreacheble { _ in
            self.showOfflinePage()
        }
        
        NetworkManager.isReachable { _ in
            self.showMainPage()
        }
        
    }
    
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }
    
    private func showMainPage() -> Void {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "mainScreen", sender: self)
        }
    }
    
}
