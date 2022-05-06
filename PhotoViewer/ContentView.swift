//
//  ContentView.swift
//  PhotoViewer
//
//  Created by 髙坂賢佑 on 2022/05/06.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            HostingWindowFinder { window in
                guard let window = window else {
                    return
                }
                appViewModel.addWindow(window: window)
                appViewModel.addViewModel(viewModel, forWindowNumber: window.windowNumber)
            }
            if (viewModel.path != nil) {
                WebImage(url: viewModel.path, isAnimating: .constant(true))
                    .resizable(resizingMode: .stretch)
                    .scaledToFill()
            }
        }
        .ignoresSafeArea()
        .onDrop(of: ["public.file-url"], isTargeted: nil) { (items) -> Bool in
            if let item = items.first {
                if let identifier = item.registeredTypeIdentifiers.first {
                    item.loadItem(forTypeIdentifier: identifier) { (urlData, error) in
                        DispatchQueue.main.async {
                            if let urlData = urlData as? Data {
                                let url = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                                viewModel.path = url
                            }
                        }
                    }
                }
                return true
            } else {
                return false
            }
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
