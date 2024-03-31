//
//  RepliesCollectionViewCellView.swift
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

import SwiftUI

@_expose(Cxx)
public struct RepliesCollectionViewCellView: View {
    @_expose(Cxx)
    public static func makeHostingController() -> NSObject {
        _makeUIHostingController(
            AnyView(
                RepliesCollectionViewCellView(itemModel: nil)
            ),
            tracksContentSize: true
        )
    }
    
    @_expose(Cxx)
    public static func updateHostingController(_ hostingController: NSObject, itemModel: NSObject?) {
        let hostingViewable: any _UIHostingViewable = hostingController as! (any _UIHostingViewable)
        let rootView: AnyView = .init(RepliesCollectionViewCellView(itemModel: itemModel as? RepliesItemModel))
        hostingViewable.rootView = rootView
    }
    
    @_expose(Cxx)
    public static func sizeThatFits(in size: CGSize, hostingController: NSObject) -> CGSize {
        let hostingViewable: any _UIHostingViewable = hostingController as! (any _UIHostingViewable)
        return hostingViewable.sizeThatFits(in: size)
    }

    @State private var viewModel: RepliesCollectionViewCellViewModel = .init()
    private let itemModel: RepliesItemModel?
    
    init(itemModel: RepliesItemModel?) {
        self.itemModel = itemModel
    }
    
    public var body: some View {
        VStack {
            HStack {
                AsyncImage(url: viewModel.profile?.image72) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
//                            .clipShape(RoundedRectangle(cornerRadius: 3.0, style: .continuous))
                            .clipShape(Capsule(style: .continuous))
                    case .failure(let error):
                        Text(error.localizedDescription)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 24.0, height: 24.0, alignment: .topLeading)
                
                if let displayName = viewModel.profile?.displayName {
                    Text(displayName)
                }
            }
            
            Color.secondary
                .frame(height: 1.0)
            
            Text(viewModel.text ?? "null")
        }
        .padding()
        .task(id: itemModel) {
            do {
                try await viewModel.load(itemModel: itemModel)
            } catch _ as CancellationError {
                
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

//#Preview {
//    RepliesCollectionViewCellView()
//}
