//
//  PuzzleBrain.m
//  15Puzzle
//
//  Created by student on 2/23/15.
//  Copyright (c) 2015 JustinGuarino. All rights reserved.
//

#import "PuzzleBrain.h"

@interface PuzzleBrain()

@property (nonatomic) int blankRow; //stores the current blank buttons row
@property (nonatomic) int blankCol; //stores the current blank buttons position
@property (nonatomic, strong) NSMutableArray *winBoard; //stores the board in solved state
@property (nonatomic, strong) NSMutableArray *board; //working board while game is played
@property (nonatomic, strong) NSMutableArray *copBoard; //allows for copying winboard on reset
@property (nonatomic) NSTimer *timer; //Crucial for distinct animations
@property (nonatomic) int rowSearch;//used by timer methods later
@property (nonatomic) int colSearch; //used by timer methods later
@property (nonatomic) NSMutableArray *buttonTracker; //keeps the array of buttons for resets
@property (nonatomic) BOOL isAnimating; //keeps calls from the viewcontroller from conflicting
@property (nonatomic) int validMoves; //keeps "win" label from displaying without valid move
@property (nonatomic) int shuffleNum; //tracks number of shuffles requested from viewcontroller
@property (nonatomic) int shuffleCount; //tracks current number of valid shuffles
@property (nonatomic) NSString *lastShuffle; //keeps from back and forth shuffles

@end

@implementation PuzzleBrain


-(NSMutableArray*) board
{
    if(!_board){
        _winBoard = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i=0; i<4; i++)
            [_winBoard addObject:[[NSMutableArray alloc] initWithCapacity:4]];
        _board = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i=0; i<4; i++)
            [_board addObject:[[NSMutableArray alloc] initWithCapacity:4]];
    
        self.blankRow=3;
        self.blankCol=3;
        self.rowSearch=0;
        self.colSearch=0;
        self.validMoves=0;
        self.shuffleNum=25;
        self.shuffleCount=0;
        self.isAnimating=false;
    }
    return _board;
}

-(void) addButtons:(NSMutableArray*) buttons
{
    //Load buttons from array created in ViewController
    //into board and winBoard;
    for(int i=0; i<4; i++){
        self.board[0][i]=buttons[i];
        self.winBoard[0][i]=buttons[i];
    }
    for(int i=0; i<4; i++){
        self.board[1][i]=buttons[i+4];
        self.winBoard[1][i]=buttons[i+4];
    }
    for(int i=0; i<4; i++){
        self.board[2][i]=buttons[i+8];
        self.winBoard[2][i]=buttons[i+8];
    }
    for(int i=0; i<4; i++){
        self.board[3][i]=buttons[i+12];
        self.winBoard[3][i]=buttons[i+12];
    }
    
    
    NSLog(@"Current blankRow: %d", self.blankRow);
    NSLog(@"Current blankCol: %d", self.blankCol);
}

-(void) moveButton: (NSString*) direction
{
    //Primary logic for valid moves below. I had confused myself for awhile by not realizing
    //the way I loaded them into the 2dNSMutable array from the array of buttons sent from
    //viewcontroller was by row first, then column. This means coordinates are more
    //Y,X coordinates more than X,Y
    UIButton *tempBlank = self.board[self.blankRow][self.blankCol];
    if([direction isEqualToString:@"right"]){
        if(self.blankCol==0)
            return;
        [self swapA:self.board[self.blankRow][self.blankCol-1] swapB:tempBlank];
        self.blankCol--;
        self.validMoves++;
    }
    if([direction isEqualToString:@"left"]){
        if(self.blankCol==3)
            return;
        [self swapA:self.board[self.blankRow][self.blankCol+1] swapB:tempBlank];
        self.blankCol++;
        self.validMoves++;
    }
    if([direction isEqualToString:@"up"]){
        if(self.blankRow==3)
            return;
        [self swapA:self.board[self.blankRow+1][self.blankCol] swapB:tempBlank];
        self.blankRow++;
        self.validMoves++;
    }
    if([direction isEqualToString:@"down"]){
        if(self.blankRow==0)
            return;
        [self swapA:self.board[self.blankRow-1][self.blankCol] swapB:tempBlank];
        self.blankRow--;
        self.validMoves++;
    }
    self.board[self.blankRow][self.blankCol]=tempBlank;
}

