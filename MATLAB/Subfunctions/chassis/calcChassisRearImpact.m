% =========================================================================
%   Function: 
%
%   Parameters: 
%   
%   Outputs: 
%
%   Description: 
% =========================================================================
function [minimumSafetyFactor] = calcChassisRearImpact(driverWeight, OutterradiustubeA, InnerradiustubeA, OutterWidthtubeB, InnerWidthtubeB)

    format long;

    %Problem Characteristics
    nnode = 18;                 %Number of Nodes
    ndof_per_node = 3;          %Number of degrees of freedom per node
    nnode_per_element = 2;      %Number of nodes per elements
    nelem = 32;                 %Number of elements
    nmat = 1;                   %Number of material types

    %Elastic Modulus and Yield Stress of 4130 AISI Steel Tubes
    Elastic_modulus = zeros(nmat,1);
    Elastic_modulus(1,1) =  205000; %MPa


    %Shear Modulus
    Shear_modulus = zeros(nmat,1);
    Shear_modulus(1,1) = 80000; %MPa


    %Nodal coordinates in milimeters
    Nodal_coordinates = zeros (nnode,2);

    %First line is the nodal coordinate is the x coordinate
    %Second line is the nodal coordinate is the y coordinate

    Nodal_coordinates(1,1) = 0;
    Nodal_coordinates(1,2) = 0;

    Nodal_coordinates(2,1) = 0;
    Nodal_coordinates(2,2) = 340;

    Nodal_coordinates(3,1) = 439;
    Nodal_coordinates(3,2) = 0;

    Nodal_coordinates(4,1) = 451.66;
    Nodal_coordinates(4,2) = 230;

    Nodal_coordinates(5,1) = 463.78;
    Nodal_coordinates(5,2) = 460.18;

    Nodal_coordinates(6,1) = 878;
    Nodal_coordinates(6,2) = 597.38;

    Nodal_coordinates(7,1) = 878;
    Nodal_coordinates(7,2) = 575.83;

    Nodal_coordinates(8,1) = 878;
    Nodal_coordinates(8,2) = 277;

    Nodal_coordinates(9,1) = 878;
    Nodal_coordinates(9,2) = 0;

    Nodal_coordinates(10,1) = 1357;
    Nodal_coordinates(10,2) = -51.5;

    Nodal_coordinates(11,1) = 1836;
    Nodal_coordinates(11,2) = -103;

    Nodal_coordinates(12,1) = 1836;
    Nodal_coordinates(12,2) = 275;

    Nodal_coordinates(13,1) = 1836;
    Nodal_coordinates(13,2) = 327.09;

    Nodal_coordinates(14,1) = 1836;
    Nodal_coordinates(14,2) = 1076;

    Nodal_coordinates(15,1) = 2250.37;
    Nodal_coordinates(15,2) = 276.37;

    Nodal_coordinates(16,1) = 2249;
    Nodal_coordinates(16,2) = -29;

    Nodal_coordinates(17,1) = 2520;
    Nodal_coordinates(17,2) = -29;

    Nodal_coordinates(18,1) = 2520;
    Nodal_coordinates(18,2) = 275;

    %Connectivity table indicated the nodes that belong to each element
    Connect_table = zeros(nelem,nnode_per_element + 1);

    %First line is node i that belongs to the element
    %Second line is node j that belongs to the element
    %Third line is the material flag
        
    Connect_table(1,1) = 1;
    Connect_table(1,2) = 2;
    Connect_table(1,3) = 1;

    Connect_table(2,1) = 2;
    Connect_table(2,2) = 5;
    Connect_table(2,3) = 1;

    Connect_table(3,1) = 2;
    Connect_table(3,2) = 4;
    Connect_table(3,3) = 1;

    Connect_table(4,1) = 1;
    Connect_table(4,2) = 4;
    Connect_table(4,3) = 1;

    Connect_table(5,1) = 1;
    Connect_table(5,2) = 3;
    Connect_table(5,3) = 1;

    Connect_table(6,1) = 5;
    Connect_table(6,2) = 4;
    Connect_table(6,3) = 1;

    Connect_table(7,1) = 4;
    Connect_table(7,2) = 3;
    Connect_table(7,3) = 1;

    Connect_table(8,1) = 5;
    Connect_table(8,2) = 7;
    Connect_table(8,3) = 1;

    Connect_table(9,1) = 4;
    Connect_table(9,2) = 7;
    Connect_table(9,3) = 1;

    Connect_table(10,1) = 4;
    Connect_table(10,2) = 8;
    Connect_table(10,3) = 1;

    Connect_table(11,1) = 4;
    Connect_table(11,2) = 9;
    Connect_table(11,3) = 1;

    Connect_table(12,1) = 3;
    Connect_table(12,2) = 9;
    Connect_table(12,3) = 1;

    Connect_table(13,1) = 7;
    Connect_table(13,2) = 6;
    Connect_table(13,3) = 1;

    Connect_table(14,1) = 7;
    Connect_table(14,2) = 8;
    Connect_table(14,3) = 1;

    Connect_table(15,1) = 8;
    Connect_table(15,2) = 9;
    Connect_table(15,3) = 1;

    Connect_table(16,1) = 7;
    Connect_table(16,2) = 12;
    Connect_table(16,3) = 1;

    Connect_table(17,1) = 8;
    Connect_table(17,2) = 12;
    Connect_table(17,3) = 1;

    Connect_table(18,1) = 9;
    Connect_table(18,2) = 12;
    Connect_table(18,3) = 1;

    Connect_table(19,1) = 9;
    Connect_table(19,2) = 10;
    Connect_table(19,3) = 1;

    Connect_table(20,1) = 10;
    Connect_table(20,2) = 11;
    Connect_table(20,3) = 1;

    Connect_table(21,1) = 11;
    Connect_table(21,2) = 12;
    Connect_table(21,3) = 1;

    Connect_table(22,1) = 12;
    Connect_table(22,2) = 13;
    Connect_table(22,3) = 1;

    Connect_table(23,1) = 13;
    Connect_table(23,2) = 14;
    Connect_table(23,3) = 1;

    Connect_table(24,1) = 14;
    Connect_table(24,2) = 15;
    Connect_table(24,3) = 1;

    Connect_table(25,1) = 12;
    Connect_table(25,2) = 15;
    Connect_table(25,3) = 1;

    Connect_table(26,1) = 11;
    Connect_table(26,2) = 15;
    Connect_table(26,3) = 1;

    Connect_table(27,1) = 11;
    Connect_table(27,2) = 16;
    Connect_table(27,3) = 1;

    Connect_table(28,1) = 15;
    Connect_table(28,2) = 16;
    Connect_table(28,3) = 1;

    Connect_table(29,1) = 16;
    Connect_table(29,2) = 17;
    Connect_table(29,3) = 1;

    Connect_table(30,1) = 15;
    Connect_table(30,2) = 17;
    Connect_table(30,3) = 1;

    Connect_table(31,1) = 15;
    Connect_table(31,2) = 18;
    Connect_table(31,3) = 1;

    Connect_table(32,1) = 17;
    Connect_table(32,2) = 18;
    Connect_table(32,3) = 1;


    % Radius of tube B will be kept as a constant
    OutterradiustubeB = 12.7;
    InnerradiustubeB = (12.7 - 1.6);

    %Moment of inertia of tubes (I)
    InertiaPipeA = (pi/4)*((OutterradiustubeA^4)-(InnerradiustubeA^4));
    InertiaPipeB = (pi/4)*((OutterradiustubeB^4)-(InnerradiustubeB^4));
    InertiaSquareB = ((OutterWidthtubeB^4)/12)-((InnerWidthtubeB^4)/12);

    %Polar moment of inertia of tubes (J)
    PolarpipeA = (pi/2)*((OutterradiustubeA^4)-(InnerradiustubeA^4));
    PolarpipeB = (pi/2)*((OutterradiustubeB^4)-(InnerradiustubeB^4));
    PolarsquareB = ((OutterWidthtubeB^4)/6)-((InnerWidthtubeB^4)/6);

    %Assigning an outer radius to each element
    Tube_outer_radius = zeros(nelem,nmat);
    Tube_outer_radius(1,1) = OutterradiustubeB;
    Tube_outer_radius(2,1) = OutterradiustubeB;
    Tube_outer_radius(3,1) = OutterradiustubeB;
    Tube_outer_radius(4,1) = OutterradiustubeB;
    Tube_outer_radius(5,1) = OutterWidthtubeB;
    Tube_outer_radius(6,1) = OutterradiustubeB;
    Tube_outer_radius(7,1) = OutterradiustubeB;
    Tube_outer_radius(8,1) = OutterradiustubeB;
    Tube_outer_radius(9,1) = OutterradiustubeB;
    Tube_outer_radius(10,1) = OutterradiustubeB;
    Tube_outer_radius(11,1) = OutterradiustubeB;
    Tube_outer_radius(12,1) = OutterWidthtubeB;
    Tube_outer_radius(13,1) = OutterradiustubeA;
    Tube_outer_radius(14,1) = OutterradiustubeA;
    Tube_outer_radius(15,1) = OutterradiustubeA;
    Tube_outer_radius(16,1) = OutterradiustubeB;
    Tube_outer_radius(17,1) = OutterradiustubeB;
    Tube_outer_radius(18,1) = OutterradiustubeB;
    Tube_outer_radius(19,1) = OutterWidthtubeB;
    Tube_outer_radius(20,1) = OutterWidthtubeB;
    Tube_outer_radius(21,1) = OutterradiustubeA;
    Tube_outer_radius(22,1) = OutterradiustubeA;
    Tube_outer_radius(23,1) = OutterradiustubeA;
    Tube_outer_radius(24,1) = OutterradiustubeB;
    Tube_outer_radius(25,1) = OutterradiustubeB;
    Tube_outer_radius(26,1) = OutterradiustubeB;
    Tube_outer_radius(27,1) = OutterWidthtubeB;
    Tube_outer_radius(28,1) = OutterradiustubeB;
    Tube_outer_radius(29,1) = OutterWidthtubeB;
    Tube_outer_radius(30,1) = OutterradiustubeB;
    Tube_outer_radius(31,1) = OutterradiustubeB;
    Tube_outer_radius(32,1) = OutterradiustubeB;

    %Assigning an inner radius to each element
    Tube_inner_radius = zeros(nelem,nmat);
    Tube_inner_radius(1,1) = InnerradiustubeB;
    Tube_inner_radius(2,1) = InnerradiustubeB;
    Tube_inner_radius(3,1) = InnerradiustubeB;
    Tube_inner_radius(4,1) = InnerradiustubeB;
    Tube_inner_radius(5,1) = InnerWidthtubeB;
    Tube_inner_radius(6,1) = InnerradiustubeB;
    Tube_inner_radius(7,1) = InnerradiustubeB;
    Tube_inner_radius(8,1) = InnerradiustubeB;
    Tube_inner_radius(9,1) = InnerradiustubeB;
    Tube_inner_radius(10,1) = InnerradiustubeB;
    Tube_inner_radius(11,1) = InnerradiustubeB;
    Tube_inner_radius(12,1) = InnerWidthtubeB;
    Tube_inner_radius(13,1) = InnerradiustubeA;
    Tube_inner_radius(14,1) = InnerradiustubeA;
    Tube_inner_radius(15,1) = InnerradiustubeA;
    Tube_inner_radius(16,1) = InnerradiustubeB;
    Tube_inner_radius(17,1) = InnerradiustubeB;
    Tube_inner_radius(18,1) = InnerradiustubeB;
    Tube_inner_radius(19,1) = InnerWidthtubeB;
    Tube_inner_radius(20,1) = InnerWidthtubeB;
    Tube_inner_radius(21,1) = InnerradiustubeA;
    Tube_inner_radius(22,1) = InnerradiustubeA;
    Tube_inner_radius(23,1) = InnerradiustubeA;
    Tube_inner_radius(24,1) = InnerradiustubeB;
    Tube_inner_radius(25,1) = InnerradiustubeB;
    Tube_inner_radius(26,1) = InnerradiustubeB;
    Tube_inner_radius(27,1) = InnerWidthtubeB;
    Tube_inner_radius(28,1) = InnerradiustubeB;
    Tube_inner_radius(29,1) = InnerWidthtubeB;
    Tube_inner_radius(30,1) = InnerradiustubeB;
    Tube_inner_radius(31,1) = InnerradiustubeB;
    Tube_inner_radius(32,1) = InnerradiustubeB;

    %Assigning a moment of inertia to every element
    Tube_inertia = zeros(nelem,nmat);
    Tube_inertia(1,1) = InertiaPipeB;
    Tube_inertia(2,1) = InertiaPipeB;
    Tube_inertia(3,1) = InertiaPipeB;
    Tube_inertia(4,1) = InertiaPipeB;
    Tube_inertia(5,1) = InertiaSquareB;
    Tube_inertia(6,1) = InertiaPipeB;
    Tube_inertia(7,1) = InertiaPipeB;
    Tube_inertia(8,1) = InertiaPipeB;
    Tube_inertia(9,1) = InertiaPipeB;
    Tube_inertia(10,1) = InertiaPipeB;
    Tube_inertia(11,1) = InertiaPipeB;
    Tube_inertia(12,1) = InertiaSquareB;
    Tube_inertia(13,1) = InertiaPipeA;
    Tube_inertia(14,1) = InertiaPipeA;
    Tube_inertia(15,1) = InertiaPipeA;
    Tube_inertia(16,1) = InertiaPipeB;
    Tube_inertia(17,1) = InertiaPipeB;
    Tube_inertia(18,1) = InertiaPipeB;
    Tube_inertia(19,1) = InertiaSquareB;
    Tube_inertia(20,1) = InertiaSquareB;
    Tube_inertia(21,1) = InertiaPipeA;
    Tube_inertia(22,1) = InertiaPipeA;
    Tube_inertia(23,1) = InertiaPipeA;
    Tube_inertia(24,1) = InertiaPipeB;
    Tube_inertia(25,1) = InertiaPipeB;
    Tube_inertia(26,1) = InertiaPipeB;
    Tube_inertia(27,1) = InertiaSquareB;
    Tube_inertia(28,1) = InertiaPipeB;
    Tube_inertia(29,1) = InertiaSquareB;
    Tube_inertia(30,1) = InertiaPipeB;
    Tube_inertia(31,1) = InertiaPipeB;
    Tube_inertia(32,1) = InertiaPipeB;

    %Assigning a polar moment of inertia to every element
    Tube_polar = zeros(nelem,nmat);
    Tube_polar(1,1) = PolarpipeB;
    Tube_polar(2,1) = PolarpipeB;
    Tube_polar(3,1) = PolarpipeB;
    Tube_polar(4,1) = PolarpipeB;
    Tube_polar(5,1) = PolarsquareB;
    Tube_polar(6,1) = PolarpipeB;
    Tube_polar(7,1) = PolarpipeB;
    Tube_polar(8,1) = PolarpipeB;
    Tube_polar(9,1) = PolarpipeB;
    Tube_polar(10,1) = PolarpipeB;
    Tube_polar(11,1) = PolarpipeB;
    Tube_polar(12,1) = PolarsquareB;
    Tube_polar(13,1) = PolarpipeA;
    Tube_polar(14,1) = PolarpipeA;
    Tube_polar(15,1) = PolarpipeA;
    Tube_polar(16,1) = PolarpipeB;
    Tube_polar(17,1) = PolarpipeB;
    Tube_polar(18,1) = PolarpipeB;
    Tube_polar(19,1) = PolarsquareB;
    Tube_polar(20,1) = PolarsquareB;
    Tube_polar(21,1) = PolarpipeA;
    Tube_polar(22,1) = PolarpipeA;
    Tube_polar(23,1) = PolarpipeA;
    Tube_polar(24,1) = PolarpipeB;
    Tube_polar(25,1) = PolarpipeB;
    Tube_polar(26,1) = PolarpipeB;
    Tube_polar(27,1) = PolarsquareB;
    Tube_polar(28,1) = PolarpipeB;
    Tube_polar(29,1) = PolarsquareB;
    Tube_polar(30,1) = PolarpipeB;
    Tube_polar(31,1) = PolarpipeB;
    Tube_polar(32,1) = PolarpipeB;

    %Local stiffness matrices
    Keloc = Local_stiffness(Nodal_coordinates,Connect_table,Tube_outer_radius,Tube_inner_radius,Tube_inertia,Tube_polar,Elastic_modulus,Shear_modulus);

    %Rotation matrices to switch between local and global coordinates
    R = Rotation(Nodal_coordinates,Connect_table);

    %Global stiffness matrices
    Ke = Global_stiffness(Keloc,R);

    %Assemblage matrix
    Ka = Assemblage_matrix(nnode,ndof_per_node,Connect_table,Ke);

    %External force vector
    Fa = zeros(nnode*ndof_per_node,1);
    Frontimpact = 18245.833; %Newtons
    Fa(49,1) = (Frontimpact/4);
    Fa(52,1) = (Frontimpact/4);

    %Gravitational Force from Driver
    Fa(29,1) = driverWeight*9.8;
    Fa(32,1) = driverWeight*9.8;

    %Boundary conditions appropiate for a front impact test
    BC = zeros(nnode,ndof_per_node);

    %fix the rear bulkhead, 1 means fixed
    BC(1,1:3) = 1;
    BC(2,1:3) = 1;

    % Modifying Ka into KaSol and Fa into FaSol to get solution 
    beta = max(max(Ka))*10e9;
    KaSol = Ka;
    FaSol = Fa;
    for i = 1:nnode
        for j = 1:ndof_per_node
        if BC(i,j) == 1
            KaSol((i-1)*ndof_per_node + j,(i-1)*ndof_per_node + j) = Ka((i-1)*ndof_per_node + j,(i-1)*ndof_per_node + j) + beta;
            FaSol((i-1)*ndof_per_node + j,1) = beta*0;
        end
        end
    end


    %Global displacement calculation

    U = KaSol\FaSol;

    %Processing of result
    Reaction_forces = [];
    Ulocal = zeros(2*ndof_per_node,nelem);
    Uglobal = zeros(2*ndof_per_node,nelem);
    Flocal = zeros(2*ndof_per_node,nelem);
    axial_stress = zeros(nelem,1);

    Ua = U;
    Fa = Ka*Ua;
    x = 1;
    for i = 1:nnode
        for j = 1:ndof_per_node
            if BC(i,j)==1
                Reaction_forces(x,1) = Fa((i-1)*ndof_per_node + j,1);
                x = x+1;
            end
        end
    end

    %Parameters to be used when calcu lating the stiffness matrices
    A = Cross_sectional_of_element(Tube_outer_radius,Tube_inner_radius);
    L = Length_of_elements(Nodal_coordinates,Connect_table);
    E = Elastic_modulus_of_elements(Elastic_modulus,Connect_table);
    G = Shear_modulus_of_elements(Shear_modulus,Connect_table);
    I = Moment_Inertia_of_elements(Tube_inertia);
    J = Polar_moment_of_inertia(Tube_polar);
    Kglobal = Global_stiffness(Keloc,R);
    %Rotating local displacement and external force vectors to global coordinates
    for i = 1:nelem     
        Rot = R(:,:,i);
        for j = 1:ndof_per_node
        Uglobal(j,i) = Ua((Connect_table(i,1) - 1)*ndof_per_node + j,1);
        Uglobal(ndof_per_node + j,i) = Ua((Connect_table(i,2) - 1)*ndof_per_node + j,1);  
        end
        Ulocal(:,i) = Rot*Uglobal(:,i);
        Flocal(:,i) = Keloc(:,:,i)*Ulocal(:,i);
        %calculating stresses in each element
        axial_stress(i,1) = max(Flocal(2,i))/A(i,1); %axial stress
        shear_stress_yaxis(i,1) = (max(Flocal(1,i)))/A(i,1); %y axis shear stress
        torsional_stress(i,1) = (max(Flocal(3,i))*Tube_outer_radius(i,1))/Tube_polar(i,1); %Torsional stress
        bending_stress_yaxis(i,1) = (max(Flocal(3,i))*Tube_outer_radius(i,1))/Tube_inertia(i,1); %Bending stress y axis
    end

    %Oraganizing required stresses in a vector
    stresses = zeros(1,4);

    stresses(1,1) = max(axial_stress); %Tensile stress
    stresses(1,2) = max(abs(shear_stress_yaxis(i,1))); %x Shear stress
    stresses(1,3) = max(abs(torsional_stress(i,1))); %Torsional stress
    stresses(1,4) = max(abs(bending_stress_yaxis(i,1))); %z Bending stress

    %Calculating safety factors and organizing in a vector
    SF = zeros(1,4);

    SF(1,1) = abs(435/(stresses(1,1))); %Axial stress safety factor
    SF(1,2) = 435/stresses(1,2); %Y Shear Stress safety factor
    SF(1,3) = 435/stresses(1,3); %Torsional Stress safety factor
    SF(1,4) = 435/stresses(1,4); %Y Bending Stress safety factor

    % Find the minimum safety factor
    minimumSafetyFactor = min(SF);

    %Calculating the parameter that are used to calculate the stiffness matrix
    %Area of element calculation
    function A = Cross_sectional_of_element(Tube_outer_radius,Tube_inner_radius)
        [nelem,~] = size(Tube_inner_radius);
        A = zeros(nelem,1);
        squares = [5 12 19 20 27 29];
        for i = 1:nelem
            if ismember(i,squares)
                A(i,1) = (Tube_outer_radius(i,1)^2)-(Tube_inner_radius(i,1)^2);
            else
                A(i,1) = pi*((Tube_outer_radius(i,1)^2)-(Tube_inner_radius(i,1)^2));
            end
        end
    end

    % Calculate the length of elements
    function L = Length_of_elements(Nodal_coordinates,Connect_table)
        [nelem,~] = size(Connect_table);
        L = zeros(nelem,1);
        for i = 1:nelem
            L(i,1) = sqrt((Nodal_coordinates(Connect_table(i,1),1) - Nodal_coordinates(Connect_table(i,2),1))^2 + (Nodal_coordinates(Connect_table(i,1),2) - Nodal_coordinates(Connect_table(i,2),2))^2);
        end
    end

    %Elastic modulus of elements
    function E = Elastic_modulus_of_elements(Elastic_modulus,Connect_table)
        [nelem,~] = size(Connect_table);
        E = zeros(nelem,1);
    for i = 1:nelem
        E(i,1) = Elastic_modulus(1,1);
    end
    end

    %Shear modulus of elements
    function G = Shear_modulus_of_elements(Shear_modulus,Connect_table)
        [nelem,~] = size(Connect_table);
        G = zeros(nelem,1);
        for i = 1:nelem
        G(i,1) = Shear_modulus(1,1);
    end 
    end

    %Moment of inertia of elements
    function I = Moment_Inertia_of_elements(Tube_inertia)
        [nelem,~] = size(Tube_inertia);
        I = zeros(nelem,1);
        for i = 1:nelem
                I(i,1) = Tube_inertia(i,1);
        end
    end


    %Polar moment of Inertia of elements
    function J = Polar_moment_of_inertia(Tube_polar)
        [nelem,~] = size(Tube_polar);
        J = zeros(nelem,1);
        for i = 1:nelem
                J(i,1) = Tube_polar(i,1);
        end
    end

    %3D Local stiffness matrix calculation
    function Keloc = Local_stiffness(Nodal_coordinates,Connect_table,Tube_outer_radius,Tube_inner_radius,Tube_inertia,Tube_polar,Elastic_modulus,Shear_modulus)
        [nelem,~] = size(Connect_table);
        Keloc = zeros(6,6,nelem); %each element is characterized by a 12x12 matrix
    
        A = Cross_sectional_of_element(Tube_outer_radius,Tube_inner_radius);
        L = Length_of_elements(Nodal_coordinates,Connect_table);
        E = Elastic_modulus_of_elements(Elastic_modulus,Connect_table);
        G = Shear_modulus_of_elements(Shear_modulus,Connect_table);
        I = Moment_Inertia_of_elements(Tube_inertia);
        J = Polar_moment_of_inertia(Tube_polar);
        
        for i = 1:nelem
        
            %first row
        Keloc(1,1,i) = (A(i,1)*E(i,1))/L(i,1);
        Keloc(1,4,i) = -(A(i,1)*E(i,1))/L(i,1);  
    
        %second row
        Keloc(2,2,i) = (12*E(i,1)*I(i,1))/L(i,1)^3;
        Keloc(2,3,i) = (6*E(i,1)*I(i,1))/L(i,1)^2;
        Keloc(2,5,i) = -Keloc(2,2,i);
        Keloc(2,6,i) = Keloc(2,3,i);
        
        %third row
        Keloc(3,2,i) = (6*E(i,1)*I(i,1))/L(i,1)^2;
        Keloc(3,3,i) = (4*E(i,1)*I(i,1))/L(i,1);
        Keloc(3,5,i) = -Keloc(3,2,i);
        Keloc(3,6,i) = Keloc(3,3,i)/2;
        
        %fourth row
        Keloc(4,1,i) = -(A(i,1)*E(i,1))/L(i,1);
        Keloc(4,4,i) = (A(i,1)*E(i,1))/L(i,1);
        
        %fifth row
        Keloc(5,2,i) = -(12*E(i,1)*I(i,1))/L(i,1)^3;
        Keloc(5,3,i) = -(6*E(i,1)*I(i,1))/L(i,1)^2;
        Keloc(5,5,i) = -Keloc(6,2,i);
        Keloc(5,6,i) = Keloc(6,3,i);
        
        %sixth row
        Keloc(6,2,i) = (6*E(i,1)*I(i,1))/L(i,1)^2;
        Keloc(6,3,i) = (2*E(i,1)*I(i,1))/L(i,1);
        Keloc(6,5,i) = -Keloc(3,2,i);
        Keloc(6,6,i) = Keloc(3,3,i)*2;
        end
    end

    % Calculating the rotation matrix to convert the stiffness matrix
    % from local coordinates to global coordinates (and vice versa)
    function R = Rotation(Nodal_coordinates,Connect_table)
    [nelem,~] = size(Connect_table);
    R = zeros(6,6,nelem);
    L = Length_of_elements(Nodal_coordinates,Connect_table);
    for i = 1:nelem
        %l
        R(1,1,i) = (Nodal_coordinates(Connect_table(i,2),1) - Nodal_coordinates(Connect_table(i,1),1)/L(i,1));
        %m
        R(1,2,i) = (Nodal_coordinates(Connect_table(i,2),2) - Nodal_coordinates(Connect_table(i,1),2)/L(i,1));
        R(2,1,i) = -R(1,2,i);
        R(2,2,i) = R(1,1,i);
        R(3,3,i) = 1;   
        R(4,4,i) = R(1,1,i);
        R(4,5,i) = R(1,2,i);
        R(5,4,i) = -R(1,2,i);
        R(5,5,i) = R(1,1,i);
        R(6,6,i) = 1;
        R(:,:,i) = R(:,:,i)/L(i,1);     
    end
    end
        

    %Global stiffness matrix calculation
    function Kglobal = Global_stiffness(Keloc,R)
        [sizeKglobal,~,nelem]=size(Keloc);
        Kglobal = zeros(sizeKglobal,sizeKglobal,nelem);
        for i = 1:nelem
            Rotate = R(:,:,i);
            Kglobal(:,:,i) = Rotate'*Keloc(:,:,i)*Rotate;
        end
    end

    % Calculating the assemblage stiffness matrix of the chassis
    function Ka =  Assemblage_matrix(nnode,ndof_per_node,Connect_table,Kglobal)
        Ka = zeros(nnode*ndof_per_node,nnode*ndof_per_node);
        [~,~,nelem]=size(Kglobal);
        for ii = 1:nnode
            for jj = 1:nnode
                for k = 1:nelem
                    if ii == Connect_table(k,1) && jj == Connect_table(k,1)
                        for i = 1:ndof_per_node
                            for j = 1:ndof_per_node
                                Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Kglobal(i,j,k);
                            end
                        end
                    elseif ii == Connect_table(k,2) && jj == Connect_table(k,2)
                        for i = 1:ndof_per_node
                            for j = 1:ndof_per_node
                                Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Kglobal(i + ndof_per_node,j + ndof_per_node,k);
                            end
                        end
                    elseif ii == Connect_table(k,1) && jj == Connect_table(k,2)
                        for i = 1:ndof_per_node
                            for j = 1:ndof_per_node
                                Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Kglobal(i,j + ndof_per_node,k);
                            end
                        end
                    elseif ii == Connect_table(k,2) && jj == Connect_table(k,1)
                        for i = 1:ndof_per_node
                            for j = 1:ndof_per_node
                                Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) = Ka((ii - 1)*ndof_per_node + i,(jj - 1)*ndof_per_node + j) + Kglobal(i + ndof_per_node,j,k);
                            end
                        end
                    end
                end
            end            
        end
    end

end