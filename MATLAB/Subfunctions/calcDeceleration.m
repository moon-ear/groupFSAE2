function [] = calcDeceleration(...
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
    coefficientDrag,...
    coefficientRoad,...
    frontalAreaCar,...
    maxVelocity,...
    gravity)
 
    

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %               Forces Reactions due to acceleration (bottom left)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    maxAcceleration = ((-coefficientRoad*lengthCOMToFrontTire))/(COMFromGroundY*coefficientRoad-lengthCOMToFrontTire-lengthCOMToRearTire)*gravity;
    normalForceFrontAcceleration = ((1/2)*totalMass*gravity*(((lengthCOMToRearTire)/(lengthCOMToRearTire+lengthCOMToFrontTire))-((COMFromGroundY/(lengthCOMToRearTire+lengthCOMToFrontTire))*(maxAcceleration/gravity))))*2;
    normalForceRearAcceleration = ((1/2)*totalMass*gravity*(((lengthCOMToFrontTire)/(lengthCOMToRearTire+lengthCOMToFrontTire))+((COMFromGroundY/(lengthCOMToRearTire+lengthCOMToFrontTire))*(maxAcceleration/gravity))))*2;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %               Static Scenario (bottom left)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    normalForceFrontStatic = (totalMass*gravity*((lengthCOMToRearTire/(lengthCOMToFrontTire+lengthCOMToRearTire))))/2;
    normalForceRearStatic = (totalMass*gravity*((lengthCOMToFrontTire/(lengthCOMToFrontTire+lengthCOMToRearTire))))/2;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %               Speed and Cornering
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    normalForceFrontWheelCornering  = (totalMass*gravity)*((lengthCOMToRearTire)/(lengthCOMToRearTire+lengthCOMToFrontTire));
    normalForceRearWheelCorneringTotal = (totalMass*gravity)*((lengthCOMToFrontTire)/(lengthCOMToRearTire+lengthCOMToFrontTire));
    frontBias = lengthCOMToRearTire/(lengthCOMToFrontTire+lengthCOMToRearTire);
    rearBias = lengthCOMToFrontTire/(lengthCOMToFrontTire+lengthCOMToRearTire);
    aeroWithoutVelocity = 0.5*densityAir*frontalAreaCar*coefficientLift;

    numberTeethDriving = 14;
    differentialGearRatio = 1;

    % cornering radius is 50m
    corneringRadius = sqrt((coefficientRoad*totalMass*gravity)/((totalMass/50)-((1/2)*densityAir*coefficientLift*frontalAreaCar*coefficientRoad)));
    disp(corneringRadius);
    
    fc = (totalMass*(corneringRadius^2))/50;
    
    frontBias = lengthCOMToRearTire/(lengthCOMToFrontTire+lengthCOMToRearTire);
    rearBias = lengthCOMToFrontTire/(lengthCOMToFrontTire+lengthCOMToRearTire);
                                        
    frontNormalForceRightWheelCornering = ((numberTeethDriving+(coefficientRoad*differentialGearRatio*(corneringRadius^2)))*lengthToRightWheelCOM-(COMFromGroundY*fc)*(differentialGearRatio))/(2*lengthToRightWheelCOM);
    frontNormalForceLeftWheelCorneringFront = ((numberTeethDriving+(coefficientRoad*differentialGearRatio*(corneringRadius^2)))*lengthToRightWheelCOM+(COMFromGroundY*fc)*(differentialGearRatio))/(2*lengthToRightWheelCOM);
    rearNormalForceRightWheelCorneringRear = ((normalForceRearWheelCorneringTotal+(coefficientRoad*rearBias*(corneringRadius^2)))*lengthToRightWheelCOM-(COMFromGroundY*fc)*(rearBias))/(2*lengthToRightWheelCOM);
    rearNormalForceLeftWheelCorneringRear = ((normalForceRearWheelCorneringTotal+(coefficientRoad*rearBias*(corneringRadius^2)))*lengthToRightWheelCOM+(COMFromGroundY*fc)*(rearBias))/(2*lengthToRightWheelCOM);

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function: calcWingDownforce
%
%   Parameters: densityAir, frontalAreaFrontWing, 
%   frontalAreaRearWing, frontalAreaCar,
%   coefficientWing, coefficientDrag,
%   coefficientLift, maxVelocity
% 
%   Outputs: downforceFrontWing, downforceRearWing,
%   dragForceFront, dragForceRear
%
%   calcCenterOfMass calculates ________
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [downforceFrontWing, downforceRearWing, dragForceFront, dragForceRear] = calcWingDownforce(...
    densityAir,...
    frontalAreaFrontWing,...
    frontalAreaRearWing,...
    coefficientWing,...
    coefficientDrag,...
    maxVelocity)

    downforceFrontWing = 0.5*densityAir*frontalAreaFrontWing*coefficientWing*(maxVelocity^2);
    downforceRearWing = 0.5*densityAir*frontalAreaRearWing*coefficientWing*(maxVelocity^2);
    
    averageDragCoefficient = coefficientDrag/(frontalAreaRearWing+frontalAreaFrontWing);
      
    dragForceFront = 0.5*densityAir*averageDragCoefficient*frontalAreaFrontWing*(maxVelocity^2);
    dragForceRear = 0.5*densityAir*averageDragCoefficient*frontalAreaRearWing*(maxVelocity^2);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Function: calcDownforce
