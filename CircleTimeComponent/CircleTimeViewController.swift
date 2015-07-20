//
//  ViewController.swift
//  CircleTimeComponent
//
//  Created by thienle on 7/13/15.
//  Copyright (c) 2015 thienle. All rights reserved.
//

import UIKit

class CircleTimeViewController: UIViewController {
  
  // MARKS: IBOutlet

  @IBOutlet weak var DaysView: UIView!
  
  @IBOutlet weak var HoursView: UIView!
  
  @IBOutlet weak var MinutesView: UIView!
  
  @IBOutlet weak var secondsView: UIView!
  
  
  @IBOutlet weak var secondsLabel: UILabel!
  
  @IBOutlet weak var minutesLabel: UILabel!
  
  @IBOutlet weak var hoursLabel: UILabel!
  
  @IBOutlet weak var daysLabel: UILabel!
  
  
  @IBOutlet weak var testView: CustomCircleView!
  
  var unitTimeCounddown = 60
  var minutesCountdown = 59
  var hoursCountdown = 23
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }


  override func viewDidLoad() {
    super.viewDidLoad()
    
//    DaysView.layoutIfNeeded()
//    testView.startDate = "2015-07-25:20:20:00"
//    testView.endDate = "2015-07-17:09:30:00"
//    testView.currentTime = NSDate()
    secondsView.backgroundColor = UIColor.clearColor()
    MinutesView.backgroundColor = UIColor.clearColor()
    HoursView.backgroundColor = UIColor.clearColor()
//    DaysView.backgroundColor = UIColor.clearColor()
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    var circleWidth = self.DaysView.frame.size.width
    initializeSecondCircle()
    initializeMinutesCircle()
    initializeHoursCircle()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  
  
  func countingSeconds() {
    unitTimeCounddown -= 1
    secondsLabel.text = "\(unitTimeCounddown)"
    if unitTimeCounddown == 0 {
      unitTimeCounddown = 60
      
    }
  }
  
  func countingMinutes() {
    minutesCountdown -= 1
    minutesLabel.text = "\(minutesCountdown)"
    if minutesCountdown == 0 {
      minutesCountdown = 60
      
    }
  }
  
  func countingHours() {
    hoursCountdown -= 1
    hoursLabel.text = "\(hoursCountdown)"
    if hoursCountdown == 0 {
      hoursCountdown = 24
    }
  }
  
  func drawSecondView() {
    addCircleView(secondsView, isForeground: true, duration: 60.0, fromValue: 0.0,  toValue: 1.0)
  }
  
  func drawMinutesView() {
    addCircleView(MinutesView, isForeground: true, duration: 3600.0, fromValue: 0.0,  toValue: 1.0)
  }
  
  func initalizeDrawMinute() {
    addCircleView(MinutesView, isForeground: true, duration: 0, fromValue: 0.0,  toValue: 1.0/60.0)
  }
  
  func drawHourView() {
    addCircleView(HoursView, isForeground: true, duration: 24 * 3600.0, fromValue: 0, toValue: 1)
  }
  
  func drawFirstHourView() {
    addCircleView(HoursView, isForeground: true, duration: 0, fromValue: 0, toValue: 7/24.0)
  }
  
  func initializeSecondCircle() {
    drawSecondView()
    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countingSeconds"), userInfo: nil, repeats: true)
    NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("drawSecondView"), userInfo: nil, repeats: true)
  }
  
  func initializeMinutesCircle() {
    initalizeDrawMinute()
    NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("countingMinutes"), userInfo: nil, repeats: true)
    NSTimer.scheduledTimerWithTimeInterval(3600, target: self, selector: Selector("drawMinutesView"), userInfo: nil, repeats: true)
  }
  
  func initializeHoursCircle() {
    drawFirstHourView()
    NSTimer.scheduledTimerWithTimeInterval(3600, target: self, selector: Selector("countingHours"), userInfo: nil, repeats: true)
    NSTimer.scheduledTimerWithTimeInterval(24 * 3600, target: self, selector: Selector("drawHoursView"), userInfo: nil, repeats: true)
  }
  
  
  //MARK: Draw circle
  func addCircleView( myView : UIView, isForeground : Bool, duration : NSTimeInterval, fromValue: CGFloat, toValue : CGFloat ) {
    var circleWidth = self.DaysView.frame.size.width
    
    var circleHeight = circleWidth
    
    // create new circle
    var circleView = CircleView(frame: CGRectMake(0, 0, circleWidth, circleHeight))
    
    // Setting the color
    if (isForeground) {
      circleView.setStrokeColor("#F2634B".CGColor)
    } else {
      circleView.setStrokeColor("#363636".CGColor)
    }
    
    myView.addSubview(circleView)
    
    // Rotate the circle so it starts from the top
    circleView.transform = CGAffineTransformMakeRotation(0.0)
    
    // animate the drawing of the circle
    circleView.animateCircleTo(duration, fromValue: fromValue, toValue: toValue)
    
  }
  




}

