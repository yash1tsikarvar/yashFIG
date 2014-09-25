//
//  YSViewController.m
//  figsComponent
//
//  Created by Shalabh Bhatia on 18/09/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "YSViewController.h"

@interface YSViewController ()
{
    int count;
    double x,y,initialDistance; int c;
}

@end

@implementation YSViewController
@synthesize imageV;
@synthesize lab;
- (void)viewDidLoad
{
    count =1;
    [super viewDidLoad];
  //  count = 0;
//    // Do any additional setup after loading the view from its nib.
//    [self.imageV setUserInteractionEnabled:YES];
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe)];
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight)];
//    
//    // Setting the swipe direction.
//    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    
//    // Adding the swipe gesture on image view
//    [self.imageV addGestureRecognizer:swipeLeft];
//    [self.imageV addGestureRecognizer:swipeRight];
    
    x=y=0;
    c=1;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *filemanager=[NSFileManager defaultManager];
    CGSize newSize = CGSizeMake(294, 509); //size of image view
    UIGraphicsBeginImageContext( newSize );
    for(int i=0; i<256; i++)
    {
        NSString *str = [NSString stringWithFormat:@"result_16x16_%d.jpg",i];
        NSLog(str);
        
        NSString *filePath=[documentsDirectory stringByAppendingPathComponent:str];
        BOOL isFilexist=[filemanager fileExistsAtPath:filePath];
       // NSLog(isFilexist);
        UIImage *im1 = [[UIImage alloc]initWithContentsOfFile:filePath];
        [im1 drawInRect:CGRectMake(x,y,newSize.width/16,newSize.height/16)];
        x= x+newSize.width/16;
        
        if(c%16==0){
            y= y+im1.size.height/16;
            x=0;
        }
        c++;
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    imageV.image= newImage;
	// Do any additional setup after loading the view, typically from a nib.
}

    
    
