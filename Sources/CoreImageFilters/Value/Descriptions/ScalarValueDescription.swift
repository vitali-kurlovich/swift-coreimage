//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import Foundation

struct ScalarValueDescription: ValueDescription {
    typealias Value = Float

    let attribute: FilterAttribute

    init(attribute: FilterAttribute) {
        assert(attribute.type == .scalar)
        assert(attribute.className == NSNumber.className())
        self.attribute = attribute
    }
}
