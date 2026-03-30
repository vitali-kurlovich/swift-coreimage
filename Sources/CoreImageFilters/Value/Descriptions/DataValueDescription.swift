//
//  Created by Vitali Kurlovich on 30.03.2026.
//

import CoreImage

public struct DataValueDescription: ValueDescription {
    public typealias Value = Data

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .custom)
        assert(attribute.className == NSData.className())
        self.attribute = attribute
    }

    public var `default`: Value? {
        if let nsData: NSData = attribute[kCIAttributeDefault] as? NSData {
            return nsData as Data
        }
        return nil
    }

    public var value: Value? {
        get {
            assert(attribute.className == NSData.className())
            return (attribute.value as? NSData) as? Data
        }

        set {
            assert(attribute.className == NSData.className())

            if let value = newValue {
                attribute.value = value as NSData
            } else {
                attribute.value = nil
            }
        }
    }
}
