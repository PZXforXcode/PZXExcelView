//
//  PZXExcelView.m
//  PZXExcelView
//
//  Created by pzx on 2021/5/13.
//  Copyright © 2021 pzx. All rights reserved.
//

#import "PZXExcelView.h"
#import "ExcelTableViewCell.h"
#import "ExcelCollectionViewCell.h"
#import "DefineData.h"

@interface PZXExcelView ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UIView *topView;
@property(strong,nonatomic)UICollectionView *topExcelCollectionView;
@property(strong,nonatomic)UITableView *ExcelTableView;
@property (assign, nonatomic) CGPoint cacheContentOffset;

@end

@implementation PZXExcelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 0.5;
        self.rowNumber = 5;
        self.columnNumber = 5;

        [self initTopView];
        [self initTableView];
        
        
        
    }
    return self;
}

//顶部headerView
-(void)initTopView{
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, rowHeight)];
    self.topView.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.topView];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rowWidth, rowHeight)];
    firstLabel.text = @"左上头";
    firstLabel.font = [UIFont systemFontOfSize:12.f];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.layer.borderWidth = 0.5;
    [self.topView addSubview:firstLabel];
    
    
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat edge = 0.f;
            layout.itemSize = CGSizeMake(rowWidth, rowHeight);
            layout.minimumLineSpacing = edge;
            layout.minimumInteritemSpacing = edge;
            layout.sectionInset = UIEdgeInsetsMake(edge, edge, edge, edge);

    //    layout.itemSize
        _topExcelCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(rowWidth, 0, self.topView.frame.size.width - rowWidth, rowHeight) collectionViewLayout:layout];
        [_topExcelCollectionView registerClass:[ExcelCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
          _topExcelCollectionView.backgroundColor = [UIColor orangeColor];
    _topExcelCollectionView.showsHorizontalScrollIndicator = NO;
        _topExcelCollectionView.delegate = self;
        _topExcelCollectionView.dataSource = self;
        [self addSubview:_topExcelCollectionView];
    

    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        
        ExcelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.layer.borderWidth = 0.5;
        cell.backgroundColor = [UIColor clearColor];
    //顶部类型（可以根据index.row去dataSource数据修改值）
        cell.excelLabel.text = [NSString stringWithFormat:@"顶部类型%ld",indexPath.row];
        return cell;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.columnNumber;
}

-(void)initTableView{
    
    self.ExcelTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, rowHeight, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    self.ExcelTableView.delegate = self;
    self.ExcelTableView.dataSource = self;
    self.ExcelTableView.backgroundColor = [UIColor redColor];
    [self.ExcelTableView registerClass:[ExcelTableViewCell class] forCellReuseIdentifier:@"ExcelTableViewCell"];
    [self addSubview:self.ExcelTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.rowNumber;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
       ExcelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExcelTableViewCell"];
     if (cell == nil)
     {
         cell = [[ExcelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExcelTableViewCell"];
     }
    cell.columnNumber = self.columnNumber;
    cell.row = indexPath.row;
    cell.innerExcelCollectionView.delegate = self;
    cell.innerExcelCollectionView.delegate = self;
//    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return rowHeight;
}


- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    
    
            if ([scrollView isKindOfClass:[UICollectionView class]]) {
    
                if (scrollView.contentOffset.y != 0) {
                    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
                    return;
                }
    
                NSLog(@"scroll123 %f",scrollView.contentOffset.x);
    
    
    
                self.topExcelCollectionView.contentOffset = scrollView.contentOffset;
    
                for (ExcelTableViewCell* cell in self.ExcelTableView.visibleCells) {
    
                   for (UIView *view in cell.contentView.subviews) {
                       
                       if ([view isKindOfClass:[UICollectionView class]]) {
                           
                           UICollectionView *collectionView = (UICollectionView *)view;
                           collectionView.contentOffset = scrollView.contentOffset;
                           self.cacheContentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
                       }
                   }
    
                }
    
    
    
            }else{
                
                    self.topExcelCollectionView.contentOffset = self.cacheContentOffset;
                    for (ExcelTableViewCell* cell in self.ExcelTableView.visibleCells) {
                
                       for (UIView *view in cell.contentView.subviews) {
                           if ([view isKindOfClass:[UICollectionView class]]) {
                               UICollectionView *collectionView = (UICollectionView *)view;
                               collectionView.contentOffset = self.cacheContentOffset;
                           }
                       }
                
                    }
            }



}

-(void)setRowNumber:(NSInteger)rowNumber{
    
    _rowNumber = rowNumber;
    [self.ExcelTableView reloadData];
    
}

-(void)setColumnNumber:(NSInteger)columnNumber{
    
    _columnNumber =columnNumber;
    [self.topExcelCollectionView reloadData];
    [self.ExcelTableView reloadData];

}


@end
