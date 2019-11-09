# iOS Arduino Bluetooth Controller 

This application was made with Swift 4.2, and uses the Apple CoreBluetooth framework to connect to a remote control car built using Arduino. The main code is split into two files, which roughly models the two abstract tasks of searching for the Arduino's bluetooth module (BTfinder.swift), and sending communications data to the car (BTtransmitter.swift).

## BTfinder.swift
 - BTFinder instantiates a CBCentralManager and starts scanning for peripherals that contain my "BLEServiceUUID" service. 
 
 - When it finds a peripheral with this service, it attempts to connect to it
 
 - If the connection is successful, we instantiate a BTtransmitter object

## BTtransmitter.swift
- Once we are connected, we loop through this peripheral's services to find the channel I want to send control data to the Arduino through

- If we find the right service, we loop again, but this time through the service's characteristics

- I find the characteristic that maps to my KeyPressUUID, and save this characteristic

## ViewController.swift
- Once all of the setup is done, we can send data to the Arduino module!

- For each of the UIButtons for controlling the Arduino car, we specify the IBAction to convert the letter (f, b, l, r, s for the four directions and stop) into UTF8 encoding, and send this data to our helper function

- The helper function then calls BTtransmitter's function to write this data to the characteristic

- Now, this data should show up in the Arduino computer's stream, and we can update our motor controls!
