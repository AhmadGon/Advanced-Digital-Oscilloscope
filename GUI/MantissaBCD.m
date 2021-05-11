fid = fopen('MantissaBCD.txt','W'); 
if (fid)
    for i = 0 : 255
        fprintf(fid,'%d:', i);
        % taking the first bit of the number and right shift the whole
        % number
        BCD = 00;
        BitWiseResult = 0;
        BitShiftResult = i;
        FloatResult = 0.0;
        PowerCount = 1;
        for x = 0 : 8
            BitWiseResult = bitand(BitShiftResult,1);
            BitShiftResult = bitshift(BitShiftResult, -1);
            FloatResult = FloatResult + PowerCount/256 * BitWiseResult;
            PowerCount = PowerCount * 2;
        end
        fprintf(fid, '%f ', FloatResult);
        fprintf(fid, '%.2d ', round(FloatResult * 100));
        fprintf(fid,'\n');
    end
    fclose(fid);
end