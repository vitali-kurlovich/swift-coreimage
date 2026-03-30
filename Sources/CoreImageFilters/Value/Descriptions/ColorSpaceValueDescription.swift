//
//  Created by Vitali Kurlovich on 30.03.2026.
//

import CoreImage

public struct ColorSpaceValueDescription: ValueDescription {
    public typealias Value = CGColorSpace

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .custom)
        assert(attribute.key == "inputColorSpace")
        assert(attribute.className == NSObject.className())
        self.attribute = attribute
    }

    public var `default`: Value? {
        guard let value = attribute[kCIAttributeDefault] else { return nil }
        return (value as! CGColorSpace)
    }

    public var value: Value? {
        get {
            assert(attribute.className == NSObject.className())

            guard let value = attribute.value else { return nil }

            return (value as! CGColorSpace)
        }

        set {
            assert(attribute.className == NSObject.className())

            attribute.value = newValue
        }
    }
}
