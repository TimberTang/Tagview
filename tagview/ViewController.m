//
//  ViewController.m
//  tagview
//
//  Created by TimberTang on 2018/11/8.
//  Copyright © 2018 TimberTang. All rights reserved.
//

#import "ViewController.h"
#import "ZYTagTitleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZYTagTitleView *tagview = [[ZYTagTitleView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 500)];
    tagview.tags = [@[@"aaaa",
                    @"aaaab",
                    @"aaaabb",
                    @"aaaabbb",
                    @"aaaabbbb",
                    @"aaaabbbbb",
                    @"aaaabbbbbb",
                      @"aaaabbbbbbaaaabbbbbbaaaabbbbbbaaaabbbbbb",
                      @"aaaabbbbbb",
                      @"aaaabbbbbb",
                    ] mutableCopy];
    tagview.tagStrokeColor = [UIColor redColor];
    tagview.tagTextColor = [UIColor greenColor];
    [self.view addSubview:tagview];
    
}


@end
