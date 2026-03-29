//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

public struct ImageValueDescription: ValueDescription {
    public typealias Value = CIImage

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .image)
        assert(attribute.className == CIImage.className())
        self.attribute = attribute
    }
}
