//
//  ContentView.swift
//  PhotoViewer
//
//  Created by 髙坂賢佑 on 2022/05/06.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        HostingWindowFinder { window in
            guard let window = window else {
                return
            }
            appViewModel.addWindow(window: window)
            appViewModel.addViewModel(viewModel, forWindowNumber: window.windowNumber)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HostingWindowFinder : NSViewRepresentable {
    var delegate:  (NSWindow?) -> ()
    
    func makeNSView(context: Context) ->  some NSView {
        let view = NSView()
        DispatchQueue.main.async { [weak view] in
            self.delegate(view?.window)
        }
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        // noop
    }
}
