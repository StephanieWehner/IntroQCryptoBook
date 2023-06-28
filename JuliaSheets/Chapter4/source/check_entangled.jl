function check_entangled(rho)
    rhoT = partialtranspose(rho);
    eg = eigvals(rhoT);
    neg = filter(x -> x < 0, eg)
    if size(neg)[1]>0
        return true 
    else
        return false
    end
end