//
//  ViewController.swift
//  iOSLuckyWheel
//
//  Created by ahmed.nasser2310@gmail.com on 03/01/2019.
//  Copyright (c) 2019 ahmed.nasser2310@gmail.com. All rights reserved.
//

import UIKit
import iOSLuckyWheel
class ViewController: UIViewController,LuckyWheelDataSource,LuckyWheelDelegate {
    var wheel :LuckyWheel?
    override func viewDidLoad() {
        super.viewDidLoad()
        wheel = LuckyWheel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40 , height: 300))
        wheel?.delegate = self
        wheel?.dataSource = self
        wheel?.center = self.view.center
        wheel?.setTarget(section: 5)
        wheel?.animateLanding = true
        self.view.addSubview(wheel!)
    }
    func numberOfSections() -> Int {
        return 8
    }
    func itemsForSections() -> [WheelItem] {
        let item = WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: UIColor.white, itemColor: UIColor.purple)
        return [item,item,item,item,item,item,item,item]
    }
    func wheelDidChangeValue(_ newValue: Int) {
        print(newValue)
    }
    
}

