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
        let fontSize: CGFloat = bounds.height * 0.12
        let font = NSFont.boldSystemFont(ofSize: fontSize)

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: NSColor.white
        ]

        // Draw "BUY"
        let buyText = NSAttributedString(string: "BUY", attributes: attributes)
        let buySize = buyText.size()
        let buyX = (bounds.width - buySize.width) / 2
        let buyY = (bounds.height / 2) + (buySize.height * 0.6)
        buyText.draw(at: NSPoint(x: buyX, y: buyY))

        // Draw "NOW"
        let nowText = NSAttributedString(string: "NOW", attributes: attributes)
        let nowSize = nowText.size()
        let nowX = (bounds.width - nowSize.width) / 2
        let nowY = (bounds.height / 2) - (nowSize.height * 1.6)
        nowText.draw(at: NSPoint(x: nowX, y: nowY))
    }

    override func animateOneFrame() {
        // Timer handles animation, nothing needed here
        return
    }

    override var hasConfigureSheet: Bool {
        return false
    }
}
