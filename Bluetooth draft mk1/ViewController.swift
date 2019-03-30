//
//  ViewController.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-08.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let fkey: String = "f"
    let bkey: String = "b"
    let lkey: String = "l"
    let rkey: String = "r"
    
    
    @IBOutlet var VStackView: UIStackView!
    @IBOutlet var HStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //global instance of BT is initialized during first reference to it, which is now
        
        _ = globalInstanceOfBTfinder
    }
    

    @IBAction func forwardButton(_ sender: UIButton) {
        print("forwardButton pressed")
        let fData: [UInt8] = Array(fkey.utf8)
        
        sendData(fData)
    }
    
    
    
    
    
    
    @IBAction func backwardButton(_ sender: UIButton) {
        print("backwardButton pressed")
        let bData: [UInt8] = Array(bkey.utf8)
        
        sendData(bData)
        
    }
    
    
    @IBAction func leftButton(_ sender: UIButton) {
        print("leftButton pressed")
        let lData: [UInt8] = Array(lkey.utf8)
        
        sendData(lData)
    }
    
    
    
    @IBAction func rightButton(_ sender: UIButton) {
        print("rightButton pressed")
        let rData: [UInt8] = Array(rkey.utf8)
        
        sendData(rData)
    }
    
    
    
    func sendData (_ data: [UInt8]){
        
        if let bleService = globalInstanceOfBTfinder.bleService{
            bleService.writeData(data)
            print("sending data: \(data)")
            
        }
    }

}

