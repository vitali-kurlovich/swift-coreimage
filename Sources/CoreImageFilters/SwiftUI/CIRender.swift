//
//  CIRender.swift
//  swift-coreimage
//
//  Created by Vitali Kurlovich on 31.03.2026.
//

import Metal
import MetalKit

protocol CIRenderDelegate {
    func transform(for render: CIRender) -> CIImage
    func image(for render: CIRender) -> CIImage
}

private let maxBuffersInFlight = 3

class CIRender: NSObject {
    let device: MTLDevice
    let context: CIContext

    let commandQueue: MTLCommandQueue
    let configuration: CIRenderConfiguration

    let inFlightSemaphore = DispatchSemaphore(value: maxBuffersInFlight)

    var transform: Transform = .identity

    init(device: MTLDevice, configuration: CIRenderConfiguration) throws {
        self.device = device
        self.configuration = configuration

        guard let queue = device.makeCommandQueue() else {
            throw NSError()
        }

        commandQueue = queue

        context = CIContext(mtlCommandQueue: queue, options: configuration.options)
    }
}

struct CIRenderConfiguration {
    var name: String
    var cacheIntermediates: Bool = false
    var allowLowPower: Bool = true
}

extension CIRenderConfiguration {
    var options: [CIContextOption: Any] {
        [
            .name: name,
            .cacheIntermediates: cacheIntermediates,
            .allowLowPower: allowLowPower,
        ]
    }
}

extension CIRender: MTKViewDelegate {
    func draw(in view: MTKView) {
        let result = inFlightSemaphore.wait(timeout: DispatchTime.distantFuture)

        guard let commandBuffer = commandQueue.makeCommandBuffer() else { return }

        let semaphore = inFlightSemaphore
        commandBuffer.addCompletedHandler { (_ commandBuffer) in
            semaphore.signal()
        }

        guard let drawable = view.currentDrawable else { return }

        let drawableSize = view.drawableSize

        let contentScaleFactor: CGFloat // = 1.0

        #if os(macOS)
            // Determine the scale factor converting a point size to a pixel size.
            contentScaleFactor = view.convertToBacking(CGSize(width: 1.0, height: 1.0)).width
        #else
            contentScaleFactor = view.contentScaleFactor
        #endif
        // Create a destination the Core Image context uses to render to the drawable's Metal texture.
        let destination = CIRenderDestination(width: Int(drawableSize.width),
                                              height: Int(drawableSize.height),
                                              pixelFormat: view.colorPixelFormat,
                                              commandBuffer: commandBuffer,
                                              mtlTextureProvider: { () -> MTLTexture in
                                                  // Core Image calls the texture provider block lazily when starting a task to render to the destination.
                                                  return drawable.texture
                                              })
    }

    func mtkView(_: MTKView, drawableSizeWillChange _: CGSize) {}
}
