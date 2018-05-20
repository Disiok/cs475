function U=x1to2(u,nx,ny),

U=zeros(ny,nx);
for i=1:ny,
  U(ny-i+1,:)=u((i-1)*nx+1:i*nx)';
end;
