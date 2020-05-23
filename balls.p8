pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

balls=50
size=50

x={}
y={}
offset={}
for i=1,balls do
 add(x,rnd(127))
 add(y,rnd(127))
 add(offset,rnd(1)-0.5)
end 
t=0
poke(0x5f34, 1)

function _update60()
 t=t+0.01
end

//0    1    2    3        
//0000 0001 0010 0011 
//4    5    6    7        
//0100 0101 0110 0111 
//8    9    a    b       
//1000 1001 1010 1011
//c    d    e    f
//1100 1101 1110 1111

function _draw()
 rectfill(0,0,127,127,1)
 for i=1,balls do 
  r=sin(t+offset[i])*size
  circfill(x[i],y[i],r,0x1101.0000)
  circfill(x[i],y[i],r,0x1102.fdf7)
  circfill(x[i]-r/8,y[i]-r/8,r-r/3,0x1102.a5a5)
  circfill(x[i]-r/4,y[i]-r/4,r-r/3*2,0x1102.0000)
  circ(x[i],y[i],r,0x1102.0000)
 end
end 
