function [y] = powerof(base,power)
%y = powerof(base,power)
% base - if not set, 2 by default
%power - if not set, 2 by default
%y = base ^ power

if ~exist('base','var')
    base = 2;
end
if ~exist('power','var')
    power=2;
end


y  = base ^ power;