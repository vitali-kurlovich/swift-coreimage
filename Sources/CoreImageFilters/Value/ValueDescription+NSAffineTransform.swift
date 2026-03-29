//
//  Created by Vitali Kurlovich on 27.03.2026.
//

#if os(macOS)

    import CoreImage

    public extension ValueDescription where Value == NSAffineTransform {
        var value: Value? {
            get {
                assert(attribute.className == NSAffineTransform.className())
                return attribute.value as? Value
            }

            set {
                assert(attribute.className == NSAffineTransform.className())
                attribute.value = value
            }
        }

        var `default`: Value {
            guard let value = attribute[kCIAttributeDefault] else { return NSAffineTransform(transform: .identity) }

            if attribute.className == NSAffineTransform.className() {
                return (value as? NSAffineTransform) ?? NSAffineTransform(transform: .identity)
            }

            return NSAffineTransform(transform: .identity)
        }

        var identity: Value? {
            attribute[kCIAttributeDefault] as? NSAffineTransform
        }
    }

#endif
