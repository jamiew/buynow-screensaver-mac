import SwiftUI
import ScreenSaver

struct ContentView: View {
    @State private var isInstalled = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isInstalling = false

    private var saverPath: URL {
        FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Screen Savers/BuyNow.saver")
    }

    var body: some View {
        VStack(spacing: 20) {
            // Preview of the screensaver
            PreviewView()
                .frame(width: 400, height: 300)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                )

            Text("BUY NOW")
                .font(.system(size: 32, weight: .bold))

            Text("Classic BeOS screensaver for macOS")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Divider()
                .padding(.vertical, 8)

            if isInstalled {
                VStack(spacing: 12) {
                    Label("Screensaver Installed", systemImage: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.headline)

                    Text("Open System Settings > Screen Saver to enable it")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)

                    Button("Open System Settings") {
                        openScreenSaverSettings()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Uninstall") {
                        uninstallScreensaver()
                    }
                    .buttonStyle(.bordered)
                }
            } else {
                VStack(spacing: 12) {
                    Button(action: installScreensaver) {
                        if isInstalling {
                            ProgressView()
                                .scaleEffect(0.7)
                                .frame(width: 200)
                        } else {
                            Text("Install Screensaver")
                                .frame(width: 200)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isInstalling)

                    Text("Installs to ~/Library/Screen Savers")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            if showError {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }

            Divider()
                .padding(.vertical, 8)

            Link("View on GitHub", destination: URL(string: "https://github.com/yourusername/buy-now")!)
                .font(.caption)
        }
        .padding(30)
        .frame(width: 500)
        .onAppear {
            checkInstallation()
        }
    }

    private func checkInstallation() {
        isInstalled = FileManager.default.fileExists(atPath: saverPath.path)
    }

    private func installScreensaver() {
        isInstalling = true
        showError = false

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try FileManager.default.createDirectory(at: saverPath.deletingLastPathComponent(),
                                                       withIntermediateDirectories: true)

                guard let bundlePath = Bundle.main.path(forResource: "BuyNow", ofType: "saver") else {
                    throw NSError(domain: "BuyNowApp", code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Screensaver bundle not found"])
                }

                if FileManager.default.fileExists(atPath: saverPath.path) {
                    try FileManager.default.removeItem(at: saverPath)
                }

                try FileManager.default.copyItem(at: URL(fileURLWithPath: bundlePath), to: saverPath)

                DispatchQueue.main.async {
                    isInstalled = true
                    isInstalling = false
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Installation failed: \(error.localizedDescription)"
                    showError = true
                    isInstalling = false
                }
            }
        }
    }

    private func uninstallScreensaver() {
        do {
            try FileManager.default.removeItem(at: saverPath)
            isInstalled = false
        } catch {
            errorMessage = "Uninstallation failed: \(error.localizedDescription)"
            showError = true
        }
    }

    private func openScreenSaverSettings() {
        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.screentime")!)
    }
}

// Preview of the screensaver animation
struct PreviewView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        return AnimatedPreview()
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

class AnimatedPreview: NSView {
    private var isTextVisible = true
    private var timer: Timer?
    private let backgroundColor = NSColor(red: 0.0, green: 0.0, blue: 0.545, alpha: 1.0)

    override init(frame: NSRect) {
        super.init(frame: frame)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.isTextVisible.toggle()
            self?.needsDisplay = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    deinit {
        timer?.invalidate()
    }

    override func draw(_ dirtyRect: NSRect) {
        backgroundColor.setFill()
        bounds.fill()

        guard isTextVisible else { return }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.boldSystemFont(ofSize: bounds.height * 0.15),
            .foregroundColor: NSColor.white
        ]

        func drawCentered(_ text: String, yOffset: CGFloat) {
            let attributed = NSAttributedString(string: text, attributes: attributes)
            let size = attributed.size()
            attributed.draw(at: NSPoint(x: (bounds.width - size.width) / 2, y: yOffset))
        }

        drawCentered("BUY", yOffset: bounds.height / 2 + (bounds.height * 0.09))
        drawCentered("NOW", yOffset: bounds.height / 2 - (bounds.height * 0.24))
    }
}
