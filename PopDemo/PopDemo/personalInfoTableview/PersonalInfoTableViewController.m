//
//  PersonalInfoTableViewController.m
//  PopDemo
//
//  Created by 卢棪 on 10/2/15.
//  Copyright © 2015 _Luyan. All rights reserved.
//

#import "PersonalInfoTableViewController.h"
#import "Pubilc.h"
#import "RollingLabel.h"

@interface PersonalCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avater;//头像
@property (nonatomic, strong) UILabel     *personalName;//姓名
@property (nonatomic, strong) UIImageView *marked;//坐标图标
@property (nonatomic, strong) RollingLabel*markLabel;//坐标名称
@property (nonatomic, strong) UILabel     *ageLabel;//年龄标签
@property (nonatomic, strong) UILabel     *age;//年龄大小
@property (nonatomic, strong) UILabel     *specialitiesLabel;//特长标签
@property (nonatomic, strong) UILabel     *specialities;//特长内容
@property (nonatomic, strong) UIImageView *bottomLine;

@end

@implementation PersonalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中状态
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//添加向右箭头
        
        self.avater = [[UIImageView alloc] init];
        self.avater.image = [UIImage imageNamed:@"example.jpeg"];
        self.avater.backgroundColor = [UIColor orangeColor];
        self.avater.layer.cornerRadius = 35.0f;
        self.avater.layer.masksToBounds = YES;
        [self.contentView addSubview:self.avater];
        
        self.personalName = [[UILabel alloc] init];
        self.personalName.text = @"Hnesoo";
        self.personalName.font = [UIFont fontWithName:@"Avenir" size:30.0f];
        self.personalName.textColor = [UIColor colorWithRed:0.01f green:0.27f blue:0.45f alpha:1.00f];
        [self.contentView addSubview:self.personalName];
        
        self.marked = [[UIImageView alloc] init];
        self.marked.image = [UIImage imageNamed:@"marked.png"];
        self.marked.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.marked];
        
        self.markLabel = [[RollingLabel alloc] initWithFrame:CGRectMake(120, 50, 100, 25) font:[UIFont fontWithName:@"Avenir" size:20.0f]];
        self.markLabel.contentText = @"Austin,TX,2 mils away";
//        self.markLabel.font = [UIFont fontWithName:@"Avenir" size:20.0f];
//        self.markLabel.contentText.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.markLabel];
        
        self.ageLabel = [[UILabel alloc] init];
        self.ageLabel.text = @"Years:";
        self.ageLabel.font = [UIFont fontWithName:@"Avenir" size:20.0f];
        self.ageLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.ageLabel];
        
        self.age = [[UILabel alloc] init];
        self.age.text = @"25";
        self.age.font = [UIFont fontWithName:@"Avenir" size:20.0f];
        self.age.textColor = [UIColor colorWithRed:0.25f green:0.60f blue:0.78f alpha:1.00f];
        [self.contentView addSubview:self.age];
        
        self.specialitiesLabel = [[UILabel alloc] init];
        self.specialitiesLabel.text = @"Specialist:";
        self.specialitiesLabel.font = [UIFont fontWithName:@"Avenir" size:20.0f];
        self.specialitiesLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.specialitiesLabel];
        
        self.specialities = [[UILabel alloc] init];
        self.specialities.text = @"Basketball,Yoga";
        self.specialities.font = [UIFont fontWithName:@"Avenir" size:20.0f];
        self.specialities.textColor = [UIColor colorWithRed:0.25f green:0.60f blue:0.78f alpha:1.00f];
        [self.contentView addSubview:self.specialities];
        
        self.bottomLine = [[UIImageView alloc] init];
        self.bottomLine.backgroundColor = [UIColor colorWithRed:0.63 green:0.63 blue:0.63 alpha:1.0f];
        [self.contentView addSubview:self.bottomLine];
        
        
    }
    return self;
}

