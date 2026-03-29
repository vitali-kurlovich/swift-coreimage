//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public struct RectValueDescription: ValueDescription {
    public typealias Value = CGRect

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .rectangle)
        assert(attribute.className == CIVector.className() || attribute.className == NSValue.className())
        self.attribute = attribute
    }
}
