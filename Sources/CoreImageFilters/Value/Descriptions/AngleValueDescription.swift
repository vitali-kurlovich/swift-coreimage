//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import Foundation

public struct AngleValueDescription: ValueDescription {
    public typealias Value = Float

    public let attribute: FilterAttribute

    public init(attribute: FilterAttribute) {
        assert(attribute.type == .angle)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
