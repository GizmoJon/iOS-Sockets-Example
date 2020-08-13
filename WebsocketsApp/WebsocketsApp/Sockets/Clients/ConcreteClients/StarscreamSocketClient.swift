//
//  StarscreamClient.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 13/08/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import Starscream

class StarscreamSocketClient: SocketClient {
    
    private let socket: WebSocket
    private var observationClosure: ((SocketResult) -> Void)?
    
    required init(with baseUrl: URL) {
        self.socket = WebSocket(url: baseUrl)
        self.socket.delegate = self
    }
    
    func connect() {
        self.socket.connect()
    }
    
    func write(text: String) {
        self.socket.write(string: text)
    }
    
    func write(data: Data) {
        self.socket.write(data: data)
    }
    
    func observe(completion: @escaping (SocketResult) -> Void) {
        observationClosure = completion
    }
    
    func disconnect() {
        self.socket.disconnect()
    }
    
}

extension StarscreamSocketClient: WebSocketDelegate {
    func websocketDidConnect(socket: WebSocketClient) {
        observationClosure?(.connected)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        observationClosure?(.disconnected)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        observationClosure?(.text(text))
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        observationClosure?(.data(data))
    }
}
