//
//  ViewController.m
//  UserProfile
//
//  Created by Marcelo Sampaio on 4/11/15.
//  Copyright (c) 2015 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize userPicture,actionButtom;


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getImage];
    
//    [self configureUI];
}



//#pragma mark - User Interface
//-(void)configureUI{
//    
//    if (self.userPicture.image==nil) {
//        self.actionButtom.hidden=NO;
//    }else{
//        self.actionButtom.hidden=YES;
//    }
//    
//    
//
//    
//}

#pragma mark - UI Actions
- (IBAction)takeAPicture:(id)sender {
    NSLog(@"will take a picture");
    [self pickImage];
}

#pragma mark - Working Methods
-(void)pickImage {
    self.imagePicker=[[UIImagePickerController alloc]init];
    self.imagePicker.delegate=self;
    self.imagePicker.allowsEditing=NO;
    self.imagePicker.videoMaximumDuration=5; // up to 5 seconds
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    } else {
        self.imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    
    self.imagePicker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    
    NSLog(@"will pick an image");
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}


#pragma mark - UIImagePickerController Delegate Methods
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // A photo was taken or selected
        self.userPicture.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.userPicture.layer.cornerRadius=100;
        self.userPicture.layer.masksToBounds=YES;
        
        // Store image in Documents Folder
        [self storeImageInDocumentsLibrary];
        

        
        //        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //            // save the image
        //            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        //        }
    }
// else {
        // A video was taken or selected
//        self.videoFilePath=(NSString *)[[info objectForKey:UIImagePickerControllerMediaURL] path];
//        
//        //        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(self.videoFilePath)) {
//        //            if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//        //                // save the video
//        //                UISaveVideoAtPathToSavedPhotosAlbum(self.videoFilePath,nil,nil,nil);
//        //            }
//        //        }
//        
//    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Image Storage
//
-(void)storeImageInDocumentsLibrary
{
    NSLog(@"store in document folder");
    NSData *pngData = UIImagePNGRepresentation(self.userPicture.image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.dat"]; //Add the file name
    NSLog(@"pathName=%@",filePath);
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    
    
    
}

// Photo Library
-(void)storeImageInPhotoLibrary
{
    // Request to save the image to camera roll
    UIImageWriteToSavedPhotosAlbum(self.userPicture.image, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        NSLog(@"Error saving the image");
    }
    else  // No errors
    {
        NSLog(@"image has been succesfuly stored");
    }
}

#pragma mark - Image Recovery
-(void) getImage {
    NSLog(@"get photo from documents folder");
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.dat"];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    self.userPicture.image = [UIImage imageWithData:pngData];
    
    
    //    NSLog(@"documentsPath=%@",documentsPath);
    //
    //    NSFileManager *fileManager=[[NSFileManager alloc]init];
    //    NSArray *array=[fileManager contentsOfDirectoryAtPath:documentsPath error:nil];
    //    NSLog(@"total de arquivos em File Manager=%lu",(unsigned long)[array count]);
    //
    //    for (int i=0; i<[array count]; i++) {
    //        NSLog(@"...... conteudo: %@",[array objectAtIndex:i]);
    //    }
    //
    //
    //
    //
    //
    //    BOOL fileExists = [[NSFileManager defaultManager]fileExistsAtPath:filePath];
    //    if (fileExists) {
    //        NSLog(@"file EXISTS");
    //    }else{
    //        NSLog(@"file DOES NO+T EXIST");
    //    }
    //
    
    
    // All photos have been taken in UP orientation, so they must be rotated to be seen
    if (self.userPicture.image.imageOrientation==UIImageOrientationUp) {
        UIImage *rotatedImage;
        rotatedImage = [[UIImage alloc] initWithCGImage: self.userPicture.image.CGImage
                                                  scale: 1.0
                                            orientation: UIImageOrientationRight];
        
        self.userPicture.image=rotatedImage;
    }
    
    self.userPicture.layer.cornerRadius=100;
    self.userPicture.layer.masksToBounds=YES;
}

@end
