//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

struct BoolValueDescription: ValueDescription {
    typealias Value = Bool

    let attribute: FilterAttribute

    init(attribute: FilterAttribute) {
        assert(attribute.type == .boolean)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