- (CGFloat) distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
        float xPoint = toPoint.x - fromPoint.x;
        float yPoint = toPoint.y - fromPoint.y;
   NSInteger z= sqrt(xPoint * xPoint + yPoint * yPoint);
    NSString *m = [NSString stringWithFormat:@"%d" ,z];
    [lab setText:m];
        return sqrt(xPoint * xPoint + yPoint * yPoint);
    }




    -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
        
        NSSet *allTouches = [event allTouches];
        
        switch ([allTouches count]) {
            case 1: { //Single touch
                
                //Get the first touch.
                UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
                
                switch ([touch1 tapCount])
                {
                    case 1: //Single Tap.
                    {
                        // Guardo la primera localización del dedo cuando pulsa por primera vez
                        //inicial = [touch1 locationInView:self.view];
                        
                    } break;
                    case 2: {//Double tap.
                        //Track the initial distance between two fingers.
                        //if ([[allTouches allObjects] count] >= 2) {
                        
                        // oculto/o no, la barra de arriba cuando se hace un dobleTap
                        //[self switchToolBar];
                        
                    } break;
                }
            } break;
            case 2: { //Double Touch
                
                // calculo la distancia inicial que hay entre los dedos cuando empieza a tocar
                UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
                UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
                
                initialDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:[self view]]
                                                         toPoint:[touch2 locationInView:[self view]]];
            }
            default:
                break;
        }
    }
    
    // when the finger/s move to
    -(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
    {
        
        NSSet *allTouches = [event allTouches];
        
        switch ([allTouches count])
        {
            case 1: {
                
                
                
            } break;
            case 2: {
                //The image is being zoomed in or out.
                
                UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
                UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
                
                //Calculate the distance between the two fingers.
                CGFloat finalDistance = [self distanceBetweenTwoPoints:[touch1 locationInView:[self view]]
                                                               toPoint:[touch2 locationInView:[self view]]];
                
                NSLog(@"Distancia Inicial :: %.f, Ditancia final :: %.f", initialDistance, finalDistance);
                
                
               // NSInteger z= sqrt(xPoint * xPoint + yPoint * yPoint);
                NSString *m = [NSString stringWithFormat:@"%d" ,finalDistance];
                [lab setText:m];
                
                float factorX = 20.0;
                float factorY = 11.0;
                
                // guardo la posicion de los 2 dedos
                //CGPoint dedo1 = [[[touches allObjects] objectAtIndex:0] locationInView:self.view];
                //CGPoint dedo2 = [[[touches allObjects] objectAtIndex:1] locationInView:self.view];
                
                // comparo para saber si el usuario esta haciendo zoom in o zoom out
                if(initialDistance < finalDistance) {
                    NSLog(@"Zoom In");
//                    
//                    float newWidth = imagen.frame.size.width + (initialDistance - finalDistance + factorX);
//                    float newHeight = imagen.frame.size.height + (initialDistance - finalDistance + factorY);
//                    
//                    if (newWidth <= 960 && newHeight <= 640) {
//                        /*
//                         if (dedo1.x >= dedo2.x) {
//                         x = (dedo1.x + finalDistance/2);
//                         y = (dedo1.y + finalDistance/2);
//                         } else {
//                         x = (dedo2.x + finalDistance/2);
//                         y = (dedo2.y + finalDistance/2);
//                         }
//                         */
//                        
//                        //x = (dedo1.x);
//                        //y = (dedo1.y);
//                        
//                        imagen.frame = CGRectMake( x, y, newWidth, newHeight);
//                    } else {
//                        imagen.frame = CGRectMake( x, y, 960, 640);
//                    }
//                    
//                    
//                    
//                }
//                else {
//                    NSLog(@"Zoom Out");
//                    
//                    float newWidth = imagen.frame.size.width - (finalDistance - initialDistance + factorX);
//                    float newHeight = imagen.frame.size.height - (finalDistance - initialDistance + factorY);
//                    
//                    if (newWidth >= 480 && newHeight >= 320) { 
//                        /*
//                         if (dedo1.x >= dedo2.x) {
//                         x = (dedo1.x + finalDistance/2); 
//                         y = (dedo1.y + finalDistance/2);
//                         } else {
//                         x = (dedo2.x + finalDistance/2); 
//                         y = (dedo2.y + finalDistance/2);
//                         }
//                         */
//                        //x -= (finalDistance - initialDistance + factorX); 
//                        //y -= (finalDistance - initialDistance + factorX); 
//                        
//                        //x = (dedo1.x);
//                        //y = (dedo1.y);
//                        
//                        imagen.frame = CGRectMake( x, y, newWidth, newHeight);
//                    } else {
//                        imagen.frame = CGRectMake( 0, 0, 480, 320);
//                    }
//                    
//                    
//                    
//                }
//                
//                initialDistance = finalDistance;
//                
//            } break;
        }
            }}}
    
    
//    NSString *filePath2=[documentsDirectory stringByAppendingPathComponent:@"2.png"];
//    NSString *filePath3=[documentsDirectory stringByAppendingPathComponent:@"3.png"];
//    NSString *filePath4=[documentsDirectory stringByAppendingPathComponent:@"4.png"];
//    
//    BOOL isFilexist=[filemanager fileExistsAtPath:filePath1];
//    UIImage *im1 = [[UIImage alloc]initWithContentsOfFile:filePath1];
//    UIImage *im2 = [[UIImage alloc]initWithContentsOfFile:filePath2];
//    UIImage *im3 = [[UIImage alloc]initWithContentsOfFile:filePath3];
//    UIImage *im4 = [[UIImage alloc]initWithContentsOfFile:filePath4];
    
//    CGSize size = CGSizeMake(1000, 1000);
//    UIGraphicsBeginImageContext(size);
//    
//    CGPoint image1Point = CGPointMake(0, 0);
//    [im1 drawAtPoint:image1Point];
//    
//    CGPoint image2Point = CGPointMake(0, im1.size.height);
//    [im2 drawAtPoint:image2Point];
//    
////    CGPoint image3Point = CGPointMake(0, im1.size.height +im2.size.height);
////    [im3 drawAtPoint:image3Point];
//    
//    UIImage* finalImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
   // UIImage *bottomImage = [UIImage imageNamed:@"bottom.png"]; //first image
   // UIImage *image       = [UIImage imageNamed:@"top.png"]; //foreground image
    
    
    
    // drawing 1st image
//    [im1 drawInRect:CGRectMake(0,0,newSize.width/2,newSize.height/2)];
//    
//    // drawing the 2nd image after the 1st
//    [im2 drawInRect:CGRectMake(0,newSize.height/2,newSize.width/2,newSize.height/2)] ;
//    [im3 drawInRect:CGRectMake(newSize.width/2,0,newSize.width/2,newSize.height/2)] ;
//    [im4 drawInRect:CGRectMake(newSize.width/2,newSize.height/2,newSize.width/2,newSize.height/2)] ;
    
    
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//   imageV.image= newImage;
//	// Do any additional setup after loading the view, typically from a nib.
//}
-(IBAction)ZoomIn:(UIPinchGestureRecognizer *) recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    //recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale =1;
}

