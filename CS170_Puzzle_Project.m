function [outputArg1,outputArg2] = CS170_Puzzle_Project(inputArg1,inputArg2)
%   CS170_PUZZLE_PROJECT by Nathaniel Fey
%   An 8-puzzle solving project
%   This project will solve an 8-puzzle using different search methods
%   To start off, the user can enter a custom puzzle or use the default one
%   Once a choice has been made, the puzzle will then be solved via one
%   method selected by the user.


% ---------- Variables ------------------- %
init_state = [1 2 3; 4 5 6; 7 0 8]; % initial state
goal_state = [1 2 3; 4 5 6; 7 8 0]; % goal state

num_of_rows = 3; % dimensions of puzzle
num_of_cols = 3; % dimensions of puzzle
max_dimension = num_of_rows * num_of_cols; % An NxN matrix is required

% ------------ End of Variables ----------------- %


% -----------------Beginning of Main Program -------------- %

% Prompt user to select either a default puzzle or a custom puzzle
fprintf("Welcome to Nathaniel Fey's 8 puzzle problem solver!\n")
userPrompt = 'Press 1 to enter a custom puzzle or press 2 for a default puzzle.\n';
user_choice = input(userPrompt);
if user_choice == 1
    fprintf('CUSTOM PUZZLE\n')
    % Below here is prompting the user to enter each element of the matrix
    
    %-----The following code is from user Wayne King on matlab answers ---%
    for nn = 1:max_dimension
     customPuzzle(nn) = input(['Enter number ' num2str(nn) '\n']);
    end
    customPuzzle = reshape(customPuzzle,num_of_rows,num_of_cols); % create matrix
    % ----------------   end of borrowed code   --------------------- %
       
    % Prompt the user for their choice of which algorithm to use
    algorithmPrompt = 'Enter your choice of algorithm to solve the puzzle\n';
    fprintf('1. Uniform cost search, 2. A* Misplaced Tile, 3. A* Manhattan\n')
    alg_choice = input(algorithmPrompt);
    
    if(alg_choice == 1)
        [size,result] = general_search(customPuzzle, goal_state);
        if result == 1
            fprintf('Uniform cost result:\n')
            fprintf('goal state found\n');
            fprintf('%d is the num of nodes expanded\n',size); 
            fprintf('Here is your custom puzzle initially\n');
            fprintf('%i %i %i\n',customPuzzle.') %from user Jan on matlab answers to print out matrix
        
        else
            fprintf('Uniform cost result:\n')
            fprintf('no possible solution\n');
            fprintf('%d is the number of nodes expanded.\n',size);

        end
    % Second choice selects the misplaced tile algorithm
    elseif(alg_choice == 2)
        puzzleResult = misplacedTileSearch(customPuzzle,goal_state);
        [size,result] = general_search(customPuzzle, goal_state);
        if result == 1
            fprintf('Misplaced tile search cost result:\n')
            fprintf('goal state found\n');
            fprintf('%d is the num of nodes expanded\n',size); 
            fprintf('Here is your custom puzzle initially\n');
            fprintf('%i %i %i\n',customPuzzle.') %from user Jan on matlab answers to print out matrix
            fprintf('%d is the number of moves possible to solve',puzzleResult)
        
        else
            fprintf('Misplaced Tile search cost result:\n')
            fprintf('no possible solution\n');
            fprintf('%d is the number of nodes expanded.\n',size);

        end
        
    % Third and final choice is the manhattan distance algorithm    
    elseif(alg_choice == 3)
        puzzleResult = manhattanDistance(customPuzzle,goal_state);
         [size,result] = general_search(customPuzzle, goal_state);
        if result == 1
            fprintf('Manhattan Distance search result:\n')
            fprintf('goal state found\n');
            fprintf('%d is the num of nodes expanded\n',size); 
            fprintf('Here is your custom puzzle initially\n');
            fprintf('%i %i %i\n',customPuzzle.') %from user Jan on matlab answers to print out matrix
            fprintf('%d is the number of moves possible to solve',puzzleResult)
        
        else
            fprintf('Manhattan Distance result:\n')
            fprintf('no possible solution\n');
            fprintf('%d is the number of nodes expanded.\n',size);

        end
    else
    end
    
% Below, the user selects the DEFAULT puzzle  
elseif user_choice == 2
    fprintf('DEFAULT\n')
    % Prompt the user for their choice of which algorithm to use
    algorithmPrompt = 'Enter your choice of algorithm to solve the puzzle\n';
    fprintf('1. Uniform cost search, 2. A* Misplaced Tile, 3. A* Manhattan\n')
    alg_choice = input(algorithmPrompt);
    
    if(alg_choice == 1)
        
        [size,result] = general_search(init_state, goal_state);
        if result == 1
            fprintf('Uniform cost result:\n')
            fprintf('goal state found\n');
            fprintf('%d is the num of nodes expanded\n',size);
            fprintf('Here is the default puzzle initially\n');
            fprintf('%i %i %i\n',init_state.') %from user 'Jan' in matlab answers to print out matrix
        
        else
            fprintf('Uniform cost result:\n')
            fprintf('no possible solution\n');
            fprintf('%d is the number of nodes expanded.\n',size);

        end
    % Second choice selects the misplaced tile algorithm
    elseif(alg_choice == 2)
        puzzleResult = misplacedTileSearch(init_state,goal_state);
        [size,result] = general_search(init_state, goal_state);
        if result == 1
            fprintf('Misplaced Tile Search result:\n')
            fprintf('goal state found\n');
            fprintf('%d is the num of nodes expanded\n',size);
            fprintf('Here is the default puzzle initially\n');
            fprintf('%i %i %i\n',init_state.') %from user 'Jan' in matlab answers to print out matrix
        
        else
            fprintf('Misplaced Tile Search result:\n')
            fprintf('no possible solution\n');
            fprintf('%d is the number of nodes expanded.\n',size);
        end    
        fprintf('%d is the number of moves possible to solve',puzzleResult)
    % Third and final choice is the manhattan distance algorithm    
    elseif(alg_choice == 3)
        puzzleResult = manhattanDistance(init_state,goal_state);
         [size,result] = general_search(init_state, goal_state);
        if result == 1
            fprintf('Manhattan Distance Search result:\n')
            fprintf('goal state found\n');
            fprintf('%d is the num of nodes expanded\n',size);
            fprintf('Here is the default puzzle initially\n');
            fprintf('%i %i %i\n',init_state.') %from user 'Jan' in matlab answers to print out matrix
            fprintf('%d is the number of moves possible to solve',puzzleResult)
        else
            fprintf('Manhattan Distance Search:\n')
            fprintf('no possible solution\n');
            fprintf('%d is the number of nodes expanded.\n',size);
            fprintf('%d is the number of moves possible to solve',puzzleResult)
        end    
      
    else
    end
  
else
    fprintf('Invalid input') % user entered a invalid input (not a 1 or 2)
end    

end
% -------------------------- End of Main Program ----------------------%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERAL SEARCH FUNCTION
% Parameters are the initial puzzle board (which is problem) and the goal state
% for the puzzle.
% Output is whether the desired goal state has been reached 
% or is unable to reach the goal state and the number of nodes expanded.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [size,result] = general_search(problem, goal_state)
% problem is the board's initial state
% returns the result either a 0 or a 1 depending if goal state is reached.
queueSize = 0; % keep track of how many nodes were expanded
currentNode = dlnode(problem); % add the problem to the node data structure

% % % The While loop will continuously check to see if the current node 
% % % is the goal state, if not, expand that node and continue until no
% % % nodes are in the queue.
% % % This code follows closely to the pseudocode given by Dr. Keogh
while(true)
    if isempty(currentNode) % check to see if the data structure is empty
        value = 0; % false, return value = 0
        break % get out of the while loop
    end
  
    check = currentNode.Data; % check is the board, set to the currentNode
    % data
    
    currentNode.removeNode; % remove the current node from list
    
    queueSize = queueSize + 1; % update the queueSize in the list
    
    if check == goal_state % check to see if the goal state is reached
        value = 1;
        break
    else % otherwise, expand its children and make a new node
        newNode = operators(check); % make a new node after making a move
        currentNode = dlnode(newNode); % add the new node
    end
end
        
result = value; % return whether goal state is reached or not
size = queueSize; % return number of nodes expanded
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OPERATORS FUNCTION
% This takes a problem(puzzle) and returns the problem with an updated
% board based on the operators used.
% This function will find the empty space in the puzzle represented by 0.
% And will move using legal moving operators.
% Function makes a move based on operators and return the new problem board
% updated with the new move made.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function new_board = operators(problem)

currentNode = problem;

index = find(currentNode == 0); % gives position of the empty square

%fprintf('%d\n',index); % location of empty space in matrix testing
%purposes only

% the next line of code gets the dimensions of the puzzle that was entered
[numRows,numCols] = size(currentNode); % get the dimensions of puzzle

% move set
up = -1;
down = 1;
left = -numRows; % moving left or right depends on the dimension of puzzle.
right = numRows; % moving left or right depends on the dimension of puzzle.

moveSet = [up,down,left,right]; % Our move set for navigating the puzzle
%end of move set

% Here we select a move based on where the current empty space 0 is at
% We pick a move from the set and try to see if it is possible to move
% using the selected move (up,down,left or right).


% Try statement below will attempt to use an element from moveSet
% If it succeeds it will return the new node and print
% If it fails (e.g. out of array bounds), it will try a different move
% Until it succeeds in making a legal move.
try
    if(index == 1 || index == 4 || index == 7)
        moveSet = [down,left,right];
        pos = randi(length(moveSet)); % from Lucas Garcia on matlab answers
        space = moveSet(pos); % from Lucas Garcia on matlab answers
   
        % swap the empty space with the newly selected legal move
        % code below on swapping pieces inspired from 'the cyclist' on matlab answers
        currentNode([index,index+space]) = currentNode([index+space,index]);    
    elseif(index == 3 || index == 6 || index == 9)
        moveSet = [up,left,right];
        pos = randi(length(moveSet)); % from matlab answers
        space = moveSet(pos); % from matlab answers
    
        % swap the empty space with the newly selected legal move
        % code inspired from user'the cyclist' on matlab answers
        currentNode([index,index+space]) = currentNode([index+space,index]);
    else
        moveSet = [up,left,right,down];
        pos = randi(length(moveSet)); % from matlab answers
        space = moveSet(pos); % from matlab answers
        % swap the empty space with the newly selected legal move
        % code inspired from user 'the cyclist' on matlab answers
        currentNode([index,index+space]) = currentNode([index+space,index]);
    end
catch ME
    % dont rethrow, just retry with a new move should it fail due to error.
end % end of try statement


    fprintf('%i %i %i\n',currentNode.') %from user 'Jan' on matlab answers to print out matrix
    fprintf('\n') % spacing between each puzzle printed
    new_board = currentNode; % new_board is the puzzle board after move is made
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MISPLACED TILE SEARCH FUNCTION
% This function will determine the number of moves needed to move a single
% to its goal state.
% This function takes in the initial puzzle board (problem) and the goal
% state.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function numMoves = misplacedTileSearch(problem,goal_state)
% want to compare our current puzzle with that of the goal state
% and determine how many moves it would take
moves = 0;
% This for loop will search through both the initial puzzle's board and
% the goal state's board to find each puzzle piece and determine how many
% moves it will need to match the goal state's puzzle board.
for i=1:8
    index = find(problem == i); % find current iteration's puzzle piece
    diff = find(goal_state == i); % find position of goal_stat
    moves = moves+(index-diff); % add up the total difference on each iteration
    if (moves < 0)
        moves = moves*-1; % if difference is negative, turn it positive
    end
end

numMoves = moves;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MANHATTAN DISTANCE FUNCTION
% Parameters are the initial state of a puzzle(problem)
% and the goal state for the puzzle
% Returns the approximate number of moves needed to solve the puzzle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function numMoves = manhattanDistance(problem,goal_state)
moves = 0; % Number of moves that the algorithm *thinks* it'll take to solve.

% this for loop will iterate through the puzzle and keep track of each 
% puzzle piece and how many moves it will take to solve depending on each
% piece's position in the puzzle.

for i=1:8
    index = find(problem == i); % find position of each puzzle piece
    diff = find(goal_state == i); % find the puzzle piece position in the goal state
    moves = moves+(index-diff); % add up the total difference on each iteration
    if (moves < 0)
        moves = moves*-1; % in the event of a negative number, turn it positive.
    end
end
numMoves = moves;
end