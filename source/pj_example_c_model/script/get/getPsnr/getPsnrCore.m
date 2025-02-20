%------------------------------------------------------------------------------
    %
    %  Filename       : getPsnrCore.m
    %  Author         : Huang Leilei
    #  Status         : draft
    #  Created        : 2025-02-18
    %  Description    : calculate PSNR (core)
    %
%-------------------------------------------------------------------------------

%*** FUNCTION ******************************************************************
function getPsnrCore(CSTR_YUV_REF, CSTR_YUV_DUT, FLAG_VERBOSE, NUMB_FRAME, SIZE_FRAME_X, SIZE_FRAME_Y)

% open files
fptRef = fopen(CSTR_YUV_REF, 'r');
fptDut = fopen(CSTR_YUV_DUT, 'r');

% main loop
if (FLAG_VERBOSE)
    fprintf('frame %7s %7s %7s\n', 'y', 'u', 'v');
end
for idxFrame = 1:NUMB_FRAME
    # read ref
    datRefY4 = fread(fptRef, SIZE_FRAME_X     * SIZE_FRAME_Y    , 'uint8');
    datRefU2 = fread(fptRef, SIZE_FRAME_X / 2 * SIZE_FRAME_Y / 2, 'uint8');
    datRefV2 = fread(fptRef, SIZE_FRAME_X / 2 * SIZE_FRAME_Y / 2, 'uint8');
    if isempty(datRefV2)
        break;
    end

    % reformat ref
    datRefY4 = reshape(datRefY4, SIZE_FRAME_X    , SIZE_FRAME_Y    );
    datRefU2 = reshape(datRefU2, SIZE_FRAME_X / 2, SIZE_FRAME_Y / 2);
    datRefV2 = reshape(datRefV2, SIZE_FRAME_X / 2, SIZE_FRAME_Y / 2);
    datRefYUV444 = zeros(SIZE_FRAME_Y, SIZE_FRAME_X, 3);
    datRefYUV444(:      , :      , 1) = datRefY4';
    datRefYUV444(1:2:end, 1:2:end, 2) = datRefU2';
    datRefYUV444(1:2:end, 2:2:end, 2) = datRefU2';
    datRefYUV444(2:2:end, 1:2:end, 2) = datRefU2';
    datRefYUV444(2:2:end, 2:2:end, 2) = datRefU2';
    datRefYUV444(1:2:end, 1:2:end, 3) = datRefV2';
    datRefYUV444(1:2:end, 2:2:end, 3) = datRefV2';
    datRefYUV444(2:2:end, 1:2:end, 3) = datRefV2';
    datRefYUV444(2:2:end, 2:2:end, 3) = datRefV2';

    % read dut
    datDutY4 = fread(fptDut, SIZE_FRAME_X     * SIZE_FRAME_Y    , 'uint8');
    datDutU2 = fread(fptDut, SIZE_FRAME_X / 2 * SIZE_FRAME_Y / 2, 'uint8');
    datDutV2 = fread(fptDut, SIZE_FRAME_X / 2 * SIZE_FRAME_Y / 2, 'uint8');
    if isempty(datDutV2)
        break;
    end

    % reformat dut
    datDutY4 = reshape(datDutY4, SIZE_FRAME_X    , SIZE_FRAME_Y    );
    datDutU2 = reshape(datDutU2, SIZE_FRAME_X / 2, SIZE_FRAME_Y / 2);
    datDutV2 = reshape(datDutV2, SIZE_FRAME_X / 2, SIZE_FRAME_Y / 2);
    datDutYUV444 = zeros(SIZE_FRAME_Y, SIZE_FRAME_X, 3);
    datDutYUV444(:      , :      , 1) = datDutY4';
    datDutYUV444(1:2:end, 1:2:end, 2) = datDutU2';
    datDutYUV444(1:2:end, 2:2:end, 2) = datDutU2';
    datDutYUV444(2:2:end, 1:2:end, 2) = datDutU2';
    datDutYUV444(2:2:end, 2:2:end, 2) = datDutU2';
    datDutYUV444(1:2:end, 1:2:end, 3) = datDutV2';
    datDutYUV444(1:2:end, 2:2:end, 3) = datDutV2';
    datDutYUV444(2:2:end, 1:2:end, 3) = datDutV2';
    datDutYUV444(2:2:end, 2:2:end, 3) = datDutV2';

    % get psnr
    if (FLAG_VERBOSE)
        fprintf('%05d   ', idxFrame);
    end
    for idxChn = 1:3
        datMse = sum(sum((datDutYUV444(:,:,idxChn) - datRefYUV444(:,:,idxChn)) .^ 2)) / (SIZE_FRAME_X * SIZE_FRAME_Y);
        datPsnr(idxFrame, idxChn) = 20 * log10(255 / sqrt(datMse));
        if (FLAG_VERBOSE)
            fprintf(' %7.3f', datPsnr(idxFrame, idxChn));
        end
    end
    if (FLAG_VERBOSE)
        fprintf('\n');
    end
end

% print mean psnr
if (FLAG_VERBOSE)
    fprintf('\n');
    fprintf('mean     %7.3f %7.3f %7.3f\n', mean(datPsnr(:,:)));
else
    fprintf('%.3f %.3f %.3f\n', mean(datPsnr(:,:)));
end

% close files
fclose(fptDut);
fclose(fptRef);
