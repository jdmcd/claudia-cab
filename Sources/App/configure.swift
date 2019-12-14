import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    guard let url = Environment.get("DATABASE_URL") else { throw Abort(.internalServerError) }
    guard let mysql = try MySQLDatabaseConfig(url: url) else { throw Abort(.internalServerError) }
    let db = MySQLDatabase(config: mysql)
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: db, as: .mysql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: CABEvent.self, database: .mysql)
    services.register(migrations)
}
