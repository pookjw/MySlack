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
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: viewModel.profile?.image72) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .clipShape(Capsule(style: .continuous))
                    case .failure(let error):
                        Text(error.localizedDescription)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 24.0, height: 24.0)
                
                if let displayName = viewModel.profile?.displayName {
                    Text(displayName)
                }
            }
            
            Color.secondary
                .frame(height: 1.0)
            
            if let body: AttributedString = viewModel.body {
                Text(body)
            } else {
                ProgressView()
            }
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
//    ThreadsCollectionViewCellView()
//}
