//
//  Created by Vitali Kurlovich on 27.03.2026.
//

#if os(iOS)

    import CoreImage

    extension ValueDescription where Value == CGAffineTransform {
        var value: Value? {
            get {
                assert(attribute.className == CIVector.className())
                return (attribute.value as? CIVector)?.cgAffineTransformValue
            }

            set {
                assert(attribute.className == CIVector.className())

                if let value = newValue {
                    attribute.value = CIVector(cgAffineTransform: value)
                } else {
                    attribute.value = nil
                }
            }
        }

        var `default`: Value {
            guard let value = attribute[kCIAttributeDefault] else { return .identity }

            if attribute.className == CIVector.className() {
                return (value as? CIVector)?.cgAffineTransformValue ?? .identity
            }

            return .identity
        }

        var identity: Value? {
            guard let value = attribute[kCIAttributeDefault] else { return nil }

            if attribute.className == CIVector.className() {
                return (value as? CIVector)?.cgAffineTransformValue
            }

            return nil
        }
    }

#endif
