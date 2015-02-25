//
//  ViewController.m
//  15Puzzle
//
//  Created by Justin Guarino on 2/22/15.
//  Copyright (c) 2015 JustinGuarino. All rights reserved.
//

#import "ViewController.h"
#import "PuzzleBrain.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, strong) PuzzleBrain *puzzleBrain;

@property (weak, nonatomic) IBOutlet UIButton *onePos;
@property (weak, nonatomic) IBOutlet UIButton *twoPos;
@property (weak, nonatomic) IBOutlet UIButton *threePos;
@property (weak, nonatomic) IBOutlet UIButton *fourPos;
@property (weak, nonatomic) IBOutlet UIButton *fivePos;
@property (weak, nonatomic) IBOutlet UIButton *sixPos;
@property (weak, nonatomic) IBOutlet UIButton *sevenPos;
@property (weak, nonatomic) IBOutlet UIButton *eightPos;
@property (weak, nonatomic) IBOutlet UIButton *ninePos;
@property (weak, nonatomic) IBOutlet UIButton *tenPos;
@property (weak, nonatomic) IBOutlet UIButton *elevenPos;
@property (weak, nonatomic) IBOutlet UIButton *twelvePos;
@property (weak, nonatomic) IBOutlet UIButton *thirteenPos;
@property (weak, nonatomic) IBOutlet UIButton *fourteenPos;
@property (weak, nonatomic) IBOutlet UIButton *fifteenPos;
@property (weak, nonatomic) IBOutlet UIButton *blankPos;
@property (weak, nonatomic) IBOutlet UIButton *shufle; //typo, but I noticed it at the end
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UISlider *difficulty;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (nonatomic) NSMutableArray *buttons;
@property (nonatomic) int shuffleNum;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"View did load.");
    //initialize game logic related variables
    self.puzzleBrain = [[PuzzleBrain alloc] init];
    self.difficulty.minimumValue=0;
    self.difficulty.maximumValue=50;
    self.difficulty.value=25;
    self.shuffleNum=25;
    
    //This rounds the corners of each button, functionality from
    //QuartzCore/QuartzCore.h I added this in hopes of removing
    //the phantom blue boxes the eye puts in between each button
    //but I personally still see them a bit...
    self.onePos.layer.cornerRadius=10;
    self.onePos.clipsToBounds=YES;
    self.twoPos.layer.cornerRadius=10;
    self.twoPos.clipsToBounds=YES;
    self.threePos.layer.cornerRadius=10;
    self.threePos.clipsToBounds=YES;
    self.fourPos.layer.cornerRadius=10;
    self.fourPos.clipsToBounds=YES;
    self.fivePos.layer.cornerRadius=10;
    self.fivePos.clipsToBounds=YES;
    self.sixPos.layer.cornerRadius=10;
    self.sixPos.clipsToBounds=YES;
    self.sevenPos.layer.cornerRadius=10;
    self.sevenPos.clipsToBounds=YES;
    self.eightPos.layer.cornerRadius=10;
    self.eightPos.clipsToBounds=YES;
    self.ninePos.layer.cornerRadius=10;
    self.ninePos.clipsToBounds=YES;
    self.tenPos.layer.cornerRadius=10;
    self.tenPos.clipsToBounds=YES;
    self.elevenPos.layer.cornerRadius=10;
    self.elevenPos.clipsToBounds=YES;
    self.twelvePos.layer.cornerRadius=10;
    self.twelvePos.clipsToBounds=YES;
    self.thirteenPos.layer.cornerRadius=10;
    self.thirteenPos.clipsToBounds=YES;
    self.fourteenPos.layer.cornerRadius=10;
    self.fourteenPos.clipsToBounds=YES;
    self.fifteenPos.layer.cornerRadius=10;
    self.fifteenPos.clipsToBounds=YES;
    
    //This sets other button properties
    [self.winLabel setAlpha:0];
    UIColor *lightBlue = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    [self.onePos setBackgroundColor:lightBlue];
    [self.onePos setTintColor:[UIColor whiteColor]];
    [self.twoPos setBackgroundColor:lightBlue];
    [self.twoPos setTintColor:[UIColor whiteColor]];
    [self.threePos setBackgroundColor:lightBlue];
    [self.threePos setTintColor:[UIColor whiteColor]];
    [self.fourPos setBackgroundColor:lightBlue];
    [self.fourPos setTintColor:[UIColor whiteColor]];
    [self.fivePos setBackgroundColor:lightBlue];
    [self.fivePos setTintColor:[UIColor whiteColor]];
    [self.sixPos setBackgroundColor:lightBlue];
    [self.sixPos setTintColor:[UIColor whiteColor]];
    [self.sevenPos setBackgroundColor:lightBlue];
    [self.sevenPos setTintColor:[UIColor whiteColor]];
    [self.eightPos setBackgroundColor:lightBlue];
    [self.eightPos setTintColor:[UIColor whiteColor]];
    [self.ninePos setBackgroundColor:lightBlue];
    [self.ninePos setTintColor:[UIColor whiteColor]];
    [self.tenPos setBackgroundColor:lightBlue];
    [self.tenPos setTintColor:[UIColor whiteColor]];
    [self.elevenPos setBackgroundColor:lightBlue];
    [self.elevenPos setTintColor:[UIColor whiteColor]];
    [self.twelvePos setBackgroundColor:lightBlue];
    [self.twelvePos setTintColor:[UIColor whiteColor]];
    [self.thirteenPos setBackgroundColor:lightBlue];
    [self.thirteenPos setTintColor:[UIColor whiteColor]];
    [self.fourteenPos setBackgroundColor:lightBlue];
    [self.fourteenPos setTintColor:[UIColor whiteColor]];
    [self.fifteenPos setBackgroundColor:lightBlue];
    [self.fifteenPos setTintColor:[UIColor whiteColor]];
    
    //Create swipe direction listeners
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeUp.direction=UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeDown.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    //I tried uising an IBoutletCollection but found that the order couldn't be guaranteed
    self.buttons=[[NSMutableArray alloc] initWithObjects:_onePos,_twoPos,_threePos,_fourPos,_fivePos,_sixPos,_sevenPos,_eightPos,_ninePos,_tenPos,_elevenPos,_twelvePos,_thirteenPos,_fourteenPos,_fifteenPos,_blankPos, nil];
    [self.puzzleBrain addButtons:_buttons];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSwipe:(UISwipeGestureRecognizer *)sender{
    
    if(![self.puzzleBrain isAnimating]){
        if(sender.direction==UISwipeGestureRecognizerDirectionRight){
            NSLog(@"Swiped right");
            [self.puzzleBrain moveButton:@"right"];
            
        }
        if(sender.direction==UISwipeGestureRecognizerDirectionLeft){
            NSLog(@"Swiped left");
            [self.puzzleBrain moveButton:@"left"];
            
        }
        if(sender.direction==UISwipeGestureRecognizerDirectionUp){
            NSLog(@"Swiped up");
            [self.puzzleBrain moveButton:@"up"];
        }
        if(sender.direction==UISwipeGestureRecognizerDirectionDown){
            NSLog(@"Swiped down");
            [self.puzzleBrain moveButton:@"down"];
        }
    }
    
    if(![self.puzzleBrain shouldTheGameContinue])
        [UIView animateWithDuration:0.5 animations:^{
            [self.winLabel setAlpha:1];
        }];
}
                            

- (IBAction)didTapShuffle:(UIButton *)sender{
    NSLog(@"Shuffle pressed");
    if(![self.puzzleBrain isAnimating]){
        [self.puzzleBrain shuffleBoard:self.shuffleNum];
    }
}

- (IBAction)didTapReset:(UIButton *)sender{
    NSLog(@"Reset pressed");
    if(![self.puzzleBrain isAnimating]){
        [self.puzzleBrain resetGame:_buttons];
        [self.winLabel setAlpha:0];
        self.difficulty.value=25;
        self.shuffleNum=25;
    }
}

- (IBAction)didMoveSlider:(UISlider *)sender{
    //NSLog(@"Slider moved");
    self.shuffleNum=self.difficulty.value;
}

@end
