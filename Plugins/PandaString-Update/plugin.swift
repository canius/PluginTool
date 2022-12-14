import Foundation
import PackagePlugin

@main
struct PandaStringPlugin: CommandPlugin {
  func performCommand(context: PluginContext, arguments: [String]) async throws {
    let pandastring = try context.tool(named: "pandastring")
      let output = context.package.directory.appending("Localizable.strings")
      if fileManager.fileExists(atPath: configuration.string) {
          try pandastring.run(output, environment: env(context: context))
      }
  }
}

private extension PandaStringPlugin {

  func env(context: PluginContext, target: SourceModuleTarget? = nil) -> [String: String] {
    [
      "PROJECT_DIR": context.package.directory.string,
      "TARGET_NAME": target?.name ?? "",
      "PRODUCT_MODULE_NAME": target?.moduleName ?? ""
    ]
  }
}

private extension PluginContext.Tool {

  func run(_ output: Path, environment: [String: String]) throws {
    try run(
      arguments: [
        "-tab",
        "Panda",
        "-output",
        output.string,
        "-platform",
        "ios",
      ],
      environment: environment
    )
  }

  /// Invoke the tool with given list of arguments
  func run(arguments: [String], environment: [String: String]) throws {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: path.string)
    task.arguments = arguments
    task.environment = environment

    try task.run()
    task.waitUntilExit()

    // Check whether the subprocess invocation was successful.
    if task.terminationReason == .exit && task.terminationStatus == 0 {
      // do something?
    } else {
      let problem = "\(task.terminationReason):\(task.terminationStatus)"
      Diagnostics.error("\(name) invocation failed: \(problem)")
    }
  }
}

//@main
//struct PandaStringPlugin: CommandPlugin {
//  func performCommand(context: PluginContext, arguments: [String]) async throws {
//    let pandastring = try context.tool(named: "pandastring")
//    let fileManager = FileManager.default
//
//    // if user provided arguments, use those
//    if !arguments.isEmpty {
//      try swiftgen.run(arguments: arguments, environment: env(context: context))
//    } else {
//      // otherwise scan for configs
//      let configuration = context.package.directory.appending("swiftgen.yml")
//      if fileManager.fileExists(atPath: configuration.string) {
//        try swiftgen.run(configuration, environment: env(context: context))
//      }
//
//      // check each target
//      let targets = context.package.targets.compactMap { $0 as? SourceModuleTarget }
//      for target in targets {
//        let configuration = target.directory.appending("swiftgen.yml")
//        if fileManager.fileExists(atPath: configuration.string) {
//          try swiftgen.run(configuration, environment: env(context: context, target: target))
//        }
//      }
//    }
//  }
//}
