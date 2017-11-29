function [x,y] = polylineinter(p1, p2, p3, p4)
    x1 = [p1(1) p2(1)];
    y1 = [p1(2) p2(2)];
    x2 = [p3(1) p4(1)];
    y2 = [p3(2) p4(2)];
    [x,y] = polyxpoly(x1, y1, x2, y2);
end