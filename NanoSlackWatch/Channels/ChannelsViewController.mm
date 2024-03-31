//
//  ChannelsViewController.mm
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/17/24.
//

#import "ChannelsViewController.hpp"
#import <objc/message.h>
#import <objc/runtime.h>
#import "ChannelsViewModel.hpp"
#import "ChannelsCollectionViewCell.hpp"
#import "ProfilesViewController.hpp"
#import "ThreadsViewController.hpp"
#import "UIColor+Private.h"

__attribute__((objc_direct_members))
@interface ChannelsViewController ()
@property (retain, readonly, nonatomic) ChannelsViewModel *viewModel;
@property (retain, readonly, nonatomic) id cellRegistration;
@end

@implementation ChannelsViewController

+ (void)load {
    [self registerMethodsIntoIsa:[self dynamicIsa] implIsa:self];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[ChannelsViewController dynamicIsa] allocWithZone:zone];
}

+ (Class)dynamicIsa {
    static Class isa;
    
    if (isa == nil) {
        Class _isa = objc_allocateClassPair([super dynamicIsa], "_ChannelsViewController", 0);
        
        class_addProtocol(_isa, NSProtocolFromString(@"PUICListCollectionViewLayoutDelegate"));
        class_addProtocol(_isa, NSProtocolFromString(@"UICollectionViewDelegate"));
        
        class_addIvar(_isa, "_viewModel", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_cellRegistration", sizeof(id), sizeof(id), @encode(id));
        class_addIvar(_isa, "_nsw_puic_statusBarPlacement", sizeof(NSInteger), sizeof(NSInteger), @encode(NSInteger));
        
        isa = _isa;
    }
    
    return isa;
}

+ (void)registerMethodsIntoIsa:(Class)isa implIsa:(Class)implIsa {
    [super registerMethodsIntoIsa:isa implIsa:implIsa];
    
    IMP collectionView_trailingSwipeActionsConfigurationForItemAtIndexPath = class_getMethodImplementation(implIsa, @selector(collectionView:trailingSwipeActionsConfigurationForItemAtIndexPath:));
    assert(class_addMethod(isa, @selector(collectionView:trailingSwipeActionsConfigurationForItemAtIndexPath:), collectionView_trailingSwipeActionsConfigurationForItemAtIndexPath, NULL));
    
    IMP updateSearchResultsForSearchController = class_getMethodImplementation(implIsa, @selector(updateSearchResultsForSearchController:));
    assert(class_addMethod(isa, @selector(updateSearchResultsForSearchController:), updateSearchResultsForSearchController, NULL));
    
    IMP collectionView_didSelectItemAtIndexPath = class_getMethodImplementation(implIsa, @selector(collectionView:didSelectItemAtIndexPath:));
    assert(class_addMethod(isa, @selector(collectionView:didSelectItemAtIndexPath:), collectionView_didSelectItemAtIndexPath, NULL));
    
    IMP profileBarButtomItemDidTrigger = class_getMethodImplementation(implIsa, @selector(profileBarButtomItemDidTrigger:));
    assert(class_addMethod(isa, @selector(profileBarButtomItemDidTrigger:), profileBarButtomItemDidTrigger, NULL));
    
    IMP bookmarkBarButtomItemDidTrigger = class_getMethodImplementation(implIsa, @selector(bookmarkBarButtomItemDidTrigger:));
    assert(class_addMethod(isa, @selector(bookmarkBarButtomItemDidTrigger:), bookmarkBarButtomItemDidTrigger, NULL));
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        id navigationItem = self.navigationItem;
        
        reinterpret_cast<void (*)(id, SEL, NSInteger)>(objc_msgSend)(navigationItem, sel_registerName("setLargeTitleDisplayMode:"), 1);
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationItem, sel_registerName("setTitle:"), @"Slack");
        
        id profileBarButtonItem = reinterpret_cast<id (*)(id, SEL, id, NSInteger, id, SEL)>(objc_msgSend)([objc_lookUpClass("UIBarButtonItem") alloc], sel_registerName("initWithImage:style:target:action:"), [UIImage systemImageNamed:@"person.crop.circle"], 0, self, @selector(profileBarButtomItemDidTrigger:));
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(profileBarButtonItem, sel_registerName("setTintColor:"), UIColor.systemCyanColor);
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationItem, sel_registerName("setLeftBarButtonItems:"), @[profileBarButtonItem]);
        [profileBarButtonItem release];
        
        id bookmarkedBarButtonItem = reinterpret_cast<id (*)(id, SEL, id, NSInteger, id, SEL)>(objc_msgSend)([objc_lookUpClass("UIBarButtonItem") alloc], sel_registerName("initWithImage:style:target:action:"), [UIImage systemImageNamed:@"bookmark"], 0, self, @selector(bookmarkBarButtomItemDidTrigger:));
        reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationItem, sel_registerName("setRightBarButtonItems:"), @[bookmarkedBarButtonItem]);
        [bookmarkedBarButtonItem release];
    }
    
    return self;
}

