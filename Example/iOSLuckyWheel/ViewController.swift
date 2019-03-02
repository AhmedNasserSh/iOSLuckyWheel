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
    var items = [WheelItem]()
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
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: UIColor.white, itemColor: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)))
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: UIColor.white, itemColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), itemColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: UIColor.white, itemColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), itemColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: UIColor.white, itemColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)))
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), itemColor: #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)))
        items.append(WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), itemColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
        return items
    }
    func wheelDidChangeValue(_ newValue: Int) {
        print(newValue)
    }
    
}

