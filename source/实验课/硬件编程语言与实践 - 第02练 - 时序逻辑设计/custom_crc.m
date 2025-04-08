function crc = custom_crc(dat, width, poly, init, xorout, refin, refout)
    if width < 8
        trueWidth = 8;
    else
        trueWidth = width;
    end
    crc = uint32(hex2dec(init)) * 2^(trueWidth - width);
    poly = uint32(hex2dec(poly)) * 2^(trueWidth - width);
    xorout = uint32(hex2dec(xorout));
    for i = 1:length(dat)
        if refin
            bit  = dec2bin(dat(i), 8);
            bit  = fliplr(bit);
            temp = bin2dec(bit);
        else 
            temp = dat(i);
        end
        crc = bitxor(crc, bitshift(uint32(temp), trueWidth - 8));
        for j = 1:8
            if bitget(crc, trueWidth)
                crc = bitshift(crc, 1);
                crc = bitxor(crc, poly);
            else
                crc = bitshift(crc, 1);
            end
        end
    end
    crc = bitand(crc, 2^trueWidth - 1) / 2^(trueWidth - width);
    if refout
        bit = dec2bin(crc, width);
        bit = fliplr(bit);
        crc = bin2dec(bit);
    end
    crc = bitxor(crc, xorout);
end
