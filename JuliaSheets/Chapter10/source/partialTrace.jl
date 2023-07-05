
#####
#
# partialTrace
# 
# returns partial trace of  a matrix "rho"
#
# Input:
#   rho: density matrix of A, B (and C) :: 4x4 or 8x8 matrix
#   sub:  subsystem to be traced out:: "A", "B", "C", "AB","AC" or "BC"
#                       
# Output:
#   reduced density matrix 

function partialTrace(rho ,sub = "B"::ASCIIString)

    # two-parties
    if size(rho)[1] == 4
        binRho = zeros(2,2,2,2) # put rho in array with binary indices |ai,bi><aj,bj|
        
        for ia = 0:1, ib = 0:1, ja = 0:1, jb = 0:1
            i = 2*ia + ib + 1 # base ten indices
            j = 2*ja + jb + 1
            binRho[ia+1,ib+1,ja+1,jb+1] = rho[i,j]
        end

        # using binary indices tracing is easy
        if sub == "A"
            rhoB = zeros(2,2)
            for i = 1:2, j = 1:2
                rhoB[i,j] = binRho[1,i,1,j] + binRho[2,i,2,j]   
            end
            return rhoB

        elseif sub == "B"
            rhoA = zeros(2,2)
            for i = 1:2, j = 1:2
                rhoA[i,j] = binRho[i,1,j,1] + binRho[i,2,j,2]
            end
            return rhoA
        else
            error("enter  as a second argument a string A or B")
        end
    
        # three parties ----------------------------------
        elseif size(rho)[1] == 8
            #println("3 parties")
            binRho = zeros(2,2,2,2,2,2) # put rho in array with binary indices 
                                                                # |ai,bi,ci><aj,bj,cj|
        
            for ia = 0:1, ib = 0:1, ic = 0:1, ja = 0:1, jb = 0:1, jc = 0:1
                i = 4*ia + 2*ib + ic + 1 # base ten indices
                j = 4*ja + 2*jb + jc+ 1 
                binRho[ia+1,ib+1,ic+1,ja+1,jb+1,jc+1] = rho[i,j]
            end

            if sub == "A"
                rhoBC = zeros(4,4)
                for ib = 1:2, ic = 1:2, jb = 1:2, jc = 1:2
                    i = 2*(ib-1) + ic
                    j = 2*(jb-1) + jc
                    rhoBC[i,j] = binRho[1,ib,ic,1,jb,jc] + binRho[2,ib,ic,2,jb,jc] 
                end
                return rhoBC

            elseif sub == "B"
                rhoAC = zeros(4,4)
                for ia = 1:2, ic = 1:2, ja = 1:2, jc = 1:2
                    i = 2*(ia-1) + ic
                    j = 2*(ja-1) + jc
                    rhoAC[i,j] = binRho[ia,1,ic,ja,1,jc] + binRho[ia,2,ic,ja,2,jc] 
                end
                return rhoAC

            elseif sub == "C"
                rhoAB = zeros(4,4)
                for ia = 1:2, ib = 1:2, ja = 1:2, jb = 1:2
                    i = 2*(ia-1) + ib
                    j = 2*(ja-1) + jb
                    rhoAB[i,j] = binRho[ia,ib,1,ja,jb,1] + binRho[ia,ib,2,ja,jb,2] 
                end
                return rhoAB

            elseif sub == "AB"
                rhoBC = partialTrace(rho,"A")
                rhoC = partialTrace(rhoBC,"A") # "A" since "B"  := "A", "C":="B"
                return rhoC
            
            elseif sub == "BC"
                rhoAC = partialTrace(rho,"B") 
                rhoA = partialTrace(rhoAC,"B")  # "B" since "B"  := "C"
                return rhoA

            elseif sub == "AC"
                rhoBC = partialTrace(rho,"A")
                rhoB = partialTrace(rhoBC,"B")
                return rhoB

            else
                error("enter as second argument, a string A,B,C,AB,BC or AC")
            end

        else
            error("This size density operator are not supported yet")
        end
end


    