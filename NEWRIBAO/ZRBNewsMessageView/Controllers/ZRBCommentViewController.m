//
//  ZRBCommentViewController.m
//  NEWRIBAO
//
//  Created by 萨缪 on 2018/11/19.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "ZRBCommentViewController.h"
#import <Masonry.h>
#import "ZRBCommentsTableViewCell.h"
@interface ZRBCommentViewController ()

@property (nonatomic, strong) ZRBCommentsTableViewCell * tempCell;

@property (nonatomic, strong) ZRBCommentsTableViewCell * shortTempCell;

@property (nonatomic, strong) ZRBLongCommentsJSONModel * allcommentsJSONModel;

@property (nonatomic, assign) NSInteger didCaculateRowAtIndexInteger;

@property (nonatomic, strong) NSLock * lock;

@end

@implementation ZRBCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isHeaderViewRefreshInteger = 0;
    _isRefreshInteger = 0;
    _buttonSelectedFlagInteger = 0;
    _realRideInteger = 0;
    _didCaculateRowAtIndexInteger = 0;
    _numOfLinesInteger = 0;
    
    _longCommentCellHeightMutArray = [[NSMutableArray alloc] init];
    _shortCellHeightMutArray = [[NSMutableArray alloc] init];
    _buttonSelectedFlagMutArray = [[NSMutableArray alloc] init];
    _cellIfRefreshButtonMutArray = [[NSMutableArray alloc] init];
    _longCellHeightMutArray = [[NSMutableArray alloc] init];
    _cellHeightMutArray = [[NSMutableArray alloc] init];
    _authorMutArray = [[NSMutableArray alloc] init];
    _contentMMutArray = [[NSMutableArray alloc] init];
    _avatorMutArray = [[NSMutableArray alloc] init];
    _timeMutArray = [[NSMutableArray alloc] init];
    _reply_toMutArray = [[NSMutableArray alloc] init];
    _onlyIdMutArray = [[NSMutableArray alloc] init];
    _likesMutArray = [[NSMutableArray alloc] init];
    _allDataMutArray = [[NSMutableArray alloc] init];
    
    _allShortDataMutArray = [[NSMutableArray alloc] init];
    _shortTimeMutArray = [[NSMutableArray alloc] init];
    _shortLikesMutArray = [[NSMutableArray alloc] init];
    _shortAuthorMutArray = [[NSMutableArray alloc] init];
    _shortAvatorMutArray = [[NSMutableArray alloc] init];
    _shortOnlyIdMutArray = [[NSMutableArray alloc] init];
    _shortContentMMutArray = [[NSMutableArray alloc] init];
    _shortReplyMutArray = [[NSMutableArray alloc] init];
