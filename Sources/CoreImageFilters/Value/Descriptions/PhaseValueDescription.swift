//
//  Created by Vitali Kurlovich on 29.03.2026.
//

import Foundation

public struct PhaseValueDescription: ValueDescription {
    public typealias Value = Float

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .phase)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
