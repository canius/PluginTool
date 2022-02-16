// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "PluginTool",
    platforms: [.iOS(.v13)],
    products: [
        .plugin(name: "SwiftGenPlugin", targets: ["SwiftGenPlugin"])
    ],
    targets: [
            .plugin(
                name: "SwiftGenPlugin",
                capability: .buildTool(),
                dependencies: ["swiftgen"]
            ),
            
        .binaryTarget(
            name: "swiftgen",
            url: "https://github.com/canius/PluginTool/releases/download/1.0.0/swiftgen.artifactbundle.zip",
            checksum: "fe9496382f6b7656dc9ada954a2e3cd0ae02ea4d0ecb94bda57a3773b5ade392"
        ),
    ]
)
