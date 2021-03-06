function [pits,Wumpus] = CS4300_WP_estimates(breezes,stench,num_trials)
% CS4300_WP_estimates - estimate pit and Wumpus likelihoods
% On input:
%     breezes (4x4 Boolean array): presence of breeze percept at cell
%       -1: no knowledge
%        0: no breeze detected
%        1: breeze detected
%     stench (4x4 Boolean array): presence of stench in cell
%       -1: no knowledge
%        0: no stench detected
%        1: stench detected
%     num_trials (int): number of trials to run (subset will be OK)
% On output:
%     pits (4x4 [0,1] array): likelihood of pit in cell
%     Wumpus (4x4 [0 to 1] array): likelihood of Wumpus in cell
% Call:
%     breezes = -ones(4,4);
%     breezes(4,1) = 1;
%     stench = -ones(4,4);
%     stench(4,1) = 0;
%     [pts,Wumpus] = CS4300_WP_estimates(breezes,stench,10000)
% pts =
%    0.2021 0.1967 0.1956 0.1953
%    0.1972 0.1999 0.2016 0.1980
%    0.5527 0.1969 0.1989 0.2119
%    0 0.5552 0.1948 0.1839
%
% Wumpus =
%    0.0806 0.0800 0.0827 0.0720
%    0.0780 0.0738 0.0723 0.0717
%    0      0.0845 0.0685 0.0803
%    0      0      0.0741 0.0812
% Author:
%     Eric Waugh and Monish Gupta
%     u0947296 and u1008121
%     Fall 2017

pits = zeros(4,4);
Wumpus = zeros(4,4);
count = 0;

for s = 1:10000
    board = CS4300_gen_board_no_GW(.2);
    if CS4300_board_ok(board, breezes, stench)
        count = count + 1;
        for i = 1:4
           for j = 1:4
              if board(i,j) == 1
                 pits(i,j) = pits(i,j) + 1; 
              end
              if board(i,j) == 3
                 Wumpus(i,j) = Wumpus(i,j) + 1; 
              end
           end
        end
    end
    if count == num_trials
        break;
    end
end

if count > 0
    pits = pits/count;
    Wumpus = Wumpus/count;
end




