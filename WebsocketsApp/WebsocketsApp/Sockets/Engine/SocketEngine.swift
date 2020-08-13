//
//  SocketEngine.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 13/08/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

protocol SocketEngineProtocol {
    init(with client: SocketClient)
    
    func connect()
    func write(text: String)
    func write(data: Data)
    func observe(completion: @escaping (SocketResult) -> Void)
    func disconnect()
}


class SocketEngine: SocketEngineProtocol {
    
    private let client: SocketClient
    
    required init(with client: SocketClient) {
        self.client = client
    }
    
    func connect() {
        client.connect()
    }
    
    func write(text: String) {
        client.write(text: text)
    }
    
    func write(data: Data) {
        client.write(data: data)
    }
    
    func observe(completion: @escaping (SocketResult) -> Void) {
        client.observe(completion: completion)
    }
    
    func disconnect() {
        client.disconnect()
    }
    
    
}
