//
//  MenuCommands.swift
//  PhotoViewer
//
//  Created by 髙坂賢佑 on 2022/05/06.
//

import Foundation
import SwiftUI
import Combine

struct MenuCommands : Commands {
    var appViewModel:  AppViewModel
    
    var body: some Commands {
        CommandGroup(after: CommandGroupPlacement.newItem) {
            Divider()
            Button(action: {
                let dialog = NSOpenPanel()
                dialog.title =  "Choose a file"
                dialog.showsResizeIndicator = true
                dialog.showsHiddenFiles = true
                dialog.allowsMultipleSelection = false
                dialog.canChooseDirectories = false
                
                if (dialog.runModal() == .OK) {
                    guard let url = dialog.url else {
                        return
                    }
                    appViewModel.activeViewModel?.path = url
                }
            }, label: {
                Text("Open File")
            })
            .keyboardShortcut("O", modifiers: [.command])
        }
    }
}
