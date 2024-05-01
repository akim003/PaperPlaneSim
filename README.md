# Paper Airplane Numerical Study
  Final Project: AEM 3103 Spring 2024

  - By: Alex Kim, John Kronkvist

  ## Summary of Findings
  This study successfully simulated flight path variations caused by initial velocity and initial flight path angle variations. Using Matlab several observations were also made about the effect of altering the initial conditions.

In the first experiment shown in Figure 1,  several key observations were made regarding the behavior of the paper airplane. Firstly, it was found that a higher initial velocity (V0) resulted in increased altitude at the expense of range. Secondly, it was observed that altering the initial flight angle had minimal impact on the trajectory, indicating a high degree of positive stability in the paper airplane design (Figure 1).

In the second experiment shown in Figure 2, some more key observations were made. In the Monte Carlo Simulations, a trend was identified when altering both initial flight path and initial velocity. All flight paths converged towards a similar pattern after they traveled approximately 10 meters, with the most significant variations occurring within the first 5  meters. This further supported the theory that the paper airplane was designed to have positive stability (Figure 2).

Finally, contrary to expectations the aircraft exhibited a brief upward acceleration at the start of the flight, on aggregate (Figure 3). Using the graphs from Figure 1 it was shown that this occurred when there was higher than nominal initial velocity and initial flight path angle. While no official hypothesis was agreed upon one theory was that the simulations conducted leaned more heavily on higher than nominal initial conditions due to uneven distributions of random numbers when rand() was used. 

Overall these findings successfully shed light on the aerodynamic characteristics and stability of the given paper airplane under different initial conditions.

 
  # Code Listing
  - [PaperPlane.m](main/PaperPlane.m)
    - Provided file, houses the variables used and example plots provided by *Supplement for Flight Dynamics* (Robert F. Stengel).
  - [EqMotion.m](main/EqMotion.m)
    - File created to house the EqMotion function provided by *Supplement for Flight Dynamics* (Robert F. Stengel).
  - [setUpFunction.m](main/setUpFunction.m)
    - Function created to eliminate codependencies between case files. Before this, each case was dependent on running the prior one; utilizes (assignin()).
  - [CaseA.m](main/CaseA.m) 
    - File created to house the solution to Case A. ODE23 is used to find the height and range curves for the given initial velocities and flight path angles. The results are plotted using the built-in Matlab functions.
  - [CaseB.m](main/CaseB.m) 
    - File created to house the solution to Case B. ODE23 is used in conjunction with a for loop to generate 100 height vs. range curves based on random initial velocity and initial flight path angles. The results are plotted using the built-in Matlab functions.
  - [CaseC.m](main/CaseC.m) 
    - File created to house the solution to Case C. A curve fit for the time_array, height_array, and range_array values calculated in CaseB, is found using the built-in Matlab functions polyfit and polyval. The results are plotted using the built-in Matlab functions.
  - [CaseD.m](main/CaseD.m)
    - File created to house the solution to Case D. The time derivatives of the height and range curve fits found in CaseC are taken using built-in Matlab function diff(). The results are plotted using the built-in Matlab functions.
  - [Animation.m](main/Animation.m) 
    - File created to house and export the animation of the nominal and additional scenario. The drawnow command is used to simulate motion in the animation and exportgraphics is used to export the desired animation as a .gif file.

  # Figures
  ## Fig. 1: Single Parameter Variation
  ![Figure 1](https://github.umn.edu/Kim01598/AEM3103/blob/main/figures/Figure%201.png)

  Figure 1 shows the effects of varying velocity and varying flight angle on the trajectory of the paper plane. Higher velocity and higher flight angle are shown in green while lower velocity and flight angle are shown in red. Nominal velocity and flight angle are included on the graphs in black for comparison. Varying the initial velocity has a more drastic effect on the overall trajectory than the flight angle, which stays relatively close to the nominal.

  ## Fig. 2: Monte Carlo Simulation
  <p align="center">
    <img src="https://media.github.umn.edu/user/28453/files/58ff6a8a-16a6-4dc0-85d4-acc07b04e3d1" alt="Figure 2">
  </p>

  Figure 2 shows the simulated 2D trajectories of 100 different paper airplane trials by randomizing initial velocity and flight angle. In the beginning of the graph, there is a large amount of variation between the trials, but in the later half of the flight, all of the trajectories seem to follow the same slope.

 ## Fig. 3: Time Derivatives
 ![Figure 3](https://github.com/akim003/PaperPlaneSim/blob/main/figures/Figure%203.png)
  
  Figure 3 shows the simulated time derivatives of the average trajectory for range and height from the Monte Carlo Simulation. In the beginning, the paper plane accelerates upwards before accelerating downwards for the rest of the flight. Conversely, the acceleration forwards remain positive and relatively stable the whole flight.

 # Animation
 ## Point-Mass Animation
  <p align="center">
    <img src="https://media.github.umn.edu/user/28453/files/58955536-f7d5-4857-bc17-1129fec0526c" alt="Figure animation">
  </p>
  The animation shows the simulated 2D trajectories of the nominal case, and the scenario where V = 7.5 m/s, and Gamma = +0.4 rad. The nominal case is shown in black and the second scenario is shown in green. The second scenario causes the paper plane to do a loop in the beginning, before slowly making its way downward for the rest of the flight.
