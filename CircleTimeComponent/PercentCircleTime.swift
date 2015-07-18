//
//  PercentCircleTime.swift
//  CircleTimeComponent
//
//  Created by thienle on 7/17/15.
//  Copyright (c) 2015 thienle. All rights reserved.
//

import UIKit

@IBDesignable
public class PercentCircleTime: UIView {
  
  public enum ViewType: Int {
    case Days, Hours, Mins, Secs
  }
  
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
  
  
  public convenience init(frame: CGRect, viewType: ViewType, viewColor: UIColor, strokeEnd: CGFloat, startDate: String) {
    self.init(frame: frame)
    self.viewType = viewType
    self.viewColor = viewColor
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

      case .Mins:
        println("MINS")

      case .Hours:
        println("HOURS")

      case .Days:
        println("Days")
      }

    }
  }
  
  
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

}
