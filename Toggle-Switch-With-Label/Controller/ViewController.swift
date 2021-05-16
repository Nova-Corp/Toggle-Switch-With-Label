//
//  ViewController.swift
//  Toggle-Switch-With-Label
//
//  Created by ADMIN on 16/05/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lableSwitch: LabelSwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lableSwitch.delegate = self
        
        
        lableSwitch.switchConfiguration = SwitchConfiguration(leftText: "Label",
                                                              leftColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
                                                              rightText: "Switch",
                                                              rightColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                                                              font: .boldSystemFont(ofSize: 14),
                                                              textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                              circleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                              currentState: .Left)
        
    }
}

extension ViewController: LableSwitchDelegate {
    // MARK:- LableSwitchDelegate
    func didTapLabelSwitch(state: SwitchState) {
        print(state)
    }
}
