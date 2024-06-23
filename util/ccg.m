function x =  ccg(M, y, ny, nx, nz, maxit, display)
x = 0*y(:); r=y(:); p = r; rr = r'*r;
prev = x; 
for it = 1:maxit
    Ap = M(p);
    a = rr/(p'*Ap);
    x = x + a*p;
    rnew = r - a*Ap;
    b = (rnew'*rnew)/rr;
    r=rnew;
    rr = r'*r;
    p = r + b*p;

    norm = (l2(prev, x));
    prev = x;
    if norm < 1e-6
        break
    end


    if display
        
        u_it = reshape(x,nx,ny,nz);
        u_it = u_it(:,:,nz/2);
        figure(1);
        imshow(abs(u_it),[]); % colorbar;
        title(['Image CG iteration ' num2str(it)]);
        drawnow;
    end
    

end
x  = reshape(x,nx,ny,nz);
end