# iOSLuckyWheel
[![Version](https://img.shields.io/cocoapods/v/iOSLuckyWheel.svg?style=flat)](https://cocoapods.org/pods/iOSLuckyWheel)
[![License](https://img.shields.io/cocoapods/l/SmoothPicker.svg?style=flat)](https://cocoapods.org/pods/SmoothPicker)
[![Platform](https://img.shields.io/cocoapods/p/iOSLuckyWheel.svg?style=flat)](https://cocoapods.org/pods/iOSLuckyWheel)

An iOS Lucky wheel with customizable text and text colors and section colors and very easy to integrate 
![Alt Text](https://media.giphy.com/media/RHIqv3l88Ewczkju60/giphy.gif) 


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

iOSLuckyWheel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'iOSLuckyWheel'
```
# Usage

Create the view extending LuckWheel by frame 
<br />

```
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
        let item = WheelItem(title: "Welcome to iOS Lucky Wheel", titleColor: UIColor.white, itemColor: UIColor.blue)
        return [item,item,item,item,item,item,item,item]
    }
    func wheelDidChangeValue(_ newValue: Int) {
        print(newValue)
    }
    
}
```

## Data Source
```
func numberOfSections() ->Int // number of wheel sections
func itemsForSections() -> [WheelItem] // the items to be displayed
```
## Delegate
```
func wheelDidChangeValue(_ newValue: Int) // the selected section  postion
@objc optional func lastAnimation() ->CABasicAnimation // custom animation after landing 
@objc optional func landingPostion() ->LandingPostion  // the landing postion [top,bottom,left,right]
```
## properties
```
public func setTarget(section:Int) // set landing target 
public var infinteRotation = false // to rotate infinitely 
public var animateLanding = false // to whether animate after landing or not. 
public func manualRotation(aCircleTime: Double) // manual rotation with time 
public func stop() // manual Stop
```

## Authors

* **Ahmed Nasser** - [AvaVaas](https://github.com/AvaVaas)

## License

iOSLuckyWheel is available under the MIT license. See the LICENSE file for more info.

