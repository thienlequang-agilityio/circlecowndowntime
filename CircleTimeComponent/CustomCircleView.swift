
import UIKit

@IBDesignable
public class CustomCircleView: UIView {
  
  public enum ViewType: Int {
    case Days, Hours, Mins, Secs
  }
  
  // MARK: - Property
  
  var dateFormater: NSDateFormatter = NSDateFormatter()
  var dateFormat: String = "yy-MM-dd:HH-mm-ss"
  
  @IBInspectable public var startDate: String = ""
  @IBInspectable public var endDate: String = ""
  public let currentTime: NSDate = NSDate()
  
  @IBInspectable var typeRaw: Int = 0 {
    didSet {
      if let type = ViewType(rawValue: typeRaw) {
        self.viewType = type
      } else {
        self.viewType = .Secs
      }
    }
  }
  
  @IBInspectable public var viewColor: UIColor = UIColor.redColor() {
    didSet {
      _circleLayer.backgroundColor = viewColor.CGColor
    }
  }
  
  @IBInspectable var lineWidth: CGFloat = 3.0
  
  @IBInspectable public var countdownSeconnd:Int =  3600 * 12 + 9 * 60 + 30
  var countdownMinute:Float = (3600 * 12 + 9 * 60  + 30) / 60.0
  var countdownHour:Float = (3600 * 12 + 9 * 60  + 30) / 3600.0
  var countdownDay:Float = (3600 * 12 + 9 * 60  + 30) / (3600 * 24)
  
  public var label = UILabel()
  
  
    var timer = NSTimer()
  var minuteTimer = NSTimer()
  
//  var flag = true
  
