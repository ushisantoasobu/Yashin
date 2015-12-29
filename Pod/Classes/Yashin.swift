//
//  Yashin.swift
//  Pods
//
//  Created by SatoShunsuke on 2015/12/29.
//
//

import Foundation
import UIKit

public class Yashin : UIView {

    public var list = [(name :String, value :UInt)]()
    public var minValue :UInt = 0
    public var maxValue :UInt = 10
    public var padding :CGFloat = 60
    public var scaleLineWidth :CGFloat = 3.0
    public var scaleLineHidden = false

    // font
    public var fontSize :CGFloat = 11.0

    // color
    public var lineColor    = UIColor.darkGrayColor()
    public var subLineColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.30)
    public var fillColor    = UIColor.darkGrayColor().colorWithAlphaComponent(0.20)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = false
        self.backgroundColor = UIColor.clearColor()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func drawRect(rect: CGRect) {

        // some validates

        if !(self.minValue < self.maxValue) {
            print("minValue, maxValueの値がおかしい")
            return
        }

        let count = self.list.count
        if count < 3 {
            print("listの数が少なすぎる")
            return
        }

        let len = min(self.frame.width, self.frame.height) - padding * 2
        if len < 100 {
            print("viewのframeが小さすぎる")
            return
        }

        let center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y - self.frame.origin.y)

        let fillPath = UIBezierPath()

        var rad :CGFloat = 2 * CGFloat(M_PI) * 3 / 4

        let scales :[CGFloat] = self.getScaleValues(self.minValue, self.maxValue)

        for (index, data) in self.list.enumerate() {

            self.lineColor.setStroke()

            let valueRatio :CGFloat = min(1.0, (CGFloat(data.value) - CGFloat(self.minValue)) / CGFloat(self.maxValue - self.minValue))
            let currentMaxPoint   = self.getPoint(center, len: len / 2, rad: rad)
            let currentValuePoint = self.getPoint(center, len: len * valueRatio / 2, rad: rad)

            let namePoint = self.getPoint(center, len: (len + 10) / 2, rad: rad)

            let nextRad = rad + 2 * CGFloat(M_PI) / CGFloat(count)

            let nextValueRatio = (index == self.list.count - 1) ?
                min(1.0, (CGFloat(self.list[0].value) - CGFloat(self.minValue)) / CGFloat(self.maxValue - self.minValue)) :
                min(1.0, (CGFloat(self.list[index + 1].value) - CGFloat(self.minValue)) / CGFloat(self.maxValue - self.minValue))
            let nextMaxPoint   = self.getPoint(center, len: len / 2, rad: nextRad)
            let nextValuePoint = self.getPoint(center, len: len * nextValueRatio / 2, rad: nextRad)

            self.drawLine(currentMaxPoint, nextMaxPoint)

            self.subLineColor.setStroke()
            self.drawLine(currentMaxPoint, center)

            if index == 0 {
                fillPath.moveToPoint(currentValuePoint)
            }
            fillPath.addLineToPoint(nextValuePoint)

            // text
            let paragraphStyle = NSMutableParagraphStyle()
            let dic = [
                NSParagraphStyleAttributeName  : paragraphStyle,
                NSForegroundColorAttributeName : self.lineColor,
                NSFontAttributeName            : UIFont.systemFontOfSize(self.fontSize)
            ]

            let name :NSString = self.list[index].name
            // switch分でタプルで書きたい
            let textWidth  :CGFloat = 200.0
            let textHeight :CGFloat = 14.0
            if index == 0 {
                paragraphStyle.alignment = NSTextAlignment.Center
                name.drawInRect(CGRectMake(namePoint.x - textWidth / 2, namePoint.y - textHeight, textWidth, textHeight), withAttributes: dic)
            } else if index == count / 2 && count % 2 == 0 {
                paragraphStyle.alignment = NSTextAlignment.Center
                name.drawInRect(CGRectMake(namePoint.x - textWidth / 2, namePoint.y, textWidth, textHeight), withAttributes: dic)
            } else if index == count / 4 && count % 4 == 0 {
                paragraphStyle.alignment = NSTextAlignment.Left
                name.drawInRect(CGRectMake(namePoint.x, namePoint.y - textHeight / 2, textWidth, textHeight), withAttributes: dic)
            } else if index == count / 4 * 3 && count % 4 == 0 {
                paragraphStyle.alignment = NSTextAlignment.Right
                name.drawInRect(CGRectMake(namePoint.x - textWidth, namePoint.y - textHeight / 2, textWidth, textHeight), withAttributes: dic)
            } else if namePoint.x < center.x && namePoint.y < center.y {
                paragraphStyle.alignment = NSTextAlignment.Right
                name.drawInRect(CGRectMake(namePoint.x - textWidth, namePoint.y - textHeight, textWidth, textHeight), withAttributes: dic)
            } else if namePoint.x > center.x && namePoint.y < center.y {
                paragraphStyle.alignment = NSTextAlignment.Left
                name.drawInRect(CGRectMake(namePoint.x, namePoint.y - textHeight, textWidth, textHeight), withAttributes: dic)
            } else if namePoint.x < center.x && namePoint.y > center.y {
                paragraphStyle.alignment = NSTextAlignment.Right
                name.drawInRect(CGRectMake(namePoint.x - textWidth, namePoint.y, textWidth, textHeight), withAttributes: dic)
            } else if namePoint.x > center.x && namePoint.y > center.y {
                paragraphStyle.alignment = NSTextAlignment.Left
                name.drawInRect(CGRectMake(namePoint.x, namePoint.y, textWidth, textHeight), withAttributes: dic)
            }

            // draw scale lines
            if scaleLineHidden {
                rad = nextRad
                continue
            }
            self.subLineColor.setStroke()
            if self.maxValue - self.minValue < 2 {
                rad = nextRad
                continue
            }

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

        self.fillColor.setFill()
        fillPath.fill()
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
        if (maxValue - minValue) <= 10 {
            for value in (minValue + 1)...(maxValue - 1) {
                values.append(CGFloat(value))
            }
            return values
        }
        for index in 1...(10 - 1) {
            let diff :CGFloat = CGFloat(self.maxValue - self.minValue) / 10.0
            values.append(CGFloat(self.minValue) + diff * CGFloat(index))
        }
        return values
    }
}
