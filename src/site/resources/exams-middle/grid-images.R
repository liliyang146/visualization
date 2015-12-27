xx <- c(22, 0, 0, 9, 9, 19, 19, 22)
yy <- c(0, 0, 6, 6, 15, 15, 1, 1)

N <- 5
#xx <- c(14, 15, 15, 0, 0, 11, 11, 14)
#yy <- c(14, 14, 8,  8, 0, 0, 12, 12)

# pirmais - (15,8) uz (0,8)
# otrais -  (11,0) uz (11,12)  --- vertikāls  
#   krustpunkts  --- (11,8)
#   (A) vertikālā nogriežņa x=11 ir starp 0 un 15
#   (B) horizontālā nogriežņa y = 8 ir starp 0 un 12

grid.newpage()
vp <- viewport(x=0.1,y=0.1,width=ww, height=hh)
pushViewport(vp)
grid.polygon(x=xx, y = yy, 
             id=rep(1,2*(N-1)), 
             gp=gpar(fill="pink"))
popViewport()


