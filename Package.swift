// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Apollo",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
    .visionOS(.v1)
  ],
  products: [
    .library(name: "Apollo", targets: ["Apollo"]),
    .library(name: "ApolloAPI", targets: ["ApolloAPI"]),
    .library(name: "Apollo-Dynamic", type: .dynamic, targets: ["Apollo"]),
    .library(name: "ApolloSQLite", targets: ["ApolloSQLite"]),
    .library(name: "ApolloWebSocket", targets: ["ApolloWebSocket"]),
    .library(name: "ApolloTestSupport", targets: ["ApolloTestSupport"]),
    .plugin(name: "InstallCLI", targets: ["Install CLI"])
  ],
  dependencies: [
    .package(
        url: "https://github.com/svetrancicik/SQLite.swift.git",
        branch: "master"
    ),
  ],
  targets: [
    .target(
      name: "Apollo",
      dependencies: [
        "ApolloAPI"
      ]
    ),
    .target(
      name: "ApolloAPI",
      dependencies: []
    ),
    .target(
      name: "ApolloSQLite",
      dependencies: [
        "Apollo",
        .product(name: "SQLite", package: "SQLite.swift"),
      ]
    ),
    .target(
      name: "ApolloWebSocket",
      dependencies: [
        "Apollo"
      ]
    ),
    .target(
      name: "ApolloTestSupport",
      dependencies: [
        "Apollo",
        "ApolloAPI"
      ]
    ),
    .plugin(
      name: "Install CLI",
      capability: .command(
        intent: .custom(
          verb: "apollo-cli-install",
          description: "Installs the Apollo iOS Command line interface."),
        permissions: [
          .writeToPackageDirectory(reason: "Creates a symbolic link to the CLI executable in your project directory."),
        ]),
      dependencies: [],
      path: "Plugins/InstallCLI"
    )
  ]
)