%
%   Parameters: driverMass (kg )
%   
%   Outputs: downforceFrontWing, downforceRearWing,
%   liftForce, dragForceFront,
%   dragForceRear
%
%   calcCenterOfMass calculates the main center of mass calculations 
%   with the inputted driver weight.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [normalForceFrontWheel, normalForceRearWheel] = calcDownforce(...
    densityAir,...
    gravity,...
    frontalAreaCar,...
    downforceFrontWing,...
    downforceRearWing,...
    dragForceFront,...
    dragForceRear,...
    COMFromGroundY,...
    lengthCOMToFrontTire,...
    lengthCOMToRearTire,...
    heightCOMToFrontWing,...
    heightCOMToRearWing,...
    coefficientLift,...
    coefficientRoad,...
    maxVelocity)

    liftForce = 0.5*coefficientLift*frontalAreaCar*densityAir*(maxVelocity^2);

    maximumDownForce = (1/2)*(1.225)*2.34*(1.542)*(maxVelocity^2);
    totalNormalForceCOM = totalMass*gravity+maximumDownForce-liftForce;
    maxAllowableFrictionTiresRoad = totalNormalForceCOM*coefficientRoad;
    maxDeceleration = maxAllowableFrictionTiresRoad/totalMass;

    normalForceFrontWheel = (((totalMass*gravity-liftForce+downforceFrontWing+downforceRearWing)*lengthCOMToRearTire+((totalMass*maxDeceleration+dragForceFront+dragForceRear)*COMFromGroundY)+downforceRearWing*lengthCOMToFrontWing+dragForceFront*heightCOMToFrontWing+dragForceRear*heightCOMToRearWing-downforceFrontWing*lengthCOMToFrontWing))/((2*lengthCOMToFrontTire)+2*lengthCOMToRearTire);
    normalForceRearWheel = (((totalMass*gravity)-liftForce+downforceFrontWing+downforceRearWing)*lengthCOMToFrontTire+((((-totalMass*maxDeceleration)-dragForceFront-dragForceRear))*COMFromGroundY)-downforceRearWing*lengthCOMToRearWing-dragForceFront*heightCOMToFrontWing-dragForceRear*heightCOMToRearWing+downforceFrontWing*lengthCOMToFrontWing)/((2*lengthCOMToFrontTire)+(2*lengthCOMToRearTire));  

    
end