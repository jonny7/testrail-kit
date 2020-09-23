import Foundation

public enum TestRailFilterValueBuilder {
  case list([Int])
  case date(Date)
  case integer(Int)
  case string(String)

  var mapping: String {
    switch self {
    case .list(let list):
      return String(list.reduce("") { "\($0),\($1)" }.dropFirst())
    case .date(let date):
      return String(Int(date.timeIntervalSince1970))
    case .integer(let number):
      return String(number)
    case .string(let filter):
      return filter
    }
  }
}
