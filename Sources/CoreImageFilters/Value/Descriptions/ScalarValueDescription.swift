//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

public struct ScalarValueDescription: ValueDescription {
    public typealias Value = Float

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .scalar)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
