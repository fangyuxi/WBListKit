Pod::Spec.new do |s|
    s.name             = 'WBListKit'
    s.version          = '0.2'
    s.summary          = 'A Wrapper of UICollectionView & UITableView'
    s.description      = 'Esay and Quick to use UICollectionView & UITableView to build list'
    s.homepage         = 'https://github.com/fangyuxi/WBListKit'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'xcoder.fang@gmail.com' => 'fangyuxi@58.com' }
    s.source           = { :git => 'https://github.com/fangyuxi/WBListKit.git', :tag => s.version.to_s}

    s.ios.deployment_target = '7.0'
    s.requires_arc = true
    s.frameworks = 'UIKit'

    s.source_files = 'Pod/Classes/**/*'
    s.dependency 'MJRefresh'
    s.dependency 'UITableView+FDTemplateLayoutCell'
end
