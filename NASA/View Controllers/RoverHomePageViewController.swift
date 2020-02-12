//
//  RoverHomePageViewController.swift
//  NASA
//
//  Created by Michael Flowers on 2/12/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import UIKit

enum RoverName: String {
    case Curiosity
    case Opportunity
    case Spirit
}

class RoverHomePageViewController: UIViewController {
    
    var roverName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    //use tags to determine which one was tapped - might have to drag all three to this link
    @IBAction func roverNameButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            roverName = RoverName.Curiosity.rawValue
            print("\(String(describing: roverName)) choosen to pass")
        case 1:
            roverName = RoverName.Opportunity.rawValue
            print("\(String(describing: roverName)) choosen to pass")
           
        case 2:
            roverName = RoverName.Spirit.rawValue
            print("\(String(describing: roverName)) choosen to pass")
        default:
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
        }
         performSegue(withIdentifier: "buttonSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buttonSegue" {
            guard let destination = segue.destination as?  PhotosCollectionViewController else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
            guard let roverName = roverName else {
                print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
                return
            }
            
            destination.roverName = roverName
        } else {
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
        }
    }
    
    
}
