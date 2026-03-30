//
//  Created by Vitali Kurlovich on 30.03.2026.
//

import CoreImage

public struct OffsetValueDescription: ValueDescription {
    public typealias Value = CGPoint

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .offset)
        #if os(macOS)
            assert(attribute.className == CIVector.className() || attribute.className == NSValue.className())
        #endif

        #if os(iOS)
            assert(attribute.className == CIVector.className())
        #endif
        self.attribute = attribute
    }
}
