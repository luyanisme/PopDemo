//
//  BounceTableViewController.m
//  PopDemo
//
//  Created by 卢棪 on 10/1/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "BounceTableViewController.h"
#import "Pubilc.h"

@interface BounceCell : UITableViewCell

@end

@implementation BounceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.textColor = [UIColor customGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中状态
        self.textLabel.font = [UIFont fontWithName:@"Avenir" size:20.0f];
    
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

@interface BounceTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *bounceTableView;//带回弹效果的tableview
@property (nonatomic, strong) NSArray     *colorList;

@end

@implementation BounceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self configColors];
    [self configBounceTableView];
}

- (void)configBounceTableView{
    self.bounceTableView = [[UITableView alloc] init];
    self.bounceTableView.delegate = self;
    self.bounceTableView.dataSource = self;
    self.bounceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.bounceTableView.showsVerticalScrollIndicator = NO;
    self.bounceTableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-NAVIBAR_HEIGHT);
    [self.view addSubview:self.bounceTableView];
}

- (void)configColors{
    self.colorList = @[[UIColor colorWithRed:0.69f green:0.87f blue:0.44f alpha:1.00f],
                       [UIColor colorWithRed:0.46f green:0.93f blue:0.93f alpha:1.00f],
                       [UIColor colorWithRed:1.00f green:0.51f blue:0.65f alpha:1.00f],
                       [UIColor colorWithRed:0.96f green:0.74f blue:0.42f alpha:1.00f],
                       [UIColor colorWithRed:0.34f green:0.35f blue:0.36f alpha:1.00f],
                       [UIColor colorWithRed:0.86f green:0.87f blue:0.83f alpha:1.00f],
                       [UIColor colorWithRed:0.58f green:0.49f blue:0.47f alpha:1.00f]];
}

# pragma mark - Delegate of Tableview
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.colorList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_HEIGHT-NAVIBAR_HEIGHT)/5;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* id = @"bounceCell";
    BounceCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[BounceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    
    cell.backgroundColor = [self.colorList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView {
    int tomove = ((int)tableView.contentOffset.y%(int)((SCREEN_HEIGHT-NAVIBAR_HEIGHT)/5));
    if(tomove < ((SCREEN_HEIGHT-NAVIBAR_HEIGHT)/5)/2) [tableView setContentOffset:CGPointMake(0, tableView.contentOffset.y-tomove) animated:YES];
    else [tableView setContentOffset:CGPointMake(0, tableView.contentOffset.y+(((SCREEN_HEIGHT-NAVIBAR_HEIGHT)/5)-tomove)) animated:YES];
}

- (void)scrollViewDidEndDragging:(UITableView *)scrollView willDecelerate:(BOOL)decelerate {
    if(decelerate) return;
    [self scrollViewDidEndDecelerating:scrollView];
}
@end
