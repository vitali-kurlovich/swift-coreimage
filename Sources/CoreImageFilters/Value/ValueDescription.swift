//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import CoreImage

public protocol ValueDescription {
    associatedtype Value

    var attribute: FilterInputAttribute { get }

    var `default`: Value { get }

    var value: Value? { get set }
}

public extension ValueDescription {
    var key: String {
        attribute.key
    }

    var type: FilterAttributeType {
        attribute.type
    }

    var displayName: String {
        attribute.displayName
    }

    var localizedDescription: String {
        attribute.localizedDescription
    }
}

public extension ValueDescription {
    func setDefault() {
        attribute.filter.setValue(attribute[kCIAttributeDefault], forKey: key)
    }
}

public extension ValueDescription where Value == Float {
    var value: Value? {
        get {
            assert(attribute.className == NSNumber.className())
            return (attribute.value as? NSNumber)?.floatValue
        }

        set {
            assert(attribute.className == NSNumber.className())

            if let value = newValue {
                attribute.value = NSNumber(value: value)
            } else {
                attribute.value = nil
            }
        }
    }

    var `default`: Value {
        (attribute[kCIAttributeDefault] as? NSNumber)?.floatValue ?? 0
    }

    var identity: Value? {
        (attribute[kCIAttributeIdentity] as? NSNumber)?.floatValue
    }

    var min: Value? {
        (attribute[kCIAttributeMin] as? NSNumber)?.floatValue
    }

    var max: Value? {
        (attribute[kCIAttributeMax] as? NSNumber)?.floatValue
    }

    var range: ClosedRange<Value>? {
        guard let min, let max else {
            return nil
        }
        return min ... max
    }

    var slider: ClosedRange<Value>? {
        guard let sliderMin = (attribute[kCIAttributeSliderMin] as? NSNumber)?.floatValue,
              let sliderMax = (attribute[kCIAttributeSliderMax] as? NSNumber)?.floatValue
        else {
            return nil
        }

        return sliderMin ... sliderMax
    }
}

public extension ValueDescription where Value == Int {
    var value: Value? {
        get {
            assert(attribute.className == NSNumber.className())
            return (attribute.value as? NSNumber)?.intValue
        }

        set {
            assert(attribute.className == NSNumber.className())

            if let value = newValue {
                attribute.value = NSNumber(value: value)
            } else {
                attribute.value = nil
            }
        }
    }

    var `default`: Value {
        (attribute[kCIAttributeDefault] as? NSNumber)?.intValue ?? 0
    }

    var identity: Value? {
        (attribute[kCIAttributeIdentity] as? NSNumber)?.intValue
    }

    var min: Value? {
        (attribute[kCIAttributeMin] as? NSNumber)?.intValue
    }

    var max: Value? {
        (attribute[kCIAttributeMax] as? NSNumber)?.intValue
    }

    var range: ClosedRange<Value>? {
        guard let min, let max else {
            return nil
        }
        return min ... max
    }

    var slider: ClosedRange<Value>? {
        guard let sliderMin = (attribute[kCIAttributeSliderMin] as? NSNumber)?.intValue,
              let sliderMax = (attribute[kCIAttributeSliderMax] as? NSNumber)?.intValue
        else {
            return nil
        }

        return sliderMin ... sliderMax
    }
}

public extension ValueDescription where Value == UInt {
    var value: Value? {
        get {
            assert(attribute.className == NSNumber.className())
            return (attribute.value as? NSNumber)?.uintValue
        }

        set {
            assert(attribute.className == NSNumber.className())

            if let value = newValue {
                attribute.value = NSNumber(value: value)
            } else {
                attribute.value = nil
            }
        }
    }

    var `default`: Value {
        (attribute[kCIAttributeDefault] as? NSNumber)?.uintValue ?? 0
    }

    var identity: Value? {
        (attribute[kCIAttributeIdentity] as? NSNumber)?.uintValue
    }

    var min: Value? {
        (attribute[kCIAttributeMin] as? NSNumber)?.uintValue
    }

    var max: Value? {
        (attribute[kCIAttributeMax] as? NSNumber)?.uintValue
    }

    var range: ClosedRange<Value>? {
        guard let min, let max else {
            return nil
        }
        return min ... max
    }

    var slider: ClosedRange<Value>? {
        guard let sliderMin = (attribute[kCIAttributeSliderMin] as? NSNumber)?.uintValue,
              let sliderMax = (attribute[kCIAttributeSliderMax] as? NSNumber)?.uintValue
        else {
            return nil
        }

        return sliderMin ... sliderMax
    }
}

public extension ValueDescription where Value == Bool {
    var value: Value? {
        get {
            assert(attribute.className == NSNumber.className())
            return (attribute.value as? NSNumber)?.boolValue
        }

        set {
            assert(attribute.className == NSNumber.className())

            if let value = newValue {
                attribute.value = NSNumber(value: value)
            } else {
                attribute.value = nil
            }
        }
    }

    var `default`: Value {
        (attribute[kCIAttributeDefault] as? NSNumber)?.boolValue ?? false
    }

    var identity: Value? {
        (attribute[kCIAttributeIdentity] as? NSNumber)?.boolValue
    }
}
