//
//  WheelItem.swift
//  WheelSwift
//
//  Created by Ahmed Nasser on 3/1/19.
//  Copyright © 2019 Ahmed Nasser. All rights reserved.
//

import Foundation
import UIKit
@objc public class WheelItem:NSObject{
    var title :String?
    var titleColor :UIColor?
    var itemColor :UIColor?
    public init (title :String ,titleColor:UIColor ,itemColor:UIColor){
        self.title = title
        self.titleColor = titleColor
        self.itemColor = itemColor
    }
}
