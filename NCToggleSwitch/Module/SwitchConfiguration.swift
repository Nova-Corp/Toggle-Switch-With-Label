//
//  SwitchConfiguration.swift
//  ToggleSwitch
//
//  Created by Mac on 17/10/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

public enum SwitchState {
    case Left
    case Right
}

public struct SwitchConfiguration {
    let leftText: String?
    let leftColor: UIColor
    let rightText: String?
    let rightColor: UIColor
    let font: UIFont
    let textColor: UIColor
    let circleColor: UIColor
    let innerCircle: Bool
    let currentState: SwitchState
    
    public init(leftText: String?, leftColor: UIColor,
                rightText: String?, rightColor: UIColor,
                font: UIFont = .systemFont(ofSize: 12),
                textColor: UIColor, circleColor: UIColor,
                innerCircle: Bool, currentState: SwitchState) {
        
        self.leftText       = leftText
        self.leftColor      = leftColor
        self.rightText      = rightText
        self.rightColor     = rightColor
        self.font           = font
        self.textColor      = textColor
        self.circleColor    = circleColor
        self.innerCircle    = innerCircle
        self.currentState   = currentState
    }
}

public protocol LableSwitchDelegate: AnyObject {
    func didTapLabelSwitch(state: SwitchState, labelSwitch: ToggleSwitch)
}
