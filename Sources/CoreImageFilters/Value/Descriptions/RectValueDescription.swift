//
//  Created by Vitali Kurlovich on 27.03.2026.
//

import CoreImage

struct RectValueDescription: ValueDescription {
    typealias Value = CGRect

    let attribute: FilterAttribute

    init(attribute: FilterAttribute) {
        assert(attribute.type == .rectangle)
        assert(attribute.className == CIVector.className() || attribute.className == NSValue.className())
        self.attribute = attribute
    }
}