//    _realLongCommentsInteger = 0;
//    _realShortCommentsInteger = 0;
    self.allcommentsJSONModel = [[ZRBLongCommentsJSONModel alloc] init];
    _longCommentsNumInteger = 0;
    _shortCommentsNumInteger = 0;
    
    self.title = [NSString stringWithFormat:@"%@ comments",[NSNumber numberWithInteger:_allCommentsNumInteger]];
    [self fenethLongCommentsFromJSONModel];
    self.commentView = [[ZRBCommentView alloc] init];
    [self.commentView.tableView registerClass:[ZRBCommentsTableViewCell class] forCellReuseIdentifier:@"commentCell"];
    [self.commentView.tableView registerClass:[ZRBCommentsTableViewCell class] forCellReuseIdentifier:@"shortCommentCell"];
    [self.commentView.tableView registerClass:[ZRBCommentsTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"commentsHeaderView"];
    
    
    _commentView.tableView.delegate = self;
    _commentView.tableView.dataSource = self;
//    _commentView.tableView.estimatedRowHeight = 100;
//    _commentView.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_commentView];
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tempCell = [[ZRBCommentsTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"commentCell"];
    self.shortTempCell = [[ZRBCommentsTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"shortCommentCell"];
    
    _nowSection = 0;
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setImage:[UIImage imageNamed:@"9.png"] forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(spreadCellSection:) forControlEvents:UIControlEventTouchUpInside];
    _flag = 0;
    _contentOffSetYHeight = 0;
    _refreshFlag = 0;
    
    _oneSectionFlag = 0;
    _twoSectionFlag = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL ifRefresh = NO;
    NSLog(@"_realShortCommentsInteger = %li",_realShortCommentsInteger);
    if ( section == 0 && _longCommentsNumInteger == 0 ){
        if ( _oneSectionFlag == 0 && _refreshFlag != 0 ){
        [_cellIfRefreshButtonMutArray addObject:@"123"];
        [_buttonSelectedFlagMutArray addObject:@"123"];
            _oneSectionFlag = 1;
        }
        return 1;
    }
    if ( section == 0 && _longCommentsNumInteger != 0 ){
        if ( _longCommentsNumInteger > 12 ){
            _longCommentsNumInteger = 12;
        }
        NSMutableArray * boolArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < _longCommentsNumInteger; i++) {
            [boolArray addObject:[NSNumber numberWithInteger:0]];
        }
        if ( _oneSectionFlag == 0 ){
            [_cellIfRefreshButtonMutArray addObject:boolArray];
            [_buttonSelectedFlagMutArray addObject:boolArray];
        }
        _oneSectionFlag = 1;
        return _longCommentsNumInteger;
    }
    //第一组存在 第二组数量总是1 Row 第一组那种存在 第一组数量为1；
    if ( section == 1 && _refreshFlag == 0 ){
        return 0;
    }
    
    if ( section == 1 && _refreshFlag != 0 && _realShortCommentsInteger != 0 ){
        if ( _realShortCommentsInteger > 12 ){
            _realShortCommentsInteger = 11;
        }
        NSMutableArray * boolArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < _realShortCommentsInteger; i++) {
            [boolArray addObject:[NSNumber numberWithInteger:0]];
        }
        if ( _twoSectionFlag == 0 ){
        [_cellIfRefreshButtonMutArray addObject:boolArray];
            [_buttonSelectedFlagMutArray addObject:boolArray];
        }
        _twoSectionFlag = 1;
        return _realShortCommentsInteger;
    }
        return 1;
}

//问题： 点击有的cell 在点击短评论会出现下拉到最下方 出现 13shortComments

//2.展开这个按钮赋值被复用 在不需要的地方被粘上
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //if ( !tableView.tableHeaderView ){
    NSLog(@"_realShortCommentsInteger = %li",_realShortCommentsInteger);
    _commentsHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"commentsHeaderView"];
    if ( _commentsHeaderView == nil ){
        _commentsHeaderView = [[ZRBCommentsTableViewHeaderView alloc] initWithReuseIdentifier:@"commentsHeaderView"];
    }
    if ( section == 0 && _longCommentsNumInteger != 0 ){
        _commentsHeaderView.commentsNumLabel.text = [NSString stringWithFormat:@"%li longComments",_realLongCommentsInteger];
    }
    else if (section == 0 && _longCommentsNumInteger == 0 ){
        _commentsHeaderView.commentsNumLabel.text = @" ";
    }
    else if (section == 1){
//        if ( _isHeaderViewRefreshInteger == 1 ){
//            return _commentsHeaderView;
//        }
        _commentsHeaderView.commentsNumLabel.text = [NSString stringWithFormat:@"%li shortComments",_realShortCommentsInteger];
        [_commentsHeaderView addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_commentsHeaderView.mas_right).offset(-80);
            make.right.equalTo(_commentsHeaderView.mas_right);
            make.height.mas_equalTo(_commentsHeaderView.mas_height);
        }];
        _nowSection = section;
    }
 //   }
   // return nil;
    return _commentsHeaderView;
}

