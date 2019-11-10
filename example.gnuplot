set terminal pdf color
set output 'example.pdf'

unset key
set samples 20000
set format '%g'
set xlabel "log(dt)"
set ylabel "log(S^2)"
set xrange [0:2]
set yrange [0:1.5]

bound_wr(x,ll,hl,v) =( ((x>ll)&& (x<hl))? v : (1/0))

fl_part(x,s,ll,hl) =  bound_wr(x,ll,hl,s)
in_part(x,s,ll,hl) = bound_wr(x,ll,hl,(1.)*x +s)
bal_part(x,s,ll,hl) = bound_wr(x,ll,hl,(2.)*x +s)

load "cubic_hermite_spline.lib.gnu"
set parametric
tr_cost = .4
tr_ext = .2
plot t,bal_part(t,0+tr_ext,0,0.25) ls 1 , t,in_part(t,0.2+tr_ext,0.15,0.85) ls 1, t,fl_part(t,1+tr_ext,0.7,2) ls 1,\
     t,bal_part(t,0+tr_cost,0,0.25) ls 2, t,in_part(t,0.2+tr_cost,0.15,0.85) ls 2, t,fl_part(t,1+tr_cost,0.7,2) ls 2,\
     t,bal_part(t,0,0,0.25+.2) ls 3,\
     cubHerMulti5t(\
     0.05,1 \
     ,0.4,1 \
     ,0.7,1 \
     ,1.2,1 \
     ,3,1 \
     ,t), cubHerMulti5t(0,2 ,0.6,1, 0.9,1 ,1.1,0 ,1.1,0 ,t) w l ls 3 lw 1,\
     cubHerMulti5t(\
     0.05,1 \
     ,0.4,1 \
     ,0.7,1 \
     ,1.2,1 \
     ,3,1 \
     ,t) -.1, cubHerMulti5t(0,2 ,0.6,1, 0.9,1 ,1.1,0 ,1.1,0 ,t) + 0.25 w l ls 2 lw 1# ,\
     # cubHerMulti5t(\
     # 0.05,1 \
     # ,0.4,1 \
     # ,0.7,1 \
     # ,1.2,1 \
     # ,3,1 \
     # ,t) -.1, cubHerMulti5t(0,2 ,0.6,1, 0.9,1 ,1.1,0 ,1.1,0 ,t)  w l ls 1 lw 1



