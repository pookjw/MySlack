//
//  ThreadsViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/22/24.
//

#import "ThreadsViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import "ThreadsViewModel.hpp"
#import "ThreadsCollectionViewCell.hpp"
#import "RepliesViewController.hpp"

__attribute__((objc_direct_members))
@interface ThreadsViewController ()
@property (retain, readonly, nonatomic) ThreadsViewModel *viewModel;
@property (copy, readonly, nonatomic) NSString *channelID;
@property (retain, readonly, nonatomic) id cellRegistration;
@end

@implementation ThreadsViewController

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[ThreadsViewController dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_ThreadsViewController", 0);
        
        class_addProtocol(_isa, NSProtocolFromString(@"UICollectionViewDelegate"));
        
        class_addIvar(_isa, "_channelID", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_viewModel", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_cellRegistration", sizeof(id), sizeof(id), @encode(id));
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP collectionView_didSelectItemAtIndexPath = class_getMethodImplementation(implIsa, @selector(collectionView:didSelectItemAtIndexPath:));
    assert(class_addMethod(isa, @selector(collectionView:didSelectItemAtIndexPath:), collectionView_didSelectItemAtIndexPath, NULL));
    
    IMP collectionView_layout_heightForItemAtIndexPath = class_getMethodImplementation(implIsa, @selector(collectionView:layout:heightForItemAtIndexPath:));
    assert(class_addMethod(isa, @selector(collectionView:layout:heightForItemAtIndexPath:), collectionView_layout_heightForItemAtIndexPath, NULL));
}

- (instancetype)initWithChannelID:(NSString *)channelID channelName:(NSString *)channelName {
    if (self = [super initWithNibName:nil bundle:nil]) {
        object_setInstanceVariable(self, "_channelID", [channelID copy]);
        
        id navigationItem = self.navigationItem;
        
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationItem, sel_registerName("setTitle:"), channelName);
    }
    
    return self;
}

- (void)dealloc {
    id _viewModel;
    object_getInstanceVariable(self, "_viewModel", reinterpret_cast<void **>(&_viewModel));
    [_viewModel release];
    
    id _channelID;
    object_getInstanceVariable(self, "_channelID", reinterpret_cast<void **>(&_channelID));
    [_channelID release];
    
    id _cellRegistration;
    object_getInstanceVariable(self, "_cellRegistration", reinterpret_cast<void **>(&_cellRegistration));
    [_cellRegistration release];
    
    [super dealloc];
}

- (void)loadView {
    id collectionViewLayout = [objc_lookUpClass("PUICListCollectionViewLayout") new];
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(collectionViewLayout, sel_registerName("setCurvesBottom:"), YES);
    reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(collectionViewLayout, sel_registerName("setCurvesTop:"), YES);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(collectionViewLayout, sel_registerName("setDelegate:"), self);
    
    id collectionView = reinterpret_cast<id (*)(id, SEL, CGRect, id)>(objc_msgSend)([objc_lookUpClass("PUICListCollectionView") alloc], sel_registerName("initWithFrame:collectionViewLayout:"), CGRectNull, collectionViewLayout);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(collectionView, sel_registerName("setDelegate:"), self);
    
    [collectionViewLayout release];
    
    self.view = collectionView;
    
    [collectionView release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewModel loadDataSourceWithChannelID:self.channelID completionHandler:^(NSError * _Nullable error) {
        assert(!error);
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            id collectionViewLayout = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(self.view, sel_registerName("collectionViewLayout"));
//            reinterpret_cast<void (*)(id, SEL)>(objc_msgSend)(collectionViewLayout, sel_registerName("invalidateLayout"));
//        });
    }];
}

- (ThreadsViewModel *)viewModel {
    ThreadsViewModel *viewModel;
    object_getInstanceVariable(self, "_viewModel", reinterpret_cast<void **>(&viewModel));
    
    if (viewModel) return viewModel;
    
    viewModel = [[ThreadsViewModel alloc] initWithDataSource:[self makeDataSource]];
    
    object_setInstanceVariable(self, "_viewModel", [viewModel retain]);
    return [viewModel autorelease];
}

- (NSString *)channelID {
    NSString *channelID;
    object_getInstanceVariable(self, "_channelID", reinterpret_cast<void **>(&channelID));
    return channelID;
}

- (id)cellRegistration {
    id cellRegistration;
    object_getInstanceVariable(self, "_cellRegistration", reinterpret_cast<void **>(&cellRegistration));
    
    if (cellRegistration) return cellRegistration;
    
    cellRegistration = reinterpret_cast<id (*)(Class, SEL, Class, id)>(objc_msgSend)(objc_lookUpClass("UICollectionViewCellRegistration"), sel_registerName("registrationWithCellClass:configurationHandler:"), ThreadsCollectionViewCell.dynamicIsa, ^(ThreadsCollectionViewCell *cell, NSIndexPath *indexPath, ThreadsItemModel *item) {
        [cell updateItemModel:item];
    });
    
    object_setInstanceVariable(self, "_cellRegistration", [cellRegistration retain]);
    return cellRegistration;
}

- (id)makeDataSource __attribute__((objc_direct)) {
    id cellRegistration = self.cellRegistration;
    
    id dataSource = reinterpret_cast<id (*)(id, SEL, id, id)>(objc_msgSend)([objc_lookUpClass("UICollectionViewDiffableDataSource") alloc], sel_registerName("initWithCollectionView:cellProvider:"), self.view, ^id _Nullable(id  _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, ThreadsItemModel * _Nonnull itemIdentifier) {
        id cell = reinterpret_cast<id (*)(id, SEL, id, id, id)>(objc_msgSend)(collectionView, sel_registerName("dequeueConfiguredReusableCellWithRegistration:forIndexPath:item:"), cellRegistration, indexPath, itemIdentifier);
        
        return cell;
    });
    
    return [dataSource autorelease];
}

- (void)pushToRepliesViewControllerWithChannelID:(NSString *)channelID threadID:(NSString *)threadID __attribute__((objc_direct)) {
    RepliesViewController *repliesViewController = [[RepliesViewController alloc] initWithChannelID:channelID threadID:threadID];
    id navigationController = self.navigationController;
    reinterpret_cast<void (*)(id, SEL, id, BOOL)>(objc_msgSend)(navigationController, sel_registerName("pushViewController:animated:"), repliesViewController, YES);
    [repliesViewController release];
}

- (void)collectionView:(id)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel itemModelAtIndexPath:indexPath completionHandler:^(ThreadsItemModel * _Nullable itemModel) {
        NSDictionary *message = itemModel.userInfo[ThreadsItemModelMessageKey];
        NSString *threadID = message[@"ts"];
        assert(threadID);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self pushToRepliesViewControllerWithChannelID:self.channelID threadID:threadID];
        });
    }];
}

- (CGFloat)collectionView:(id)collectionView layout:(id)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect bounds = reinterpret_cast<CGRect (*)(id, SEL)>(objc_msgSend)(collectionView, sel_registerName("bounds"));
    UIEdgeInsets effectiveContentInset = reinterpret_cast<UIEdgeInsets (*)(id, SEL)>(objc_msgSend)(collectionView, sel_registerName("_effectiveContentInset"));
    return CGRectGetHeight(bounds) - effectiveContentInset.top - effectiveContentInset.bottom;
}

@end
