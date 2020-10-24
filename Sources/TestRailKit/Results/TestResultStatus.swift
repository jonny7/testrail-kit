public enum TestResultStatus: Int {
    case passed = 1
    case blocked = 2
    case untested = 3
    case retest = 4
    case failed = 5
}

extension TestResultStatus: Codable {}
