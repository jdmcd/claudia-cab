import FluentMySQL
import Vapor

/// A single entry of a Todo list.
final class CABEvent: MySQLModel, Content {
    var id: Int?
    
    var title: String
    var description: String
    var dateString: String
    var eventType: Int
    
    init (title: String, description: String, dateString: String, eventType: EventType) {
        self.title = title
        self.description = description
        self.dateString = dateString
        self.eventType = eventType.rawValue
    }

    enum EventType: Int {
        case typeOne
        case typeTwo
        case typeThree
    }
}

/// Allows `Todo` to be used as a dynamic migration.
extension CABEvent: Migration { }
extension CABEvent: Parameter { }
