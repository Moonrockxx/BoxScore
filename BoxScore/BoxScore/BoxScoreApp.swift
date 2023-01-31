//
//  BoxScoreApp.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import SwiftUI
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate {
//    //    override init() {
//    //        super.init()
//    //        FirebaseApp.configure()
//    //    }
//
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        //        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct BoxScoreApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
    }
}
