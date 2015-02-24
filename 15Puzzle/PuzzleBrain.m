//
//  PuzzleBrain.m
//  15Puzzle
//
//  Created by student on 2/23/15.
//  Copyright (c) 2015 JustinGuarino. All rights reserved.
//

#import "PuzzleBrain.h"

@interface PuzzleBrain()

@property (nonatomic) int blankRow;
@property (nonatomic) int blankCol;
@property (nonatomic, strong) NSMutableArray *winBoard;
@property (nonatomic, strong) NSMutableArray *board;

@end

@implementation PuzzleBrain


-(NSMutableArray*) winBoard
{
    if(!_winBoard){
        _winBoard = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i=0; i<4; i++)
            [_winBoard addObject:[[NSMutableArray alloc] initWithCapacity:4]];
        _board = [[NSMutableArray alloc] initWithCapacity:4];
        for(int i=0; i<4; i++)
            [_board addObject:[[NSMutableArray alloc] initWithCapacity:4]];
        
        self.blankRow=3;
        self.blankCol=3;
    }
    return _board;
}

-(void) addButtons:(NSMutableArray*) buttons
{
    [_winBoard addObjectsFromArray:buttons];
    [_board addObjectsFromArray:buttons];
}

-(void) swapA:(UIButton *) buttonA swapB:(UIButton *) buttonB
{
    int aRow;
    int aCol;
    int bRow;
    int bCol;
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
    
}

-(BOOL) moveButton: (NSString*) direction
{
    UIButton *tempBlank = self.board[self.blankRow][self.blankCol];
    if([direction isEqualToString:@"right"]){
        if(self.blankCol==0)
            return false;
        [self swapA:self.board[self.blankCol-1][self.blankRow] swapB:tempBlank];
        self.blankCol--;
    }
    if([direction isEqualToString:@"left"]){
        if(self.blankCol==3)
            return false;
        [self swapA:self.board[self.blankCol+1][self.blankRow] swapB:tempBlank];
        self.blankCol++;
        
    }
    if([direction isEqualToString:@"up"]){
        if(self.blankRow==3)
            return false;
        [self swapA:self.board[self.blankCol][self.blankRow-1] swapB:tempBlank];
        self.blankRow++;
    }
    if([direction isEqualToString:@"down"]){
        if(self.blankRow==0)
            return false;
        [self swapA:self.board[self.blankCol][self.blankRow+1] swapB:tempBlank];
        self.blankRow--;
    }
    self.board[self.blankRow][self.blankCol]=tempBlank;
    return true;
}

@end