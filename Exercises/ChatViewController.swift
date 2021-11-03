//
//  ChatViewController.swift
//  Exercises
//
//  Created by Facundo Martinez on 27/10/2021.
//

import UIKit

class ChatViewController: UIViewController {
    //outlets
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var errorUILabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var messages: [Message]? = [] {
        didSet {
            self.messagesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        MessageManager().retrieveFromJson() {
            [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                switch result {
                case .success(let messages):
                    self?.messages = messages
                case .failure(let error):
                    switch error {
                    case .fileNotFound:
                        self?.errorUILabel.text = "File not found"
                    case .decodingProblem(let problem):
                        self?.errorUILabel.text = "There was a problem decoding the data: \(problem)"
                    default:
                        self?.errorUILabel.text = "There was a problem"
                    }
                    self?.errorUILabel.isHidden = false
                    self?.messages = []
                }
            }
        }
        configureTable()
        activityIndicator.stopAnimating()
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = self.messages?[indexPath.row] else { return UITableViewCell() }
        if message.username == "Me" {
            let cellReuseIdentifier = MessageSenderTableViewCell.getReuseIdentifier()
            var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MessageSenderTableViewCell
            if cell == nil {
                cell = MessageSenderTableViewCell()
            }
            cell?.configureCell(message)
            return cell ?? UITableViewCell()
        } else {
            let cellReuseIdentifier = MessageReceiverTableViewCell.getReuseIdentifier()
            var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MessageReceiverTableViewCell
            if cell == nil {
                cell = MessageReceiverTableViewCell()
            }
            cell?.configureCell(message)
            return cell ?? UITableViewCell()
        }
    }
    
    private func configureTable() {
        messagesTableView.dataSource = self
        messagesTableView.register(MessageSenderTableViewCell.getNib(), forCellReuseIdentifier: MessageSenderTableViewCell.getReuseIdentifier())
        messagesTableView.register(MessageReceiverTableViewCell.getNib(), forCellReuseIdentifier: MessageReceiverTableViewCell.getReuseIdentifier())
    }
}
