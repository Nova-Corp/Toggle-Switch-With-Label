//
//  ViewController.swift
//  Toggle-Switch-With-Label
//
//  Created by ADMIN on 16/05/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit
import ToggleSwitch

class ViewController: UIViewController {
    
    @IBOutlet weak var labelSwitchOne: ToggleSwitch!
    
    lazy var labelSwitchTwo: ToggleSwitch = {
        let labelSwitch = ToggleSwitch(frame: .init(x: view.frame.width/2 - 50,
                                                   y: view.frame.height/2 - 60,
                                                   width: 100,
                                                   height: 30))
        return labelSwitch
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelSwitchOne.delegate = self
        labelSwitchOne.switchConfiguration = SwitchConfiguration(leftText: nil,
                                                                 leftColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
                                                                 rightText: nil,
                                                                 rightColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                                                                 font: .boldSystemFont(ofSize: 5),
                                                                 textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                                 circleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                                 innerCircle: true,
                                                                 currentState: .Right)
        
        labelSwitchTwo.delegate = self
        labelSwitchTwo.switchConfiguration = SwitchConfiguration(leftText: "Label",
                                                              leftColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
                                                              rightText: "Switch",
                                                              rightColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
                                                              font: .boldSystemFont(ofSize: 14),
                                                              textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                              circleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                              innerCircle: false,
                                                              currentState: .Left)
         view.addSubview(labelSwitchTwo)
    }
}
extension ViewController: LableSwitchDelegate {
    // MARK:- LableSwitchDelegate
    func didTapLabelSwitch(state: SwitchState, labelSwitch: ToggleSwitch) {
        switch labelSwitch {
        case labelSwitchOne:
            print("---labelSwitchOne State is \(state)---")
        case labelSwitchTwo:
            print("---labelSwitchTwo State is \(state)---")
        default:
            print("---Nothing---")
        }
    }
}
