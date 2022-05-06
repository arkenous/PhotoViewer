//
//  AppDelegate.swift
//  PhotoViewer
//
//  Created by 髙坂賢佑 on 2022/05/06.
//

import Foundation
import AppKit
import SDWebImageSwiftUI

class  AppDelegate : NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        SDImageCodersManager.shared.addCoder(SDImageAWebPCoder.shared)
    }
}
