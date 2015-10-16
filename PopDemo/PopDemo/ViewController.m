//
//  ViewController.m
//  PopDemo
//
//  Created by 卢棪 on 9/29/15.
//  Copyright (c) 2015 _Luyan. All rights reserved.
//

#import "ViewController.h"

#import "ShakeBtnViewController.h"
#import "MenuDeleteBtnViewController.h"
#import "PersonalInfoTableViewController.h"
#import "SubmitBtnViewController.h"
#import "CircleMenuViewController.h"

@interface AnimationCell : UITableViewCell

@property (nonatomic, strong) UIImageView *line;

@end

@implementation AnimationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.textColor = [UIColor customGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中状态
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//添加向右箭头
        self.textLabel.font = [UIFont fontWithName:@"Avenir" size:20.0f];
        
        // Initialization code
        self.line = [[UIImageView alloc] init];
        self.line.backgroundColor = [UIColor colorWithRed:0.63 green:0.63 blue:0.63 alpha:1.0f];
        self.line.frame = CGRectMake(10, self.bounds.size.height-0.5, self.bounds.size.width-20, 0.5);
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)prepareForReuse{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *animationList;//动画类型展示列表
@property (nonatomic, strong) NSArray *controllers;//存放controller的列表

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"POP Animation";
    [self configTitle];
    [self initTableView];
    [self initAnimationList];
    [self initControllers];
}

- (void)initAnimationList{
    self.animationList = @[@"Shake Button", @"Submit Button", @"MenuDelete Button", @"PersonalInfoTableView", @"CircleMenu"];
}

- (void)initControllers{
    self.controllers = @[[ShakeBtnViewController class],
                         [SubmitBtnViewController class],
                         [MenuDeleteBtnViewController class],
                         [PersonalInfoTableViewController class],
                         [CircleMenuViewController class]
                         ];
}

- (void)initTableView{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:self.tableView];
}

- (void)configTitle{
    UILabel *headlinelabel = [UILabel new];
    headlinelabel.font = [UIFont fontWithName:@"Avenir-Light" size:28];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor = [UIColor grayColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.title];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor customBlueColor]
                             range:NSMakeRange(1, 1)];
    
    headlinelabel.attributedText = attributedString;
    [headlinelabel sizeToFit];
    
    [self.navigationItem setTitleView:headlinelabel];
}

# pragma mark - Delegate of Tableview
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.animationList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* id = @"AnimationCell";
    AnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[AnimationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    
    cell.textLabel.text = [self.animationList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[self.controllers objectAtIndex:indexPath.row] new] animated:YES];
}


@end
