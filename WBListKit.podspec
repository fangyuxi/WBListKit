Pod::Spec.new do |s|
    s.name             = 'WBListKit'
    s.version          = '0.4'
    s.summary          = 'A Wrapper of UICollectionView & UITableView'
    s.description      = 'Esay and Quick to use UICollectionView & UITableView to build list'
    s.homepage         = 'https://github.com/fangyuxi/WBListKit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'xcoder.fang@gmail.com' => 'fangyuxi@58.com' }
    s.source           = { :git => 'https://github.com/fangyuxi/WBListKit.git', :tag => "1.0.1"}

    s.ios.deployment_target = '7.0'
    s.requires_arc = true
    s.frameworks = 'UIKit'

    s.source_files = 'WBListKit/{WBListKit,WBListDataReformerProtocol,WBListKitAssert,WBListKitMacros,WBListReusableViewProtocol,WBListRefreshControlCallbackProtocol,WBListRefreshControlProtocol,WBListRefreshHeaderViewProtocol,WBListRefreshFooterViewProtocol,WBListDiffableProtocol}.h'
    s.public_header_files = 'WBListKit/{WBListKit,WBListDataReformerProtocol,WBListKitAssert,WBListKitMacros,WBListKitMacros,WBListReusableViewProtocol,WBListRefreshControlCallbackProtocol,WBListRefreshControlProtocol,WBListRefreshHeaderViewProtocol,WBListRefreshFooterViewProtocol,WBListDiffableProtocol}.h'

    s.subspec 'Differ' do |d|
        d.source_files = 'WBListKit/IGListAssert.h',
        'WBListKit/IGListCompatibility.h',
        'WBListKit/IGListDiffable.h',
        'WBListKit/IGListDiffKit.h',
        'WBListKit/IGListExperiments.h',
        'WBListKit/IGListIndexPathResultInternal.h',
        'WBListKit/IGListIndexSetResultInternal.h',
        'WBListKit/IGListMacros.h',
        'WBListKit/IGListMoveIndexInternal.h',
        'WBListKit/IGListMoveIndexPathInternal.h',
        'WBListKit/IGListDiff.{h,mm}',
        'WBListKit/IGListBatchUpdateData.{h,mm}',
        'WBListKit/IGListBatchUpdates.{h,m}',
        'WBListKit/IGListIndexPathResult.{h,m}',
        'WBListKit/IGListIndexSetResult.{h,m}',
        'WBListKit/IGListMoveIndex.{h,m}',
        'WBListKit/IGListMoveIndexPath.{h,m}',
        'WBListKit/IGListReloadIndexPath.{h,m}',
        'WBListKit/NSNumber+IGListDiffable.{h,m}',
        'WBListKit/NSString+IGListDiffable.{h,m}',
        'WBListKit/UICollectionView+IGListBatchUpdateData.{h,m}'

        d.public_header_files = 'WBListKit/{IGListAssert,IGListCompatibility,IGListDiffable,IGListDiffKit,IGListExperiments,IGListIndexPathResultInternal,IGListIndexSetResultInternal,IGListMacros,IGListMoveIndexInternal,IGListMoveIndexPathInternal,IGListDiff,IGListBatchUpdateData,IGListBatchUpdates,IGListIndexPathResult,IGListIndexSetResult,IGListMoveIndex,IGListReloadIndexPath,IGListMoveIndexPath,NSNumber+IGListDiffable,NSString+IGListDiffable,UICollectionView+IGListBatchUpdateData}.h'
    end

    s.subspec 'TableView' do |t|
        t.dependency 'UITableView+FDTemplateLayoutCell'
        t.source_files = 'WBListKit/WBTableRow.{h,m}',
        'WBListKit/UITableView+WBListKitPrivate.{h,m}',
        'WBListKit/UITableView+WBListKit.{h,m}',
        'WBListKit/WBTableSection.{h,m}',
        'WBListKit/WBTableSectionHeaderFooter.{h,m}',
        'WBListKit/WBTableViewAdapter.{h,m}',
        'WBListKit/WBTableViewDelegateProxy.{h,m}',
        'WBListKit/WBTableUpdater.{h,m}',
        'WBListKit/WBTableCellProtocal.h',
        'WBListKit/WBTableSectionPrivate.h',
        'WBListKit/WBTableHeaderFooterViewProtocal.h',
        'WBListKit/WBTableViewAdapterPrivate.h'
        t.public_header_files = 'WBListKit/{WBTableRow,UITableView+WBListKitPrivate,UITableView+WBListKit,WBTableSection,WBTableSectionHeaderFooter,WBTableViewAdapter,WBTableViewDelegateProxy,WBTableCellProtocal,WBTableHeaderFooterViewProtocal,WBTableViewAdapterPrivate,WBTableSectionPrivate}.h'
    end

    s.subspec 'CollectionView' do |c|
        c.source_files =    'WBListKit/WBCollectionItem.{h,m}',
                            'WBListKit/UICollectionView+WBListKitPrivate.{h,m}',
                            'WBListKit/WBCollectionViewAdapterPrivate.h',
                            'WBListKit/UICollectionView+WBListKit.{h,m}',
                            'WBListKit/WBCollectionUpdater.{h,m}',
                            'WBListKit/WBCollectionSection.{h,m}',
                            'WBListKit/WBCollectionViewAdapter.{h,m}',
                            'WBListKit/WBCollectionViewDelegateProxy.{h,m}',
                            'WBListKit/WBCollectionSupplementaryItem.{h,m}',
                            'WBListKit/WBCollectionCellProtocol.h',
                            'WBListKit/WBCollectionSupplementaryViewProtocol.h',
                            'WBListKit/WBCollectionSectionPrivate.h'
        c.public_header_files = 'WBListKit/{WBCollectionItem,UICollectionView+WBListKitPrivate,WBCollectionViewAdapterPrivate,UICollectionView+WBListKit,WBCollectionSection,WBCollectionViewAdapter,WBCollectionViewDelegateProxy,WBCollectionSupplementaryItem,WBCollectionCellProtocol,WBCollectionSupplementaryViewProtocol,WBCollectionSectionPrivate}.h'
        c.dependency 'UITableView+FDTemplateLayoutCell'
    end

    s.subspec 'DataSource' do |d|
        d.source_files =    'WBListKit/WBListDataSource.{h,m}',
                            'WBListKit/WBTableViewDataSource.{h,m}',
                            'WBListKit/WBCollectionViewDataSource.{h,m}',
                            'WBListKit/WBListController.{h,m}',
                            'WBListKit/UIViewController+WBList.{h,m}',
                            'WBListKit/WBMustOverride.{h,m}',
                            'WBListKit/WBListDataSourceDelegate.h',
                            'WBListKit/WBTableViewDataSourcePrivate.h',
                            'WBListKit/WBCollectionViewDataSourcePrivate.h'
        d.public_header_files = 'WBListKit/{WBListDataSource,WBTableViewDataSource,WBCollectionViewDataSource,WBListController,UIViewController+WBList,WBListDataSourceDelegate,WBTableViewDataSourcePrivate,WBCollectionViewDataSourcePrivate}.h'
        d.dependency 'WBListKit/CollectionView'
        d.dependency 'WBListKit/TableView'
    end
end
