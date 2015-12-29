//
//  ViewController.swift
//  Yashin
//
//  Created by ushisantoasobu on 12/29/2015.
//  Copyright (c) 2015 ushisantoasobu. All rights reserved.
//

import UIKit
import Yashin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupRadarChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupRadarChart() {
        let radarChart = Yashin()
        radarChart.frame = self.view.frame
//        let radarChart = Yashin(coder: self.view.frame)
        //        let radarChart = Yashin(frame: CGRectMake(80, 80, 240, 240))
        //        let radarChart = Yashin(frame: CGRectMake(0, 0, 240, 240))

        radarChart.maxValue = 100
        radarChart.minValue = 0
        //        radarChart.padding += 10
        radarChart.fontSize = 10.0
        radarChart.scaleLineWidth = 2.0
        //        radarChart.scaleLineHidden = true

        self.view.addSubview(radarChart)

        radarChart.list = [
            ("攻撃力", 82),
            ("守備力", 72),
            ("ボディ", 84),
            ("体力", 88),
            ("パス", 82),
            ("シュート", 77),
            ("ドリブル", 76),
            ("ヘディング", 81),
            ("安定性", 85),
            ("メンタリティ", 88),
        ]
    }

}

