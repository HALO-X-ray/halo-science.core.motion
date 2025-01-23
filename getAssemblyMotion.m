function assemblyMotionData = getAssemblyMotion(deDataArray)
    
    % Define empty output
    assemblyMotionData = struct('position_frames', [],...
                                'position_data', [],...
                                'outlierN', [],...
                                'outlierPct', []);

    % Handle empty data
    if isempty(deDataArray)
        return
    end

    % Get projected timestamp for each frame
    frame_timestamps = (1:size(deDataArray(:,1))) * 0.035;
    
    % Remove outliers from positional data
    [assemblyMotionData.position_data, positionMask] = rmoutliers(deDataArray(:,1));

    % Filter timestamps by outlier mask
    assemblyMotionData.position_frames = frame_timestamps(~positionMask);
    
    % Get misreporting statistics
    assemblyMotionData.outlierN = sum(positionMask);
    assemblyMotionData.outlierPct = 100*assemblyMotionData.outlierN./numel(positionMask);
    
end