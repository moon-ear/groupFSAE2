function [totalMass, COMFromGroundX, COMFromGroundY, COMFromGroundZ, RearTireToCOM, FrontTireToCOM] = calcCenterOfMass(driverWeight)

    xTimesMass = 839.1;
    yTimesMassWithoutDriver = 43716.7778;
    zTimesMassWithoutDriver = 300147.5028;
    
    yTimesMassDriver = -35 * driverWeight;
    zTimesMassDriver = 1312.54 * driverWeight;
    
    yTimesMass = yTimesMassWithoutDriver + yTimesMassDriver;
    zTimesMass = zTimesMassWithoutDriver + zTimesMassDriver;
    
    totalMass = 191.885 + driverWeight;
    
    COMx = totalMass * xTimesMass;
    COMy = totalMass * yTimesMass;
    COMz = totalMass * zTimesMass;
    
    COMFromGroundX = COMx;
    COMFromGroundY = COMy + 103 + 55;
    COMFromGroundZ = COMz;
    
    RearTireToCOM = COMFromGroundZ - 2261.56;
    FrontTireToCOM = COMFromGroundZ - 658.535;

end