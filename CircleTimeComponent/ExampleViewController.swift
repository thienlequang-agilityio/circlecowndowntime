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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    secondsView.endDate = "2015-07-17:09:22:00"
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }
  
}
