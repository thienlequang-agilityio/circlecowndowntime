//
//  CircleView.swift
//  CircleTimeComponent
//
//  Created by thienle on 7/13/15.
//  Copyright (c) 2015 thienle. All rights reserved.
//

import UIKit

class CircleView: UIView {

  var circleLayer: CAShapeLayer!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clearColor()
    
    // Use UIBezierPath as an easy way to create the CGPath for the layer.
    // The path should be the entry circle
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0 , y: frame.size.height / 2.0), radius: (frame.size.width - 10) / 2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
    
    // Setup the CAShapeLayer with the path, colors, and line width
    circleLayer = CAShapeLayer()
    circleLayer.path = circlePath.CGPath
    circleLayer.fillColor = UIColor.clearColor().CGColor
    
    circleLayer.strokeColor = UIColor.redColor().CGColor
    
    // CHANGE THE WIDTH OF CIRCLE
    circleLayer.lineWidth = 3.0
    
    // Dont' draw the circle initally
    circleLayer.strokeEnd = 0.0
    
    // Add the circleLayer to the View's layer's sublayers
    layer.addSublayer(circleLayer)
    
  }
  
  func setStrokeColor(color: CGColorRef) {
    circleLayer.strokeColor = color
  }
  
  // Draw a partial circle
  func animateCircleTo(duration: NSTimeInterval, fromValue: CGFloat, toValue:CGFloat) {
    // We want to animate the strokeEnd property of the circleLayer
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    
    // Set the animation duration appropriately
    animation.duration = duration
    
    // Animation from 0 (no circle) to 1 (full circle)
    animation.fromValue = 0
    animation.toValue = toValue
    
    // Do an easeout.
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    // Set the circleLayer's strokeEnd property to 1.0 now so that it's the right value when animation ends.
    circleLayer.strokeEnd = toValue
    
    // Do the actual Animation
    circleLayer.addAnimation(animation, forKey: "animateCircle")
    if toValue == 1.0 {
      circleLayer.strokeEnd = 0.0
    }
  }
  
  // This is what call if you want to draw a full circle
  func animateCircle(duration: NSTimeInterval) {
    animateCircleTo(duration, fromValue: 0.0, toValue: 1.0)
  }

  
  // Require func
  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

}
