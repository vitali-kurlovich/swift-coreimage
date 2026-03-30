//
//  Created by Vitali Kurlovich on 30.03.2026.
//

import CoreImage

public struct StringValueDescription: ValueDescription {
    public typealias Value = String

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .custom)
        assert(attribute.className == NSString.className())
        self.attribute = attribute
    }

    public var `default`: Value? {
        if let nsString: NSString = attribute[kCIAttributeDefault] as? NSString {
            return nsString as String
        }
        return nil
    }

    public var value: Value? {
        get {
            assert(attribute.className == NSString.className())
            return (attribute.value as? NSString) as? String
        }

        set {
            assert(attribute.className == NSString.className())

            if let value = newValue {
                attribute.value = value as NSString
            } else {
                attribute.value = nil
            }
        }
    }
}
