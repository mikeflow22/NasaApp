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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //use tags to determine which one was tapped - might have to drag all three to this link
    @IBAction func roverNameButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
        case 1:
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
        case 2:
            print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
        default: print("Error in file: \(#file), in the body of the function: \(#function) on line: \(#line)\n")
        }
    }
    
    
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
  

}
