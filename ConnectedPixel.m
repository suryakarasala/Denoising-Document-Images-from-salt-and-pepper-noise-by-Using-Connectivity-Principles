function [img,varargout] = ConnectedPixel(bw,value,conn)

img = bw;
if nargin < 3,
    conn = 4;
end

if ~strcmp(class(img),'double'), 
    img = double(img);
end

[width,height] = size(img);
L = [];
for r = 1:width
    for c = 1:height
        if(img(r,c) == 1),
            [img,numPixels] = shells(r,c,value,1,img,conn);
            L = [L; numPixels];
            value = value + 1;
        end
    end
end

% Min non-zero value in img is 2. So, push down every pixel by 1.
ind = img > 0;
img(ind) = img(ind) - 1;
value = value - 2;

if nargout > 1,
    varargout(1) = { value } ;
    varargout(2) = { L };
end
