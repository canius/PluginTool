// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "PluginTool",
    platforms: [.iOS(.v13)],
    products: [
        .plugin(name: "PandaString-Update", targets: ["PandaString-Update"]),
        .plugin(name: "SwiftGenPlugin", targets: ["SwiftGenPlugin"]),
    ],
    targets: [
        .plugin(
          name: "PandaString-Update",
          capability: .command(
            intent: .custom(
              verb: "update-code-from-googlesheet",
              description: "Update String from GoogleSheet"
            ),
            permissions: [
              .writeToPackageDirectory(reason: "This command update string tables")
            ]
          ),
          dependencies: ["pandastring"]
        ),
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
        .binaryTarget(
            name: "pandastring",
            url: "https://panda.dev.ff-svc.cn:8888/repository/spm/plugin/pandastring.artifactbundle.zip",
            checksum: "640aa47990cfcb65c413cabf7ba2070b4bd479f6bd022258a44ca57355e83bed"
        ),
    ]
)
