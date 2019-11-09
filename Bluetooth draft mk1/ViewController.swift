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
    let skey: String = "s"
    
    let BTfinderObject = BTfinder()
    
    @IBOutlet var VStackView: UIStackView!
    @IBOutlet var HStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //BTfinder instantiated when ViewController loads
        _ = BTfinderObject
    }
    
    //MARK: - UIButtons from Storyboard
    
    @IBAction func forwardButton(_ sender: UIButton) {
        print("forwardButton pressed") //for debugging
        let fData: [UInt8] = Array(fkey.utf8)
        
        sendData(fData)
    }
    
    @IBAction func backwardButton(_ sender: UIButton) {
        print("backwardButton pressed") //for debugging
        let bData: [UInt8] = Array(bkey.utf8)
        
        sendData(bData)
        
    }
    
    @IBAction func leftButton(_ sender: UIButton) {
        print("leftButton pressed") //for debugging
        let lData: [UInt8] = Array(lkey.utf8)
        
        sendData(lData)
    }
    
    @IBAction func rightButton(_ sender: UIButton) {
        print("rightButton pressed") //for debugging
        let rData: [UInt8] = Array(rkey.utf8)
        
        sendData(rData)
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        print("stopButton pressed") //for debugging
        let sData: [UInt8] = Array(skey.utf8)
        
        sendData(sData)
    }
    
    
    //Helper function to send data to Arduino
    func sendData (_ data: [UInt8]){
        
        if let bleService = BTfinderObject.bleService{
            bleService.writeData(data)
            print("sending data: \(data)")
            
        }
    }

}

