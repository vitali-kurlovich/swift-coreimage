//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public extension ValueDescription where Value == CGPoint {
    var value: Value? {
        get {
            #if os(macOS)
                assert(attribute.className == CIVector.className() || attribute.className == NSValue.className())

                if attribute.className == NSValue.className(), let nsValue = (value as? NSValue) {
                    let point = nsValue.pointValue
                    return CGPoint(x: point.x, y: point.y)
                }

            #endif

            #if os(iOS)
                assert(attribute.className == CIVector.className())
            #endif

            guard let vector = attribute.value as? CIVector else {
                return nil
            }

            return vector.cgPointValue
        }

        set {
            guard let value = newValue else {
                attribute.value = nil
                return
            }

            #if os(macOS)
                assert(attribute.className == CIVector.className() || attribute.className == NSValue.className())

                if attribute.className == NSValue.className() {
                    attribute.value = NSValue(point: .init(x: value.x, y: value.y))
                }
            #endif
            #if os(iOS)
                assert(attribute.className == CIVector.className())
            #endif
            if attribute.className == CIVector.className() {
                attribute.value = CIVector(cgPoint: value)
            }
        }
    }

    var `default`: Value {
        guard let value = attribute[kCIAttributeDefault] else { return .zero }
        #if os(macOS)
            if attribute.className == NSValue.className(), let nsValue = (value as? NSValue) {
                let point = nsValue.pointValue
                return CGPoint(x: point.x, y: point.y)
            }
        #endif
        if attribute.className == CIVector.className(), let vector = (value as? CIVector) {
            return vector.cgPointValue
        }

        return .zero
    }

    var identity: Value? {
        (attribute[kCIAttributeIdentity] as? CIVector)?.cgPointValue
    }
}
