//
//  ToggleSwitch.swift
//  Toggle-Switch-With-Label
//
//  Created by ADMIN on 16/05/21.
//  Copyright © 2021 Success Resource Pte Ltd. All rights reserved.
//

import UIKit

final public class ToggleSwitch: UIView {
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = switchConfiguration.leftText
        label.backgroundColor = switchConfiguration.leftColor
        label.font = switchConfiguration.font
        label.textColor = switchConfiguration.textColor
        label.isUserInteractionEnabled = true
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
        label.isUserInteractionEnabled = true
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
    
    private lazy var innerCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = (self.frame.height - 14) / 2
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private var leadingAnchorForLeftLabel: CGFloat = 0
    private let leftLabelLeadingAnchorIdentifier = "LeftLabelLeadingAnchor"
    
    // MARK:- Switch Configuration
    public var switchConfiguration: SwitchConfiguration!{
        didSet{
            configureView()
        }
    }
    
    private lazy var switchState: SwitchState! = switchConfiguration.currentState
    
    public weak var delegate: LableSwitchDelegate?
    
    // MARK:- Configuration
    private func configureView() {
    
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        
        addSubview(leftLabel)
        addSubview(rightLabel)
        addSubview(circleView)
        circleView.addSubview(innerCircleView)
        
        updateConstraintsForLabel()
        
        // MARK:- Tap Recognizer
        circleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchTapped)))
        leftLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchTapped)))
        rightLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(switchTapped)))
    }
    
    @objc private func switchTapped() {
        if switchState == SwitchState.Right {
            switchState = .Left
            UIView.animate(withDuration: 0.2) {[weak self] in
                self?.constraintWith(
                    identifier: self!.leftLabelLeadingAnchorIdentifier)?.constant = -(self?.leftLabel.frame.width)!
                self?.backgroundColor = self?.switchConfiguration.rightColor
                self?.innerCircleView.backgroundColor = self?.switchConfiguration.rightColor
                self?.layoutIfNeeded()
            }
        } else {
            switchState = .Right
            UIView.animate(withDuration: 0.2) {[weak self] in
                self?.constraintWith(identifier: self!.leftLabelLeadingAnchorIdentifier)?.constant = 0
                self?.backgroundColor = self?.switchConfiguration.leftColor
                self?.innerCircleView.backgroundColor = self?.switchConfiguration.leftColor
                self?.layoutIfNeeded()
            }
        }
        delegate?.didTapLabelSwitch(state: switchState, labelSwitch: self)
    }
    
    private func updateConstraintsForLabel() {
        
        var leftLabelAnchor: NSLayoutConstraint!
        
        if switchState == SwitchState.Right {
            leftLabelAnchor = leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
            backgroundColor = switchConfiguration.leftColor
            innerCircleView.backgroundColor = switchConfiguration.leftColor
        }else{
            leftLabelAnchor = leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -(frame.width - frame.height))
            backgroundColor = switchConfiguration.rightColor
            innerCircleView.backgroundColor = switchConfiguration.rightColor
        }
        
        innerCircleView.isHidden = switchConfiguration.innerCircle
        
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
            
            // MARK:- Constraints for Circle
            innerCircleView.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 7),
            innerCircleView.leadingAnchor.constraint(equalTo: circleView.leadingAnchor, constant: 7),
            innerCircleView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            innerCircleView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            
            // MARK:- Constraints for Right Label
            rightLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor),
            rightLabel.topAnchor.constraint(equalTo: topAnchor),
            rightLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightLabel.widthAnchor.constraint(equalTo: leftLabel.widthAnchor),
        ])
    }
}

extension ToggleSwitch{
    private func constraintWith(identifier: String) -> NSLayoutConstraint?{
        return self.constraints.first(where: {$0.identifier == identifier})
    }
}
