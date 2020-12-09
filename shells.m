function [img,varargout] = shells(xc,yc,new,old,img,conn)

%global img; % label image
numPixels = 0;

if nargin < 8,
    conn = 4;
end

[w,h] = size(img);

q = [xc yc];

while size(q,1) > 0,
    v = q(end,:);
    q = q(1:end-1,:);
    if img(v(1), v(2)) == new,
        continue;
    end
    img(v(1),v(2)) = new;
    numPixels = numPixels + 1;
    for dx=-1:1
        for dy=-1:1
              if abs(dx+dy) == 0% 8-conn
              %if abs(dx+dy) ~= 1, % 4-conn
                continue;
              end
            vv = v + [dx dy];
            if (vv(1) < 1 || vv(1) > w || vv(2) < 1 || vv(2) > h),
                continue;
            end
            if (img(vv(1),vv(2)) == old),
                q = [q; vv];
            end
        end
    end
end

if nargout > 1,
    varargout(1) = { numPixels };
end
