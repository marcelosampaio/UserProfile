//
//  ViewController.m
//  UserProfile
//
//  Created by Marcelo Sampaio on 4/11/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize userPicture;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
}



#pragma mark - User Interface
-(void)configureUI{
    
    self.userPicture.layer.cornerRadius=25;
    self.userPicture.layer.masksToBounds=YES;
    
}







@end
