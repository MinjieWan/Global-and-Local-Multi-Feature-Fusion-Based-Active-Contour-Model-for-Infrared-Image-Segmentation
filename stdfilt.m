function [Std] = stdfilt(I, d)
    I = double(I);
    h = ones(2 * d + 1);
    n = (2 * d + 1)^2;
    conv1 = imfilter(I.^2, h, 'symmetric') / (n - 1); 
    conv2 = imfilter(I, h, 'symmetric').^2 / (n * (n - 1));
    Std = sqrt(conv1 - conv2);
end

