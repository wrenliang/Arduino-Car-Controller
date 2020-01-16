//
//  BTtransmitter.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-10.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import Foundation
import CoreBluetooth



class BTtransmitter: NSObject {
    
    var peripheral: CBPeripheral?
    var positionCharacteristic: CBCharacteristic?
    
    init(initWithPeripheral peripheral: CBPeripheral) {
        super.init()
        
        print("initializing BTtransmitter")
        self.peripheral = peripheral
        self.peripheral?.delegate = self
    }
    
    deinit {
        self.reset()
    }
    
    func reset() {
        print("reseting BTtransmitter")
        if peripheral != nil {
            peripheral = nil
        }
    }
    
    func startDiscoveringServices() {
        self.peripheral?.discoverServices([CustomServiceUUID])
    }
    
    //Helper function to send byte data over Bluetooth
    func writeData(_ data: [UInt8]){
        if let positionCharacteristic = self.positionCharacteristic {
            let byteData = Data(bytes: data)
            self.peripheral?.writeValue(byteData, for: positionCharacteristic, type: CBCharacteristicWriteType.withoutResponse)
            print("writeValue \(byteData)")
        }
    }
}

extension BTtransmitter: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        let uuidForBTtransmission: [CBUUID] = [KeyPressServiceUUID]
        print("didDiscoverServices")

        if peripheral != self.peripheral || error != nil {
            return
        }
        
        guard let services = peripheral.services else {
            return
        }
        
        for service in services {
            if service.uuid == CustomServiceUUID {
                peripheral.discoverCharacteristics(uuidForBTtransmission, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("didDiscoverCharacteristics")
        
        if peripheral != self.peripheral || error != nil{
            return
        }
        
        guard let characteristics = service.characteristics else {
            return
        }
        
        for characteristic in characteristics {
            if characteristic.uuid == KeyPressServiceUUID {
                self.positionCharacteristic = characteristic
                print("KeyPressState found")
                //receive notifications for this characteristic
                peripheral.setNotifyValue(true, for: characteristic)
                
                //send notification to UI that bluetooth is fully connected
            }
        }
    }
}
