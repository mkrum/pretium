//
//  startViewController.swift
//  pretium
//
//  Created by Dan Kerrigan on 2/20/16.
//  Copyright © 2016 ndSophware. All rights reserved.
//

import Foundation
import UIKit

class startViewController: UIViewController {
    
    @IBOutlet weak var cashImage2: UIImageView!
    var prices:[String] = []
    

    @IBOutlet weak var cashImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
/*
        //sweet animation Krumdick wouldn't let me include
        var imageArray = [UIImage]()
        for var x=1; x<=2; x++ {
            let img = UIImage(named: "money\(x).png")
            imageArray.append(img!)
        }
        cashImage2.animationImages=imageArray
        cashImage2.animationDuration=2.0
        cashImage2.animationRepeatCount=0
        cashImage2.startAnimating()
    }
*/
    }
}
