import App
import Vapor

//try app(.detect()).run()

let colors: [String] = [
    "32a852",
    "324aa8",
    "a432a8",
    "a83232",
    "a88e32"
]
var ids: [String] = []

var connections: [WebSocket] = []

// First, create an HTTPProtocolUpgrader
let ws = HTTPServer.webSocketUpgrader(shouldUpgrade: { req in
    // Returning nil in this closure will reject upgrade
    if req.url.path == "/deny" { return nil }
    // Return any additional headers you like, or just empty
    return [:]
}, onUpgrade: { ws, req in
    // This closure will be called with each new WebSocket client
    connections.append(ws)
    ws.send("Connected")
    ws.onText { ws, string in
        print("getting message: \(string)")
        let deviceId = string
        if !ids.contains(deviceId) {
            ids.append(deviceId)
        }
        //        ws.send(string.reversed())
    }
})

// Create an EventLoopGroup with an appropriate number
// of threads for the system we are running on.
let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
// Make sure to shutdown the group when the application exits.
defer { try! group.syncShutdownGracefully() }

let port = 8080

struct EchoResponder: HTTPServerResponder {
    
    /// See `HTTPServerResponder`.
    func respond(to req: HTTPRequest, on worker: Worker) -> Future<HTTPResponse> {
        print("Incoming request: \(req.method) \(req.urlString)")
        // Create an HTTPResponse with the same body as the HTTPRequest
        
        print("socket request")
        if req.urlString == "/socket-test" {
            if !colors.isEmpty && !ids.isEmpty {
                let color = colors.randomElement()!
                let id = ids.randomElement()!
                let data = "{\"id\": \"\(id)\", \"color\": \"\(color)\"}".data(using: .utf8)!
                connections.forEach { $0.send(data) }
            }
        }
        
        let res = HTTPResponse(body: req.body)
        // We don't need to do any async work here, we can just
        // se the Worker's event-loop to create a succeeded future.
        return worker.eventLoop.newSucceededFuture(result: res)
    }
}

// Start an HTTPServer using our EchoResponder
// We are fine to use `wait()` here since we are on the main thread.
let server = try HTTPServer.start(
    hostname: "localhost",
    port: port,
    responder: EchoResponder(),
    upgraders: [ws],
    on: group
).wait()

print("Running server on port \(port)")

// Run the server.
try server.onClose.wait()



