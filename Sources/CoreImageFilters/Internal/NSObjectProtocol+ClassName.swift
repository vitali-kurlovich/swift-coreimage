//
//  Created by Vitali Kurlovich on 27.03.2026.
//

#if os(iOS)

    import ObjectiveC

    extension NSObjectProtocol {
        static func className() -> String {
            String(describing: Self.self)
        }
    }
#endif
