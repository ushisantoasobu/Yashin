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

        radarChart.set(
            ["shoot", "pass", "dribble", "speed", "power", "stamina", "mentality"],
            [
                ([6,9,5,8,7,4,6], UIColor.greenColor().colorWithAlphaComponent(0.40)),
                ([7,6,7,7,8,8,6], UIColor.blackColor().colorWithAlphaComponent(0.40)),
                ([8,7,8,7,7,9,5], UIColor.redColor().colorWithAlphaComponent(0.40))
            ]
        )
    }

}

