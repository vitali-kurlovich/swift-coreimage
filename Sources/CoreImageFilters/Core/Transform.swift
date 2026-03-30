//
//  Created by Vitali Kurlovich on 30.03.2026.
//

import CoreImage
import MathKit

public typealias Transform = MKAffineTransform<Float>

#if os(iOS)
    public extension CGAffineTransform {
        init(m11: CGFloat, m12: CGFloat, m21: CGFloat, m22: CGFloat, tX: CGFloat, tY: CGFloat) {
            self.init(m11, m12, m21, m22, tX, tY)
        }

        init(_ tr: Transform) {
            self.init(m11: CGFloat(tr.m11),
                      m12: CGFloat(tr.m12),
                      m21: CGFloat(tr.m21),
                      m22: CGFloat(tr.m22),
                      tX: CGFloat(tr.tx),
                      tY: CGFloat(tr.ty))
        }
    }

    public extension Transform {
        init(_ tr: CGAffineTransform) {
            self.init(m11: Float(tr.a),
                      m12: Float(tr.b),
                      m21: Float(tr.c),
                      m22: Float(tr.d),
                      tx: Float(tr.tx),
                      ty: Float(tr.ty))
        }
    }

#endif

#if os(macOS)
    public extension AffineTransform {
        init(_ tr: Transform) {
            self.init(m11: CGFloat(tr.m11),
                      m12: CGFloat(tr.m12),
                      m21: CGFloat(tr.m21),
                      m22: CGFloat(tr.m22),
                      tX: CGFloat(tr.tx),
                      tY: CGFloat(tr.ty))
        }
    }

    public extension Transform {
        init(_ tr: NSAffineTransform) {
            let src = tr.transformStruct
            self.init(m11: Float(src.m11),
                      m12: Float(src.m12),
                      m21: Float(src.m21),
                      m22: Float(src.m22),
                      tx: Float(src.tX),
                      ty: Float(src.tY))
        }
    }

    public extension NSAffineTransform {
        convenience init(_ tr: Transform) {
            let affine = AffineTransform(tr)
            self.init(transform: affine)
        }
    }

#endif

public extension CIVector {
    convenience init(_ tr: Transform) {
        self.init(values: [CGFloat(tr.m11), CGFloat(tr.m12), CGFloat(tr.m21), CGFloat(tr.m22), CGFloat(tr.tx), CGFloat(tr.ty)], count: 6)
    }
}

public extension Transform {
    init(_ vector: CIVector) {
        assert(vector.count == 6)
        self.init(m11: Float(vector.value(at: 0)),
                  m12: Float(vector.value(at: 1)),
                  m21: Float(vector.value(at: 2)),
                  m22: Float(vector.value(at: 3)),
                  tx: Float(vector.value(at: 4)),
                  ty: Float(vector.value(at: 5)))
    }
}
