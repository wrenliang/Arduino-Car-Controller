//
//  BTfinder.swift
//  Bluetooth draft mk1
//
//  Created by Wren Liang on 2019-03-10.
//  Copyright © 2019 Wren Liang. All rights reserved.
//

import Foundation
import CoreBluetooth

//GLOBAL INSTANCE of BTfinder
let globalInstanceOfBTfinder = BTfinder()

class BTfinder: NSObject, CBCentralManagerDelegate{
    
    fileprivate var centralManager: CBCentralManager?
    fileprivate var peripheralBLE: CBPeripheral?
    
    
    override init(){
        super.init()
        
        let centralQueue = DispatchQueue(label: "mainQ", qos: .default, attributes: [.concurrent] )
        centralManager = CBCentralManager(delegate: self, queue: centralQueue)
        
    }
    
    
    func startScan() {
        if let central = centralManager{
            central.scanForPeripherals(withServices: [BLEServiceUUID], options: nil)
        }
        
    }
    
    
    var bleService: BTtransmitter?{
        //if bleService value is changed
        didSet {
            if let service = self.bleService{
                service.startDiscoveringServices();
            }
        }
    }
    
    
    //CENTRALMANAGER CONFORM
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("didDiscover peripheral")
        
        if((self.peripheralBLE == nil) || (self.peripheralBLE?.state == CBPeripheralState.disconnected)){
            //save peripheral to variable
            self.peripheralBLE = peripheral
            
            //reset bleService to nil
            self.bleService = nil
            
            central.connect(peripheral, options: nil)
            print("connecting to peripheral")
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("connection successful")
        print("Peripheral info: \(peripheral)")
        
        //if this is correct peripheral, initialize BTtransmitter with this peripheral
        if peripheral == self.peripheralBLE{
            self.bleService = BTtransmitter(initWithPeripheral: peripheral)
        }
        
        
    }
    
    //called when centralManager is created
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == CBManagerState.poweredOn{
            print("Bluetooth is on, proceeding to scan for peripheral")
            startScan()
        }
        
        else{
            print("Bluetooth is off")
            //send message to UI!!
        }
    }
    
    
}
