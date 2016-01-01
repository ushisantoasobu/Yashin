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

