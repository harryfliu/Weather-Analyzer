function [out] = sum_square_HFL(x,y)
%sum_square_HFL Task 17
%   takes in two vectors, returns a scalar as an output 
%   ex. out = sum_square_HFL(x,y);

out = (x.*y)-((sum(x)*sum(y))/(length(x)));

end

