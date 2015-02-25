//
//  ViewController.m
//  15Puzzle
//
//  Created by Justin Guarino on 2/22/15.
//  Copyright (c) 2015 JustinGuarino. All rights reserved.
//

#import "ViewController.h"
#import "PuzzleBrain.h"

@interface ViewController ()

@property (nonatomic) PuzzleBrain *puzzleBrain;

@property (nonatomic) IBOutlet UIButton *onePos;
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
@property (weak, nonatomic) IBOutlet UIButton *shufle;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UISlider *difficulty;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"View did load.");
    
    self.puzzleBrain = [[PuzzleBrain alloc] init];
    [self.winLabel setAlpha:0];
    
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
    NSMutableArray *buttons=[[NSMutableArray alloc] initWithObjects:_onePos,_twoPos,_threePos,_fourPos,_fivePos,_sixPos,_sevenPos,_eightPos,_ninePos,_tenPos,_elevenPos,_twelvePos,_thirteenPos,_fourteenPos,_fifteenPos,_blankPos, nil];
    [self.puzzleBrain addButtons:buttons];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSwipe:(UISwipeGestureRecognizer *)sender{
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
    if(![self.puzzleBrain shouldTheGameContinue])
        [self.winLabel setAlpha:1];
    
}
                            

- (IBAction)didTapShuffle:(UIButton *)sender{
    NSLog(@"Shuffle pressed");
}

- (IBAction)didTapReset:(UIButton *)sender{
    NSLog(@"Reset pressed");
    [self.puzzleBrain resetGame];
    [self.winLabel setAlpha:0];
}

- (IBAction)didMoveSlider:(UISlider *)sender{
    NSLog(@"Slider moved");
}

@end
