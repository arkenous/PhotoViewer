//
//  AppViewModel.swift
//  PhotoViewer
//
//  Created by 髙坂賢佑 on 2022/05/06.
//

import Foundation
import AppKit

public class AppViewModel : NSObject, ObservableObject {
    @Published var windowSet = Set<NSWindow>()
    @Published var viewModels: [Int:ContentViewModel] = [:]
    @Published var activeWindow: NSWindow?
    @Published var activeViewModel: ContentViewModel?
    
    func addWindow(window: NSWindow) {
        window.delegate = self
        windowSet.insert(window)
    }
    
    func addViewModel(_ viewModel: ContentViewModel, forWindowNumber windowNumber: Int) {
        viewModels[windowNumber] = viewModel
    }
}

extension AppViewModel : NSWindowDelegate {
    public func windowWillClose(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            windowSet.remove(window)
            viewModels.removeValue(forKey: window.windowNumber)
        }
    }
    
    public func windowDidBecomeKey(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            activeWindow = window
            activeViewModel = viewModels[window.windowNumber]
        }
    }
}
