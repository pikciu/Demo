import ProjectDescription

extension Settings {
    
    public static var frameworkSettings: Settings {
        .settings(
            base: ["GENERATE_INFOPLIST_FILE" : "YES"],
            configurations: [
                .debug(name: "Debug", xcconfig: "../Config.xcconfig"),
                .release(name: "Release", xcconfig: "../Config.xcconfig"),
            ]
        )
    }
}
