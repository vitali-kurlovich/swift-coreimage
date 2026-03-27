//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

public struct BoolValueDescription: ValueDescription {
    public typealias Value = Bool

    public let attribute: FilterAttribute

    public init(attribute: FilterAttribute) {
        assert(attribute.type == .boolean)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
