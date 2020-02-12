//
//  ViewController.swift
//  NASA
//
//  Created by Michael Flowers on 2/11/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let network = MarsRoverClient()
        network.fetchEarthView(lon: 100.75, lat: 1.5, cloudScore: true) { (image) in
            guard let image = image else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
            print("image we got back: \(image.description)")
        }
    }
}




