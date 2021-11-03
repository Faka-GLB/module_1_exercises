//
//  MessageSenderTableViewCell.swift
//  Exercises
//
//  Created by Facundo Martinez on 29/10/2021.
//

import UIKit

class MessageSenderTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MessageSenderTableViewCell"
    
    @IBOutlet weak var messageUILabel: UILabel!
    @IBOutlet weak var timeUILabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    static func getReuseIdentifier() -> String {
        return reuseIdentifier
    }
    
    static func getNib() -> UINib{
        return UINib(nibName: "MessageSenderTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ message: Message) {
        messageUILabel.text = message.textMessage
        timeUILabel.text = message.timeMessage
        messageView.layer.cornerRadius = 10
    }
    
}
