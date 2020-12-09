function N = histogram(I, varargin)
    
  if nargin < 2,
      n = 10;
  else
      n = varargin{1};
  end
  
  if nargin < 4,
      minm = min(I(:)); maxm = max(I(:));
  else
      minm = fix(varargin{2}); maxm = fix(varargin{3});
  end
 
  x = double(round(linspace(minm, maxm, n)));
  out = zeros(1,numel(x));
  
  [row,col] = size(I);
  for r=1:row
      for c=1:col
          ind = find(x == I(r,c));
          if ~isempty(ind),
            out(ind) = out(ind) + 1;
          end
      end
  end
  
  
  if ~strcmp(class(I),'double'), 
      I = im2double(I); 
  end
  
  out = (out / maxm ) * size(I,1);
%  out = out / numel(I);
  figure;  bar(x,out); 
  title(sprintf('Histogram. Bins: %d',n)); axis tight;
