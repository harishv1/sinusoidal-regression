% Clearing Variables, Closing figures, Clear Screen
clear variables
close all
clc
% Loading data
data_matrix= load('dataset1b.txt');

% Forming training set and testing set
train_set_x= data_matrix(1:100,1);
train_set_y= data_matrix(1:100,2);

test_set_x= data_matrix(101:200,1);
test_set_y= data_matrix(101:200,2);

% Initializing Value of k to iterate through and running the polyreg
% function for all values of k.
var_k=15;
% Now running the sinreg function with half of the data as training
% data and the rest 100 values as testing data. Also storing training loss
% and testing loss
training_loss=zeros(1,var_k);
testing_loss=zeros(1,var_k);
for j=1:var_k
    figure;
    [err,poly_coeff,errT] = sinreg(train_set_x,train_set_y,j,test_set_x,test_set_y);
    training_loss(1,j)=err;
    testing_loss(1,j)=errT;
    hold on
end
% Plotting training_loss vs testing_loss 
figure
plot(training_loss,'r');
hold on
plot(testing_loss,'b');
legend('training loss','testing loss');
axis([0,var_k,0,0.16]);
% Finding the indices of minimum testing_loss
[r,c]=find(testing_loss==min(min(testing_loss)));
% Printing the order of polynomial which gives the lowest testing loss.
% Printing the training loss and minimum testing loss at minimum testing
% loss.
fprintf( 'The value of k with lowest testing loss = %d\n', c);
fprintf( 'Training loss at minimum testing loss  = %d\n',training_loss(r,c));
fprintf( 'Minimum testing loss = %d\n',testing_loss(r,c));



