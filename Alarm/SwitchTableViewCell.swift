//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Collin Cannavo on 5/29/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {

    weak var delegate: SwitchTableViewCellDelegate?
    
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
        
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    
    }
    
    
    
}

