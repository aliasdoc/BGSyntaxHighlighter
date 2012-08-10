//
//  BGSyntaxHighlightView.m
//  BGSyntaxHighlighter
//
//  Created by KAZUMA Ukyo on 12/08/08.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BGSyntaxHighlightView.h"

@interface BGSyntaxHighlightView()
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIScrollView *baseScrollView;
@end

@implementation BGSyntaxHighlightView
@synthesize codeObject;
@synthesize tableView = _tableView;
@synthesize baseScrollView = _baseScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.baseScrollView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        [self.baseScrollView addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width * 2, self.frame.size.height);
    self.baseScrollView.frame = self.frame;
    self.baseScrollView.contentSize = CGSizeMake(self.frame.size.width * 2, self.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.codeObject numberOfCodeLines];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.text = [[self.codeObject codeStringForLineAtIndex:indexPath.row] string];
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:12];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}
@end
