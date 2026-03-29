//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public struct TransformValueDescription: ValueDescription {
    #if os(macOS)
        public typealias Value = NSAffineTransform
    #endif

    #if os(iOS)
        public typealias Value = CGAffineTransform
    #endif

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .transform)
        #if os(macOS)
            assert(attribute.className == NSAffineTransform.className())
        #endif

        #if os(iOS)
            assert(attribute.className == NSValue.className() || attribute.className == CIVector.className())
        #endif

        self.attribute = attribute
    }
}
