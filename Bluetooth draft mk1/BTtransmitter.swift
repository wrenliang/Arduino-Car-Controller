//
//  BTtransmitter.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-10.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import Foundation
import CoreBluetooth



class BTtransmitter: NSObject, CBPeripheralDelegate{
    
    var peripheral: CBPeripheral?
    var positionCharacteristic: CBCharacteristic?
    
    init(initWithPeripheral peripheral: CBPeripheral){
        super.init()
        
        print("initializing BTtransmitter")
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
        self.peripheral?.discoverServices([CustomServiceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        let uuidForBTtransmission: [CBUUID] = [KeyPressServiceUUID]
        print("didDiscoverServices")
        
        if peripheral != self.peripheral{
            print("Error: wrong peripheral")
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
            if service.uuid == CustomServiceUUID{
                peripheral.discoverCharacteristics(uuidForBTtransmission, for: service)
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("didDiscoverCharacteristics")
        
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
                if characteristic.uuid == KeyPressServiceUUID{
                    self.positionCharacteristic = characteristic
                    print("KeyPressState found")
                    //receive notifications for this characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                    
                    //send notification to UI that bluetooth is fully connected
                }
            }
        }
        
        
    }
    
    func writeData(_ data: [UInt8]){
        
        if let positionCharacteristic = self.positionCharacteristic{
            let byteData = Data(bytes: data)
            self.peripheral?.writeValue(byteData, for: positionCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
            print("writeValue \(byteData)")
            
        }
        
    }
    
    
    //add functions
    
    
    
    
    
}
