% =========================================================================
%   Function: 
%
%   Parameters: 
%   
%   Outputs: 
%
%   Description: 
% =========================================================================
function [OutterradiustubeA, InnerradiustubeA, OutterWidthtubeB, InnerWidthtubeB] = calcChassisTubeThickness(driverWeight)

    
    %Width of sqaure tubes in mm
    OutterWidthtubeB = 25.4;
    InnerWidthtubeB = (25.4-3.2);

    %Radii of tubes in mm
    OutterradiustubeA = 12.5;
    InnerradiustubeA = (12.5 - 1.25);

    % Initial calculation of minimum safety factor
    [minimumSafetyFactorFront] = calcChassisFrontImpact(driverWeight, OutterradiustubeA, InnerradiustubeA, OutterWidthtubeB, InnerWidthtubeB);
    [minimumSafetyFactorRear] = calcChassisRearImpact(driverWeight, OutterradiustubeA, InnerradiustubeA, OutterWidthtubeB, InnerWidthtubeB);

    safetyFactor = min([minimumSafetyFactorFront, minimumSafetyFactorRear]);

    % re-calculate the safety factor to ensure it is above 2.5
    % by increasing wall thickness
    while safetyFactor < 2.5
        
        % Decrement width of inner tube B in mm
        InnerWidthtubeB = InnerWidthtubeB - 0.1;
        
        % Decrement radii of inner tube A in mm
        InnerradiustubeA = InnerradiustubeA - 0.1;
    
        % Initial calculation of minimum safety factor
        [minimumSafetyFactorFront] = calcChassisFrontImpact(driverWeight, OutterradiustubeA, InnerradiustubeA, OutterWidthtubeB, InnerWidthtubeB);
        [minimumSafetyFactorRear] = calcChassisRearImpact(driverWeight, OutterradiustubeA, InnerradiustubeA, OutterWidthtubeB, InnerWidthtubeB);
    
        safetyFactor = min([minimumSafetyFactorFront, minimumSafetyFactorRear]);
    end
    
    
end