//
//  OCTestVC.m
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/6/28.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

#import "OCTestVC.h"
#import "ZJTimerProxy.h"
#import "SwiftMore-Swift.h"
@interface OCTestVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic, copy) NSArray *titleArr ;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation OCTestVC

#pragma mark ********LifeCycle********
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView] ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated] ;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated] ;
}

#pragma mark ********SetUp********
- (void)setUpView {
    self.navigationItem.title = @"我的" ;
    self.view.backgroundColor = [UIColor whiteColor] ;
    [_myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"] ;
}

#pragma mark ********UITableViewDelegate********
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"] ;
    cell.textLabel.font = [UIFont systemFontOfSize:15] ;
    cell.textLabel.textColor = [UIColor rgbFromHexWithRgb:0x333333] ;
    cell.textLabel.text = self.titleArr[indexPath.row] ;
    return cell ;
}

#pragma mark ********NetWork********

#pragma mark ********EventResponse********
- (IBAction)clickButton:(id)sender {
}

#pragma mark ********PrivateMethod********

#pragma mark ********Setter********

#pragma mark ********Getter********
- (NSArray *)titleArr {
    return @[@"ZJCarouselBanner", @"ZJPageController"] ;
}
@end
