import ScreenSaver
import Cocoa

class BuyNowView: ScreenSaverView {
    private var isTextVisible = true
    private var timer: Timer?

    // Dark blue matching BeOS original
    private let backgroundColor = NSColor(red: 0.0, green: 0.0, blue: 0.545, alpha: 1.0) // #00008B

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        setupTimer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTimer()
    }

    deinit {
        timer?.invalidate()
    }

    private func setupTimer() {
        // Flash every second
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.isTextVisible.toggle()
            self?.setNeedsDisplay(self?.bounds ?? .zero)
        }
    }

    override func draw(_ rect: NSRect) {
        // Dark blue background
        backgroundColor.setFill()
        rect.fill()

        // Draw white "BUY NOW" text if visible
        if isTextVisible {
            drawText()
        }
    }

    private func drawText() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.boldSystemFont(ofSize: bounds.height * 0.12),
            .foregroundColor: NSColor.white
        ]

        func drawCentered(_ text: String, yOffset: CGFloat) {
            let attributed = NSAttributedString(string: text, attributes: attributes)
            let size = attributed.size()
            attributed.draw(at: NSPoint(x: (bounds.width - size.width) / 2, y: yOffset))
        }

        drawCentered("BUY", yOffset: bounds.height / 2 + (bounds.height * 0.072))
        drawCentered("NOW", yOffset: bounds.height / 2 - (bounds.height * 0.192))
    }

    override var hasConfigureSheet: Bool {
        false
    }
}