- (void)spreadCellSection:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    NSIndexSet * indexSet = [[NSIndexSet alloc] initWithIndex:_nowSection];
    if ( btn.selected ){
        _refreshFlag++;
        _flag++;
    }else{
        _refreshFlag--;
        _flag--;
    }
    NSInteger i = 0;
    NSLog(@"_flag = %li",_flag);
    if ( _flag == 1 ){
        if ( _contentOffSetYHeight != 0 ){
    _commentView.tableView.contentOffset = CGPointMake(0, _contentOffSetYHeight-5);
        }else{
            _commentView.tableView.contentOffset = CGPointMake(0, 245);
        }
        NSLog(@"Spread里面_contentOffSetYHeight = %f",_contentOffSetYHeight);
    }else{
        if ( _contentOffSetYHeight != 0 ){
        _commentView.tableView.contentOffset = CGPointMake(0, (_contentOffSetYHeight-5)*(-1));
            
        }else{
            _commentView.tableView.contentOffset = CGPointMake(0, -245);
        }
    }
    
    [_commentView.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    //[_commentView.tableView endUpdates];
//    通过协议传值把头视图弄到顶部
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if ( _isHeaderViewRefreshInteger == 1 ){
//        return 0.1;
//    }
    if ( section == 0 && _longCommentsNumInteger != 0 ){
        return 50;
    }
    else if (section == 0 && _longCommentsNumInteger == 0){
        return 0.1;
    }
    else if(section == 1){
        return 50;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"5555indexPath.row = %li,indexPath.section = %li",indexPath.row,indexPath.section);
    if ( indexPath.section == 0 && _longCommentsNumInteger != 0 ){
        if ( [self.allDataMutArray isKindOfClass:[NSArray class]] && _allDataMutArray.count > 0 ){
            CGFloat cellHeight = 0;
            if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 0 ){
                self.tempCell.expandButton.selected = YES;
                [self.tempCell changeNumberOfLines];
                cellHeight = [self.tempCell heightForModel:_allDataMutArray[0][indexPath.row]];
            }
            else if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 1 )
            {
                self.tempCell.expandButton.selected = NO;
                [self.tempCell zeroToChangeNumberOfLines];
                cellHeight = [self.tempCell heightForModel:_allDataMutArray[0][indexPath.row]];
            }
            
    //CGFloat cellHeight = [self.tempCell heightForModel:_allDataMutArray[0][indexPath.row]];
            if ( _didCaculateRowAtIndexInteger < _longCommentsNumInteger ){
                _contentOffSetYHeight += cellHeight;
                _didCaculateRowAtIndexInteger++;
            }
            [_longCommentCellHeightMutArray addObject:[NSNumber numberWithFloat:cellHeight]];
            if ( _longCommentCellHeightMutArray.count == _longCommentsNumInteger ){
                return [_longCommentCellHeightMutArray[indexPath.row] floatValue];
            }
    return cellHeight;
        }else{
            return 300;
        }
        
    }
    else if (indexPath.section == 1 && _shortCommentsNumInteger != 0 ){
        if ( [self.allShortDataMutArray isKindOfClass:[NSArray class]] && self.allShortDataMutArray.count > 0 ){
            NSLog(@"这时的indexPath.row = %li",indexPath.row);
            
            if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 0 ){
                            NSLog(@"indexPath.row = %li,indexPath.section = %li",indexPath.row,indexPath.section);
                            self.shortTempCell.expandButton.selected = YES;
                            [self.shortTempCell changeNumberOfLines];
                            _isRefreshInteger = 1;
            }
            else if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 1 )
            {
                            self.shortTempCell.expandButton.selected = NO;
                            [self.shortTempCell zeroToChangeNumberOfLines];
            }
            
            CGFloat cellHeight = [self.shortTempCell heightForModel:_allShortDataMutArray[0][indexPath.row]];
            NSLog(@"indexPath.row = %li",indexPath.row);
            NSString * shortStr = [NSString stringWithFormat:@"%@",_allShortDataMutArray[0][indexPath.row]];
            NSLog(@"_allShortDataMutArray[0][indexPath.row]] = %@",[NSString stringWithFormat:@"%@",shortStr]);
            [_shortCellHeightMutArray addObject:[NSNumber numberWithFloat:cellHeight]];
            if ( _shortCellHeightMutArray.count == _shortCommentsNumInteger ){
                return [_shortCellHeightMutArray[indexPath.row] floatValue];
            }
            return cellHeight;
        }
    }
        return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"1111");
    NSLog(@"indexPath.row = %li,indexPath.section = %li",indexPath.row,indexPath.section);
    ZRBCommentsTableViewCell * cell = nil;
    ZRBCommentsTableViewCell * shortCell = nil;
    
    cell = [self.commentView.tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    shortCell = [self.commentView.tableView dequeueReusableCellWithIdentifier:@"shortCommentCell"];
    if ( cell == nil ){
        cell = [[ZRBCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentCell"];
    }
    if ( shortCell == nil ){
        shortCell = [[ZRBCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shortCommentCell"];
    }
    
    [cell.expandButton addTarget:self action:@selector(pressExpandButton:) forControlEvents:UIControlEventTouchUpInside];
    [shortCell.expandButton addTarget:self action:@selector(pressExpandButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ( indexPath.section == 0 && _longCommentsNumInteger != 0 ){
        if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 0 ){
            cell.expandButton.selected = YES;
            [cell changeNumberOfLines];
        }
        else if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 1 )
        {
            cell.expandButton.selected = NO;
            [cell zeroToChangeNumberOfLines];
        }
        NSInteger q = 0;
        if ( [self.allDataMutArray isKindOfClass:[NSArray class]] && self.allDataMutArray.count > 0 ){
            if ( [_longCellHeightMutArray[indexPath.row] floatValue] < 50 ){
                cell.expandButton.hidden = YES;
            }else{
                cell.expandButton.hidden = NO;
            }
                [cell setMessage:self.allDataMutArray[0][indexPath.row]];
        }
        return cell;
    }
    
    if ( indexPath.section == 0 && _longCommentsNumInteger == 0 && _realRideInteger == 1 ){
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"10.jpg"];
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        return cell;
    }
    
    if ( indexPath.section == 1 && _shortCommentsNumInteger != 0 && _refreshFlag != 0 ){
        if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 0 ){
            NSLog(@"indexPath.row = %li,indexPath.section = %li",indexPath.row,indexPath.section);
            shortCell.expandButton.selected = YES;
            [shortCell changeNumberOfLines];
            _isRefreshInteger = 1;
        }
        else if ( [_cellIfRefreshButtonMutArray[indexPath.section][indexPath.row] integerValue] == 1 )
        {
                shortCell.expandButton.selected = NO;
                [shortCell zeroToChangeNumberOfLines];
        }
        
        NSInteger q = 0;
        if ( [self.allShortDataMutArray isKindOfClass:[NSArray class]] && self.allShortDataMutArray.count > 0 ){
            NSArray * array = [NSArray arrayWithObject:_allShortDataMutArray[0]];
            NSLog(@"array.count = %li",array.count);
            if ( [_cellHeightMutArray[indexPath.row] floatValue] < 50 ){
                shortCell.expandButton.hidden = YES;
            }else{
                shortCell.expandButton.hidden = NO;
            }
            [shortCell setMessage:_allShortDataMutArray[0][indexPath.row]];
        }
        NSInteger j = 0;
        if ( _flag == 0 ){
            shortCell.hidden = YES;
        }else{
            shortCell.hidden = NO;
            
        }
    }
    return shortCell;
}


//问题 为什么所有的button都走了这个方法?
- (void)pressExpandButton:(UIButton *)idSender
{
    //刷新的时候 头视图也会被刷新
    _isHeaderViewRefreshInteger = 1;
    ZRBCommentsTableViewCell * cell = (ZRBCommentsTableViewCell *)idSender.superview.superview;
    if ( _buttonSelectedFlagInteger == 1 ){
        //_numOfLinesInteger = 2;
    }else{
        //_numOfLinesInteger = 0;
    }
    NSIndexPath * indexPath = [_commentView.tableView indexPathForCell:cell];
    NSLog(@"12321indexPath.section = %li",indexPath.section);
    NSLog(@"12312indexPath.row = %li",indexPath.row);
    NSIndexPath * nowIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    NSInteger sectionInteger = nowIndexPath.section;
    NSInteger rowInteger = nowIndexPath.row;
    NSLog(@"_cellIfRefreshButtonMutArray = %@",_cellIfRefreshButtonMutArray);
    if ( [_cellIfRefreshButtonMutArray[sectionInteger][rowInteger] integerValue] == 0 ){
        if ( _isRefreshInteger == 1 ){
            
        }
        _cellIfRefreshButtonMutArray[sectionInteger][rowInteger] = [NSNumber numberWithInteger:1];
    }
    else if ( [_cellIfRefreshButtonMutArray[sectionInteger][rowInteger] integerValue] == 1 )
    {
        _cellIfRefreshButtonMutArray[sectionInteger][rowInteger] = [NSNumber numberWithInteger:0];
        //_buttonSelectedFlagMutArray[sectionInteger][rowInteger] = [NSNumber numberWithInteger:1];
    }
    

    //在这里添加代理  在cell中执行代理

    //[_commentView.tableView beginUpdates];
    
    NSNotification * notification = [NSNotification notificationWithName:@"changHeightNoti" object:@{@"numberOfLines":[NSNumber numberWithInteger:_numOfLinesInteger]}];
    //[[NSNotificationCenter defaultCenter] postNotification:notification];
    
    NSArray * reloadIndexPaths = [NSArray arrayWithObject:nowIndexPath];
    NSLog(@"reloadIndexPaths = %@",reloadIndexPaths);
    [_commentView.tableView reloadRowsAtIndexPaths:@[nowIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //[_commentView.tableView endUpdates];
}



- (void)fenethLongCommentsFromJSONModel
{
    [[ZRBCommentManager sharedManager] fetchCommentsNumDataFormNewsViewWithIdString:_secondResaveIdString Succeed:^(ZRBNewsAdditionalJSONModel *additionalJSONModel) {
        _longCommentsNumInteger = 0;
        if ( additionalJSONModel.long_comments != 0 ){
            //执行长评论网络请求
            [[ZRBCommentManager sharedManager] fetchLongLongCommentsDataFromNewsViewWith:_secondResaveIdString Succeed:^(ZRBLongCommentsJSONModel *longCommentsJSONModel) {
                
                self.allcommentsJSONModel = longCommentsJSONModel;
                NSMutableArray * dataArray = [[NSMutableArray alloc] init];
                [dataArray addObject:longCommentsJSONModel.comments];
                [_allDataMutArray addObject:longCommentsJSONModel.comments];
                NSLog(@"dataArray[0][0] = %@",dataArray[0][0]);
                //接收所有数据
                _longCommentsNumInteger = additionalJSONModel.long_comments;
                //1.创建一个数组接收 author
                [_authorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"author"]];
                [_contentMMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"content"]];
                [_avatorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"avatar"]];
                [_onlyIdMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"id"]];
                [_likesMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"likes"]];
                [_timeMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"time"]];
                ZRBReplyToJSONModel * replyJSONModel = [[ZRBReplyToJSONModel alloc] init];
                replyJSONModel = [longCommentsJSONModel.comments valueForKey:@"reply_to"];
                NSString * replyStr = [NSString stringWithFormat:@"%@",replyJSONModel];
                NSLog(@"replyStr = %@",replyStr);
                //if ( ![replyStr isEqualToString:@"(\n    \"<null>\",\n    \"<null>\",\n    \"<null>\"\n)"]){
                [_reply_toMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"reply_to"]];
               // }
                if ( additionalJSONModel.long_comments > 12 ){
                    additionalJSONModel.long_comments = 12;
                }
                for (int i = 0; i < additionalJSONModel.long_comments; i++) {
                    NSString * replyStr = [NSString stringWithFormat:@"%@",_reply_toMutArray[0][i]];
                    ZRBReplyToJSONModel * storyModel = _reply_toMutArray[0][i];
                    if ( ![replyStr isEqualToString:@"(null)"] ){
                        NSString * authorStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"author"]];
                        NSString * contentStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"content"]];
                        NSString * allReplyStr = [NSString stringWithFormat:@"//%@: %@",authorStr,contentStr];
                        CGFloat replySize = [allReplyStr boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
                        [_longCellHeightMutArray addObject:[NSNumber numberWithFloat:replySize]];
                        
                    }else{
                        CGFloat replySize = [replyStr boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
                        [_longCellHeightMutArray addObject:[NSNumber numberWithFloat:replySize]];
                    }
                }
            } error:^(NSError *error) {
                NSLog(@"网络请求出错： %@",error);
            }];
        }
        if ( additionalJSONModel.long_comments == 0 ){
            _realRideInteger = 1;
            //不知道这里需不需要更新视图 可以尝试一下
            dispatch_async(dispatch_get_main_queue(), ^{
                _realRideInteger = 1;
                [self.commentView.tableView reloadData];
            });
        }
        if ( additionalJSONModel.short_comments != 0 ){
            [[ZRBCommentManager sharedManager] fetchShortShortCommentsDataFromNewsWith:_secondResaveIdString Succeed:^(ZRBLongCommentsJSONModel *longCommentsJSONModel) {
                self.allcommentsJSONModel = longCommentsJSONModel;
                _shortCommentsNumInteger = additionalJSONModel.short_comments;
                NSMutableArray * dataArray = [[NSMutableArray alloc] init];
                [dataArray addObject:longCommentsJSONModel.comments];
                [_allShortDataMutArray addObject:longCommentsJSONModel.comments];
                //1.创建一个数组接收 author
                [_shortAuthorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"author"]];
                [_shortContentMMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"content"]];
                [_shortAvatorMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"avatar"]];
                [_shortOnlyIdMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"id"]];
                [_shortLikesMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"likes"]];
                [_shortTimeMutArray addObject:[longCommentsJSONModel.comments valueForKey:@"time"]];
                
                ZRBReplyToJSONModel * replyJSONModel = [[ZRBReplyToJSONModel alloc] init];
                replyJSONModel = [self.allcommentsJSONModel.comments valueForKey:@"reply_to"];
                NSString * replyStr = [NSString stringWithFormat:@"%@",replyJSONModel];
                NSLog(@"replyStr = %@",replyStr);
               // if ( ![replyStr isEqualToString:@"(\n    \"<null>\",\n    \"<null>\",\n    \"<null>\"\n)"]){
                    [_shortReplyMutArray addObject:[self.allcommentsJSONModel.comments valueForKey:@"reply_to"]];
                //}
                //在这里面计算高度 二维数组第二维的数量就是
                if ( additionalJSONModel.short_comments > 12 ){
                    additionalJSONModel.short_comments = 11;
                }
                NSLog(@"additionalJSONModel.short_comments = %li",additionalJSONModel.short_comments);
                for (int i = 0; i < additionalJSONModel.short_comments; i++) {
                    CGFloat allReplySize = 0;
                    CGFloat replyContentSize = 0;
                    NSString * replyStr = [NSString stringWithFormat:@"%@",_shortReplyMutArray[0][i]];
                    ZRBReplyToJSONModel * storyModel = _shortReplyMutArray[0][i];
                    if ( ![replyStr isEqualToString:@"(null)"] ){
                        NSString * authorStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"author"]];
                        NSString * contentStr = [NSString stringWithFormat:@"%@",[storyModel valueForKey:@"content"]];
                        NSString * allReplyStr = [NSString stringWithFormat:@"//%@: %@",authorStr,contentStr];
                        CGFloat replySize = [allReplyStr boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
                        [_cellHeightMutArray addObject:[NSNumber numberWithFloat:replySize]];
                        
                    }else{
                    CGFloat replySize = [replyStr boundingRectWithSize:CGSizeMake(326, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
                    [_cellHeightMutArray addObject:[NSNumber numberWithFloat:replySize]];
                    }
                    
                }
                
                //OKcell的高度已经存取完毕 接下来就在 cellForIndexRow里面使用即可
                NSInteger i = 0;
                for (i = 0; i < 0; i++) {
                    //if ( [[NSString stringWithFormat:@"%@",_shortReplyMutArray[i]] isEqualToString:@"<null>"] ){
                        NSLog(@"str = %@",_shortReplyMutArray[0][i]);
                   // }
                    
                    //这个管用
                    
                    if ( [[NSString stringWithFormat:@"%@",_shortReplyMutArray[0][i]] isEqualToString:@"<null>"] ){
                    NSLog(@"123str = %@",_shortReplyMutArray[0][i]);
                     }
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.commentView.tableView reloadData];
                });
            } error:^(NSError *error) {
                NSLog(@"网络请求出错： %@",error);
            }];
        }
        
        else{
            _longCommentsNumInteger = 0;
            _shortCommentsNumInteger = 0;
        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.commentView.tableView reloadData];
//        });
    } error:^(NSError *error) {
        NSLog(@"网络请求失败：原因  %@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationItem.leftBarButtonItem = nil;
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
