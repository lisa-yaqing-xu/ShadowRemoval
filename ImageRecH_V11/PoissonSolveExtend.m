function phase_next = PoissonSolveExtend(im,dPdx,dPdy)
% extend phase by mirroring
[dxH,dyH] = getGradientH(im); 

[m,n] = size(im);
dpre = 4; % number of rows and cols we are extending by before the image (up and to the left);
dpost = 2; % number of rows and cols we are extending by after (down and to the right);
phase_ext = padarray(im,[dpre,dpre],'symmetric','pre'); % 4 rows and cols before
phase_ext = padarray(phase_ext,[dpost,dpost],'symmetric','post'); % 2 rows and cols after

m_ext = m + dpre + dpost;
n_ext = n + dpre + dpost;

dx_created = zeros(m_ext-1,n_ext-1);
dx_created(dpre+1:end-dpost,dpre+1:end-dpost) = dPdx;
dx_created(dpre,dpre+1:end-dpost) = dxH(1,:); % first row from dx
dx_created(end-dpost+1,dpre+1:end-dpost) = dxH(end,:); % last row from dx
dx_created(1:dpre-1,dpre+1:end-dpost) = flipud(dPdx(1:dpre-1,:));
dx_created(end-dpost+2:end,dpre+1:end-dpost) = flipud(dPdx(end-dpost+2:end,:));
dx_created(:,1:dpre-1) = -fliplr(dx_created(:,dpre+1:2*dpre-1));
dx_created(:,end-dpost+2:end) = -fliplr(dx_created(:,end-dpost));

dy_created = zeros(m_ext-1,n_ext-1);
dy_created(dpre+1:end-dpost,dpre+1:end-dpost) = dPdy;
dy_created(dpre+1:end-dpost,dpre) = dyH(:,1); % first column from dy
dy_created(dpre+1:end-dpost,end-dpost+1) = dyH(:,end); % last column from dy
dy_created(dpre+1:end-dpost,1:dpre-1) = fliplr(dPdy(:,1:dpre-1));
dy_created(dpre+1:end-dpost,end-dpost+2:end) = fliplr(dPdy(:,end-dpost+2:end));
dy_created(1:dpre-1,:) = -flipud(dy_created(dpre+1:2*dpre-1,:));
dy_created(end-dpost+2:end,:) = -flipud(dy_created(end-dpost,:));

div = getDiv(dx_created,dy_created);
g = .25;
lap = getLaplacian(phase_ext);
phase_ext(2:end-1,2:end-1) = phase_ext(2:end-1,2:end-1) + g*(lap - div);
phase_next = phase_ext(dpre+1:end-dpost,dpre+1:end-dpost);