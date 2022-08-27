clc; clear; close;

x = 0:.1:1   % creates vector equal to x = linspace(0,1,11)

%f(x) = cos(x);  % wouldv'e been AOK if it was on paper. ... that sounds
                % dumb, what I mean is that "normal" math notation is not
                % used in MATLAB. Do this instead:

f = @(x) cos(x);    % This creates a "function handle", which is a MATLAB
                    % data type, a type of data. More specifically:
                    % "Anonymous function handles (often called anonymous
                    % functions) represent single inline executable
                    % expressions that return one output." -Docs.

% data type (from Wikipedia):
% a set of possible values and a set of allowed operations on it. A data
% type tells the compiler or interpreter how the programmer intends to use
%the data. Berättar för compilern (vad nu det är) vilken slags data det är.


