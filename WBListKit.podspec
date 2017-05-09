Pod::Spec.new do |s|
    s.name             = 'WBListKit'
    s.version          = '0.2'
    s.summary          = 'A Wrapper of UICollectionView & UITableView'
    s.description      = 'Esay and Quick to use UICollectionView & UITableView to build list'
    s.homepage         = 'https://github.com/fangyuxi/WBListKit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'xcoder.fang@gmail.com' => 'fangyuxi@58.com' }
    s.source           = { :git => 'https://github.com/fangyuxi/WBListKit.git', :tag => s.version.to_s }

    s.ios.deployment_target = '7.0'
    s.requires_arc = true
    s.frameworks = 'UIKit'

    s.source_files = 'WBListKit/{WBListKit,WBListDataReformerProtocol,WBListKitAssert,WBListKitMacros,WBListReusableViewProtocol}.h'

    s.subspec 'TableView' do |t|
        t.source_files =    'WBListKit/WBTableRow.{h,m}', 
                            'WBListKit/WBTableSection.{h,m}',
                            'WBListKit/WBTableSectionMaker.{h,m}',
                            'WBListKit/WBTableSectionHeaderFooter.{h,m}',
                            'WBListKit/WBTableViewAdapter.{h,m}',
                            'WBListKit/WBTableViewDelegateProxy.{h,m}',
                            'WBListKit/WBTableCellProtocal.h',
                            'WBListKit/WBTableHeaderFooterViewProtocal.h',
                            'WBListKit/WBTableSectionPrivate.h'

        t.dependency 'UITableView+FDTemplateLayoutCell'
    end

    s.subspec 'CollectionView' do |c|
        c.source_files =    'WBListKit/WBCollectionItem.{h,m}', 
                            'WBListKit/WBCollectionSection.{h,m}',
                            'WBListKit/WBCollectionSectionMaker.{h,m}',
                            'WBListKit/WBCollectionViewAdapter.{h,m}',
                            'WBListKit/WBCollectionViewDelegateProxy.{h,m}',
                            'WBListKit/WBCollectionSupplementaryItem.{h,m}',
                            'WBListKit/WBCollectionCellProtocol.h',
                            'WBListKit/WBCollectionSupplementaryViewProtocol.h',
                            'WBListKit/WBCollectionSectionPrivate.h'

        c.dependency 'UITableView+FDTemplateLayoutCell'
    end

    s.subspec 'DataSource' do |d|
        d.source_files =    'WBListKit/WBListDataSource.{h,m}',
                            'WBListKit/WBTableViewDataSource.{h,m}',
                            'WBListKit/WBCollectionViewDataSource.{h,m}',
                            'WBListKit/WBListController.{h,m}',
                            'WBListKit/UIViewController+WBList.{h,m}',
                            'WBListKit/WBListDataSourceDelegate.h'
        d.dependency 'MJRefresh'
    end
end
