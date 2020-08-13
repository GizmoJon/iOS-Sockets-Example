//
//  SocketClient.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 13/08/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

protocol SocketClient {
    
    init(with baseURL: URL)
    
    func connect()
    func write(text: String)
    func write(data: Data)
    func observe(completion: @escaping (SocketResult) -> Void)
    func disconnect()
}
