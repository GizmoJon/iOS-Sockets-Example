//
//  URLSessionWebSocketClient.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 13/08/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class URLSessionWebSocketClient: SocketClient {
    
    private let session: URLSession
    private let socket: URLSessionWebSocketTask
    private var observationClosure: ((SocketResult) -> Void)?
    
    required init(with baseURL: URL) {
        self.session = URLSession(configuration: .default)
        self.socket = self.session.webSocketTask(with: baseURL)
    }
    
    func connect() {
        self.socket.resume()
        observationClosure?(.connected)
    }
    
    func write(text: String) {
        self.socket.send(.string(text)) { [weak self] error in
            guard let error = error else { return }
            self?.observationClosure?(.failure(error))
        }
    }
    
    func write(data: Data) {
        self.socket.send(.data(data)) { [weak self] error in
            guard let error = error else { return }
            self?.observationClosure?(.failure(error))
        }
    }
    
    func observe(completion: @escaping (SocketResult) -> Void) {
        self.observationClosure = completion
        receiveMessages()
    }
    
    func disconnect() {
        self.socket.cancel(with: .normalClosure, reason: nil)
    }
    
    private func receiveMessages() {
        socket.receive { [weak self] result in
            switch result {
            case .failure(let error):
                self?.observationClosure?(.failure(error))
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.observationClosure?(.text(text))
                case .data(let data):
                    self?.observationClosure?(.data(data))
                default:
                    break
                }
            }
            self?.receiveMessages()
        }
    }
    
    
}
