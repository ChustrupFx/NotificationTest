//
//  NotificationTestApp.swift
//  NotificationTest
//
//  Created by Victor Soares on 27/10/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error to register for temote notification with error: \(error)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken.hexString)
    }
}

@main
struct NotificationTestApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
