//
//  Message.swift
//  Exercises
//
//  Created by Facundo Martinez on 29/10/2021.
//

import Foundation

struct Message: Decodable {
    var username: String
    var textMessage: String
    var timeMessage: String
    
    enum CodingKeys: String, CodingKey {
        case username, timeMessage
        case textMessage = "message"
    }
}
