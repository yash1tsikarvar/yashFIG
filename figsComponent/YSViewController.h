//
//  YSViewController.h
//  figsComponent
//
//  Created by Shalabh Bhatia on 18/09/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
- (IBAction)leftAcn:(id)sender;
- (IBAction)rightAcn:(id)sender;
-(IBAction)ZoomIn:(UIPinchGestureRecognizer *) recognizer;
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end
