//
//  ThreadsCollectionViewCellView.swift
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/25/24.
//

import SwiftUI

@_expose(Cxx)
public struct ThreadsCollectionViewCellView: View {
    @_expose(Cxx)
    public static func makeHostingController() -> NSObject {
        _makeUIHostingController(
            AnyView(
                ThreadsCollectionViewCellView(itemModel: nil)
            ),
            tracksContentSize: true
        )
    }
    
    @_expose(Cxx)
    public static func updateHostingController(_ hostingController: NSObject, itemModel: NSObject?) {
        let hostingViewable: any _UIHostingViewable = hostingController as! (any _UIHostingViewable)
        let rootView: AnyView = .init(ThreadsCollectionViewCellView(itemModel: itemModel as? ThreadsItemModel))
        hostingViewable.rootView = rootView
    }
    
    @_expose(Cxx)
    public static func sizeThatFits(in size: CGSize, hostingController: NSObject) -> CGSize {
        let hostingViewable: any _UIHostingViewable = hostingController as! (any _UIHostingViewable)
        return hostingViewable.sizeThatFits(in: size)
    }
    
    @State private var viewModel: ThreadsCollectionViewCellViewModel = .init()
    private let itemModel: ThreadsItemModel?
    
    init(itemModel: ThreadsItemModel?) {
        self.itemModel = itemModel
    }
    
    public var body: some View {
        VStack {
            Text(viewModel.profile?.displayName ?? "null")
            
            Color.pink
                .frame(height: 2.0)
            
            Text(viewModel.text ?? "null")
        }
            .task(id: itemModel) { 
                try! await viewModel.load(itemModel: itemModel)
            }
    }
}

//#Preview {
//    ThreadsCollectionViewCellView()
//}
