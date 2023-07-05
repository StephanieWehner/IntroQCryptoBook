function mmp(A::Array{Float64})
    out = ""
    out *= "\begin{pmatrix}"
    digits = 3
    A = round.(A,digits=digits) 
    nrows, ncols  = size(A)
    
    all_positive = ( sum(A.>0) > 0 )
    
    for (i,el) in enumerate(A)
        if all_positive == true
            put = "$el"
        else
            if el > 0
                put = "$el"
            else 
                put = L"\phantom{-}"*"$el"
            end
        end
        if i%ncols == 1
            out *= " "*put
            elseif i%ncols == 0 && i != nrows*ncols
            out *= " &amp; "*put*" \\"
        else
            out *= " &amp; "*put
        end
    end
    out*"\end{pmatrix}"
end

function mmp(A::Array{Int64})
    out = ""
    out *= "\begin{pmatrix}"
    nrows, ncols  = size(A)
    
    all_positive = ( sum(A.>0) > 0 )
    
    for (i,el) in enumerate(A)
        if all_positive == true
            put = "$el"
        else
            if el > 0
                put = "$el"
            else 
                put = L"\phantom{-}"*"$el"
            end
        end
        if i%ncols == 1
            out *= " "*put
            elseif i%ncols == 0 && i != nrows*ncols
            out *= " &amp; "*put*" \\"
        else
            out *= " &amp; "*put
        end
    end
    out*"\end{pmatrix}"
end