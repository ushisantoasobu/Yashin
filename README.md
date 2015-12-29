# Yashin

Simple Rader Chart written in Swift.

[![CI Status](http://img.shields.io/travis/ushisantoasobu/Yashin.svg?style=flat)](https://travis-ci.org/ushisantoasobu/Yashin)
[![Version](https://img.shields.io/cocoapods/v/Yashin.svg?style=flat)](http://cocoapods.org/pods/Yashin)
[![License](https://img.shields.io/cocoapods/l/Yashin.svg?style=flat)](http://cocoapods.org/pods/Yashin)
[![Platform](https://img.shields.io/cocoapods/p/Yashin.svg?style=flat)](http://cocoapods.org/pods/Yashin)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Basic

```Swift
import UIKit
import Yashin

class SomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let radarChart = Yashin(frame: self.view.frame))
        self.view.addSubview(radarChart)

        radarChart.list = [
            ("shoot", 72),
            ("dribble", 82),
            ("pass", 84)
        ]
    }
}
```

### Setting some properties

```Swift
radarChart.maxValue = 100 // Max value of chart. Default is 10

radarChart.minValue = 0 // Min value of chart. Default is 0

radarChart.padding = 100 // Padding from chart to outline frame. Default is 60.0

radarChart.fontSize = 9.0 // Font size. Default is 11.0

radarChart.scaleLineWidth = 4.0 // Scale-line width. Default is 2.0

radarChart.scaleLineHidden = false // Scale-line hidden flag. Default is false

radarChart.lineColor = UIColor.greenColor() // Color of chart outer-line. Default is XXX

radarChart.subLineColor = UIColor.brownColor() // Color of chart inner-line. Default is XXX

radarChart.fillColor = UIColor.blackColor().colorWithAlphaComponent(0.1) // Color of chart fill. Default is XXX
```

## Requirements

## Installation

Yashin is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Yashin"
```

## Author

ushisantoasobu, babblemann.shunsee@gmail.com

## License

Yashin is available under the MIT license. See the LICENSE file for more info.
