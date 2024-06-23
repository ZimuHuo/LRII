function result = zpad3(x, shape)
    ny = shape(1);
    nx = shape(2);
    nz = shape(3);
    fy = fix(ny/2 - size(x, 1)/2);
    fx = fix(nx/2 - size(x, 2)/2);
    fz = fix(nz/2 - size(x, 3)/2);
    
    result = padarray(x, [fy, fx, fz], 0, 'both');
end
