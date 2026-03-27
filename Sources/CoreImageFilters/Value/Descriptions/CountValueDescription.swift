//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

public struct CountValueDescription: ValueDescription {
    public typealias Value = UInt

    public let attribute: FilterAttribute

    public init(attribute: FilterAttribute) {
        assert(attribute.type == .count)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
