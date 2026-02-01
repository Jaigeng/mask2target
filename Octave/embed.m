function main()
  % load pakage
  % pkg load image;

  % [x, y, width, height]
  figure('position', [0 0 2000 1200]);

  % call function by button
  b1 = uicontrol('Style', 'pushbutton', 'String', '載入目標影像', ...
  'position', [300 50 150 30], ...
  'Callback', @target);

  b2 = uicontrol('Style', 'pushbutton', 'String', '載入遮罩影像', ...
  'position', [550 50 150 30], ...
  'Callback', @mask);

  b3 = uicontrol('Style', 'pushbutton', 'String', '嵌入遮罩資訊', ...
  'position', [800 50 130 30], ...
  'Callback', @em);
endfunction

% h: parameter
function target(h, event)
  global im;

  [f, p] = uigetfile({'*.gif;*.jpg;*.png;*.bmp', 'Supported Picture Formats'});

  pf = [p f];
  im = imread(pf);

  subplot(1, 3, 1);
  [r, c, p] = size(im);

  imshow(im);
endfunction

function mask(h, event)
  global hide;

  [f, p] = uigetfile({'*.gif;*.jpg;*.png;*.bmp', 'Supported Picture Formats'});

  pf = [p f];

  hide = imread(pf);

  subplot(1, 3, 2);
  imshow(hide);
endfunction

function em(h, event)
  global hide;
  global im;

  [r1, c1, p1]=size(im);
  [r2, c2, p2]=size(hide);

  target = im;
  hidden = hide;

  if (r1 < r2 || c1 < c2)
    return;
  elseif
    target(fix(r1/2-r2/2):fix(r1/2+r2/2)-1,fix(c1/2-c2/2):fix(c1/2+c2/2)-1,:) = ...
    target(fix(r1/2-r2/2):fix(r1/2+r2/2)-1,fix(c1/2-c2/2):fix(c1/2+c2/2)-1,:) + ...
    0.3*hidden(1:r2,1:c2,:);
  endif
  subplot(1, 3, 3);

  imshow(target);
endfunction
