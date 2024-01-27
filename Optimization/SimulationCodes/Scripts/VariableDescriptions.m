%parametersModelFactors:            struct that contains all the non-dimentional parameters related to the robots model. As fields you can find.
%                                   1) The dimensional total mass, height and gravity accelaration. (Respectively, Mall, Lall, g)
%                                   2) The non-dimensional femoral and tibial link masses. (Respectively, mFFactor, mTFactor. Note: mHFactor
%                                   is implied by the relation mHFactor = 1 - 2*(mFFactor+mTFactor))
%                                   3) The non-dimensional femoral link, tibial link and hip mass moment of inertia. (Respectively, IFFactor, ITFactor)
%                                   4) The non-dimensional femoral link, tibial link and hip mass moment of inertia. (Respectively, IFFactor, ITFactor)
%                                   5) The non-dimensional femoral link length. (LFFactor, Note: LTFactor is implied by the relation LTFactor = 1 - LFFactor)
%                                   6) The non-dimensional femoral and tibial link's longitudinal center of mass (lFFactor, lTFactor)
%                                   7) The non-dimensional femoral link's transverse center of mass (lTxFactor)
%                                   8) The four bar link lengths. See four bar bar link section at 
%                                   explanations presentation (C:\Projects\BipedProject\Reports\Explanations.pptx). (l1Factor, l2Factor, l3Factor, l4Factor, l5Factor, l6Factor, ksiFAngle, ksiTAngle)
%                                   9) The non-dimensional rotational spring stiffness and damping at the knee cup. (kFactor, bFactor)
%                                   10) The footshape's file folder path (footShapePath)
%                                   11) The foot's half arc angle in [rad] (er)
%                                   12) The foot's non dimensional radius. (footsizeFactor)
%                                   To create a parametersModelFactors struct use the script "GenerateWorkSpace.m".
%
%parametersModel:                   struct that contains all the dimensional parameters related to the robots model. As fields you can find.
%                                   1) The hip, femoral and tibial mass. (M, miF, miF. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                   2) The femoral and tibial link lengths. (LiF, LiT. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                   3) The femoral and tibial link's longitudinal center of mass (liF, liT. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                   4) The femoral link's transverse center of mass (liTx. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                 	5) The four bar link lengths. See four bar bar link section at 
%                                   explanations presentation (C:\Projects\BipedProject\Reports\Explanations.pptx). (l1, l2, l3, l4, l5, l6, ksiF, ksiT, knee_cap_angle) 
%                                   6) The rotational spring stiffness and damping at the knee cup. (k, b)
%                                   7) The fooshape and the foot's radius in case radial foot. (footshape, r0)
%                                   8) The slope angle of the ground in [rad]. (alfa)
%
%stateConditions:                   struct that contains the reduced robot's state in the form of
%                               	1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                   2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
%fixedPointConditions:              struct in the same form of state conditions that aditionally constitutes the 
%                                   the fixed point condtion for the specific simulation model.
%
%---Best:                           Best means that the current results correspond to the best result that the algorith has found throught
%                                   the iterations.
%
%initialConditions:                 struct in the same form of state conditions used to initialize the
%                                   search for the fixed point conditions.
%
%sectionPlaneName:                  The alias of the poincare section plane that is used.
%
%sectionPlane:                      struct that contains all the functions and data related to the section plane.
%                                   1) The unconstrained state variables of the system on the section plane (VariablesUnconstrained)
%                                   2) The constrained state variables of the system on the section plane (VariablesConstrained)
%                                   3) The return map function that corresponds to the section plane (runReturnSequence)
%                                   4) The function that calculates the constraint state variable's value
%                                   based on the values of the unconstrained state variables (etc. calculateThetaF)
%                                   5) The function that moves the system's state up to the section plane based
%                                   on the unconstrained variables. (moveConditionsOnSectionPlane)
%                                   6) The function that transforms the data of a "stateConditions" struct to a "stateVector"
%                                   of the unconstraint state variables. (Usefool for the calculation of the fixed point
%                                   conditions using newton raphson). (transformConditions2UnconstrainedVariablesVector)
%                                   7) The function that transforms the data of a "stateVector" 
%                                   to "stateConditions" struct. (transformUnconstrainedVariablesVector2Conditions)
%                                   8) The initial stance foot index when the return sequence is called. (initialFoot)
%
%
%x:                                 double state vector that the DAE and solver reads. The state variables are assigned in the below sequence
%                                   1) The hips location at x direction. (x(1) = xH)
%                                   2) The hips location at y direction. (x(2) = yH)
%                                   3) The femoral angle of the foot 1 [rad]. (x(3) = thetaF)
%                                   4) The knee angle of the foot 1 [rad]. (x(4) = thetaK)
%                                   5) The femoral angle of the foot 2 [rad]. (x(5) = psiF)
%                                   6) The knee angle of the foot 2 [rad]. (x(6) = psiK)
%                                   7) The time derivative of hips location at x direction. (x(7) = xH_d)
%                                   8) The time derivative of hips location at y direction. (x(8) = yH_d)
%                                   9) The time derivative of femoral angle of the foot 1 [rad]. (x(9) = thetaF_d)
%                                   10) The time derivative of knee angle of the foot 1 [rad]. (x(10) = thetaK_d)
%                                   11) The time derivative of femoral angle of the foot 2 [rad]. (x(11) = psiF_d)
%                                   12) The time derivative of knee angle of the foot 2 [rad]. (x(12) = psiK_d)
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   In case that the robot is in single stance phase of the foot i (where i = 1 or 2)
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   13) The foot's i not slip constraint lagragian multiplier antiderivatives. (x(13) = lamda_ix)
%                                   14) The foot's i not ground perturbation constraint lagragian multiplier antiderivatives. (x(14) = lamda_iy)
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   In case that the robot is in double stance phase
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   13) The foot's 1 not slip constraint lagragian multiplier antiderivatives. (x(13) = lamda_1x)
%                                   14) The foot's 1 not ground perturbation constraint lagragian multiplier antiderivatives. (x(14) = lamda_1y)
%                                   15) The foot's 2 not slip constraint lagragian multiplier antiderivatives. (x(15) = lamda_2x)
%                                   16) The foot's 2 not ground perturbation constraint lagragian multiplier antiderivatives. (x(16) = lamda_2y)
%
%IC:                                struct in the same form of stateConditions struct augmented with the field xinit initial x
%                                   vector that the DAE solver reads. Also the field 'below_knee' which contains the tibial angles
%                                   of the robot that are caclulated analytically from the state space.
%
%
%simulationParameters:              simulationParameters:      struct that contains as fields
%                                	1) A struct with all the dimensional model pararameters. (Model) 
%                                 	2) A struct with all the undimensional model parameters. (ModelFactors)
%                                  	3) A struct that contains all the solver parameters. (Solver)
%                                	4) The section plane sturct. (sectionPlane)
%
%initialFoot:                       Index that indicates which foot is in stance at the section plane space.
%
%results:                           struct in which all the simulation run results are saved. As fields you can find:
%                                   results structure can be initialized using the initialize_simulation.m function. (See gaitFunction.m)
%                                   1) A struct that contains the final timestep's state vector of the model in the form that the solver can read. (xinit)
%                                   also the final time step's time is included (t0). (intermidiate)
%                                   2) The simulation's time at each timestep. (t)
%                                   3) The phase of the robot's gait at each timestep. (phase)
%                                   4) The hips location at x direction at each timestep. (xH)
%                                   5) The hips location at y direction at each timestep. (yH)
%                                   6) The femoral angle and the angularar velocity. "theta" corresponds to "foot1" and "psi" corresponds to "foot2". (---F, ---F_d)
%                                   7) The tibial angle and the angularar velocity. "theta" corresponds to "foot1" and "psi" corresponds to "foot2". (---T, ---T_d)
%                                   8) The knee angle and the angularar velocity. "--- = theta" corresponds to "foot1" and " --- = psi" corresponds to "foot2". (---K, ---K_d)
%                                   9) The events the total number of events that has been recorded at the simulation
%                                   and the corresponding intermidiates. (Respectively: events.occurancies and events.intermidiates)
%                                   10) A flag that indicates if the robot has fallen during the simiulation. (fell)
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   EXTRA
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   After the extractFootClearance.m function call the results structure aditionally contains the foot clearance related results.
%                                   1) The swing foot's ground clearance calculated at each timestep. (footClearance)
%                                 	2) The swing foot's lower part location in the x direction at each timestep. (footClearanceXLocation)
%                                	3) The swing foot's distance traveled. (footSwingDistanceTraveled)
%                                  	4) The swing foot's ground clearance time derivative at each timestep. (footClearanceRate)
%                                	5) The swing foot's mean clearance with respect to the distance traveled. (footMeanClearance)
%                               	6) The swing foot's clearance local minimums. (footClearanceLocalMinimums)
%                                 	7) The swing foot's clearance local minimums (indexesfootClearanceLocalMinimumIdxs)
%                                   
%
%events:                            struct that contains the function handles of all the event equations
%                                   for a specific set of model parameters.
%
%options:                           struct that contains the solver options for each different simulation that
%                                   will be propably executed.
%
%stateStructure:                    struct that contains the each one of the reduced robot's state as a field.
%                                   For example stateStructure.ThetaF etc.
%
%Jacobian:                          struct that contains the jacobian matrix of the linearized return map. (Matrix)
%                                   Apart from that this structure also contains
%                                   1) The symbolic representation of jacobian.(Symbolic)
%                                   2) The eigen values vector of the jacobian matrix. (eigenValues)
%                                   3) The norm vector of the eigen values vector. (eigenValuesNorm)
%                                   4) The maximum from the norm of eigen values vector which is also considered
%                                   as a metric of the system's stability. (eigenValueMax)
%                                   5) The not-constrained-by-the-section-plane variables that are differentiatiad (partialDerivatives)
%                                   6) The not-constrained-by-the-section-plane variables that are not differentiated (partialDerivativeExcluded)
%                                   In order to have a better understanding of the section plane structure read: C:\Projects\BipedProject\Reports\SectionPlane.docx
%                           
% resemblanceMetrics:               struct that takes contains the comparison between to state condition. As field you can find:
%                                   1) The state conditions1. (stateConditions1)
%                                   2) The state conditions2. (stateConditions2)
%                                   3) The absolute difference between the tow state conditions e.g. thetaF1 - thetaF2. (DifferenceAbsolute)
%                                   4) The relative difference between the tow state conditions e.g. (thetaF1 - thetaF2)/thetaF1. (DifferenceRelative)
%
% resemblanceMetricsFunction:       struct in the same form of resemblance metrics. In this variable the compared states are the conditions before 
%                                   the return map function call (stateConditions) and conditions after the return map function call P(stateConditions).
%                                   At the fixed point the difference between those tow state conditions mast be near to 0.
%
%resemblanceMetricsSolution:        struct in the same form of resemblance metrics. In this variable the compared states are the conditions before 
%                                   the newton raphson (n)^th iteration (stateConditions) and conditions calculated after the (n)^th iterations (stateConditionsNew).
%                                   At the fixed point the difference between those tow state conditions mast be near to 0.
%
%isStateConverged:                  logical that acts as flag in order the user to know if the fixed point is found with an acceptable level of accuracy.
%
%vectorBasedOnJacobian:             double array that contains the unconstraint-by-the-section-plane that are inculded in the jacobian matrix calculation
%                                	variable values. The vector is generated in the same sequence that the jacobian matrix is generated.
%
%vectorBasedOnJacobianExcluded:     double array that contains the unconstraint-by-the-section-plane that are excluded in the jacobian matrix calculation
%                                	variable values. The vector is generated in the same sequence that the jacobian matrix is generated.
%
%iIteration:                        integer number tha specifies the iterative method's iteration index.
%
%modelAlias:                        char that specifies the name of the model of which the fixed point is calculated.
%
%perturbation:                      double value that is used as state variable's perturbation in the numerical calculation
%                                   of the biped retun map's jacobian matrix.
% 
%functionCalls:                     struct that contains for each unconstrained variable the front and back perturbed conditions
%                               	needed for the retun map's jacobian matrix calculation.
%
%areConditionsSimilar:              logical flag that indicates if the tow condition states can be considered equal based
%                                 	on their relative difference.
%
%OptimizationOptions:               struct that contains options that can affect the optimization's performance. As fields you can find:
%                                   1) Options related to the calculation of the fixed point for each examination of
%                                   different model parameters. (FixedPointCalculationOptions)
%                                   2) Options related to the jacobian matrix calculation (JacobianCalculationOptions)
%                                   3) Options related to the cost function weights (CostFunctionOptions)
%                                   4) Options related to the steepest descend method (SteepestDescendOptions)
%                                   See RunOptimizationAlgorithm.m in order to obtain more details about each option structure.
%
%SimulationModelOptions:            struct that contains options that are related to the model simulation parameters and the real construction characteristics.
%                                   As fields you can find:
%   `                               1) The initial simulation paramerameters of the mode (simulationParameters)
%                                   2) The initial conditions with wich the optimization starts (initialConditions)
%                                   3) The construction characteristics that produce the construction restrictions (ConstructionCharacteristics)
%                                   See RunOptimizationAlgorithm.m in order to obtain more details about each option structure.
%
%iterationResults:                  struct [1xn] that contains all the optimization iteration information. Each row corresponds to one design variable.
%                                   As fields you can find:
%                                   1) The gradient of the cost function with respect to the corresponding design variable (gradient).
%                                   2) The mean cost of the back and the front perturbated model (cost).
%                                   3) The (maximum eigen value, construnction, mean foot clearance, minimum foot clearance)
%                                   cost gradient (eigenValueMaxGr, constructionGr, meanFootClearanceGr, minFootClearanceGr).
%                                   4) The (maximum eigen value, construnction, mean foot clearance, minimum foot clearance)
%                                   values (eigenValueMax, construction, meanFootClearance, minFootClearance).
%                                   5) The optimizations design factors and their values (designFactors, designFactorValues)
%                                   6) The model's parameter factors of the current iteration and
%                                   the corresponding initial conditions (parametersModelFactors, initialConditions)
%                                   7) Extra function call details related to the front and the 
%                                   back perturbated model (functionCallDetailsFront, functionCallDetailsBack)
%
%
%                                   
%optimizationInformation:           struct that contains all the optimization procedure related information. As fields of this structure you can find:
%                                   1) The number of the optimization iterations (numOfIterations)
%                                   2) A flag that indicates if the optimization has converged (isOptimizationConverged)
%                                   3) The path that the optimization has been saved (optimizationFolder)
%
%materialName:                      char array that indicates the material name of a link. From the material name the usefull material
%                                   characteristics can be extracted.
%
%
%ConstructionParameters:            struct that contains important for the construction base calculation parameters. Those parameters are
%                                   setted in the form of fields. As field you can find.
%                                   1) The total length of the robot (Lall).
%                                   2) The femoral to total length ratio (LFFactor).
%                                   3) The hip to total mass ratio (mHFactor).
%                                   4) The safety to buckling factor for the femoral link
%                                   5) The safety to buckling factor for the tibial link
%
%Constraints:                       struct that contains nominal parameters based on the construction characteristics and the deviation span of them that is considered acceptable
%                                   As field you can find.
%                                   1) The nominal parameters that are calculated based on the construction characteristics. (Center)
%                                   2) The model parameters deviation span from the nominal parameters that they are considered acceptable. (Span)
%                                   3) Side data calculated such as total mass, cross section areas, lengths. (Data)
%
%RobotLegs:                         struct that contains all the robot leg link information. Each leg constitutes from one femoral beam
%                                   and one tibial beam. In the beam stucture contains information in the form of fields. As fields you can find 
%                                   1) A cross section structure. (CrossSection)
%                                   2) A material structure. (Material)
%                                   3) The beams lenght, mass, mass moment of inertia, the center of mass in x and y direction, 
%                                   critical buckling load and aspect ratio. (Length, Mass, MassInertia, CenterOfMassY, CenterOfMassX,
%                                   LoadBuckling, AspectRatio)
%
%Material:                          struct that contains all the material related information. As fields you can find
%                                   1) The material's name. (name)
%                                   2) The material's density [kg/m^3].(material density)
%                                   3) The yield strength of the material [Pa]. (StrengthYield)
%                                   4) The ultimate strength of the material [Pa]. (StrengthUltimate)
%                                   5) The material's young modulus [Pa]. (YoungModulus)
%                                   6) The material's Poisson ration. (PoissonRatio)
%
%
%crossSectionData:                  struct that contains the robot's links cross-section data. As fields you can find.
%                                   1) The cross section name. The word 'automatic' in the crossection name, indicates 
%                                   that all the other cross-section data, are calculated automatically and no other inputs
%                                   are required. (crossSectionName)
%                                   As each cross-section is governed by different formulas see generateCrossSectionStructure.m script
%                                   for more details.
%
%CrossSection:                      stuct that constains the crossSectionData with some extra calculations as area and area moment of inertia
%
%Beam:                              struct that contains the information related to a beam of a specific cross-section, material, and length. As fields you can find 
%                                	1) A cross section structure. (CrossSection)
%                                   2) A material structure. (Material)
%                                   3) The beams lenght, mass, mass moment of inertia, the center of mass in x and y direction, 
%                                   critical buckling load and aspect ratio. (Length, Mass, MassInertia, CenterOfMassY, CenterOfMassX,
%                                   LoadBuckling, AspectRatio)
%
%penaltyCost:                       double value of the total penalty due to model's parameters factors deviation from the acceptable deviation span.
%
%
%ConstraintsDifference:             struct that contains information related to the deviation of the model's parameter factors from the acceptable factor's span
%                                   according to the Constraints struct. As fields you can find:
%                                   1) The constraint parameter factors names. (constraintNames)
%                                   2) The maximum acceptable value of the parameter factors. (constraintLimitMax)
%                                   3) The minimum acceptable value of the parameter factors. (constraintLimitMin)
%                                   4) The actual parameter factors values. (factorValues)
%                                   5) The actual parameter factors values distance from the maximum factors values. (constraintValuesMax)
%                                   6) The actual parameter factors values distance from the minimum factors values. (constraintValuesMin)
%                                   7) The possitive values of the constraintValuesMax. (constraintValuesMaxOn)
%                                   8) The possitive values of the constraintValuesMin. (constraintValuesMinOn)
%
%cost:                              double that indicates the cost-function's value. The cost depends on the cost function options. 
%
%functionCallDetails:               struct that contains all the cost function call data that has been collected during the cost function call
%                                   this structure is usefull for troubleshooting problems during the optimization. As fields you can find:
%                                   1) The fixepoint conditions that has bee calculate for the parameters of the specific cost function call.   (fixePointConditions)
%                                   2) The model's parameter factors that correspond to the specific cost function call.                        (parametersModelFactors)
%                                   3) The return map's Jacobian                                                                                (Jacobian)
%                                   5) The convergence to the fixed point information.                                                         	(resemblanceMetricsSolution, resemblanceMetricsFunction)
%                                   6) The simulation results after a simple function call                                                   	(results)
%                                   7) The construction constraints information                                                                 (ConstraintsDifference, RobotLegs)
%                                   8) The eigen values of each parameter used at the robustness test.                                          (maximumEigenValues)
%                                   9) The maximum absolute eigen value of the Jacobian                                                         (eigenValueMax).
%                                   10) The mean eigen value after the robustness test.                                                         (eigenValueRobustness)
%                                   11) The deviation from the nominal construction summary metric.                                         	(Construction)
%                                   12) The mean foot clearance after a simple function call.                                                   (meanFootClearance)
%                                   13) The minimum foot clearance after a simple function call.                                                (minFootClearance)
%                                   14) The "eigenValueMax" cost at the cost function.                                                          (eigenValueCost)
%                                   15) The "eigenValueRobustness" cost at the cost function.                                                   (eigenValueRobustnessCost)
%                                   16) The "construction" cost at the cost function.                                                           (constructionCost)
%                                   17) The "meanFootClearance" cost at the cost function.                                                      (meanFootClearanceCost)
%                                   18) The "minFootClearance" cost at the cost function.                                                       (minFootClearanceCost)
%                                   
%
%designParametersRobustness:        cell that contains the name of the parameters whith which the models robustness will be checked.
%
%maximumEigenValues:                double array that contains the maximum jacobian eigen value after each design parameter's small perturbation.
%
%isImpactValid:                     flag that indicates if the impact actually leads the model in double stance phase.
%                                   The conditions for a valid double stance phase condition is that both feet no penetration ground reaction 
%                                   forces to be possitive.
%
%xImpact:                           vector in the form of x state vector after the impact.
%
%lamdas4x1:                         double vector that contains the ground reaction forces calculated in the double stance phase. Bellow you can find the sequence of them
%                                   1) Foot's 1 no slip reaction forece.                (lamdas4x1(1))
%                                   2) Foot's 1 no ground penetration reaction forece.  (lamdas4x1(2))
%                                   3) Foot's 2 no slip reaction forece.                (lamdas4x1(3))
%                                   4) Foot's 2 no ground penetration reaction forece.  (lamdas4x1(4))
%
%optimizationPath:                  char that indicates the path of the folder where the optimization results are saved.
%
%OptimizationFigures:               struct that contains all the resulted optimization figure handles.
%
%pOpts:                             struct that contains all the important options and functions. As fields you can find:
%                                   1) The figures position, font size, linewidth, box option. (figurePosition, lineWidthImportant, lineWidthMinor, Box)
%                                   2) The all plots colormap function. (colormapFunction)
%                                   3) The figure generation function. (gFigure)
%                                   4) The axes generation function. (gAxes)
%                                  	5) The line plots generation function. (gLine)
%
