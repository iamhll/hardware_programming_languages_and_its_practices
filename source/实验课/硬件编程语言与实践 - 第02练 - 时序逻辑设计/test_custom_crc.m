% init
clear;
clc;

% main loop
for idxTest = 1:1000
    % parameter
    num = randi([1,4096],1);
    dat = randi([0,255], num, 1);
    width = randi([4,32],1);
    poly = dec2hex(bitor(randi([0,2^width-1]), 1));
    init = dec2hex(randi([0,2^width-1]));
    xorout = dec2hex(randi([0,2^width-1]));
    refin = randi([0,1],1);
    refout = randi([0,1],1);

    % test
    crc_test = custom_crc(dat, width, poly, init, xorout, refin, refout);
    disp(['数据: ', mat2str(dat)]);
    disp(['位宽: ', num2str(width)]);
    disp(['生成多项式: ', poly]);
    disp(['初始值: ', init]);
    disp(['结果异或值: ', xorout]);
    disp(['输入数据反转: ', num2str(refin)]);
    disp(['输出数据反转: ', num2str(refout)]);
    disp(['校验值: ', dec2hex(crc_test)]);

    % golden
    polyInStr = ['1', dec2bin(hex2dec(poly), width)];
    polyInBin = str2num(polyInStr(:));
    initInStr = dec2bin(hex2dec(init), width);
    initInBin = str2num(initInStr(:));
    xoroutInStr = dec2bin(hex2dec(xorout), width);
    xoroutInBin = str2num(xoroutInStr(:));
    H = comm.CRCGenerator(polyInBin', ...
        'InitialConditions', initInBin', ...
        'FinalXOR', xoroutInBin', ...
        'ReflectInputBytes', refin, ...
        'ReflectChecksums', refout, ...
        'DirectMethod', true ...
        );
    dataInStr = dec2bin(dat, 8)';
    dataInBin = str2num(dataInStr(:));
    crc_expected = H(dataInBin)';
    crc_expected = crc_expected(end - width + 1:end);
    crc_expected = bin2dec(int2str(crc_expected));
    disp(['校验值: ', dec2hex(crc_expected)]);

    % check
    if crc_expected ~= crc_test
        fprintf("*** ERROR! ***\n");
        break;
    end
end
