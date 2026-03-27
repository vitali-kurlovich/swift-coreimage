//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public struct ColorValueDescription: ValueDescription {
    public typealias Value = CIColor

    public let attribute: FilterAttribute

    public init(attribute: FilterAttribute) {
        assert(attribute.type == .color || attribute.type == .opaqueColor)
        assert(attribute.className == CIColor.className())
        self.attribute = attribute
    }

    public var isOpaque: Bool {
        type == .opaqueColor
    }
}