-(void)handleSwipe//:(id)sender
{
    if(count < 4)
    {
        count++;
        UIImageView *moveIMageView = imageV;
        [self addAnimationPresentToView:moveIMageView];
        [self changeImage];
    }
    
}
- (void)addAnimationPresentToView:(UIImageView *)viewTobeAnimated
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.30;
   // transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
   // [transition setValue:@"IntroSwipeIn" forKey:@"IntroAnimation"];
   // transition.fillMode=kCAFillModeForwards;
     transition.type = kCATransitionPush;
     transition.subtype =kCATransitionFromRight;
     [viewTobeAnimated.layer addAnimation:transition forKey:nil];
    
}

- (void)addAnimationPresentToViewOut:(UIImageView *)viewTobeAnimated
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.30;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [transition setValue:@"IntroSwipeIn" forKey:@"IntroAnimation"];
    transition.fillMode=kCAFillModeForwards;
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromLeft;
    [viewTobeAnimated.layer addAnimation:transition forKey:nil];
    
}
-(void)handleSwipeRight//:(id)sender
{
    if(count>0)
    {
        count--;
        UIImageView *moveIMageView = self.imageV;
        [self addAnimationPresentToViewOut:moveIMageView];
        [self changeImage];
    }
    
}
//-(void)handleSwipe:(id)sender
//{
//    if(count < 4)
//    {
//        count++;
//        [self changeImage];
//    }
//    
//}
//-(void)handleSwipeRight:(id)sender
//{
//    if(count>0)
//    {
//        count--;
//        [self changeImage];
//    }
//    
//}


-(void)changeImage
{
    switch (count) {
        case 1:
            
            
        {
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
            
                //NSString *str =[NSString stringWithFormat:@"%d.png",count];
                NSString *filePath=[documentsDirectory stringByAppendingPathComponent:@"2.png"];
                NSFileManager *filemanager=[NSFileManager defaultManager];
                BOOL isFilexist=[filemanager fileExistsAtPath:filePath];
                UIImage *p = [[UIImage alloc]initWithContentsOfFile:filePath];
                self.imageV.image= p;
                 break;
           
            
            //hi
            NSLog(@"yash");
            
           // self.imageV.image = [UIImage imageNamed:@"1.png"];
           
        }
        case 2:
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            //NSString *str =[NSString stringWithFormat:@"%d.png",count];
            NSString *filePath=[documentsDirectory stringByAppendingPathComponent:@"3.png"];
            NSFileManager *filemanager=[NSFileManager defaultManager];
            BOOL isFilexist=[filemanager fileExistsAtPath:filePath];
            UIImage *p = [[UIImage alloc]initWithContentsOfFile:filePath];
            self.imageV.image= p;
            break;
        }
        case 3:
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            //NSString *str =[NSString stringWithFormat:@"%d.png",count];
            NSString *filePath=[documentsDirectory stringByAppendingPathComponent:@"4.png"];
            NSFileManager *filemanager=[NSFileManager defaultManager];
            BOOL isFilexist=[filemanager fileExistsAtPath:filePath];
            UIImage *p = [[UIImage alloc]initWithContentsOfFile:filePath];
            self.imageV.image= p;
            break;
        }
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)leftAcn:(id)sender {
//    if(count>1)
//    {
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//         count--;
//        NSString *str =[NSString stringWithFormat:@"%d.png",count];
//        NSString *filePath=[documentsDirectory stringByAppendingPathComponent:str];
//        NSFileManager *filemanager=[NSFileManager defaultManager];
//        BOOL isFilexist=[filemanager fileExistsAtPath:filePath];
//        UIImage *p = [[UIImage alloc]initWithContentsOfFile:filePath];
//        //[imageV setImage:p ]
//        imageV.image= p;
//       
//    }
//}
//
//- (IBAction)rightAcn:(id)sender {
//    
//    
//  
//    
//}
@end
