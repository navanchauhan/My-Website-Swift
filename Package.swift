// swift-tools-version:5.1
// Update with ReadTimePublishPlugin
import PackageDescription

let package = Package(
    name: "MyWebsite",
    products: [
        .executable(name: "MyWebsite", targets: ["MyWebsite"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.4.0"),
        .package(url: "https://github.com/artrmz/ReadTimePublishPlugin", from: "0.1.0"),
        .package(url: "https://github.com/navanchauhan/SwiftPygmentsPublishPlugin", .branch("master")),
    ],
    targets: [
        .target(
            name: "MyWebsite",
            dependencies: ["Publish","ReadTimePublishPlugin","SwiftPygmentsPublishPlugin"]
        )
    ]
)
