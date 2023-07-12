

#######################
# Bell test calculations #
#######################
# Summary:
#           Calculates expected probability distributions associated with a Bell test.
# Input:
#            rho_AB: Two-qubit state
#            theta_0: "measurement angle" (degrees) corresponding to Alice measurement setting x = 0
#            theta_1: "measurement angle" (degrees) corresponding to Alice measurement setting x = 1
#            gamma_0: "measurement angle" (degrees) corresponding to Alice measurement setting y = 0
#            gamma_1: "measurement angle" (degrees) corresponding to Alice measurement setting y = 1
# Output: 
#             tuple containting the four associated probability distributions P(a,b | x,y)

function bell_test_calculations(rho_AB, theta_0 = 0, theta_1 = 45, gamma_0 = 22.5, gamma_1 = 77.5)

    #############################################
    # Angles define measurements                #
    #############################################

    # theta is for Alice
    # gamma for Bob

    ####################################
    # Define Measurement Basis Vectors #
    ####################################

    # Syntax: a_a_x where x is a setting, a the outcome
    # Syntax: b_b_y where y is a setting, b the outcome

    a_0_0 = [cosd(theta_0),sind(theta_0)]
    a_1_0 = [cosd(theta_0+90),sind(theta_0+90)]

    a_0_1 = [cosd(theta_1),sind(theta_1)]
    a_1_1 = [cosd(theta_1+90),sind(theta_1+90)]

    b_0_0 = [cosd(gamma_0),sind(gamma_0)]
    b_1_0 = [cosd(gamma_0+90),sind(gamma_0+90)]

    b_0_1 = [cosd(gamma_1),sind(gamma_1)]
    b_1_1 = [cosd(gamma_1+90),sind(gamma_1+90)]

    ###################################
    # Define associated 1-party POVMs #
    ###################################

    # Syntax: A_a_x where x is a setting, a the outcome
    # Syntax: B_b_y where y is a setting, b the outcome

    A_0_0 = kron(a_0_0',a_0_0)
    A_1_0 = kron(a_1_0',a_1_0)

    A_0_1 = kron(a_0_1',a_0_1)
    A_1_1 = kron(a_1_1',a_1_1)

    B_0_0 = kron(b_0_0',b_0_0)
    B_1_0 = kron(b_1_0',b_1_0)

    B_0_1 = kron(b_0_1',b_0_1)
    B_1_1 = kron(b_1_1',b_1_1)

    ###################################
    # Define associated 2-party POVMs #
    ###################################

    # Syntax: AB_ab_xy where x,y are settings, a,b are outcomes
    # Thus:
    # AB_ab_xy = kron(A_a_x, B_b_y)

    AB_00_00 = kron(A_0_0, B_0_0)
    AB_01_00 = kron(A_0_0, B_1_0)
    AB_10_00 = kron(A_1_0, B_0_0)
    AB_11_00 = kron(A_1_0, B_1_0)

    AB_00_01 = kron(A_0_0, B_0_1)
    AB_01_01 = kron(A_0_0, B_1_1)
    AB_10_01 = kron(A_1_0, B_0_1)
    AB_11_01 = kron(A_1_0, B_1_1)

    AB_00_10 = kron(A_0_1, B_0_0)
    AB_01_10 = kron(A_0_1, B_1_0)
    AB_10_10 = kron(A_1_1, B_0_0)
    AB_11_10 = kron(A_1_1, B_1_0)

    AB_00_11 = kron(A_0_1, B_0_1)
    AB_01_11 = kron(A_0_1, B_1_1)
    AB_10_11 = kron(A_1_1, B_0_1)
    AB_11_11 = kron(A_1_1, B_1_1)

    #############################
    # Measurement probabilities #
    #############################

    p00_00 = tr(AB_00_00*rho_AB)
    p00_01 = tr(AB_01_00*rho_AB)
    p00_10 = tr(AB_10_00*rho_AB)
    p00_11 = tr(AB_11_00*rho_AB)

    p01_00 = tr(AB_00_01*rho_AB)
    p01_01 = tr(AB_01_01*rho_AB)
    p01_10 = tr(AB_10_01*rho_AB)
    p01_11 = tr(AB_11_01*rho_AB)

    p10_00 = tr(AB_00_10*rho_AB)
    p10_01 = tr(AB_01_10*rho_AB)
    p10_10 = tr(AB_10_10*rho_AB)
    p10_11 = tr(AB_11_10*rho_AB)

    p11_00 = tr(AB_00_11*rho_AB)
    p11_01 = tr(AB_01_11*rho_AB)
    p11_10 = tr(AB_10_11*rho_AB)
    p11_11 = tr(AB_11_11*rho_AB)

    ########################################
    # Associated Probability Distributions #
    ########################################

    # Note, for plotting purposes constructed as 1D 4-element Arrays; [1,2,3]
    # not as 2D 4x1 Array; [1 2 3]

    p00 = [p00_00, p00_01, p00_10, p00_11]
    p01 = [p01_00, p01_01, p01_10, p01_11]
    p10 = [p10_00, p10_01, p10_10, p10_11]
    p11 = [p11_00, p11_01, p11_10, p11_11]

    return p00, p01, p10, p11
end

################
# bell_test_plot #
################
# Summary:
#            a PyPlot wrapper, 
#            plot serves to visualize Bell test 
# Input/Output: Naming conventions are as defined above.

function bell_test_plot(theta_0, theta_1, gamma_0, gamma_1, p00, p01, p10, p11)

        # Switch to radials

        theta_0r = 2*pi*theta_0/360  
        theta_1r = 2*pi*theta_1/360 
        gamma_0r = 2*pi*gamma_0/360
        gamma_1r = 2*pi*gamma_1/360

        ################################## ALICE's measurement angles 

        color_a0 = "red"
        color_a1 = "#ffa500"

        ax = subplot(161, polar = "true")
        ax[:plot](theta_0r*ones(2), 
                            [0,1], 
                            color=color_a0, 
                            label="\$a_0\$");
        ax[:scatter](theta_0r, 
                                1,
                                s=50, 
                                c=color_a0, 
                                alpha=0.5); 
         ax[:plot]((theta_0r+pi/2)*ones(2), 
                            [0,1], 
                            color=color_a0, 
                            label="\$a_0\$");

        ax[:plot](theta_1r*ones(2), 
                            [0,1], 
                            color=color_a1, 
                            label="\$a_1\$");
        ax[:scatter](theta_1r, 
                                1,
                                s=50, 
                                c=color_a1, 
                                alpha=0.5); 
         ax[:plot]((theta_1r+pi/2)*ones(2), 
                            [0,1], 
                            color=color_a1, 
                            label="\$a_1\$");

        ax[:set_ylim]([0,1.1])
        ax[:set_xticklabels](["\$|0\\rangle\$","\$|+\\rangle\$",
                                          "\$|1\\rangle\$","\$-|-\\rangle\$",
                                          "\$-|0\\rangle\$","\$-|+\\rangle\$",
                                          "\$-|1\\rangle\$","\$|-\\rangle\$"])
        ax[:set_yticks]([0,1])
        ax[:set_yticklabels](["",""])

        #################################### BOB's measurement angles 

        color_b0 = "blue"
        color_b1 = "#00868B"

        ax = subplot(162, polar = "true")
        ax[:plot](gamma_0r*ones(2), 
                            [0,1], 
                            color=color_b0, 
                            label="\$b_0\$");
        ax[:scatter](gamma_0r, 
                                1,
                                s=50, 
                                c=color_b0, 
                                alpha=0.5); 
        ax[:plot]((gamma_0r+pi/2)*ones(2), 
                            [0,1], 
                            color=color_b0, 
                            label="\$b_0\$");


        ax[:plot](gamma_1r*ones(2), 
                            [0,1], 
                            color=color_b1, 
                            label="\$b_1\$");
        ax[:scatter](gamma_1r, 
                                1,
                                s=50, 
                                c=color_b1, 
                                alpha=0.5); 
        ax[:plot]((gamma_1r+pi/2)*ones(2), 
                            [0,1], 
                            color=color_b1, 
                            label="\$b_1\$");


        ax[:set_ylim]([0,1.1])
        ax[:set_xticklabels](["\$|0\\rangle\$","\$|+\\rangle\$",
                                          "\$|1\\rangle\$","\$-|-\\rangle\$",
                                          "\$-|0\\rangle\$","\$-|+\\rangle\$",
                                          "\$-|1\\rangle\$","\$|-\\rangle\$"])
        ax[:set_yticks]([0,1])
        ax[:set_yticklabels](["",""])

        ######### Probability Distributions
        highlight_color = "#DDDDDD"
        regular_color = "white"
        transp = 0.5 # transparency
        
        ax = subplot(163)
        ax[:bar](collect(1:4), [p00[1],0,0,p00[4]], color = highlight_color, alpha = transp, align="center")
        ax[:bar](collect(1:4), [0,p00[2],p00[3],0], color = regular_color, alpha = transp, align="center")
        ax[:spines]["top"][:set_color]("none") # Remove the top axis boundary
        ax[:spines]["right"][:set_color]("none") # Remove the right axis boundary 
        ax[:spines]["left"][:set_color]("none") # Remove the right axis boundary 
        xticks([]) # Remove ticks
        xlabel("00")
        yticks([]) # Remove ticks
        ylim(0,1) # Set y-axis limit

        ax = subplot(164)
        ax[:bar](collect(1:4), [p01[1],0,0,p01[4]], color = highlight_color, alpha = transp, align="center")
        ax[:bar](collect(1:4), [0,p01[2],p01[3],0], color = regular_color, alpha = transp, align="center")
        ax[:spines]["top"][:set_color]("none") 
        ax[:spines]["right"][:set_color]("none") 
        ax[:spines]["left"][:set_color]("none") 
        xticks([])
        xlabel("01")
        yticks([])
        ylim(0,1)

        ax = subplot(165)
        ax[:bar](collect(1:4), [p10[1],0,0,p10[4]], color = highlight_color, alpha = transp, align="center")
        ax[:bar](collect(1:4), [0,p10[2],p10[3],0], color = regular_color, alpha = transp, align="center")
        ax[:spines]["top"][:set_color]("none") 
        ax[:spines]["right"][:set_color]("none") 
        ax[:spines]["left"][:set_color]("none")
        xticks([])
        xlabel("10")
        yticks([])
        ylim(0,1)

        ax = subplot(166)
        ax[:bar](collect(1:4), [p11[1],0,0,p11[4]], color = regular_color, alpha = transp, align="center")
        ax[:bar](collect(1:4), [0,p11[2],p11[3],0], color = highlight_color, alpha = transp, align="center")
        ax[:spines]["top"][:set_color]("none")
        ax[:spines]["left"][:set_color]("none")
        xticks([])
        xlabel("11")
        ax[:yaxis][:set_ticks_position]("right")
        yticks([0,0.5,1])
        ylim(0,1)

        # P_win
        P = 0.25*(p00[1] + p00[4] + p01[1] + p01[4] + p10[1] + p10[4] + p11[2] + p11[3])
        digits = 3
        P = round(P,digits=digits)        
        suptitle("P_win = $P")        
end

function pwinCHSH(rho_AB, θ_0, θ_1, γ_0, γ_1)
    p00, p01, p10, p11 = bell_test_calculations(rho_AB, θ_0, θ_1, γ_0, γ_1);
    return 0.25*(p00[1] + p00[4] + p01[1] + p01[4] + p10[1] + p10[4] + p11[2] + p11[3])
end
