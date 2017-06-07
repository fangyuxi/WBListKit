//
//  WBListRowDataProviderProtocal.h
//  Pods
//
//  Created by fangyuxi on 2017/3/20.
//
//

@class WBTableRow;

#ifndef WBTableRowDataReformerProtocal_h
#define WBTableRowDataReformerProtocal_h



/**
     如果获取的rawdata不能直接用于cell渲染，或者需要一些额外的state，那么你需要一个转换器转换数据格式后提供给cell渲染
 
     WBTableRow *row = [[WBTableRow alloc] init];
     row.calculateHeight = ^CGFloat(WBTableRow *row){
     return 60.0f;
     };
     NSDictionary *rawData = @{@"title":@(index),@"date":[NSDate new]};
     row.associatedCellClass = [WBReformerListCell class];
     WBReformerListCellReformer *reformer = [WBReformerListCellReformer new];
     [reformer reformRawData:rawData forRow:row];
     row.data = reformer;
     maker.addRow(row);
 
     WBReformerListCellReformer mybe has some customized properties used by cell in 'update' method
 
     - (void)update{
         WBReformerListCellReformer *reformer = self.row.data;
         self.title.text = reformer.title;
         self.date.text = reformer.date;
     }
 */
@protocol WBListDataReformerProtocol <NSObject>

- (void)reformRawData:(id)data forRow:(WBTableRow *)row;

@optional
@property (nonatomic, strong) id rawData;

@end

#endif /* WBTableRowDataReformerProtocal_h */
