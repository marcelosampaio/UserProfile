//
//  ViewController.h
//  UserProfile
//
//  Created by Marcelo Sampaio on 4/11/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *userPicture;
@property (strong, nonatomic) IBOutlet UIButton *actionButtom;

@property (nonatomic, strong) UIImagePickerController *imagePicker;



@end

