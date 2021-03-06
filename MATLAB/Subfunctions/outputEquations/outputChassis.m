% =========================================================================
%   Function: 
%
%   Parameters: 
%   
%   Outputs: 
%
%   Description:
% =========================================================================
function outputChassis(InnerradiustubeA, InnerWidthtubeB)

    chassis_file = 'H:\\groupFSAE2\\SolidWorks\\Equations\\Chassis_Inner_Diameters.txt';
    
    %Write the equations file
    fid = fopen(chassis_file,'w+t');
    fprintf(fid,strcat('"Front_Hoop_ID"= '," ",num2str(InnerradiustubeA*2),'mm\n\n'));
    fprintf(fid,strcat('"D2@Sketch15"="Front_Hoop_ID"\n\n'));
    fprintf(fid,strcat('"Front_Bulkhead_IW"= '," ",num2str(InnerWidthtubeB),'mm\n\n'));
    fprintf(fid,strcat('"D4@Sketch18"="Front_Bulkhead_IW"\n\n'));
    fprintf(fid,strcat('"Front_Bulkhead_SupportLower_IW"= '," ",num2str(InnerWidthtubeB),'mm\n\n'));
    
    fprintf(fid,strcat('"D3@Sketch2"="Front_Bulkhead_SupportLower_IW"\n\n'));
    fprintf(fid,strcat('"Front_Bulkhead_Bracing_ID"= 23mm\n\n'));
    fprintf(fid,strcat('"D2@Sketch1"="Front_Bulkhead_Bracing_ID"\n\n'));
    fprintf(fid,strcat('"D2@Sketch110"="Front_Bulkhead_Bracing_ID"\n\n'));
    fprintf(fid,strcat('"Front_Bulkhead_Support_ID"= 23mm\n\n'));
    
    fprintf(fid,strcat('"Side_Impact_Structure_ID"= '," ",num2str(InnerWidthtubeB),'mm\n\n'));
    
    fprintf(fid,strcat('"D4@Sketch116" = "Side_Impact_Structure_ID"\n\n'));
    fprintf(fid,strcat('"D2@Sketch119" = "Side_Impact_Structure_ID"\n\n'));
    fprintf(fid,strcat('"Main_Hoop_Bracing_ID"= 23mm\n\n'));
    fprintf(fid,strcat('"D2@Sketch120"="Main_Hoop_Bracing_ID"\n\n'));
    fprintf(fid,strcat('"D2@Sketch121"="Main_Hoop_Bracing_ID"\n\n'));
    
    fprintf(fid,strcat('"Rear_Bulkhead_ID"= '," ",num2str(InnerWidthtubeB),'mm\n\n'));
    
    fprintf(fid,strcat('"D4@Sketch122"="Rear_Bulkhead_ID"\n\n'));
    fprintf(fid,strcat('"D2@Sketch123"="Rear_Bulkhead_ID"\n\n'));
    
    fprintf(fid,strcat('"Main_Hoop_ID"= '," ",num2str(InnerradiustubeA*2),'mm\n\n'));
    
    fprintf(fid,strcat('"D2@Sketch125"="Main_Hoop_ID"'));

    fclose(fid);

end