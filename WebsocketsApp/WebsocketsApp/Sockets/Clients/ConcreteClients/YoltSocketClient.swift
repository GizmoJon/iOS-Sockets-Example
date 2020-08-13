//
//  CombinedSocketClient.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 13/08/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

class CombinedSocketClient: SocketClient {
    
    private let starscreamSocketClient: StarscreamSocketClient
    private let urlSessionWebSocketClient: URLSessionWebSocketClient
    
    required init(with baseURL: URL) {
        starscreamSocketClient = StarscreamSocketClient(with: baseURL)
        urlSessionWebSocketClient = URLSessionWebSocketClient(with: baseURL)
    }
    
    func connect() {
        if #available(iOS 13.0, *) {
            urlSessionWebSocketClient.connect()
        } else {
            starscreamSocketClient.connect()
            
        }
    }
    
    func write(text: String) {
        if #available(iOS 13.0, *) {
            urlSessionWebSocketClient.write(text: text)
        } else {
            starscreamSocketClient.write(text: text)
        }
    }
    
    func write(data: Data) {
        if #available(iOS 13.0, *) {
            urlSessionWebSocketClient.write(data: data)
        } else {
            starscreamSocketClient.write(data: data)
        }
    }
    
    func observe(completion: @escaping (SocketResult) -> Void) {
        if #available(iOS 13.0, *) {
            urlSessionWebSocketClient.observe(completion: completion)
        } else {
            starscreamSocketClient.observe(completion: completion)
        }
    }
    
    func disconnect() {
        if #available(iOS 13.0, *) {
            urlSessionWebSocketClient.disconnect()
        } else {
            starscreamSocketClient.disconnect()
        }
    }
    
}
