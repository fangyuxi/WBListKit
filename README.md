# WBListKit


## 简介

列表，在iOS中是最常用的UI，可以说我们在开发项目的时候有一半以上的时间是在和列表打交道，但是在写列表的时候我们并不愉快</br>
为了解决在项目中使用UITableView和UICollectionView的时候，要写很多重复的代码，而且每个人写法和代码风格不统一的问题，WBListKit封装了UITableView和UICollectionView。

## 特性

* 简单易用，会让团队中每个成员的代码风格统一，容易维护
* 功能强大，几乎适用于所有列表样式的UI
* 无类型污染，框架是基于协议设计，不存在继承体系，没有强耦合，扩展性强
* drop in clean，零成本接入现有项目，对旧代码没有影响
* 对下拉刷新和上拉加载更多有很好的支持
* 对空页面和错误页面提示提供了插件化支持
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
`WBTableViewAdapter`并不关心数据从哪里来(Tag1),只是将数据按照一定的格式拼装(Tag2)给`UITableView`使用，下面分别介绍下这几个对象<br>

### WBTableRow
`WBTableRow` 代表了一行,同时充当了`UITableViewCell`的模型，主要完成以下工作<br>
* 通过属性`associatedCellClass` 关联一个已经实现了`WBTableCellProtocol` 协议的`UITableViewCell`对象（同时支持NIB）
* 可以配置这个`Cell`是使用自动布局的方式[确定高度](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)还是使用Frame方式
* 框架除了会帮你通过`IndexPath`确定`Cell`的具体位置之外,还会根据具体位置抽象出一个`WBTableRowPosition`,帮你确定`Cell`具体是`Top`,`Bottom`,`Middle`,`Single`,这样对于一些要根据`Cell`具体位置布局UI的情况就很方便了很多
* 提供一个`data`属性,为`Cell`提供真正的数据源,`data`对象到底是什么类型,下面再讨论（这样的好处就在于不用为每一种类型的`Cell`都创建一种Row类型）

### WBTableSection WBTableSectionMaker
* `maker`负责装配`section`对象,增删改查`Row`,为section创建一个标识符
* 给`section`提供`id`,逻辑层就不用关心`section`的具体位置，只要通过`id`就可以找到想要的`section`,能够解决一部分UI位置一变，逻辑层也跟着变的窘境,一定程度也会解决各种数组越界的问题
* 给`section`添加`footer`和`header`
* 之所以提供一个maker，是因为方便以后扩展，section只是一个模型，如果以后有更多的逻辑，比如自动diff数组自动刷新等功能，显然不适合一股脑都放到section中，所以提供maker

### WBTableSectionHeaderFooter
* `WBTableSectionHeaderFooter`类似于`WBTableRow`,都是给数据驱动的View(Tag3)提供模型
* 通过属性`associatedHeaderFooterClass`关联一个已经实现了`WBTableHeaderFooterViewProtocal`协议的`UITableViewReusebleView`对象（同时支持NIB）
* 可以配置这个`WBTableSectionHeaderFooter`是使用自动布局的方式[确定高度](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)还是使用Frame方式

### (Tag3) 那么什么是数据驱动的View
iOS列表中数据驱动的View包括 `UITableViewCell` `UICollectionViewCell` `UITableViewFooter&Header` `UICollectionViewSupplementary` <br>
这些视图的很多行为相同，比如update,reset,reload,cancel,框架会在合适的时机回调这些方法，业务方只需要在这些方法做相应的事情就可以（大家的代码又一样了）所以就有了这个协议 `WBListReusableViewProtocol` 所以 `WBTableCellProtocal` `WBTableHeaderFooterViewProtocal` 都是 `WBListReusableViewProtocol` 的子协议 <br>
同时这些View还存在向外部抛出事件的需求，那么所有遵循 `WBListActionToControllerProtocol` 的对象都可以接受抛出事件的回调，大部分来讲这个对象是控制器<br>
这样所有的事件都有迹可循，每个人写的代码都八九不离十。 `WBListActionToControllerProtocol` 同时也继承了 `UITableViewDelegate`协议，结果所有事件都可以通过一个代理搞定

### WBTableViewAdapter

* 实现了 `UITableView` 的所有数据源和大部分代理方法，而且通过[拦截者](https://github.com/facebook/AsyncDisplayKit/blob/7b112a2dcd0391ddf3671f9dcb63521f554b78bd/AsyncDisplayKit/ASCollectionView.mm#L34-L53)方式，所以这些代理对业务方完全透明
* 自动注册 `UITableViewCell` `UICollectionViewCell` `UITableViewFooter&Header` `UICollectionViewSupplementary`
* 通过updateSection,addSection,deleteSection等操作给View装配数据,上代码：

```c
self.adapter = [[WBTableViewAdapter alloc] init];
self.tableView bindAdapter:self.adapter];
[self.adapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
        
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.associatedCellClass = [WBSimpleListCell class];
            row.data = @{@"title":@(index)
                            };
            maker.addRow(row);
        }
        
        maker.setIdentifier(@"FixedHeightSection");
    }];
```

Cell中的代码

```c
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

### (Tag2) 我们给Cell提供什么样的数据
第一种方式，不论什么情况下，直接将网络请求或者本地加载的数据，用原始类型(NSDictionary,NSArray...)提供给row的data属性，在cell的update方法中直接访问原始类型<br>
这种方式很好，不会造成类爆炸，可以在调试的时候直接打印，很直观，但是并不完美，如果一个cell有自己的状态，比如是否选中，比如是否在播放中，是否浏览过，这些状态如果我们也追加到原始类型中,就会出现表意不明，如果没有定义好足够明确的key，那么后期维护是很恐怖的。即便强制要求代码规范，但是项目是在生长的，很难讲什么时候走偏。<br>
第二种方式是通过映射(MJExtension,YYModel)等的方式将网络返回的原始数据转换（不讨论转换代码的位置，只讨论交付的数据）成Model交付给Cell,这样就解决了上面的问题，但是坏处也是显而易见的，会造成类爆炸，即便是简单的表单提交页面，也会写出很多不必要的Model。<br>

针对上述问题，框架提供了一个协议 `WBListDataReformerProtocol` 协议长这个样子：

```c
@protocol WBListDataReformerProtocol <NSObject>

- (void)reformRawData:(id)data forRow:(WBTableRow *)row;

@optional
@property (nonatomic, strong) id rawData;

@end
```
对于没有状态的Cell，使用原始数据类型表征就很清楚了，可以直接将原始类型扔给Cell用。<br>
对于带有自有状态，或者需要原始数据转化后才能显示的需求，创建一个遵循这个协议的对象，自定义对象属性，提供给Cell使用，代码如下:<br>
```C
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

```C
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

```C
- (void)update{
    WBReformerListCellReformer *reformer = (WBReformerListCellReformer *)self.row.data;
    self.title.text = reformer.title;
    self.date.text = reformer.date;
}
```

### (Tag3) 下面解决数据从哪里来的问题
从上面我们可以看出来,Adapter其实只是一个数据的装配器，`UITableView`的Adapter装配适合`UITableView`的数据，`UICollectionView`的Adapter装配适合`UICollectionView`的数据，它并不关心数据从哪里来的问题。
