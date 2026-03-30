//
//  Created by Vitali Kurlovich on 30.03.2026.
//

import class CoreML.MLModel

public struct MLModelValueDescription: ValueDescription {
    public typealias Value = MLModel

    public let attribute: FilterInputAttribute

    public init(attribute: FilterInputAttribute) {
        assert(attribute.type == .custom)
        assert(attribute.className == MLModel.className())
        self.attribute = attribute
    }

    public var value: Value? {
        get {
            assert(attribute.className == MLModel.className())
            return (attribute.value as? MLModel)
        }

        set {
            assert(attribute.className == MLModel.className())

            attribute.value = newValue
        }
    }
}
