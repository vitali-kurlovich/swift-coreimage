//
//  Created by Vitali Kurlovich on 26.03.2026.
//

import Foundation

struct AngleValueDescription: ValueDescription {
    typealias Value = Float

    let attribute: FilterAttribute

    init(attribute: FilterAttribute) {
        assert(attribute.type == .angle)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
