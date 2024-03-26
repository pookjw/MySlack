//
//  RepliesViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/26/24.
//

#import "RepliesViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import "RepliesViewModel.hpp"
#import "RepliesCollectionViewCell.hpp"

__attribute__((objc_direct_members))
@interface RepliesViewController ()
@property (retain, readonly, nonatomic) RepliesViewModel *viewModel;
@property (copy, readonly, nonatomic) NSString *channelID;
@property (copy, readonly, nonatomic) NSString *threadID;
@property (retain, readonly, nonatomic) id cellRegistration;
@end

@implementation RepliesViewController

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[RepliesViewController dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_RepliesViewController", 0);
        
        class_addIvar(_isa, "_viewModel", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_channelID", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_threadID", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_cellRegistration", sizeof(id), sizeof(id), @encode(id));
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP collectionView_didSelectItemAtIndexPath = class_getMethodImplementation(implIsa, @selector(collectionView:didSelectItemAtIndexPath:));
    assert(class_addMethod(isa, @selector(collectionView:didSelectItemAtIndexPath:), collectionView_didSelectItemAtIndexPath, NULL));
}

- (instancetype)initWithChannelID:(NSString *)channelID threadID:(NSString *)threadID {
    if (self = [super initWithNibName:nil bundle:nil]) {
        object_setInstanceVariable(self, "_channelID", [channelID copy]);
        object_setInstanceVariable(self, "_threadID", [threadID copy]);
        
        id navigationItem = self.navigationItem;
        
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationItem, sel_registerName("setTitle:"), @"Thread");
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
    
    id _threadID;
    object_getInstanceVariable(self, "_threadID", reinterpret_cast<void **>(&_threadID));
    [_threadID release];
    
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
    [self.viewModel loadDataSourceWithChannelID:self.channelID threadID:self.threadID completionHandler:^(NSError * _Nullable error) {
        assert(!error);
    }];
}

- (RepliesViewModel *)viewModel {
    RepliesViewModel *viewModel;
    object_getInstanceVariable(self, "_viewModel", reinterpret_cast<void **>(&viewModel));
    
    if (viewModel) return viewModel;
    
    viewModel = [[RepliesViewModel alloc] initWithDataSource:[self makeDataSource]];
    
    object_setInstanceVariable(self, "_viewModel", [viewModel retain]);
    return [viewModel autorelease];
}

- (NSString *)channelID {
    NSString *channelID;
    object_getInstanceVariable(self, "_channelID", reinterpret_cast<void **>(&channelID));
    return channelID;
}

- (NSString *)threadID {
    NSString *threadID;
    object_getInstanceVariable(self, "_threadID", reinterpret_cast<void **>(&threadID));
    return threadID;
}

- (id)cellRegistration {
    id cellRegistration;
    object_getInstanceVariable(self, "_cellRegistration", reinterpret_cast<void **>(&cellRegistration));
    
    if (cellRegistration) return cellRegistration;
    
    cellRegistration = reinterpret_cast<id (*)(Class, SEL, Class, id)>(objc_msgSend)(objc_lookUpClass("UICollectionViewCellRegistration"), sel_registerName("registrationWithCellClass:configurationHandler:"), RepliesCollectionViewCell.dynamicIsa, ^(RepliesCollectionViewCell *cell, NSIndexPath *indexPath, RepliesItemModel *item) {
        [cell updateItemModel:item];
    });
    
    object_setInstanceVariable(self, "_cellRegistration", [cellRegistration retain]);
    return cellRegistration;
}

- (id)makeDataSource __attribute__((objc_direct)) {
    id cellRegistration = self.cellRegistration;
    
    id dataSource = reinterpret_cast<id (*)(id, SEL, id, id)>(objc_msgSend)([objc_lookUpClass("UICollectionViewDiffableDataSource") alloc], sel_registerName("initWithCollectionView:cellProvider:"), self.view, ^id _Nullable(id  _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, RepliesItemModel * _Nonnull itemIdentifier) {
        id cell = reinterpret_cast<id (*)(id, SEL, id, id, id)>(objc_msgSend)(collectionView, sel_registerName("dequeueConfiguredReusableCellWithRegistration:forIndexPath:item:"), cellRegistration, indexPath, itemIdentifier);
        
        return cell;
    });
    
    return [dataSource autorelease];
}

- (void)collectionView:(id)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
