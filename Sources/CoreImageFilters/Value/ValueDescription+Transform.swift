//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage
import Foundation
import MathKit

public extension ValueDescription where Value == Transform {
    var value: Value? {
        get {
            if attribute.className == CIVector.className(), let value = attribute.value as? CIVector {
                return Transform(value)
            }

            #if os(macOS)

                if attribute.className == NSAffineTransform.className(), let transform = attribute.value as? NSAffineTransform {
                    return Transform(transform)
                }
            #endif

            #if os(iOS)
                if attribute.className == NSValue.className(), let value = attribute.value as? NSValue {
                    return Transform(value.cgAffineTransformValue)
                }
            #endif

            return nil
        }

        set {
            if attribute.className == CIVector.className() {
                if let value = newValue {
                    attribute.value = CIVector(value)
                } else {
                    attribute.value = nil
                }
            }

            #if os(macOS)
                if attribute.className == NSAffineTransform.className() {
                    if let value = newValue {
                        attribute.value = NSAffineTransform(value)
                    } else {
                        attribute.value = nil
                    }
                }
            #endif

            #if os(iOS)
                if attribute.className == NSValue.className(), let value = attribute.value as? NSValue {
                    if let value = newValue {
                        attribute.value = NSValue(cgAffineTransform: CGAffineTransform(value))
                    } else {
                        attribute.value = nil
                    }
                }
            #endif
        }
    }

    var `default`: Value? {
        guard let value = attribute[kCIAttributeDefault] else { return nil }

        if attribute.className == CIVector.className(), let vector = value as? CIVector {
            return Transform(vector)
        }

        #if os(macOS)
            if attribute.className == NSAffineTransform.className(), let vector = value as? NSAffineTransform {
                return Transform(vector)
            }
        #endif

        #if os(iOS)
            if attribute.className == NSValue.className(), let value = attribute.value as? NSValue {
                return Transform(value.cgAffineTransformValue)
            }
        #endif

        return nil
    }

    var identity: Value? {
        guard let value = attribute[kCIAttributeIdentity] else { return nil }

        if attribute.className == CIVector.className(), let vector = value as? CIVector {
            return Transform(vector)
        }

        #if os(macOS)
            if attribute.className == NSAffineTransform.className(), let transform = value as? NSAffineTransform {
                return Transform(transform)
            }
        #endif

        #if os(iOS)
            if attribute.className == NSValue.className(), let value = attribute.value as? NSValue {
                return Transform(value.cgAffineTransformValue)
            }
        #endif

        return nil
    }
}
