//
//  PhotoViewerApp.swift
//  PhotoViewer
//
//  Created by 髙坂賢佑 on 2022/05/06.
//

import SwiftUI

@main
struct PhotoViewerApp: App {
    @State var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appViewModel)
        }
    }
}
