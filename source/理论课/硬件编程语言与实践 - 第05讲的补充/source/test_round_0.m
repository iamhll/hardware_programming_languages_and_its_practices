x = -2:0.25:2;
y1 = x; y2 = x; y3 = x; y4 = x; y5 = x; y6 = x;
for i = 1:numel(x)
    y1(i) = round(x(i), TieBreaker="fromzero");
    y2(i) = round(x(i), TieBreaker="tozero");
    y3(i) = round(x(i), TieBreaker="even");
    y4(i) = round(x(i), TieBreaker="odd");
    y5(i) = round(x(i), TieBreaker="plusinf");
    y6(i) = round(x(i), TieBreaker="minusinf");
end

fprintf("%3d ", x * 4);
fprintf("\n");
fprintf("%3d ", y1);
fprintf("\n");
fprintf("%3d ", y2);
fprintf("\n");
fprintf("%3d ", y3);
fprintf("\n");
fprintf("%3d ", y4);
fprintf("\n");
fprintf("%3d ", y5);
fprintf("\n");
fprintf("%3d ", y6);
fprintf("\n");
