//
//  MessageReceiverTableViewCell.swift
//  Exercises
//
//  Created by Facundo Martinez on 29/10/2021.
//

import UIKit

class MessageReceiverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userUILabel: UILabel!
    @IBOutlet weak var textUILabel: UILabel!
    @IBOutlet weak var timeUILabel: UILabel!
    
    static let reuseIdentifier = "MessageReceiverTableViewCell"
    
    static func getReuseIdentifier() -> String {
        return reuseIdentifier
    }
    
    static func getNib() -> UINib {
        return UINib(nibName: "MessageReceiverTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ message: Message) {
        userUILabel.text = message.username
        textUILabel.text = message.textMessage
        timeUILabel.text = message.timeMessage
    }
    
}
