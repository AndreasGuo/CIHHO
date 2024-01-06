function s = simplebounds_re(s,Lb,Ub)
[ps,D] = size(s);
%Lb = repmat(Lbb, NP, 1);
%Ub = repmat(Ubb, NP, 1);
ns_tmp = s;
for i = 1:ps
    for j = 1:D
        if ns_tmp(i,j)<Lb(j)
            ns_tmp(i,j)=min(Ub(j),2*Lb(j)-ns_tmp(i,j));
        end
        if ns_tmp(i,j)>Ub(j)
            ns_tmp(i,j)=max(Lb(j),2*Ub(j)-ns_tmp(i,j));
        end
    end
end
s=ns_tmp;





