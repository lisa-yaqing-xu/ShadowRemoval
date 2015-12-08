function[gradl, grads] = getLSGradients(sampleset, mask, Gmag)
gradl = [];
grads = [];

gls = {};
gss = {};

glsize = 1;
gssize = 1;

[s_,ssize] = size(sampleset); 
[msx,msy] = size(mask);
for i = 1:ssize;
    s = sampleset{i};
        sr = s(2);
    scol = s(1);
    slen = s(3);
    sdir = s(4);
    for j = 0:2
    if(sdir == 3)
        la = [sr,scol+1+j];
        sa = [sr,scol+1-(slen+1)-j];
    elseif(sdir == 0)
        la = [sr+1+j,scol];
        sa = [sr+1-(slen+1)-j,scol];
    elseif(sdir == 1)
        la = [sr,scol-1-j];
        sa = [sr,scol-1+(slen+1)+j];
    elseif(sdir == 2)
        la = [sr-1-j,scol];
        sa = [sr-1+(slen+1)+j,scol];
    end 
    lastr = strcat(num2str(la(1)),'_',num2str(la(2)));
    sastr = strcat(num2str(sa(1)),'_',num2str(sa(2)));
    
    if(ismember(lastr,gls) == 0 && la(1) > 0 && la(1) <= msx && ...
            la(2) > 0 && la(2) <= msy && mask(la(1), la(2)) == 255)
        gradl(glsize) = Gmag(la(1),la(2));
        gls{glsize} = lastr;
        glsize = glsize + 1;
    end
    if(ismember(sastr,gss) == 0 && sa(1) > 0 && sa(1) <= msx && ...
            sa(2) > 0 && sa(2) <= msy && mask(sa(1), sa(2)) == 0)
        grads(gssize) = Gmag(sa(1),sa(2));
        gss{gssize} = sastr;
        gssize = gssize + 1;
    end
    end
end



