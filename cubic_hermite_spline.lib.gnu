# Alessandro Corbetta, 2019

## USAGE:
# cubHerMulti3t(x0,u0,x1,u1,x2,u2,t)
#
# where x0,u0 are the value and the
# derivative at t=0, x1,u1 are the value and first derivative at t=1
# and so on


#basis functions, as in http://gnuplot.sourceforge.net/demo/spline.html
h00(x) = x**2 * ( 2 * x - 3) + 1
h01(x) = -x**2 * (2 * x - 3)
h10(x) = x * (x - 1)**2
h11(x) = x**2 * (x - 1)


## combination weights can be overridden if necessary, otherwise they are defaulted to 0.4
if !exists("wu0"){
wu0 = .4
}
if !exists("wu1"){
wu1 = .4
}

#basic definition
cubHer(x0,x1,u0,u1,t) = ((t>=0)&&(t<=1))?  h00(t) * x0 + h01(t) * x1 + h10(t) * u0 * wu0 + h11(t) * u1 * wu1 : 0

#bounds a value v between two time instants.
tlim(v,t,tm,tM) = ((t>=tm)&&(t<=tM))? v : 1/0

#sort of recursive construction, note, the next one with time bounding should rather be used.
cubHerMulti2(x0,u0,x1,u1,t) = cubHer(x0,x1,u0,u1,t)
cubHerMulti3(x0,u0,x1,u1,x2,u2,t) =  cubHerMulti2(x0,u0,x1,u1,t) + cubHerMulti2(x1,u1,x2,u2,t-1)
cubHerMulti4(x0,u0,x1,u1,x2,u2,x3,u3,t) =  cubHerMulti3(x0,u0,x1,u1,x2,u2,t) + cubHerMulti2(x2,u2,x3,u3,t-2)
cubHerMulti5(x0,u0,x1,u1,x2,u2,x3,u3,x4,u4,t) =  cubHerMulti4(x0,u0,x1,u1,x2,u2,x3,u3,t) + cubHerMulti2(x3,u3,x4,u4,t-3)

#final hermite polynomials.
cubHerMulti2t(x0,u0,x1,u1,t) = tlim(cubHerMulti2(x0,u0,x1,u1,t),t,0,1)
cubHerMulti3t(x0,u0,x1,u1,x2,u2,t) = tlim(cubHerMulti3(x0,u0,x1,u1,x2,u2,t),t,0,2)
cubHerMulti4t(x0,u0,x1,u1,x2,u2,x3,u3,t) = tlim(cubHerMulti4(x0,u0,x1,u1,x2,u2,x3,u3,t),t,0,3)
cubHerMulti5t(x0,u0,x1,u1,x2,u2,x3,u3,x4,u4,t) = tlim(cubHerMulti5(x0,u0,x1,u1,x2,u2,x3,u3,x4,u4,t),t,0,4)


