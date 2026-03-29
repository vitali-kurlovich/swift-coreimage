//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public struct PositionValueDescription: ValueDescription {
    public typealias Value = CGPoint

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .position)
        assert(attribute.className == CIVector.className())
        self.attribute = attribute
    }
}

//
