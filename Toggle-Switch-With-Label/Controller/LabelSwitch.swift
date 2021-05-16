//
//  LabelSwitch.swift
//  Toggle-Switch-With-Label
//
//  Created by ADMIN on 16/05/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

class LabelSwitch: UIView {
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = switchConfiguration.leftText
        label.backgroundColor = switchConfiguration.leftColor
        label.font = switchConfiguration.font
        label.textColor = switchConfiguration.textColor
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = switchConfiguration.rightText
        label.backgroundColor = switchConfiguration.rightColor
        label.font = switchConfiguration.font
        label.textColor = switchConfiguration.textColor
        return label
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = switchConfiguration.circleColor
        view.layer.cornerRadius = self.frame.height / 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .init(width: 0, height: 1)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var leadingAnchorForLeftLabel: CGFloat = 0
    private let leftLabelLeadingAnchorIdentifier = "LeftLabelLeadingAnchor"
    
    // MARK:- Switch Configuration
    var switchConfiguration: SwitchConfiguration! = SwitchConfiguration(leftText: "Label",
                                                  leftColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
                                                  rightText: "Switch",
                                                  rightColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),
                                                  font: .boldSystemFont(ofSize: 12),
                                                  textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                  circleColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                                  currentState: .Right){
        didSet{
            configureView()
        }
    }
    
    
    lazy var switchState: SwitchState! = switchConfiguration.currentState
    
    weak var delegate: LableSwitchDelegate!
    
    // MARK:- Configuration
    private func configureView() {
    
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(circleView)
        
        updateConstraintsForLabel()
        
        // MARK:- Tap Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(switchTapped))
        circleView.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    @objc private func switchTapped() {
        
        if switchState == SwitchState.Right {
            switchState = .Left
            
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?.constraintWith(
                    identifier: self!.leftLabelLeadingAnchorIdentifier)?.constant = -(self?.leftLabel.frame.width)!
                self?.backgroundColor = self?.switchConfiguration.rightColor
                self?.layoutIfNeeded()
            }
        } else {
            switchState = .Right
    
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?.constraintWith(identifier: self!.leftLabelLeadingAnchorIdentifier)?.constant = 0
                self?.backgroundColor = self?.switchConfiguration.leftColor
                self?.layoutIfNeeded()
            }
        }
        
        delegate.didTapLabelSwitch(state: switchState)
    }
    
    
    
    
    private func updateConstraintsForLabel() {
        
        var leftLabelAnchor: NSLayoutConstraint!
        
        if switchState == SwitchState.Right {
            leftLabelAnchor = leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
            backgroundColor = switchConfiguration.leftColor
        }else{
            leftLabelAnchor = leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -(frame.width - frame.height))
            backgroundColor = switchConfiguration.rightColor
        }
        
        leftLabelAnchor.identifier = leftLabelLeadingAnchorIdentifier
        
        NSLayoutConstraint.activate([
            // MARK:- Constraints for Left Label
            leftLabelAnchor,
            leftLabel.topAnchor.constraint(equalTo: topAnchor),
            leftLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftLabel.trailingAnchor.constraint(equalTo: circleView.leadingAnchor),
            leftLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -frame.height),
            
            // MARK:- Constraints for Circle
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            circleView.widthAnchor.constraint(equalToConstant: frame.height),
            
            // MARK:- Constraints for Right Label
            rightLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor),
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightLabel.widthAnchor.constraint(equalTo: leftLabel.widthAnchor),
        ])
    }
}
extension LabelSwitch{
    func constraintWith(identifier: String) -> NSLayoutConstraint?{
        return self.constraints.first(where: {$0.identifier == identifier})
    }
}

enum SwitchState {
    case Left
    case Right
}

struct SwitchConfiguration {
    let leftText: String
    let leftColor: UIColor
    
    let rightText: String
    let rightColor: UIColor
    
    let font: UIFont
    let textColor: UIColor
    
    let circleColor: UIColor
    
    let currentState: SwitchState
    
}

protocol LableSwitchDelegate: AnyObject {
    func didTapLabelSwitch(state: SwitchState)
}
