//
//  SocketResult.swift
//  WebsocketsApp
//
//  Created by Mohammed Al Waili on 13/08/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation

enum SocketResult {
    case connected
    case disconnected
    case data(Data)
    case text(String)
    case failure(Error)
}
