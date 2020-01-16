//
//  BTfinder.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-10.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import Foundation
import CoreBluetooth

//CONSTANTS
let BLEServiceUUID = CBUUID(string: "0000FFF0-0000-1000-8000-00805F9B34FB")
let CustomServiceUUID = CBUUID(string:"0000FFE0-0000-1000-8000-00805F9B34FB")
let KeyPressServiceUUID = CBUUID(string: "0000FFE1-0000-1000-8000-00805F9B34FB")

class BTfinder: NSObject {
    
    fileprivate var centralManager: CBCentralManager?
    fileprivate var peripheralBLE: CBPeripheral?
    
    var bleService: BTtransmitter? {
        didSet { bleService?.startDiscoveringServices() }
    }
    
    override init(){
        super.init()
        
        let centralQueue = DispatchQueue(label: "mainQueue", qos: .background, attributes: [.concurrent] )
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
    }
    
    func startScan() {
        if let central = centralManager {
            central.scanForPeripherals(withServices: [BLEServiceUUID], options: nil)
            print("scanning for peripherals")
        }
    }
    
}

extension BTfinder: CBCentralManagerDelegate {
    //called when centralManager is created
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == CBManagerState.poweredOn{
            print("Bluetooth is on, proceeding to scan for peripheral")
            startScan()
        } else{
            print("Bluetooth is off")
        }
    }
    
    //called when centralManager discovers a peripheral device
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("didDiscover peripheral")
        
        if((self.peripheralBLE == nil) || (self.peripheralBLE?.state == CBPeripheralState.disconnected)){
            //assign this peripheral value to my peripheralBLE variable
            self.peripheralBLE = peripheral
            
            //reset bleService to nil
            self.bleService = nil
            
            central.connect(peripheral, options: nil)
            print("connecting to peripheral")
        }
        
    }
    
    //called when centralManager connects to a peripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connection successful")
        print("Peripheral info: \(peripheral)")
        
        //if this is the correct peripheral, initialize BTtransmitter with this peripheral
        if peripheral == self.peripheralBLE {
            self.bleService = BTtransmitter(initWithPeripheral: peripheral)
        }
        
        
    }
}
