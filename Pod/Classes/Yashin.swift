//
//  Yashin.swift
//
//  Created by SatoShunsuke on 2015/12/29.
//
//

import Foundation
import UIKit

public class Yashin : UIView {

    public typealias Value = ([UInt], UIColor)

    private var keys   = [String]()
    private var values = [Value]()

    public var minValue :UInt = 0
    public var maxValue :UInt = 10
    public var padding :CGFloat = 60
    public var scaleLineWidth :CGFloat = 3.0
    public var scaleLineHidden = false

    // font
    public var fontSize :CGFloat = 11.0

    // color
    public var lineColor    = UIColor.darkGrayColor()
    public var subLineColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.50)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(keys :[String], _ values :[Value]) {
        self.keys = keys
        self.values = values
    }

    public override func drawRect(rect: CGRect) {

        if !self.validateMinAndMax() {
            print("Invalid combination minValue and maxValue")
            return
        }

        if !self.validateKeyCount() {
            print("key count is needed at least 3")
            return
        }

        if !self.validateIntegrityKeyAndValue() {
            print("invalid combination key and value")
            return
        }

        if !self.validateSufficientFrame() {
            print("frame size is too small to show")
            return
        }

        let keyCount   = self.keys.count
        let valueCount = self.values.count
        let len = min(self.frame.width, self.frame.height) - padding * 2
        let center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)
        let scales :[CGFloat] = self.getScaleValues(self.minValue, self.maxValue)

        var rad :CGFloat = 2 * CGFloat(M_PI) * 3 / 4
        var maxPoints    = [CGPoint]()
        var valuePoints  = Array(count: valueCount, repeatedValue: [CGPoint]())

        for (index, key) in self.keys.enumerate() {

            let currentMaxPoint = self.getPoint(center, len: len / 2, rad: rad)
            maxPoints.append(currentMaxPoint)

            for (valueIndex, value) in self.values.enumerate() {
                let values :[UInt] = value.0
                let valueRatio :CGFloat = min(1.0, (CGFloat(values[index]) - CGFloat(self.minValue)) / CGFloat(self.maxValue - self.minValue))
                let point = self.getPoint(center, len: len * valueRatio / 2, rad: rad)
                valuePoints[valueIndex].append(point)
            }

            // draw inner-line
            self.subLineColor.setStroke()
            self.drawLine(currentMaxPoint, center)

            // draw text
            let paragraphStyle = NSMutableParagraphStyle()
            let dic = [
                NSParagraphStyleAttributeName  : paragraphStyle,
                NSForegroundColorAttributeName : self.lineColor,
                NSFontAttributeName            : UIFont.systemFontOfSize(self.fontSize)
            ]
            let namePoint = self.getPoint(center, len: (len + 10) / 2, rad: rad)
            let textWidth  :CGFloat = 200.0
            let textHeight :CGFloat = 14.0
            var textX :CGFloat = namePoint.x
            var textY :CGFloat = namePoint.y

            if index == 0 {
                paragraphStyle.alignment = NSTextAlignment.Center
                textX = namePoint.x - textWidth / 2
                textY = namePoint.y - textHeight
            } else if index == keyCount / 2 && keyCount % 2 == 0 {
                paragraphStyle.alignment = NSTextAlignment.Center
                textX = namePoint.x - textWidth / 2
            } else if index == keyCount / 4 && keyCount % 4 == 0 {
                paragraphStyle.alignment = NSTextAlignment.Left
                textY = namePoint.y - textHeight / 2
            } else if index == keyCount / 4 * 3 && keyCount % 4 == 0 {
                paragraphStyle.alignment = NSTextAlignment.Right
                textX = namePoint.x - textWidth
                textY = namePoint.y - textHeight / 2
            } else {
                if namePoint.x < center.x {
                    paragraphStyle.alignment = NSTextAlignment.Right
                    textX = namePoint.x - textWidth
                } else {
                    paragraphStyle.alignment = NSTextAlignment.Left
                }

                if namePoint.y < center.y {
                    textY = namePoint.y - textHeight
                }
            }
            key.drawInRect(CGRectMake(textX, textY, textWidth, textHeight), withAttributes: dic)

            let nextRad = rad + 2 * CGFloat(M_PI) / CGFloat(keyCount)

            // draw scale lines
            if scaleLineHidden || (self.maxValue - self.minValue < 2) {
                rad = nextRad
                continue
            }
            self.subLineColor.setStroke()
            for scaleValue in scales {
                let ratio :CGFloat = (scaleValue - CGFloat(self.minValue)) / CGFloat(self.maxValue - self.minValue)
                let targetPoint = self.getPoint(center, len: len / 2 * ratio, rad: rad)
                let fromRad = rad + CGFloat(M_PI) / 2
                let toRad   = rad + CGFloat(M_PI) / 2 * 3
                let fromPoint = self.getPoint(targetPoint, len: scaleLineWidth, rad: fromRad)
                let toPoint   = self.getPoint(targetPoint, len: scaleLineWidth, rad: toRad)
                self.drawLine(fromPoint, toPoint)
            }

            rad = nextRad
        }

        // draw outer-line
        for (index, _) in maxPoints.enumerate() {
            self.lineColor.setStroke()
            if index == maxPoints.count - 1 {
                self.drawLine(maxPoints[index], maxPoints[0])
            } else {
                self.drawLine(maxPoints[index], maxPoints[index + 1])
            }
        }

        // fill value
        for (index, points) in valuePoints.enumerate() {
            let fillColor :UIColor = self.values[index].1
            let fillPath = UIBezierPath()
            fillColor.setFill()
            for (subIndex, point) in points.enumerate() {
                if subIndex == 0 {
                    fillPath.moveToPoint(point)
                }
                fillPath.addLineToPoint(point)
            }
            fillPath.fill()
        }

    }

    // MARK: - validate

    internal func validateMinAndMax() -> Bool {
        return self.minValue < self.maxValue
    }

    internal func validateKeyCount() -> Bool {
        let count = self.keys.count
        return !(count < 3)
    }

    internal func validateIntegrityKeyAndValue() -> Bool {
        let count = self.keys.count
        for value in self.values {
            if value.0.count != count {
                return false
            }
        }
        return true
    }

    internal func validateSufficientFrame() -> Bool {
        let len = min(self.frame.width, self.frame.height) - padding * 2
        return !(len < 60)
    }

    // MARK: - private funcs

    private func drawLine(from :CGPoint, _ to :CGPoint, width :CGFloat = 1.0) {
        let path = UIBezierPath()
        path.lineWidth = width
        path.moveToPoint(from)
        path.addLineToPoint(to)
        path.stroke()
    }

    private func getPoint(centerPoint :CGPoint, len :CGFloat, rad :CGFloat) -> CGPoint {
        return CGPointMake(centerPoint.x + len * cos(rad), centerPoint.y + len * sin(rad))
    }

    private func getScaleValues(minValue :UInt, _ maxValue :UInt) -> [CGFloat] {
        var values = [CGFloat]()
        if (maxValue - minValue) < 2 {
            return values
        }
        if (maxValue - minValue) < 10 {
            for value in (minValue + 1)...(maxValue - 1) {
                values.append(CGFloat(value))
            }
            return values
        }
        for index in 1...(10 - 1) {
            let diff :CGFloat = CGFloat(maxValue - minValue) / 10.0
            values.append(CGFloat(minValue) + diff * CGFloat(index))
        }
        return values
    }
}
