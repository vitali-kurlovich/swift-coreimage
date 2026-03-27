//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

public struct DistanceValueDescription: ValueDescription {
    public typealias Value = Float

    public let attribute: FilterAttribute

    public init(attribute: FilterAttribute) {
        assert(attribute.type == .distance)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
