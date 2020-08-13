import Vapor
import WebSocket

final class SocketController {
    
    func index(_ req: Request) throws -> [String] {
        return [""]
    }
    
    func create(_ req: Request) throws -> String {
        return ""
    }
    
    func register(_ req: Request) throws -> String {
        let id = try req.parameters.next(Int.self)
        return "Registering id: \(id)"
    }
    
}