-(void) swapA:(UIButton *) buttonA swapB:(UIButton *) buttonB
{
    //Search through the whole grid of buttons, and once both buttonA and buttonB are found
    //the positions are noted so they may be switched
    int aRow, aCol, bRow, bCol;
    for(int row=0; row<4; row++){
        for(int col=0; col<4; col++){
            if(self.board[row][col]==buttonA){
                aRow=row;
                aCol=col;
            }
            else if(self.board[row][col]==buttonB){
                bRow=row;
                bCol=col;
            }
        }
    }

    [self animateA:buttonA buttonB:buttonB];
    
    //(NSLog(@"Button A switched with Button B"));
    self.board[aRow][aCol]=buttonB;
    self.board[bRow][bCol]=buttonA;
    
}
-(void) animateA:(UIButton *) buttonA buttonB:(UIButton*) buttonB
{
    //Without this it is possible to swipe faster than the frames
    //animate causing overlapping frames. It also keeps from
    //swiping while a reset or shuffle is happening.
    self.isAnimating=TRUE;
    CGRect tempFrame = buttonA.frame;
    [UIView animateWithDuration:.5 animations:^{
        buttonA.frame=buttonB.frame;
        buttonB.frame=tempFrame;
    } completion:^(BOOL finished) {
        self.isAnimating=false;
    }];
}

-(BOOL) shouldTheGameContinue
{
    //add this case as otherwise a swipe left or up will display win label at start
    if(self.validMoves==0)
        return true;
    for(int row=0; row<4; row++)
        for(int col=0; col<4; col++)
            if(self.board[row][col]!=self.winBoard[row][col])
                return true;
    return false;
}

-(void) resetGame:(NSMutableArray*) buttons;
{
    //I tried many ways of delaying things so that the reset, shuffle, etc wouldn't
    //animate all at once. After looking on stackexchange and the apple dev site
    //a timer seemed to be the best way to do this.
    self.copBoard=[[NSMutableArray alloc] initWithArray:self.winBoard copyItems:YES];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeHandler:) userInfo:nil repeats:YES];
    self.buttonTracker=buttons;
    self.blankRow=3;
    self.blankCol=3;
    self.validMoves=0;
}
-(void) timeHandler:(NSTimer*) timer
{
    //These need each time as function is repeatable
    int row=self.rowSearch;
    int col=self.colSearch;
    
    if(self.board[row][col]!=self.copBoard[row][col])
        [self swapA:self.board[row][col] swapB:self.copBoard[row][col]];
    
    self.colSearch++;
    if(self.rowSearch==3 && self.colSearch==3){
        self.rowSearch=0;
        self.colSearch=0;
        self.copBoard=nil;
        [self addButtons:self.buttonTracker]; //make logic for buttons is reset
        [timer invalidate]; //stop timer repeat
        return;
    }
    else if(self.colSearch>3){
        self.colSearch=0;
        self.rowSearch++;
    }

}

-(void) shuffleBoard:(int) num
{
    self.shuffleNum=num;
    self.timer= [NSTimer scheduledTimerWithTimeInterval:.1 target: self selector:@selector(shuffleHandler:) userInfo:nil repeats:YES];
    self.validMoves=0; //if this isn't cleared each time shuffles can count invalid moves
                        //which is very noticeable with small shufles
    
}

-(void) shuffleHandler:(NSTimer *) timer
{
    
    if(self.shuffleCount>=self.shuffleNum){
        [timer invalidate];
        self.shuffleCount=0;
        self.lastShuffle=@"";
        return;
    }
    
    int rando=rand()%4;
    //If you want to watch a funny dancing board remove the shufflecount increment...
    if(rando==0&&![self.lastShuffle isEqualToString:@"left"]){
        [self moveButton:@"right"];
        if(self.shuffleCount+1==self.validMoves) { //This way invalid moves aren't counted
            self.lastShuffle=@"right";
            self.shuffleCount++;
        }
    }
    else if(rando==1&&![self.lastShuffle isEqualToString:@"right"]){
        [self moveButton:@"left"];
        if(self.shuffleCount+1==self.validMoves){
            self.lastShuffle=@"left";
            self.shuffleCount++;
        }
    }
    else if(rando==2&&![self.lastShuffle isEqualToString:@"down"]){
        [self moveButton:@"up"];
        if(self.shuffleCount+1==self.validMoves){
            self.lastShuffle=@"up";
            self.shuffleCount++;
        }
    }
    else if(rando==3&&![self.lastShuffle isEqualToString:@"up"]){
        [self moveButton:@"down"];
        if(self.shuffleCount+1==self.validMoves){
            self.lastShuffle=@"down";
            self.shuffleCount++;
        }
    }
}

@end