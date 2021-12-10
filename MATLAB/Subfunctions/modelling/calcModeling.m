%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function: 
%
%   Parameters: 
% 
%   Outputs: 
%
%   Description: calcWingDownforce  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [normalForceFrontWheelDownforce, normalForceRearWheelDownforce, normalForceFrontAcceleration, normalForceRearAcceleration, normalForceFrontStatic, normalForceRearStatic, fxLeftWheelFront, fxLeftWheelRear, fyLeftWheelFront, fyLeftWheelRear, fzLeftWheelFront, fzLeftWheelRear, frontBias, rearBias] = calcModeling(...
    totalMass,...
    lengthCOMToRearTire,...
    lengthCOMToFrontTire,...
    COMFromGroundX,...
    COMFromGroundY,...
    COMFromGroundZ,...
    lengthCOMToFrontWing,... 
    lengthCOMToRearWing,...
    heightCOMToFrontWing,...
    heightCOMToRearWing,...
    lengthToRightWheelCOM,...
    lengthToLeftWheelCOM,...
    densityAir,...
    coefficientWing,...
    frontalAreaFrontWing,...
    frontalAreaRearWing,...
    coefficientLift,...
    coefficientLiftWing,...
    coefficientDrag,...
    coefficientRoad,...
    frontalAreaCar,...
    maxVelocity,...
    gravity)
 
    % Calculate the normal downforce and drag acting on the vehicle
    [normalForceFrontWheelDownforce, normalForceRearWheelDownforce] = calcDownforce(...
    totalMass,...
    densityAir,...
    gravity,...
    COMFromGroundY,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire,...
    lengthCOMToFrontWing,...
    lengthCOMToRearWing,...
    frontalAreaFrontWing,...
    frontalAreaRearWing,...
    heightCOMToFrontWing,...
    heightCOMToRearWing,...
    frontalAreaCar,...
    coefficientWing,...
    coefficientDrag,...
    coefficientLift,...
    coefficientRoad,...
    maxVelocity);

    % Calculate the normal acceleration forces acting on the vehicle
    [normalForceFrontAcceleration, normalForceRearAcceleration] = calcAcceleration(...
    totalMass,...
    gravity,...
    COMFromGroundY,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire,...
    coefficientRoad);

    % Calculate the normal static forces acting on the vehicle
    [normalForceFrontStatic, normalForceRearStatic] = calcStatic(...
    totalMass,...
    gravity,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire);

    % Calculate the normal forces acting on each wheel & biases when the car is cornering towards the left
    [fxLeftWheelFront, fxLeftWheelRear, fyLeftWheelFront, fyLeftWheelRear, fzLeftWheelFront, fzLeftWheelRear, frontBias, rearBias] = calcCornering(...
    totalMass,...
    gravity,...
    densityAir,...
    COMFromGroundY,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire,...
    lengthToRightWheelCOM,...
    normalForceFrontStatic,...
    normalForceRearStatic,...
    frontalAreaCar,...
    coefficientLiftWing,...
    coefficientRoad);
    

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function: calcDownforce
%
%   Parameters: densityAir (kg/m^3), frontalAreaFrontWing (m^2), 
%   frontalAreaRearWing (m^2), frontalAreaCar (m^2),
%   coefficientWing, coefficientDrag,
%   coefficientLift, maxVelocity (m/s)
% 
%   Outputs: normalForceFrontWheelDownforce (N), normalForceRearWheelDownforce (N)
%
%   Description: calcDownforce calculates the downforce on the wings with drag 
%   to determine the normal force on each wheel 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [normalForceFrontWheelDownforce, normalForceRearWheelDownforce] = calcDownforce(...
    totalMass,...
    densityAir,...
    gravity,...
    COMFromGroundY,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire,...
    lengthCOMToFrontWing,...
    lengthCOMToRearWing,...
    frontalAreaFrontWing,...
    frontalAreaRearWing,...
    heightCOMToFrontWing,...
    heightCOMToRearWing,...
    frontalAreaCar,...
    coefficientWing,...
    coefficientDrag,...
    coefficientLift,...
    coefficientRoad,...
    maxVelocity)

    % Calculate the downforce of the front and rear wing
    % The derivation of this equation can be found in the modelling section of the analysis report
    downforceFrontWing = 0.5*densityAir*frontalAreaFrontWing*coefficientWing*(maxVelocity^2); % N
    downforceRearWing = 0.5*densityAir*frontalAreaRearWing*coefficientWing*(maxVelocity^2); % N
    
    % Calculate the average drag coefficient
    averageDragCoefficient = coefficientDrag/(frontalAreaRearWing+frontalAreaFrontWing); % Unitless
      
    % Calculate the drag force in the front and rear
    % The derivation of this equation can be found in the modelling section of the analysis report
    dragForceFront = 0.5*densityAir*averageDragCoefficient*frontalAreaFrontWing*(maxVelocity^2); % N
    dragForceRear = 0.5*densityAir*averageDragCoefficient*frontalAreaRearWing*(maxVelocity^2); % N
    
    % Calculate the lift force generated from the vehicle
    liftForce = 0.5*coefficientLift*frontalAreaCar*densityAir*(maxVelocity^2); % N
    
    % Calculate the maximum down force generated from the maximum velocity 
    maximumDownForce = (1/2)*(1.225)*2.34*(1.542)*(maxVelocity^2); % N
    
    % Calculate the normal force about the center of mass
    totalNormalForceCOM = totalMass*gravity+maximumDownForce-liftForce; % N
    
    % Calculate the maximum allowable total friction from the tires and
    % road
    maxAllowableFrictionTiresRoad = totalNormalForceCOM*coefficientRoad; % N
    
    % Calculate the maximum decelration in this situation
    maxDeceleration = maxAllowableFrictionTiresRoad/totalMass; % m/s^2

    % Normal force (downforce and drag) on both wheels during deceleration
    % The derivation of this equation can be found in the modelling section of the analysis report
    normalForceFrontWheelDownforce = (((totalMass*gravity-liftForce+downforceFrontWing+downforceRearWing)*lengthCOMToRearTire+((totalMass*maxDeceleration+dragForceFront+dragForceRear)*COMFromGroundY)+downforceRearWing*lengthCOMToFrontWing+dragForceFront*heightCOMToFrontWing+dragForceRear*heightCOMToRearWing-downforceFrontWing*lengthCOMToFrontWing))/((2*lengthCOMToFrontTire)+2*lengthCOMToRearTire); % N
    normalForceRearWheelDownforce = (((totalMass*gravity)-liftForce+downforceFrontWing+downforceRearWing)*lengthCOMToFrontTire+((((-totalMass*maxDeceleration)-dragForceFront-dragForceRear))*COMFromGroundY)-downforceRearWing*lengthCOMToRearWing-dragForceFront*heightCOMToFrontWing-dragForceRear*heightCOMToRearWing+downforceFrontWing*lengthCOMToFrontWing)/((2*lengthCOMToFrontTire)+(2*lengthCOMToRearTire)); % N 

    
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function: calcAcceleration
%
%   Parameters: totalMass (kg), gravity (m/s^2),
%   COMFromGroundY (m), lengthCOMToFrontTire (m),
%   lengthCOMToRearTire (m), coefficientRoad
%   
%   Outputs: normalForceFrontAcceleration (N),
%   normalForceRearAcceleration (N)
%
%   Description: calcAcceleration calculates the normal force on the front and rear of
%   the vehicle while accelerating
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [normalForceFrontAcceleration, normalForceRearAcceleration] = calcAcceleration(...
    totalMass,...
    gravity,...
    COMFromGroundY,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire,...
    coefficientRoad)

    % Calculate the maximum acceleration 
    % The derivation of this equation can be found in the modelling section of the analysis report
    maxAcceleration = ((-coefficientRoad*lengthCOMToFrontTire))/(COMFromGroundY*coefficientRoad-lengthCOMToFrontTire-lengthCOMToRearTire)*gravity; % m/s^2
    
    % Calculate the normal force on the front and rear wheels during acceleration
    % The derivation of this equation can be found in the modelling section of the analysis report
    normalForceFrontAcceleration = ((1/2)*totalMass*gravity*(((lengthCOMToRearTire)/(lengthCOMToRearTire+lengthCOMToFrontTire))-((COMFromGroundY/(lengthCOMToRearTire+lengthCOMToFrontTire))*(maxAcceleration/gravity))))*2; % N
    normalForceRearAcceleration = ((1/2)*totalMass*gravity*(((lengthCOMToFrontTire)/(lengthCOMToRearTire+lengthCOMToFrontTire))+((COMFromGroundY/(lengthCOMToRearTire+lengthCOMToFrontTire))*(maxAcceleration/gravity))))*2; % N

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function: calcStatic
%
%   Parameters: totalMass (kg), gravity (m/s^2),
%   lengthCOMToFrontTire (m), lengthCOMToRearTire (m)
%   
%   Outputs: normalForceFrontStatic (N), normalForceRearStatic (N)
%
%   Description: calcStatic calculates the static normal force on the front and rear of the vehicle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [normalForceFrontStatic, normalForceRearStatic] = calcStatic(...
    totalMass,...
    gravity,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire)
    
    % Calculate the normal force on the front and rear tires when the vehicle is static
    % The derivation of this equation can be found in the modelling section of the analysis report
    normalForceFrontStatic = (totalMass*gravity*((lengthCOMToRearTire/(lengthCOMToFrontTire+lengthCOMToRearTire)))); % N
    normalForceRearStatic = (totalMass*gravity*((lengthCOMToFrontTire/(lengthCOMToFrontTire+lengthCOMToRearTire)))); % N

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function: calcCornering
%
%   Parameters: totalMass (kg), gravity (m/s^2),
%   densityAir (kg/m^3), COMFromGroundY (m),
%   lengthCOMToFrontTire (m), lengthCOMToRearTire (m),
%   lengthToRightWheelCOM (m), frontalAreaCar (m^2),
%   coefficientLift, coefficientRoad
%   
%   Outputs: 
%
%   Description: calcCornering calculates the front/rear bias, and normal force on the
%   left wheel while cornering on each axis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fxLeftWheelFront, fxLeftWheelRear, fyLeftWheelFront, fyLeftWheelRear, fzLeftWheelFront, fzLeftWheelRear, frontBias, rearBias] = calcCornering(...
    totalMass,...
    gravity,...
    densityAir,...
    COMFromGroundY,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire,...
    lengthToRightWheelCOM,...
    normalForceFrontStatic,...
    normalForceRearStatic,...
    frontalAreaCar,...
    coefficientLiftWing,...
    coefficientRoad)

    % Calculate the normal force of both wheels while cornering
    normalForceRearWheelDownforceCornering = (totalMass*gravity)*((lengthCOMToFrontTire)/(lengthCOMToRearTire+lengthCOMToFrontTire)); % N
    
    % Calculate the front and rear bias during cornering
    frontBias = lengthCOMToRearTire/(lengthCOMToFrontTire+lengthCOMToRearTire); % decimal percentage
    rearBias = lengthCOMToFrontTire/(lengthCOMToFrontTire+lengthCOMToRearTire); % decimal percentage
    
    % Calculate the aero without velocity
    aeroWithoutVelocity = 0.5*densityAir*frontalAreaCar*coefficientLiftWing; % kg/m

    % Calculate the maximum velocity while cornering radius a radius of 50m
    maxVelocityCornering = sqrt((coefficientRoad*totalMass*gravity)/((totalMass/50)-((1/2)*densityAir*coefficientLiftWing*frontalAreaCar*coefficientRoad))); % m/s
    
    % Calculate the centripetal force on the vehicle at a cornering radius of 50m
    centripetalForce = (totalMass*(maxVelocityCornering^2))/50; % N
                                        
    % Calculate the normal force on each wheel during the largest corner on each axis
    % only the left wheel is analysed because it is undergoing the most stress
    % The derivation of this equation can be found in the modelling section of the analysis report
    fyLeftWheelFront = ((normalForceFrontStatic+(aeroWithoutVelocity*frontBias*(maxVelocityCornering^2)))*lengthToRightWheelCOM+(COMFromGroundY*centripetalForce)*(frontBias))/(2*lengthToRightWheelCOM); % N
    fyLeftWheelRear = ((normalForceRearStatic+(aeroWithoutVelocity*rearBias*(maxVelocityCornering^2)))*lengthToRightWheelCOM+(COMFromGroundY*centripetalForce)*(rearBias))/(2*lengthToRightWheelCOM); % N
    fyRightWheelFront = ((normalForceFrontStatic+(aeroWithoutVelocity*frontBias*(maxVelocityCornering^2)))*lengthToRightWheelCOM-(COMFromGroundY*centripetalForce)*(frontBias))/(2*lengthToRightWheelCOM); % N
    fyRightWheelRear = ((normalForceRearStatic+(aeroWithoutVelocity*rearBias*(maxVelocityCornering^2)))*lengthToRightWheelCOM-(COMFromGroundY*centripetalForce)*(rearBias))/(2*lengthToRightWheelCOM); % N
    
    % Calculate the total force on the y axis
    fyTotalLeftWheel = fyLeftWheelFront + fyLeftWheelRear; % N
    fyTotalRightWheel = fyRightWheelFront + fyRightWheelRear; % N
    
    % Calculate the bias of the forces on the left wheel
    fyLeftBias = 1 - fyTotalRightWheel / fyTotalLeftWheel; % decimal percentage

    % Calculate the total reaction forces on the y axis
    fyReactionForces = centripetalForce*fyLeftBias; % N
    
    % Calculate the x-axis forces on the front and rear
    fxLeftWheelFront = fyReactionForces*frontBias; % N
    fxLeftWheelRear = fyReactionForces*rearBias; % N
    
    % Calculate the z-axis forces on the left wheel
    fzLeftWheelFront = fyLeftWheelFront*coefficientRoad; % N
    fzLeftWheelRear = fyLeftWheelRear*coefficientRoad; % N
    
end


