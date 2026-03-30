//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public struct TransformValueDescription: ValueDescription {
    public typealias Value = Transform

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .transform)
        #if os(macOS)
            assert(attribute.className == NSAffineTransform.className() || attribute.className == CIVector.className())
        #endif

        #if os(iOS)
            assert(attribute.className == NSValue.className() || attribute.className == CIVector.className())
        #endif

        self.attribute = attribute
    }
}
