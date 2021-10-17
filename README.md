
# Awesome Toggle Switch
## Usage

### Storyboard
![Storyboard setup](/assets/Screenshot1.png?raw=true "Storyboard")

### ViewController
```
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

```

### Result
![Storyboard setup](/assets/Screenshot2.png?raw=true "Simulator")
