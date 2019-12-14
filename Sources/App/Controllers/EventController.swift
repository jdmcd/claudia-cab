import Vapor

final class TodoController: RouteCollection {
    func boot(router: Router) throws {
        router.get("/api/v1/events", use: index)
        router.get("/api/v1/events", CABEvent.parameter, use: getSingleEvent)
    }
    
    func index(_ req: Request) throws -> Future<[CABEvent]> {
        return CABEvent.query(on: req).all()
    }

    func getSingleEvent(req: Request) throws -> Future<CABEvent> {
        return try req.parameters.next(CABEvent.self)
    }
}