  public var viewType: ViewType  = .Secs {
    didSet {
      switch viewType {
      case .Secs:
        println("SECS")
      case .Mins:
        println("MINS")
      case .Hours:
        println("HOURS")
      case .Days:
        println("Days")
      }
    }
  }
  
  
  private var _circlePath: UIBezierPath {
    
    let side = self.bounds.size
    return UIBezierPath(arcCenter: CGPoint(x: side.width / 2.0, y: side.height / 2.0), radius: (side.width - 5) / 2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
  }
  
  
  lazy private var _circleLayer: CAShapeLayer = {

    let layer = CAShapeLayer()
    layer.path      = self._circlePath.CGPath
    layer.fillColor = UIColor.clearColor().CGColor
    layer.strokeColor = self.viewColor.CGColor
    layer.lineWidth = self.lineWidth

    return layer
    }()
  
  // MARK: - initialize
  
  public convenience init(frame: CGRect, viewType: ViewType, viewColor: UIColor, strokeEnd: CGFloat, startDate: String) {
    self.init(frame: frame)
    self.viewType = viewType
    self.viewColor = viewColor
    self.startDate = startDate
//    self.flag = true
    switch viewType {
    case .Secs:
      println("SECS")
//      self.drawSecondsCircle()
    case .Mins:
      println("MINS")
    case .Hours:
      println("HOURS")
    case .Days:
      println("Days")
    }
  }
  
  
  // MARK: - Override
  public override func layoutSubviews() {
    super.layoutSubviews()
    
    if _circleLayer.superlayer != layer {
      layer.addSublayer(_circleLayer)
      
      switch viewType {
      case .Secs:
//
        println("..")
        self.drawSecondsCircle()
      case .Mins:
        println("MINS")
        self.drawMinuteCircle()
      case .Hours:
        println("HOURS")
        self.drawHourCircle()
      case .Days:
        println("Days")
      }
      self.addSubview(label)
    }
  }
  
  // MARK: - Method
  // Draw a partial circle
  public func animateCircleTo(duration: NSTimeInterval, fromValue: CGFloat, toValue:CGFloat) {
    // We want to animate the strokeEnd property of the circleLayer
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animation from 0 (no circle) to 1 (full circle)
    animation.fromValue = fromValue
    animation.toValue = toValue
    
    // Do an easeout.
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the right value when animation ends.
    _circleLayer.strokeEnd = toValue
    
    // Do the actual Animation
    _circleLayer.addAnimation(animation, forKey: "animateCircle")

  }

  public func remaindSecond() {
    countdownSeconnd -= 1
    label.text = "\(countdownSeconnd % 60)"
    
  }
  
  public func drawSecondsCircle() {
    let seconds = 60 - (countdownSeconnd % 60)
    let circleRound = Int(countdownSeconnd / 60)
    println("\(circleRound)")
    self.animateCircleTo(NSTimeInterval(60 - seconds), fromValue: CGFloat(seconds) / 60, toValue: 1.0)
    label.frame = CGRectMake(0, self.frame.height / 2 - 10 , self.frame.width, 20)
    label.textAlignment = NSTextAlignment.Center
    for i in 0...(countdownSeconnd) {
      timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(i), target: self, selector: Selector("remaindSecond"), userInfo: nil, repeats: false)
    }

    let delay = Double(60 - seconds - 1) * Double(NSEC_PER_SEC)
    var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
      self.timer.invalidate()
      if circleRound > 0 {
        for i in 1...circleRound {
          NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(60 * (i - 1)), target: self, selector: Selector("drawTotalSecondCircle"), userInfo: nil, repeats: false)
        }
      }
    })
  }
  
  public func drawTotalSecondCircle() {
    _circleLayer.strokeEnd = 0
    animateCircleTo(60, fromValue: 0.0, toValue: 1.0)
  }

  
  public func drawMinuteCircle() {
    println("countdownMinute \(countdownMinute)")
    var remindMinute = (countdownMinute % 60)
    
    let circleRound = Int(countdownMinute / 60) - 1

    self.animateCircleTo(NSTimeInterval(remindMinute * 60), fromValue: CGFloat(60 - remindMinute) / 60 , toValue: 1.0)
    label.frame = CGRectMake(0, self.frame.height / 2 - 10 , self.frame.width, 20)
    label.textAlignment = NSTextAlignment.Center
    
    label.text = "\(Int(remindMinute))"
    // sau thoi gian la so giay con lai thi giam label xuong 1
    for i in 0...Int(countdownMinute) {
      var time = i * 60 + Int((remindMinute - Float(Int(remindMinute))) * 60)

      NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(time), target: self, selector: Selector("showMinuteLabel"), userInfo: nil, repeats: false)
    }
    let delay = Double(remindMinute * 60) * Double(NSEC_PER_SEC)
    var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
    for i in 0...0 {
      println("hehe")
    }
    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
      if circleRound > 0 {
        for i in 0...circleRound {
          NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3600 * i), target: self, selector: Selector("drawTotalMinuteCircle"), userInfo: nil, repeats: false)
        }
      }
    })

  }
  func showMinuteLabel() {
    println("in show minute label")
    label.text = "\(Int(countdownMinute) % 60 - 1)"
    println("abc \(Int(countdownMinute) % 60 - 1)")
    // TODO:
    // O day ccheck new % 60 = 0 sau do -1 ra -1 thi phai thay thanh 59
    countdownMinute -= 1
  }
  public func drawTotalMinuteCircle() {
    _circleLayer.strokeEnd = 0
    animateCircleTo(3600, fromValue: 0.0, toValue: 1.0)
  }
  
  
  //-------------------------HOURCIRCLE-----------------------------//
  
  public func drawHourCircle() {
    var remindHours = countdownHour % 24
    let circleRound = Int(countdownHour / 24) - 1
    
    self.animateCircleTo(NSTimeInterval(remindHours * 60 * 60), fromValue: CGFloat(24 - remindHours) / 24.0 , toValue: 1.0)
    label.frame = CGRectMake(0, self.frame.height / 2 - 10 , self.frame.width, 20)
    label.textAlignment = NSTextAlignment.Center
    
    label.text = "\(Int(remindHours))"
    // sau thoi gian la so giay con lai thi giam label xuong 1
    for i in 0...Int(countdownMinute) {
      var time = i * 60 * 60 + Int((remindHours - Float(Int(remindHours))) * 60 * 60)
      
      NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(time), target: self, selector: Selector("showHourLabel"), userInfo: nil, repeats: false)
    }
    let delay = Double(remindHours * 60 * 60) * Double(NSEC_PER_SEC)
    var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))

    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
      if circleRound > 0 {
        for i in 0...circleRound {
          NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(3600 * 24 * i), target: self, selector: Selector("drawTotalMinuteCircle"), userInfo: nil, repeats: false)
        }
      }
    })
  }
  
  func showHourLabel() {

    label.text = "\(Int(countdownMinute) % 24 - 1)"
    println("abc \(Int(countdownMinute) % 24 - 1)")
    // TODO:
    // O day ccheck new % 60 = 0 sau do -1 ra -1 thi phai thay thanh 59
    countdownMinute -= 1
  }
  
  public func drawTotalHourCircle() {
      _circleLayer.strokeEnd = 0
      animateCircleTo(24 * 3600, fromValue: 0.0, toValue: 1.0)
  }
}

