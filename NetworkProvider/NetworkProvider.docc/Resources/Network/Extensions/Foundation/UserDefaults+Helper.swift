//
//  UserDefaults+Helper.swift
//
//
//  Created by Çağrı Yörükoğlu on 15.11.2024.
//

import Foundation

extension UserDefaults {

    // MARK: - Keys

    private struct Keys {
        static let activeUrl: String = "activeUrl"
        static let activeBackend: String = "activeBackend"
    }

    // MARK: - Default Preferences

    public class func registerDefaultPreferences() {
        standard.register(defaults: defaultPreferences())
        standard.synchronize()
    }

    public class func resetToDefaultPreferences() {
        standard.setValuesForKeys(defaultPreferences())
        standard.synchronize()
    }

    private class func defaultPreferences() -> [String: AnyObject] {
        guard let defaultPList: String = Bundle.main.path(forResource: "Defaults", ofType: "plist"),
            let defaultPreferences: [String: AnyObject] = NSDictionary(contentsOfFile: defaultPList) as? [String: AnyObject] else {
            Logger.error("Unable to find Defaults.plist.")
            return [:]
        }
        return defaultPreferences
    }

    // MARK: - Backend URLs

    public class var activeUrl: String {
        get {
            guard let url: String = standard.string(forKey: UserDefaults.Keys.activeUrl) else {
                let defaultValue: String = "private-d3ae2-n11case.apiary-mock.com"

                standard.set(defaultValue, forKey: UserDefaults.Keys.activeUrl)
                standard.synchronize()
                return defaultValue
            }
            return url
        }
        set {
            standard.set(newValue, forKey: UserDefaults.Keys.activeUrl)
            standard.synchronize()
        }
    }

    // MARK: - Active Backend

    public class var activeBackend: String {
        get {
            guard let environment: String = standard.string(forKey: UserDefaults.Keys.activeBackend) else {
                let defaultValue: String = BackendType.live.rawValue
                
                standard.set(defaultValue, forKey: UserDefaults.Keys.activeBackend)
                standard.synchronize()
                return defaultValue
            }
            return environment
        }
        set {
            standard.set(newValue, forKey: UserDefaults.Keys.activeBackend)
            standard.synchronize()
        }
    }
}

extension UserDefaults {

    public static  func getCurrentAppVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            Logger.error("App version not found in info plist")
            return "1.0.0"
        }

        return version
    }

    func date(forKey key: String) -> Date? {
        let date: Date? = self.value(forKey: key) as? Date
        return date
    }

    func set<Element: Codable>(value: Element, forKey key: String) {
        let data: Data? = try? JSONEncoder().encode(value)
        UserDefaults.standard.setValue(data, forKey: key)
    }

    func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        let element: Element? = try? JSONDecoder().decode(Element.self, from: data)
        return element
    }

}
