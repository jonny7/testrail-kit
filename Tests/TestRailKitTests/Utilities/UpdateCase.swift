@testable import TestRailKit

public class UpdatedCase: UpdatedTestRailCase {
    public var property_id: Int
    
    private enum CodingKeys: CodingKey {
        case property_id
    }

    init(propertyId: Int) {
        self.property_id = propertyId
        super.init()
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.property_id = try container.decode(Int.self, forKey: .property_id)
        try super.init(from: decoder)
    }
}
