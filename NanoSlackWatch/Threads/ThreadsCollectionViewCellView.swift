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
    
    private let itemModel: ThreadsItemModel?
    
    private var text: String? {
        guard let message: [String: Any] = itemModel?.userInfo?[ThreadsItemModel.messageKey] as? [String: Any] else {
            return nil
        }
        
        return message["text"] as? String
    }
    
    init(itemModel: ThreadsItemModel?) {
        self.itemModel = itemModel
    }
    
    public var body: some View {
        Text(text ?? "null")
    }
}

//#Preview {
//    ThreadsCollectionViewCellView()
//}
