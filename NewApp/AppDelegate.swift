//
//  AppDelegate.swift
//  NewApp
//
//  Created by Jake Woodall on 10/26/26.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
