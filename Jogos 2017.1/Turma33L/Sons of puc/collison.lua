function collision (x,y,h,w,x2,y2,h2,w2)
  return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end