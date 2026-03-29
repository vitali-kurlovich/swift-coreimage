//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

public struct IntValueDescription: ValueDescription {
    public typealias Value = Int

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .integer)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
