//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public extension ValueDescription where Value == CIImage {
    var value: Value? {
        get {
            assert(attribute.className == Value.className())
            return attribute.value as? Value
        }

        set {
            assert(attribute.className == Value.className())
            attribute.value = newValue
        }
    }

    var `default`: Value {
        (attribute[kCIAttributeDefault] as? Value) ?? CIImage.empty()
    }

    var identity: Value? {
        attribute[kCIAttributeDefault] as? Value
    }
}
