function deDataArrayCorrected = hxt264CorrectDEDataPosition(deDataArray, correctionDelayMilliseconds, ab)

    dt = 3.5e-3; % Frame Time
    filterFrequency = 10; %Hz

    deDataArray(1,:) = [];
    if ab==0
        deDataArray(deDataArray(:,2)<=0,:) = [];
    end

    if correctionDelayMilliseconds<0
        correctionDelayMilliseconds = 10;
    end

    % Get XZ coords
    probePosition = deDataArray(:,1:2);
    
    % Get + filter probe speed
    probeVelocity = ([0 0; diff(probePosition,[],1)]*1e-3)/dt;
    probeVelocityFiltered = lpff(probeVelocity',filterFrequency,dt)';

    % Correct position based on speed filter
    probePositionCorrected = probePosition - (probeVelocityFiltered)*(correctionDelayMilliseconds*1e-3)*1e3;

    % Reassign position
    deDataArrayCorrected = deDataArray;
    deDataArrayCorrected(:,1:2) = probePositionCorrected;
    
end