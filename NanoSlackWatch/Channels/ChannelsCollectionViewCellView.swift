//
//  ChannelsCollectionViewCellView.swift
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/20/24.
//

import SwiftUI

@_expose(Cxx)
public struct ChannelsCollectionViewCellView: View {
    @_expose(Cxx)
    public static func makeHostingController() -> NSObject {
        _makeUIHostingController(
            AnyView(
                ChannelsCollectionViewCellView(itemModel: nil)
            ),
            tracksContentSize: true
        )
    }
    
    @_expose(Cxx)
    public static func updateHostingController(_ hostingController: NSObject, itemModel: NSObject?) {
        let hostingViewable: any _UIHostingViewable = hostingController as! (any _UIHostingViewable)
        let rootView: AnyView = .init(ChannelsCollectionViewCellView(itemModel: itemModel as? ChannelsItemModel))
        hostingViewable.rootView = rootView
    }
    
    private let itemModel: ChannelsItemModel?
    
    private var name: String? {
        guard let channel: [String: Any] = itemModel?.userInfo?[ChannelsItemModel.channelKey] as? [String: Any] else {
            return nil
        }
        
        return channel["name_normalized"] as? String
    }
    
    init(itemModel: ChannelsItemModel?) {
        self.itemModel = itemModel
    }
    
    public var body: some View {
        Text(name ?? "(null)")
    }
}

//#Preview {
//    ChannelsCollectionViewCellView()
//}
