# Yashin

Simple Rader Chart written in Swift.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
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

        let radarChart = Yashin(frame: self.view.frame)
        self.view.addSubview(radarChart)

        radarChart.list = [
            ("shoot", 7),
            ("pass", 9),
            ("dribble", 5),
            ("speed", 8),
            ("power", 6),
            ("stamina", 5),
            ("mentality", 7)
        ]
    }
}
```

<img src="https://github.com/ushisantoasobu/Yashin/blob/master/screenshots/1.png" width="320">

### Setting some properties

```Swift
// param
radarChart.maxValue = 100 // Max value of chart. Default is 10
radarChart.minValue = 0 // Min value of chart. Default is 0

// appearance
radarChart.padding = 100 // Padding from chart to outline frame. Default is 60.0
radarChart.fontSize = 13.0 // Font size. Default is 11.0
radarChart.scaleLineWidth = 4.0 // Scale-line width. Default is 2.0
radarChart.scaleLineHidden = false // Scale-line hidden flag. Default is false

// color
radarChart.lineColor = UIColor.brownColor() // Color of chart outer-line. Default is XXX
radarChart.subLineColor = UIColor.lightGrayColor() // Color of chart inner-line. Default is XXX
radarChart.fillColor = UIColor.cyanColor().colorWithAlphaComponent(0.30) // Color of chart fill. Default is XXX

radarChart.list = [
    ("shoot", 70),
    ("pass", 91),
    ("dribble", 58),
    ("speed", 84),
    ("power", 67),
    ("stamina", 56),
    ("mentality", 78),
]
```

<img src="https://github.com/ushisantoasobu/Yashin/blob/master/screenshots/2.png" width="320">

## Requirements

## Installation

### Carthage

Add the following to your Cartfile:

```ruby
github "ushisantoasobu/Yashin"
```

And run `carthage update`, then add the framework as described in [Carthage Readme](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

### CocoaPods

Yashin is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Yashin"
```

## Author

ushisantoasobu, babblemann.shunsee@gmail.com

## License

Yashin is available under the MIT license. See the LICENSE file for more info.
