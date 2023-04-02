function [c_in,c_out, f_in, f_out]= feature_extraction(Img, K, H_u,u)

    H_n=1-H_u;
    c_in = sum(sum(Img.*(u<0)))/(sum(sum(u<0)));
    c_out = sum(sum(Img.*(u>=0)))/(sum(sum(u>=0)));
    f_x=Img.*H_u;
    f1=conv2(f_x,K,'same');
    f2=conv2(H_u,K,'same');
    f_in=f1./f2;

    f_y=Img.*H_n;
    f3=conv2(f_y,K,'same');
    f4=conv2(H_n,K,'same');
    f_out=f3./f4;

end
