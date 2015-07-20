//
//  ExampleViewController.swift
//  CircleTimeComponent
//
//  Created by thienle on 7/17/15.
//  Copyright (c) 2015 thienle. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
  
  @IBOutlet weak var secondsView: CustomCircleView!
  
  @IBOutlet weak var minutesView: CustomCircleView!
  
  @IBOutlet weak var hoursView: CustomCircleView!
  
  
  @IBOutlet weak var daysView: CustomCircleView!
  var countdownTime: Int = 0
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    

  }
  override func viewDidLoad() {
    super.viewDidLoad()

    countdownTime = (24 * 3600) + 60 + 12

    secondsView.countdownSeconnd = countdownTime
    minutesView.countdownMinute = Float(countdownTime) / 60.0
    hoursView.countdownHour = Float(countdownTime) / 3600.0
    daysView.countdownDay = Float(countdownTime) / (24 * 3600.0)
    daysView.dayBetweenStartTimeAndEndTime = 6
    
    daysView.viewColor = UIColor.greenColor()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }
  
}
