# WBListKit


## 简介

列表，在iOS中是最常用的UI，可以说我们在开发项目的时候有一半以上的时间是在和列表打交道，但是在写列表的时候我们并不愉快</br>
为了解决在项目中使用UITableView和UICollectionView的时候，要写很多重复的代码，而且每个人写法和代码风格不统一的问题，
WBListKit封装了UITableView和UICollectionView

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

**注意:** 只介绍针对`UITableView`的实现方式，`UICollectionView`的实现大体相似，后续只介绍不同的地方


针对`UITableView`的每一行，抽象成对象`WBTableRow`，针对`UITableView`的每一个section，抽象成`WBTableSection`对象，将Header和Footer抽象成`WBTableSectionHeaderFooter`对象<br>
同时提供了`WBTableSectionMaker`用于配置section并实现链式操作<br>
`WBTableViewAdapter`实现了`UITableView`的全部数据源方法和部分代理方法，将之前重复的（团队中成员为了实现相同的逻辑，但是代码并不相同）代码封装成一个内聚的对象<br>
`WBTableViewAdapter`并不关心数据从哪里来(Tag1)，只是将数据按照一定的格式拼装(Tag2)给`UITableView`使用，下面分别介绍下这几个对象<br>

### WBTableRow

`WBTableRow`代表了一行，同时充当了`UITableViewCell`的模型，主要完成以下工作<br>
* 通过属性`associatedCellClass`关联一个已经实现了`WBTableCellProtocal`协议的`UITableViewCell`对象（同时支持NIB）
* 可以配置这个`Cell`是使用自动布局的方式确定高度还是使用Frame方式布局
* 框架除了会帮你通过`IndexPath`确定`Cell`的具体位置之外，还会根据具体位置抽象出一个`WBTableRowPosition`,帮你确定`Cell`具体是`Top`,`Bottom`,`Middle`,`Single`<br>这样对于一些要根据`Cell`具体位置布局UI的情况就很方便了
* 提供一个`data`属性，为`Cell`提供真正的数据源，`data`对象到底是什么类型，下面再讨论

### WBTableSection WBTableSectionMaker

* `maker`负责装配`section`对象，增删改查`Row`
* 给`section`提供`id`，逻辑层就不用关心`section`的具体位置，只要通过`id`就可以找到想要的`section`，能够解决一部分UI位置一变，逻辑层也跟着变的窘境,一定程度也会解决各种数组越界的问题
* 给`section`添加`footer`和`header`

### WBTableSectionHeaderFooter
* `WBTableSectionHeaderFooter`类似于`WBTableRow`，都是给数据驱动的View(Tag3)提供模型
* 通过属性`associatedHeaderFooterClass`关联一个已经实现了`WBTableHeaderFooterViewProtocal`协议的`UITableViewReusebleView`对象（同时支持NIB）