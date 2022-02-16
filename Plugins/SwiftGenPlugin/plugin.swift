import PackagePlugin
import Foundation

@main struct SwiftGenPlugin: BuildToolPlugin {

    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) throws -> [PackagePlugin.Command] {
        let output = context.pluginWorkDirectory.appending("GeneratedSources")
        try FileManager.default.createDirectory(at: URL(fileURLWithPath: output.string, isDirectory: true), withIntermediateDirectories: true)
        return [.prebuildCommand(
            displayName: "Running SwiftGen",
            executable: try context.tool(named: "swiftgen").path,
            arguments: [
                "config", "run",
                "--config", "\(context.package.directory.appending("swiftgen.yml"))"
            ],
            environment: [
                "INPUT_DIR": target.directory.appending("Resources").string,
                "OUTPUT_DIR": output.string
            ],
            outputFilesDirectory: output)]
    }
}
