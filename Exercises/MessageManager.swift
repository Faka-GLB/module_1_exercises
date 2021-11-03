//
//  MessageManager.swift
//  Exercises
//
//  Created by Facundo Martinez on 29/10/2021.
//

import Foundation

enum Errors: Error {
    case fileNotFound
    case invalidData
    case decodingProblem(String)
}

class MessageManager {
    func retrieveFromJson(onCompletion: @escaping (Result<[Message], Errors>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = Bundle.main.url(forResource: "chat", withExtension: "json")
            guard let myUrl = url else {
                onCompletion(.failure(.fileNotFound))
                return
            }
            guard let myData = try? Data(contentsOf: myUrl) else {
                onCompletion(.failure(.invalidData))
                return
            }
            do {
                let messages = try JSONDecoder().decode([Message].self, from: myData)
                onCompletion(.success(messages))
            } catch DecodingError.dataCorrupted(_) {
                onCompletion(.failure(.decodingProblem("Data corrupted")))
            } catch DecodingError.keyNotFound(let codingKey, _) {
                onCompletion(.failure(.decodingProblem(codingKey.stringValue)))
            } catch let error {
                onCompletion(.failure(.decodingProblem(error.localizedDescription)))
            }
        }
    }
}
