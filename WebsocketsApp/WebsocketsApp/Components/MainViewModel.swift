//
//  MainViewModel.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 13/08/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

struct ColorSocketData: Decodable {
    let id: String
    let color: String
}

class MainViewModel {
    
    private let engine: SocketEngine
    private var deviceID: String?
    
    var colorReceivedHandler: ((UIColor) -> Void)?
    
    init(with engine: SocketEngine) {
        self.engine = engine
    }
    
    func connectToSocket() {
        self.engine.observe { [weak self] result in
            self?.observeSocketResult(result)
        }
        self.engine.connect()
    }
    
    private func observeSocketResult(_ result: SocketResult) {
        switch result {
        case .connected:
            guard let id = deviceID else { return }
            engine.write(text: id)
        case.disconnected:
            break
        case .text:
            break
        case .data(let data):
            parseData(data)
        case .failure:
            break
        }
    }
    
    func registerDeviceId(_ id: String) {
        deviceID = id
    }
    
    private func parseData(_ data: Data) {
        guard
            let id = deviceID,
            let socketData = try? JSONDecoder()
                .decode(ColorSocketData.self, from: data) else {
            print("could not decode")
            return
        }
        
        print("ID Received: \(socketData.id)")
        print("Color Received: \(socketData.color)")

        if socketData.id == id {
            colorReceivedHandler?(UIColor(hexString: socketData.color))
        }
    }
    
}
