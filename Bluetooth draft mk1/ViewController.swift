//
//  ViewController.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-08.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let akey: String = "a"
    let dkey: String = "d"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //global instance of BT is initialized during first reference to it, which is now
        
        _ = globalInstanceOfBTfinder
    }
    


    @IBAction func onButton(_ sender: UIButton) {
        print("onButton pressed")
        let aData: [UInt8] = Array(akey.utf8)
        
        sendData(aData)
        
    }
    
    
    @IBAction func offButton(_ sender: UIButton) {
        print("offButton pressed")
        let dData: [UInt8] = Array(dkey.utf8)
        
        sendData(dData)
        
    }
    
    
    
    func sendData (_ data: [UInt8]){
        
        if let bleService = globalInstanceOfBTfinder.bleService{
            bleService.writeData(data)
            print("sending data: \(data)")
            
        }
    }

}

