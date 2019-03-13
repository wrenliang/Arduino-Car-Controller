//
//  BTtransmitter.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-10.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import Foundation
import CoreBluetooth

let BLEServiceUUID = CBUUID(string: "FILL WITH TREVOR'S INFO")
let PositionCharUUID = CBUUID(string: "FIND TREVOR's CHARACTERISTICS")


class BTtransmitter: NSObject, CBPeripheralDelegate{
    var peripheral: CBPeripheral?
    var positionCharacteristic: CBCharacteristic?
    
    init(initWithPeripheral peripheral: CBPeripheral){
        super.init()
        
        self.peripheral = peripheral
        self.peripheral?.delegate = self
    }
    
    deinit{
        self.reset()
    }
    
    func reset(){
        
        print("reseting BTtransmitter")
        if peripheral != nil{
            peripheral = nil
        }
        
        //send notification to UI!!
    }
    
    func startDiscoveringServices(){
        self.peripheral?.discoverServices([BLEServiceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        let uuidForBTtransmission: [CBUUID] = [PositionCharUUID]
        
        if peripheral != self.peripheral{
            //error: incorrect peripheral
            print("error: wrong peripheral")
            return
        }
        
        if error != nil{
            return
        }
        
        if (peripheral.services == nil || peripheral.services!.count == 0){
            //error: no services found
            return
        }
        
        for service in peripheral.services!{
            if service.uuid == BLEServiceUUID{
                peripheral.discoverCharacteristics(uuidForBTtransmission, for: service)
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if peripheral != self.peripheral{
            print("error: wrong peripheral")
            return
        }
        
        if error != nil{
            print("error: \(error!.localizedDescription)")
            return
        }
        
        if let characteristics = service.characteristics {
            for characteristic in characteristics{
                if characteristic.uuid == PositionCharUUID{
                    self.positionCharacteristic = characteristic
                    
                    //receive notifications for this characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                    
                    //send notification to UI that bluetooth is fully connected
                }
            }
        }
        
        
    }
    
    
    //add functions 
    
    
    
    
}
