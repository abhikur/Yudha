import Foundation

func localizedString(_ key: String, table: String) -> String {
    return NSLocalizedString(key, tableName: table, bundle: Bundle.main, value: "", comment: "")
}
