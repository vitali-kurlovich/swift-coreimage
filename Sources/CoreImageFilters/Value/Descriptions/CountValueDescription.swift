//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

struct CountValueDescription: ValueDescription {
    typealias Value = UInt

    let attribute: FilterAttribute

    init(attribute: FilterAttribute) {
        assert(attribute.type == .count)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
