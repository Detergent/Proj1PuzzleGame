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
@property (weak, nonatomic) IBOutlet UIButton *shufle;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UISlider *difficulty;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *buttons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"View did load.");
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

    [self.puzzleBrain addButtons:_buttons];
    
    
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
    else if(sender.direction==UISwipeGestureRecognizerDirectionLeft){
         NSLog(@"Swiped left");
        [self.puzzleBrain moveButton:@"left"];
        /*
        CGRect tempFrame = self.blankPos.frame;
        self.blankPos.frame=self.fifteenPos.frame;
        self.fifteenPos.frame=tempFrame;*/
        
    }
    else if(sender.direction==UISwipeGestureRecognizerDirectionUp){
         NSLog(@"Swiped up");
        [self.puzzleBrain moveButton:@"up"];
        /*
        CGRect tempFrame = self.blankPos.frame;
        self.blankPos.frame=self.twelvePos.frame;
        self.twelvePos.frame=tempFrame;*/
    }
    else if(sender.direction==UISwipeGestureRecognizerDirectionDown){
         NSLog(@"Swiped down");
        [self.puzzleBrain moveButton:@"down"];
    }
}
                            

- (IBAction)didTapShuffle:(UIButton *)sender{
    NSLog(@"Shuffle pressed");
}

- (IBAction)didTapReset:(UIButton *)sender{
    NSLog(@"Reset pressed");
}

- (IBAction)didMoveSlider:(UISlider *)sender{
    NSLog(@"Slider moved");
}

@end