- (void)dealloc {
    id _viewModel;
    object_getInstanceVariable(self, "_viewModel", reinterpret_cast<void **>(&_viewModel));
    [_viewModel release];
    
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

- (void)viewIsAppearing:(BOOL)animated {
    [super viewIsAppearing:animated];
    
    id navigationItem = self.navigationItem;
    
    id puic_searchController = [objc_lookUpClass("PUICSearchController") new];
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(puic_searchController, sel_registerName("setSearchResultsUpdater:"), self);
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(navigationItem, sel_registerName("puic_setSearchController:"), puic_searchController);
    [puic_searchController release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel reloadDataSourceWithSearchText:nil completionHandler:^(NSError * _Nullable error) {
        assert(!error);
    }];
}

- (ChannelsViewModel *)viewModel __attribute__((objc_direct)) {
    ChannelsViewModel *viewModel;
    object_getInstanceVariable(self, "_viewModel", reinterpret_cast<void **>(&viewModel));
    
    if (viewModel) return viewModel;
    
    viewModel = [[ChannelsViewModel alloc] initWithDataSource:[self makeDataSource]];
    
    object_setInstanceVariable(self, "_viewModel", [viewModel retain]);
    return [viewModel autorelease];
}

- (id)cellRegistration {
    id cellRegistration;
    object_getInstanceVariable(self, "_cellRegistration", reinterpret_cast<void **>(&cellRegistration));
    
    if (cellRegistration) return cellRegistration;
    
    cellRegistration = reinterpret_cast<id (*)(Class, SEL, Class, id)>(objc_msgSend)(objc_lookUpClass("UICollectionViewCellRegistration"), sel_registerName("registrationWithCellClass:configurationHandler:"), ChannelsCollectionViewCell.dynamicIsa, ^(ChannelsCollectionViewCell *cell, NSIndexPath *indexPath, ChannelsItemModel *item) {
        [cell updateItemModel:item];
    });
    
    object_setInstanceVariable(self, "_cellRegistration", [cellRegistration retain]);
    return cellRegistration;
}

- (id)makeDataSource __attribute__((objc_direct)) {
    id cellRegistration = self.cellRegistration;
    
    id dataSource = reinterpret_cast<id (*)(id, SEL, id, id)>(objc_msgSend)([objc_lookUpClass("UICollectionViewDiffableDataSource") alloc], sel_registerName("initWithCollectionView:cellProvider:"), self.view, ^id _Nullable(id  _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, ChannelsItemModel * _Nonnull itemIdentifier) {
        id cell = reinterpret_cast<id (*)(id, SEL, id, id, id)>(objc_msgSend)(collectionView, sel_registerName("dequeueConfiguredReusableCellWithRegistration:forIndexPath:item:"), cellRegistration, indexPath, itemIdentifier);
        
        return cell;
    });
    
    return [dataSource autorelease];
}

- (id)collectionView:(id)collectionView trailingSwipeActionsConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath {
    id testAction = reinterpret_cast<id (*)(Class, SEL, NSInteger, id, id)>(objc_msgSend)(objc_lookUpClass("UIContextualAction"), sel_registerName("contextualActionWithStyle:title:handler:"), 0, nil, ^(id action, id sourceView, void (^completionHandler)(BOOL actionPerformed)){
        completionHandler(YES);
    });
    
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(testAction, sel_registerName("setImage:"), [UIImage systemImageNamed:@"eraser.line.dashed"]);
    
    UIColor *backgroundColor = reinterpret_cast<id (*)(Class, SEL)>(objc_msgSend)(UIColor.class, sel_registerName("arouetBlueColor"));
    reinterpret_cast<void (*)(id, SEL, id)>(objc_msgSend)(testAction, sel_registerName("setBackgroundColor:"), backgroundColor);
    
    id swipeActions = reinterpret_cast<id (*)(Class, SEL, id)>(objc_msgSend)(objc_lookUpClass("UISwipeActionsConfiguration"), sel_registerName("configurationWithActions:"), @[testAction]);
    
    return swipeActions;
}

- (void)collectionView:(id)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel itemModelAtIndexPath:indexPath completionHandler:^(ChannelsItemModel * _Nullable itemModel) {
        if (itemModel == nil) return;
        
        NSDictionary<NSString *, id> *channel = itemModel.userInfo[ChannelsItemModelChannelKey];
        NSString *channelID = channel[@"id"];
        NSString *channelName = channel[@"name_normalized"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self pushToThreadsViewControllerWithChannelID:channelID channelName:channelName];
        });
    }];
}

- (void)updateSearchResultsForSearchController:(id)searchController {
    id searchField = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(searchController, sel_registerName("searchField"));
    NSString *text = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(searchField, sel_registerName("text"));
    
    [self.viewModel filterWithSearchText:text completionHandler:nil];
}

- (void)profileBarButtomItemDidTrigger:(id)sender {
    id profilesViewController = [ProfilesViewController new];
    id navigationController = reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)([objc_lookUpClass("PUICNavigationController") alloc], sel_registerName("initWithRootViewController:"), profilesViewController);
    [profilesViewController release];
    [self presentViewController:navigationController animated:YES completion:nil];
    [navigationController release];
}

- (void)bookmarkBarButtomItemDidTrigger:(id)sender {
    
}

- (void)pushToThreadsViewControllerWithChannelID:(NSString *)channelID channelName:(NSString *)channelName __attribute__((objc_direct)) {
    ThreadsViewController *threadsViewController = [[ThreadsViewController alloc] initWithChannelID:channelID channelName:channelName];
    id navigationController = self.navigationController;
    reinterpret_cast<void (*)(id, SEL, id, BOOL)>(objc_msgSend)(navigationController, sel_registerName("pushViewController:animated:"), threadsViewController, YES);
    [threadsViewController release];
}

@end
