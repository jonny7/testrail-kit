import NIO

public protocol Routeable {
    
    /// This generic function provide CRUD functionality for managing resources  in TestRail
    /// - Parameter option: See `ConfigurationRepresentable`
    func action<C, TP, TM>(resource: C, body: TP) throws -> EventLoopFuture<TM> where C: ConfigurationRepresentable, TP: TestRailPostable, TM: TestRailModel
    
    func action<C, TM>(resource: C) throws -> EventLoopFuture<TM> where C: ConfigurationRepresentable, TM: TestRailModel
}
