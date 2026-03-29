//
//  Created by Vitali Kurlovich on 29.03.2026.
//

import Combine

public final class FilterInputAttribute: FilterAttribute {
    public let objectWillChange = ObservableObjectPublisher()
}

extension FilterInputAttribute: ObservableObject {}

extension FilterInputAttribute {
    var value: Any? {
        get {
            filter.value(forKey: key)
        }

        set {
            objectWillChange.send()
            filter.setValue(newValue, forKey: key)
        }
    }
}
