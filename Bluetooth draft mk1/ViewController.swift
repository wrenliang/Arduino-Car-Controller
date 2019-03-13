//
//  ViewController.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-08.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //global instance of BT is initialized during first reference to it, which is now
        _ = globalInstanceOfBTfinder
    }

    
    

}

