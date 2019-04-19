# WBListKit
[![996.icu](https://img.shields.io/badge/link-996.icu-red.svg)](https://996.icu)
[![LICENSE](https://img.shields.io/badge/license-Anti%20996-blue.svg)](https://github.com/996icu/996.ICU/blob/master/LICENSE)

## 简介

列表是在iOS开发中是最常用的UI控件，可以说我们项目开发过程中有一半以上的时间是在和列表打交道。但是很多同学在写列表的时候我们需要写很多的重复代码，并且团队中每个成员的写法和代码风格不同，这就造成了难以阅读，难以调试和难以维护。<br/>
为了解决这个问题，WBListKit对UITableView和UICollectionView进行了封装，简化了UITableView和CollectionView的使用和维护，并且解决了项目中的普遍问题，比如：空白页面，错误页面，上拉加载下拉刷新等。

## 特性

* 简单易用，让团队中每个成员的代码风格统一，容易维护
* 功能强大，几乎适用于所有列表样式的UI
* 无类型污染，框架是基于协议设计的，不存在继承体系，没有强耦合，扩展性强
* Drop In，零成本接入现有项目，对旧代码没有影响
* 对下拉刷新和上拉加载更多有很好的支持
* 对空页面和错误页面提示提供了插件化支持
* 集成了自动differ功能，再也不用手动调用insertRow,deleteRow，只刷新变化的部分
* 支持Swift混编

## 系统要求

* iOS 7.0 以上系统
* Xcode 7.3 或更高版本

## Author

xcoder.fang@gmail.com, fangyuxi@58.com

## License

WBListKit is available under the MIT license. See the LICENSE file for more info.

## 使用教程

**注意:** 项目中有比较完善的Demo，可以查看

## 设计思路

**注意:** 只介绍针对`UITableView`的实现方式,`UICollectionView`的实现大体相似，后续只介绍不同的地方

针对`UITableView`的每一行,抽象成对象`WBTableRow`,针对`UITableView`的每一个section，抽象成`WBTableSection`对象,将Header和Footer抽象成`WBTableSectionHeaderFooter`对象<br>
同时提供了`WBTableSectionMaker` 用于配置section并实现链式操作<br>
`WBTableViewAdapter`实现了`UITableView`的全部数据源方法和部分代理方法,将之前重复的（团队中成员为了实现相同的逻辑，但是代码并不相同）代码封装成一个内聚的对象<br>
`WBTableViewAdapter`并不关心数据从哪里来,只是将数据按照一定的格式拼装给`UITableView`使用，下面分别介绍下这几个对象<br>

### WBTableRow

`WBTableRow` 代表了一行,同时充当了`UITableViewCell`的模型，主要完成以下工作<br>
* 通过属性`associatedCellClass` 关联一个已经实现了`WBTableCellProtocol` 协议的`UITableViewCell`对象（支持NIB）
* 可以配置这个`Cell`是使用自动布局的方式[确定高度](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)还是使用Frame方式
* 框架除了会帮你通过`IndexPath`确定`Cell`的具体位置之外,还会根据具体位置抽象出一个`WBTableRowPosition`,帮你确定`Cell`具体是`Top`,`Bottom`,`Middle`,`Single`,这样对于一些要根据`Cell`具体位置布局UI的情况就很方便了很多
* 提供一个`data`属性,为`Cell`提供真正的数据源,`data`对象到底是什么类型,下面再讨论（这样的好处在于不用为每一种类型的`Cell`都创建一种Row类型）

### WBTableSection

* 装配`section`,增删改查`Row`
* 给`section`提供`id`,逻辑层就不用关心`section`的具体位置，只要通过`id`就可以找到想要的`section`,能够解决一部分UI位置一变，逻辑层也跟着变的窘境,也在一定程度上解决了各种数组越界的问题
* 给`section`添加`footer`和`header`
* `section` 支持diff操作

### WBTableSectionHeaderFooter

* `WBTableSectionHeaderFooter`类似于`WBTableRow`,都是给数据驱动的View提供模型
* 通过属性`associatedHeaderFooterClass`关联一个已经实现了`WBTableHeaderFooterViewProtocal`协议的`UITableViewReusebleView`对象（同时支持NIB）
* 可以配置这个`WBTableSectionHeaderFooter`是使用自动布局的方式[确定高度](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)还是使用Frame方式

### 那么什么是数据驱动的View

iOS列表中数据驱动的View包括 `UITableViewCell` `UICollectionViewCell` `UITableViewFooter&Header` `UICollectionViewSupplementary` <br>
这些视图的很多行为相同，比如update,reset,reload,cancel,框架会在合适的时机回调这些方法，业务方只需要在这些方法做相应的事情就可以（大家的代码又一样了）所以就有了这个协议 `WBListReusableViewProtocol` 所以 `WBTableCellProtocal` `WBTableHeaderFooterViewProtocal` 都是 `WBListReusableViewProtocol` 的子协议, `WBTableCellProtocal`中有row属性，`WBTableHeaderFooterViewProtocal`中有headerfooter属性，这样所有的cell和footer，header都有了row模型，同时也拥有了`WBListReusableViewProtocol`中的框架回调方法，还担心大家的代码不一致吗？<br>
同时这些View还存在向外部抛出事件的需求，那么所有遵循 `WBListActionToControllerProtocol` 的对象都可以接受抛出事件的回调，大部分来讲这个对象是控制器<br>
这样所有的事件都有迹可循，每个人写的代码都八九不离十。 `WBListActionToControllerProtocol` 同时也继承了 `UITableViewDelegate`协议，结果所有事件都可以通过一个代理搞定,这个协议如下：<br>

```objc
/**
 比如Cell中有一个button，需要到Controller中发送网络请求，那么代码如下：
 'button.action = ^(){
     [self.actionDelegate actionFromView:self withEventTag:@"YourEventTage" withParameterObject:self.row];
 };'
 
 actionDelegate是WBListReusableViewProtocol中的一个可选属性，业务方可以合成这个属性，将事件分发出去
*/

@protocol WBListActionToControllerProtocol <NSObject,
                                UITableViewDelegate,
                                UICollectionViewDelegateFlowLayout,
                                UICollectionViewDelegate>
@optional

- (void)actionFromReusableView:(UIView *)view
                      eventTag:(NSString *)tag
                     parameter:(id)param;

@end
```
**注：当UITableViewCell遵守了协议:`WBTableCellProtocol`之后需要加上如下代码：**

```
@synthesize row = _row;
@synthesize actionDelegate = _actionDelegate;
```   

来让编译器自动生成get set方法，因为该属性是放到WBTableCellProtocol中的。

### WBTableViewAdapter

* 实现了 `UITableView` 的所有数据源和大部分代理方法，而且是通过[拦截者](https://github.com/facebook/AsyncDisplayKit/blob/7b112a2dcd0391ddf3671f9dcb63521f554b78bd/AsyncDisplayKit/ASCollectionView.mm#L34-L53)方式实现的，所以这些代理对业务方完全透明
* 自动注册 `UITableViewCell` `UICollectionViewCell` `UITableViewFooter&Header` `UICollectionViewSupplementary`
* 通过updateSection,addSection,deleteSection等操作给View装配数据,上代码：

```objc
self.adapter = [[WBTableViewAdapter alloc] init];
self.tableView bindAdapter:self.adapter];
[self.adapter addSection:^(WBTableSection * _Nonnull section) {
        
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.associatedCellClass = [WBSimpleListCell class];
            row.data = @{@"title":@(index)
                            };
            maker.addRow(row);
        }
      
        [section addRow:row];
        section.key = @"FixedHeightSection"
    }];
```

Cell中的代码

```objc
@implementation WBSimpleListCell

@synthesize row = _row;

- (void)makeLayout{
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

//框架在合适的时机调用这个方法，业务方根据self.row.data中的数据更新显示
- (void)update{
    self.label.text = [NSString stringWithFormat:@"SimpleList self manage height Cell Index : %@",[[(NSDictionary *)self.row.data objectForKey:@"title"] stringValue]];
}

@end
```

###  我们给Cell提供什么样的数据

#### 方式一:使用原始数据

不论什么情况下，直接将网络请求或者本地加载的数据，用原始类型(NSDictionary,NSArray...)提供给row的data属性，在cell的update方法中直接访问原始类型<br>
这种方式很好，不会造成类爆炸，可以在调试的时候直接打印，很直观，但是并不完美，如果一个cell有自己的状态，比如是否选中，比如是否在播放中，是否浏览过，这些状态如果我们也追加到原始类型中,就会出现表意不明，如果没有定义好足够明确的key，那么后期维护是很恐怖的。即便强制要求代码规范，但是项目是在生长的，很难讲什么时候走偏。<br>

#### 方式二:映射

使用MJExtension,YYModel等方式将网络返回的原始数据转换（不讨论转换代码的位置，只讨论交付的数据）成Model交付给Cell,这样就解决了上面的问题，但是坏处也是显而易见的，会造成类爆炸，即便是简单的表单提交页面，也会写出很多不必要的Model。<br>

针对上述问题，框架提供了一个协议 `WBListDataReformerProtocol`：

```objc
@protocol WBListDataReformerProtocol <NSObject>

- (void)reformRawData:(id)data forRow:(WBTableRow *)row;

@optional
@property (nonatomic, strong) id rawData;

@end
```

对于没有状态的Cell，使用原始数据类型表征就很清楚了，可以直接将原始类型扔给Cell用。<br>
对于带有自有状态，或者需要原始数据转化后才能显示的需求，创建一个遵循这个协议的对象，自定义对象属性，提供给Cell使用，代码如下:<br>

```objc
[self.adapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
          
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.associatedCellClass = [WBReformerListCell class];
            WBReformerListCellReformer *reformer = [WBReformerListCellReformer new];
            [reformer reformRawData:@{@"title":@(index),
                                      @"date":[NSDate new]
                                      } forRow:row];
            row.data = reformer;
            maker.addRow(row);
        }
    }];
```

Reformer代码

```objc
@interface WBReformerListCellReformer : NSObject<WBListDataReformerProtocol>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *date;

@end

@interface WBReformerListCellReformer ()

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *date;

@end

@implementation WBReformerListCellReformer

@synthesize rawData = _rawData;

- (void)reformRawData:(id)data forRow:(WBTableRow *)row{
    
    if (![data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    self.rawData = data;
    self.title = [[data objectForKey:@"title"] stringValue];
    NSDate *date = [data objectForKey:@"date"];
    self.date = [date description];
}

@end
```

Cell中代码：

```objc
- (void)update{
    WBReformerListCellReformer *reformer = (WBReformerListCellReformer *)self.row.data;
    self.title.text = reformer.title;
    self.date.text = reformer.date;
}
```  

### 内建的自动Differ刷新功能

我们都有这样的经验，当我们需要删除一些rows或者sections的时候，要频繁的调用`deleteRow` `insertRow` `deleteSection`等操作，同时还要同步数据和UI显示，
一不小心就容易崩溃。同时当我们加载更多的时候，为了避免如上操作，经常会`reload`整个view，造成不必要的计算浪费（重新reload就需要重新加载cell中的数据，如果Cell中有图片或者其来自缓存的资源，那么势必会造成不必要的IO消耗）。现在框架内部提供了数据Differ功能，通俗得讲就是比较两个数组，将数组变化的部分转化成Insert，Delete，Move 等操作，然后在合适的时候批量提交给View进行刷新。所以业务方可以尽情的Delete，Move，Insert。具体有如下三个方法

```objc   
- (void)beginAutoDiffer;
- (void)commitAutoDifferWithAnimation:(BOOL)animation;
- (void)reloadDifferWithAnimation:(BOOL)animation;
```  

所有在begin和commit中间进行的操作都会在commit的一刻提交给view显示，可以指定是否要动画。reload方法会随时将和上次reload或者commit之后的更改提交给View更新，代码如下：

```objc
[self.tableViewAdapter beginAutoDiffer];
    [self.tableViewAdapter deleteAllSections];
    [self.tableViewAdapter commitAutoDifferWithAnimation:NO];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_Z-wjbc-074017)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableViewAdapter beginAutoDiffer];
            [self.tableViewAdapter addSection:^(WBTableSection * _Nonnull section) {
                
                [section setIdentifier:@"fangyuxi"];
                for (NSInteger index = 0; index < 15; ++index) {
                    WBTableRow *row = [[WBTableRow alloc] init];
                    row.calculateHeight = ^CGFloat(WBTableRow *row){
                        return 60.0f;
                    };
                    row.associatedCellClass = [WBReformerListCell class];
                    WBReformerListCellReformer *reformer = [WBReformerListCellReformer new];
                    [reformer reformRawData:@{@"title":@(index),
                                              @"date":[NSDate new]
                                              } forRow:row];
                    row.data = reformer;
                    [section addRow:row];
                }
            }];
            [self.tableViewAdapter commitAutoDifferWithAnimation:NO];
            
            self.canLoadMore = YES;
            [self notifyDidFinishLoad];
        });
```

### 那么数据从哪里来呢？

从上面我们可以看出来,Adapter其实只是一个数据的装配器（不同于Android），`UITableView`的Adapter装配适合`UITableView`的数据，`UICollectionView`的Adapter装配适合`UICollectionView`的数据，它并不关心数据从哪里来。那么如果是非常简单的数据源，比如一个关于页面中只有两列，版本信息和版权信息，而且也没有下拉刷新等功能，那么直接用Controller提供数据未尝不可，所有逻辑都集中在一个类中，比如下面的代码：

```objc
@interface WBListKitDemosViewController ()<WBListActionToControllerProtocol>
@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation WBListKitDemosViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"WBListKit Demos";
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen     mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    [self.tableView bindAdapter:self.adapter];
    self.tableView.actionDelegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    
    // hide warnings
    __weak typeof(self) weakSelf = self;
    [self.adapter addSection:^(WBTableSection * _Nonnull section) {
        
        NSMutableArray *rows = [NSMutableArray new];
        [[weakSelf data] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            WBTableRow *row = [[WBTableRow alloc] init];
            row.calculateHeight = ^CGFloat(WBTableRow *row){
                return 60.0f;
            };
            row.associatedCellClass = [WBDemosCell class];
            row.data = obj;
            [rows addObject:row];
 
        }];
 
        [section addRows:rows]
        section.key = @"DemoIdentifier"
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_Z-wjbc-074017)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadData];
        });
    });
}

- (NSArray *)data{
    return @[@{@"title":@"Simple List",@"class":[WBSimpleListViewController class]},
             @{@"title":@"Expanding Cell List",@"class":[WBExpandingCellViewController class]},
             @{@"title":@"Reformer List",@"class":[WBReformerListViewController class]},
             @{@"title":@"FooterHeader List",@"class":[WBListHeaderFooterViewController class]},
             @{@"title":@"MVC Demos",@"class":[WBMVCViewController class]},
             @{@"title":@"Multi DataSource",@"class":[WBMultiSourceController class]},
             @{@"title":@"CollectionView",@"class":[WBCollectionViewController class]},
             @{@"title":@"Nested",@"class":[WBNestedViewController class]},
             @{@"title":@"Custom Layout",@"class":[WBCustomLayoutViewController class]},
             @{@"title":@"WaterFall Layout",@"class":[WBWaterFallViewController class]},
             @{@"title":@"Empty Kit Swift ",@"class":[WBSwiftEmptyViewController class]},
             @{@"title":@"Empty Kit OC ",@"class":[WBOCEmptyViewController class]}
             ];
}
@end

```

以上代码，提供数据源的方法 `- (NSArray *)data` ，加载数据的方法 `- (void)loadData` ，这样些并没有什么问题，但是如果提供数据源方法业务逻辑复查杂（查询数据库，加载网络，缓存），而且还要支持上拉刷新等操作，都写在控制器里面，坏处是显而易见的，那么这个时候我们就急需要一个Model层和一个Dao层，所以框架提供了列表类的数据源 `WBListDataSource` 此类定义了外部（通常是控制器）操作数据源的接口`loadSource` `loadMoreSource` `cancelLoad`和属性 `canLoadMore`，对外部提供代理方法 `WBListDataSourceDelegate`来汇报其自身的状态：

```objc
@protocol WBListDataSourceDelegate <NSObject>

@optional

- (void)sourceDidStartLoad:(WBListDataSource *)tableSource;
- (void)sourceDidFinishLoad:(WBListDataSource *)tableSource ;
- (void)sourceDidStartLoadMore:(WBListDataSource *)tableSource;
- (void)sourceDidFinishLoadMore:(WBListDataSource *)tableSource;

- (void)source:(WBListDataSource *)tableSource loadError:(NSError *)error;
- (void)source:(WBListDataSource *)tableSource loadMoreError:(NSError *)error;
- (void)source:(WBListDataSource *)source didReceviedExtraData:(id)data;

- (void)sourceDidClearAllData:(WBListDataSource *)tableSource;

@end
```  

子类可以在合适的时机调用如下这些方法驱动delegate:

```objc
@interface WBListDataSource (NotifyController)

- (void)notifyWillLoad;
- (void)notifyWillLoadMore;
- (void)notifyDidFinishLoad;
- (void)notifyDidFinishLoadMore;
- (void)notifyDidReceviedExtraData:(nonnull id)data;
- (void)notifyLoadError:(nonnull NSError *)error;
- (void)notifyLoadMoreError:(nonnull NSError *)error;
- (void)notifySourceDidClear;

@end
```

并提供了两个子类 `WBTableViewDataSource` `WBCollectionViewDataSource` 、两个子类中分别带有 `UITableViewAdapter` `UICollectionViewAdapter` 用于拼装数据。用这种方法之后代码见 `MVC` 文件夹。并且当页面中存在多种数据源的时候，只需要切换就可以了，代码见 `MultiDataSource` 文件夹，代码就不大段贴了，只贴一部分控制器的代码，可以看出来，很精简。

```objc
@interface WBMVCViewController ()<WBListActionToControllerProtocol>

@end

@implementation WBMVCViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self createView];
    self.list.tableDataSource = [[WBMVCTableListDataSource alloc] initWithDelegate:self];
    [self.list.tableView bindViewDataSource:self.list.tableDataSource];
    
    [self.list refreshImmediately];
}

- (void)createView{
    WBMVCRefreshHeader *header = [[WBMVCRefreshHeader alloc] init];
    self.list.refreshHeaderControl = header;
    
    self.list.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,           [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.list.tableView];
    
    WBMVCRefreshFooter *footer = [[WBMVCRefreshFooter alloc] init];
    self.list.loadMoreFooterControl = footer;
}

- (void)sourceDidStartLoad:(WBListDataSource *)tableSource{
    
}

- (void)actionFromReusableView:(UIView *)view eventTag:(NSString *)tag parameter:(id)param{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end

```

### 看不明白self.list是什么？

到目前为止，之前提出的问题大部分都解决了，只是还剩一个，下拉刷新和上拉加载更多怎么支持？**这些动作其实是View层发出的action，我们应该交由Controller层响应事件，然后通知DataSource刷新数据，然后Controller再响应DataSource的回调刷新View，这个流程是所有业务方都有的流程，** 那么我们是不是可以提供一个列表控制器的基类来完成一些View和DataSource的协调工作呢，这样子类就天然拥有了这些协调工作，可以，但是不够完美，因为看到了继承，而且还是控制器的继承，一旦我们要求业务方继承一个控制器，那么就很难将框架应用到现有的项目中，而且继承是强耦合的范式，也不方便扩展。那用协议怎么样？协议是最好的解决办法，但是我们不仅需要统一的接口，也需要一些实现好的接口，OC语言也天然没有支持协议默认实现的功能(Swift中的协议扩展适合解决这个问题，OC可以通过[ProtocolKit](https://github.com/forkingdog/ProtocolKit)解决).那么我们可以给`UIViewController`提供一个proxy对象，通过组合的方式给`UIViewController`提供列表功能，这个属性叫`list`（只要在现有项目中控制器没有这个list属性的命名冲突就可以0成本接入了），`list`是一个 `WBListController`类型的实例，继承自(NSObject)，提供了全套的列表功能支持，代码如下：

```objc
@interface WBListController : NSObject<WBListDataSourceDelegate>

/**
 创建列表控制器

 @param viewController 'UIViewController'
 @return listController
 */
- (nullable instancetype)initWithController:(nonnull UIViewController *)viewController;

/**
 refresh
 */
- (void)dragToRefresh; //会引发refreshHeaderControl的刷新动画(调用refreshHeaderControl中的begin方法)
- (void)refreshImmediately; //直接刷新数据源，不会引发refreshHeaderControl变化

/**
 加载更多的两种方式，通常，这两个方法需要手工调用的情况很少，加载更多的控件会在合适的时机自动调用它们
 我能想到的场景就是在做预加载的情况下可以调用
 */
- (void)dragToLoadMore;
- (void)loadMoreImmediately;

/**
 提供一个WBTableViewDataSource和UITableView
 注意不能同时存在UITableView和UICollectionView，如果同时存在会产生异常
 */
@property (nonatomic, strong, nullable) WBTableViewDataSource *tableDataSource;
@property (nonatomic, strong, nullable) UITableView *tableView;

/**
 提供一个WBCollectionViewDataSource和UICollectionView
 注意不能同时存在UITableView和UICollectionView，如果同时存在会产生异常
 */
@property (nonatomic, strong, nullable) WBCollectionViewDataSource *collectionDataSource;
@property (nonatomic, strong, nullable) UICollectionView *collectionView;


/**
 集成下拉刷新和上拉加载更多的接口，框架内部会在合适的时机调用接口中定义的方法
 */
@property (nonatomic, strong, nullable) id<WBListRefreshHeaderViewProtocol> refreshHeaderControl;
@property (nonatomic, strong, nullable) id<WBListRefreshFooterViewProtocol> loadMoreFooterControl;

@end

```
`WBListController`控制了MVC的数据流转

* 通过接口规范了同刷新控件的交互方式，可以插件化的提供刷新控件
* 响应刷新控件的消息，进而控制数据源
* 响应数据源回调，刷新View

如果你的业务不是上述加粗字体的流程，那么可以定义自己的 " `WBListController` "

### 刷新控件

利用如下四个协议：`WBListRefreshControlCallbackProtocol` `WBListRefreshControlProtocol` `WBListRefreshFooterViewProtocol` `WBListRefreshHeaderViewProtocol` ，一个实现好的刷新控件：

```objc
#import <MJRefresh/MJRefresh.h>
#import "WBListRefreshHeaderViewProtocol.h"

@interface WBMVCRefreshHeader : MJRefreshStateHeader<WBListRefreshHeaderViewProtocol>

@end

@interface WBMVCRefreshHeader ()
@property (nonatomic, weak) UIScrollView *attchedView;
@end

@implementation WBMVCRefreshHeader

- (void)begin{
    [self beginRefreshing];
}

- (void)end{
    [self endRefreshing];
}

- (void)attachToView:(UIScrollView *)scrollView
      callbackTarget:(id<WBListRefreshControlCallbackProtocol>)target{
    
    self.attchedView = scrollView;
    scrollView.mj_header = self;
    self.refreshingTarget = target;
    self.refreshingBlock = ^{
        [target refreshControlBeginRefreshing];
    };
}

- (void)enable{
    self.attchedView.mj_header = self;
}

- (void)disable{
    self.attchedView.mj_header = nil;
}

@end
```

### 空页面加载，错误页面，空内容提示

老生常谈的问题，当View没有内容的时候，需要给一个全屏的提示，可能是正在加载的提示，可能是加载错误并没有缓存等。框架提供了 `WBListEmptyViewKit` 但是并没有耦合到框架内部。使用方法见Demo，由于 `WBListEmptyViewKit` 是使用Swift编写，而且用了协议扩展和泛型，目前并不能和业务方的OC代码混编，如果想要OC版本,[可看这里](https://github.com/dzenbot/DZNEmptyDataSet)，使用方法和 `WBListEmptyViewKit` 一样。 其实`WBListEmptyViewKit`就是仿照这个写的。类似这样：

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.empty.delegate = self
        tableView.empty.dataSource = self
        tableView.actionDelegate = self
        tableView.bindTableView(adapter)
        
        let leftItem: UIBarButtonItem = UIBarButtonItem(title: "增加", style: UIBarButtonItemStyle.plain, target: self, action: #selector(add))
        let rightItem: UIBarButtonItem = UIBarButtonItem(title: "清空", style: UIBarButtonItemStyle.plain, target: self, action: #selector(clear))
            
        self.navigationItem.rightBarButtonItems = [leftItem, rightItem]
        self.loadData()
    }

extension WBSwiftEmptyViewController : WBListEmptyKitDataSource{
    
    // 可以在这些方法中通过ViewSource的delegate方法中拿到error code 根据error code 
    // 返回特定的view
    
      // you can try
//    func ignoredSectionsNumber(in view: UIView) -> [Int]? {
//        return [0]
//    }
    
    // you can try
//    func emptyLabel(for emptyView: UIView, in view: UIView) -> UILabel? {
//        let label = UILabel()
//        label.text = "空页面"
//        label.textAlignment = NSTextAlignment.center
//        label.backgroundColor = UIColor.red
//        return label
//    }
    
    func emptyButton(for emptyView: UIView, in view: UIView) -> UIButton? {
        let button = UIButton()
        button.setTitle("空页面按钮演示，点击事件", for: UIControlState.normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        return button
    }
}

extension WBSwiftEmptyViewController : WBListEmptyKitDelegate{
    
    func emptyView(_ emptyView: UIView, button: UIButton, tappedInView: UIView) {
        print( #function, #line, type(of: self))
    }
    
    func emptyView(_ emptyView: UIView, tappedInView: UIView) {
        print( #function, #line, type(of: self))
    }
}
```    


### UICollectionView

实现原理和用法和UITableView一样，不同点如下：

* 高度缓存，UICollectionView的Item的Size是由布局对象决定，而且UICollectionView内部已经做好了高度缓存。
* 提供了 `WBCollectionSupplementaryItem` 支持
* 结合自定义布局 请看 `CustomLayout` 提供了两个例子

### 在UITableViewCell中嵌入UICollectionView

```objc
@implementation WBNestedTableViewCell

@synthesize row = _row;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.contentView.backgroundColor = [UIColor redColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.contentView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.actionDelegate = self;
    
    [self makeLayout];
    
    self.adapter = [[WBCollectionViewAdapter alloc] init];
    [self.collectionView bindAdapter:self.adapter];
    
    return self;
}

- (void)makeLayout{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)update{
    [self.adapter deleteAllElements];
    [self.collectionView reloadData];
    
    // data from ... anywhere
    
    [self.adapter addSection:^(WBCollectionSection * _Nonnull section) {
        maker.setIdentifier(@"WBNested");
        for (NSInteger index = 0; index < 100; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBNestedCollectionViewCell class];
            item.data = @{@"title":@(index)
                          };
           [section addItem:item];
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(40, 40);
}

@end
```

### MVVM

对于表单提交类的列表来说，MVVM可能很合适，框架内部虽然没有支持，也是考虑到每个项目的MVVM选型不一样，但是Reformer机制已经提供了足够多的灵活性，Reformer可以结合ReactCocoa或者KVOController来实现MVVM。

### 问题

Reformer的设计是否存在摇摆不定？如果框架没有一个范式来约束什么时候用原始类型什么时候用Reformer，那么业务方怎么保证用的准确？