- (void)prepareForReuse{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    self.avater.frame = CGRectMake(20, 15, 70, 70);
    self.ageLabel.frame = CGRectMake(20, 100, 60, 20);
    self.age.frame = CGRectMake(80, 100, 30, 20);
    self.specialitiesLabel.frame = CGRectMake(20, 130, 100, 20);
    self.specialities.frame = CGRectMake(120, 130, 200, 25);
    
    self.personalName.frame = CGRectMake(100, 15, 200, 35);
    self.marked.frame = CGRectMake(100, 50, 20, 20);
//    self.markLabel.frame = CGRectMake(120, 50, 100, 25);
    
    self.bottomLine.frame = CGRectMake(20, self.bounds.size.height-0.5, self.bounds.size.width-20, 0.5);
}

@end

@interface PersonalInfoTableViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    int _lastPosition;
}
@property (nonatomic, strong) UITableView *personalInfoList;
@property (nonatomic, strong) NSArray     *personalLists;
@property (nonatomic, assign) BOOL        isUp;//是否向上滑动

@end

@implementation PersonalInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isUp = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self configPersonalLists];
    [self configPersonalInfoTableView];
}

- (void)configPersonalLists{
    self.personalLists = @[@(1),@(1),@(1),@(1),@(1),@(1),@(1),@(1)];
}

- (void)configPersonalInfoTableView{
    self.personalInfoList = [[UITableView alloc] init];
    self.personalInfoList.delegate = self;
    self.personalInfoList.dataSource = self;
    self.personalInfoList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.personalInfoList.showsVerticalScrollIndicator = NO;
    self.personalInfoList.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-NAVIBAR_HEIGHT);
    [self.view addSubview:self.personalInfoList];
}

# pragma mark - Delegate of Tableview
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.personalLists.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 168;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* id = @"bounceCell";
    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[PersonalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isUp) {
        UIView *cellContentView = [cell contentView];
        //    CGFloat rotationAngleDegrees = -30;
        //    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
        CGPoint offsetPositioning = CGPointMake(0, -cell.contentView.frame.size.height*4);
        CATransform3D transform = CATransform3DIdentity;
        //    transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
        cellContentView.layer.transform = transform;
        cellContentView.layer.opacity = 0.8;
        
        [UIView animateWithDuration:0.65 delay:00 usingSpringWithDamping:0.85 initialSpringVelocity:0.8 options:0 animations:^{
            cellContentView.layer.transform = CATransform3DIdentity;
            cellContentView.layer.opacity = 1;
        } completion:^(BOOL finished) {}
         ];
    } else {
        UIView *cellContentView = [cell contentView];
        //    CGFloat rotationAngleDegrees = -30;
        //    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
        CGPoint offsetPositioning = CGPointMake(0, cell.contentView.frame.size.height*4);
        CATransform3D transform = CATransform3DIdentity;
        //    transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
        cellContentView.layer.transform = transform;
        cellContentView.layer.opacity = 0.8;
        
        [UIView animateWithDuration:0.65 delay:00 usingSpringWithDamping:0.85 initialSpringVelocity:0.8 options:0 animations:^{
            cellContentView.layer.transform = CATransform3DIdentity;
            cellContentView.layer.opacity = 1;
        } completion:^(BOOL finished) {}
         ];
    }
    

    /*从左边出现
    UIView *cellContentView  = [cell contentView];
    CGFloat rotationAngleDegrees = -30;
    CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
    CGPoint offsetPositioning = CGPointMake(500, -20.0);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, rotationAngleRadians, -50.0, 0.0, 1.0);
    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, -50.0);
    cellContentView.layer.transform = transform;
    cellContentView.layer.opacity = 0.8;
    
    [UIView animateWithDuration:.65 delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:.8 options:0 animations:^{
        cellContentView.layer.transform = CATransform3DIdentity;
        cellContentView.layer.opacity = 1;
    } completion:^(BOOL finished) {}];
    */
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    PersonalCell *personalCell = (PersonalCell *)cell;
    [personalCell.avater.layer pop_removeAllAnimations];

}

// 滚动时调用此方法(手指离开屏幕后)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 10) {
        _lastPosition = currentPostion;
        NSLog(@"ScrollUp now");
        self.isUp = YES;
    } else if (_lastPosition - currentPostion > 10)
    {
        _lastPosition = currentPostion;
        NSLog(@"ScrollDown now");
        self.isUp = NO;
    }
}

@end
