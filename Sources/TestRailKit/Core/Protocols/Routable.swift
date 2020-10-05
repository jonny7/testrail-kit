import NIO

public protocol Routeable {
    
    /// This generic function provide CRUD functionality for managing resources  in TestRail
    /// - Parameter option: See `ConfigurationRepresentable`
    func action<TM: TestRailModel, C: ConfigurationRepresentable>(configurable: C) throws -> EventLoopFuture<TM>
}
