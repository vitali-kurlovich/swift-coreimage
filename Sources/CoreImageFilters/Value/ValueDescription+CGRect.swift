//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public extension ValueDescription where Value == CGRect {
    var value: Value? {
        get {
            assert(attribute.className == CIVector.className())

            guard let vector = attribute.value as? CIVector else {
                return nil
            }

            return vector.cgRectValue
        }

        set {
            assert(attribute.className == CIVector.className())

            if let value = newValue {
                attribute.value = CIVector(cgRect: value)
            } else {
                attribute.value = nil
            }
        }
    }

    var `default`: Value {
        guard let value = attribute[kCIAttributeDefault] else { return .zero }

        if attribute.className == CIVector.className() {
            return (value as? CIVector)?.cgRectValue ?? .zero
        }
        #if os(macOS)
            if attribute.className == NSValue.className() {
                if let rect = (value as? NSValue)?.rectValue {
                    return CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
                }
            }
        #endif
        return .zero
    }

    var identity: Value? {
        guard let value = attribute[kCIAttributeIdentity] else { return nil }
        #if os(macOS)
            if attribute.className == NSValue.className() {
                if let rect = (value as? NSValue)?.rectValue {
                    return CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height)
                }
            }

        #endif
        if attribute.className == CIVector.className() {
            return (value as? CIVector)?.cgRectValue
        }

        return nil
    }
}
