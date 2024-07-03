extension String {

    public static let bundleID = "com.pikciu.demo"

    public static func bundleID(_ suffix: String) -> String {
        "\(bundleID).\(suffix)"
    }
}
