pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--mii music



mx={}
my={}
ix={}
iy={}
dx={}
dy={}

--mii logo m
mx={ 0,-4 ,-6 ,-9 ,-11 ,-11,-6 ,-6,-2,-1,1,2,6 ,6,11, 11,  9,  6,  4 }
my={ 0,-12,-13,-13,-11 , 9 , 9 ,-5, 8,9 ,9,8,-5,9,9 ,-11,-13,-13,-12   }
--mii logo i
ix={-2,-2,3,3}
iy={ 9,-5,-5,9}
--mii logo dots
for i=1,8 do
 add(dx,cos(i/8.)*3.1)--dx={4,3,1,0,1,-3,-4,-3, 1, 0, 1, 3}
 add(dy,sin(i/8.)*3.1)--dy={0,1,3,4,3, 1, 0,-1,-3,-4,-3,-1}
end
sx=0
sy=0
ox=0
oy=0
dt=0

function _init()

 -- palette gradient
 poke4(0x5f1c,0x070c.0c0c)
 poke4(0x5f18,0x0c0c.8c8c)
 poke4(0x5f14,0x8c8c.0101)
 poke4(0x5f10,0x8181.0000)
 poke(0x5f2e,0)


 poke(0x5f40,0b1111)
 poke(0x5f41,0b0000)
 poke(0x5f42,0b0000)
 poke(0x5f43,0b1111)
 music(0)
end

a=0
p1=0
p2=0

function _draw()
 local i
 for i=0,0x2000 do
  p1=@(0x6000+i)&0b00001111--(@(0x6000+i)&0b11110000)>>>4
  --p2=(@(0x6000+i)&0b00001111)
  p1=(p1*0.99)\1
  --p1=(p2*0.8)\
  poke(0x1000+i,p1<<4|p1)
 end
-- memcpy(0x1000,0x6000,0x2000)
 cls(0) 
 for i=0,15 do
 -- rectfill(i*4,8,i*4+4,12,i)
 end
 efu_smear()
 color(15)
 drawlogo(ox,oy,sx,sy,a-0.25)
 drawlogo(ox+0.5,oy,sx,sy,a-0.25)
 drawlogo(ox+1,oy,sx,sy,a-0.25)
end


function drawlogo(x,y,sx,sy,a)
 local an={sin(a),cos(a)}
 polyline(mx,my,1,x-10*sx,y,sx,sy,an)
 polyline(ix,iy,1,x+6*sx,y,sx,sy,an)
 polyline(ix,iy,1,x+14*sx,y,sx,sy,an)
 polyline(dx,dy,1,x+6*sx+1,y-10*sy,sx,sy,an)
 polyline(dx,dy,1,x+14*sx+1,y-10*sy,sx,sy,an)

end

function efu_smear()
 local i
 for i=1,127 do
  smcpy(0x6000+i*63,0x1000+i*63,128)
 end
end

--memcopy that doesn't overflow
function smcpy(to_mem,fr_mem,len)
 if to_mem<0x6000 then to_mem=0x6000 end
 if to_mem>0x7ffe then
  to_mem=0x7ffe
  len=1
 end
 if to_mem+len>0x7fff then len=0x7fff-to_mem end
 --if fr_mem<0x6000 then fr_mem=0x6000 end
 if fr_mem>0x7ffe then
  fr_mem=0x7ffe
  len=1
 end
 if fr_mem+len>0x7fff then len=0x7fff-fr_mem end

 memcpy(to_mem,fr_mem,len)

end


function polyline(px,py,loop,ox,oy,sx,sy,an)
 local x={}
 local y={}
 local dx={}
 local dy={}

 for i=1,#px do
  if i+1>#px then 
  	ii=1
  else
   ii=i+1
  end
  if loop==1 or ii>1 then 
   x[1]=(ox+px[i]*sx)
   y[1]=(oy+py[i]*sy)
   x[2]=(ox+px[ii]*sx)
   y[2]=(oy+py[ii]*sy)
   dx[1]=x[1]*an[1]-y[1]*an[2]
   dy[1]=x[1]*an[2]+y[1]*an[1]
   dx[2]=x[2]*an[1]-y[2]*an[2]
   dy[2]=x[2]*an[2]+y[2]*an[1]
   line(64+dx[1],64+dy[1],64+dx[2],64+dy[2])
  end
 end
end

function _update60()
 dt=dt+0.01
 sx=1+sin(dt)*0.2
 sy=1+cos(dt*0.9)*0.25
 ox=cos(dt*0.4)*16
 oy=sin(dt*0.3)*16
 a=a+(0.002+sin(dt*0.2)*0.003)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000hhhhhh0000000000hhhhhh000000hh000000hh0000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000hhhhhh0000000000hhhhhh0000hhhhhh00hhhhhh00000000000000000000000000000000000000
000000000000000000000000000000000000000000000000001111hhhh000000111111hh00hh11hhhhhh11hhhh00000000000000000000000000000000000000
00000000000000000000000000000000000000000000000011111111hh000011111111hhhh111111hh110011hhhh000000000000000000000000000000000000
00000000000000000000000000000000000000000000000011ssss11hh000011ssss111111ss111111ss110011hh000000000000000000000000000000000000
000000000000000000000000000000000000000000000000ssssssss110000ssssssss11ssssssssssssss1111hh000000000000000000000000000000000000
000000000000000000000000000000000000000000000000ssssssss110000ssssssssssssssssssssssss111100000000000000000000000000000000000000
000000000000000000000000000000000000000000000000ccccsssssshhccccccssssccssssssccssssss11hh00000000000000000000000000000000000000
0000000000000000000000000000000000000000000000ssccccccsssshhccccccssccccccssccccccssss110000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000ccccccccssssccccccccccccccccccccccccsssshhhh00000000000000000000000000000000000000
0000000000000000000000000000000000000000000000ccccccccccssccccccccccccccccccccccccsshhhhhh00000000000000000000000000000000000000
0000000000000000000000000000000000000000000000ccccccccccccccccccccccccccccccccccccss1111hh00000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777ccccc777777scc77777c777777ccccccssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077ccc77ccccc77ccc777c77cc7777cc77ccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cccs77ccc77cccc17777ccc777ccc77ccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cccs77ccc77ccssc77c77cc7777cc77ccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cccss77cc77ccssc77c77c77c77cc77ccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077ccccc77cc77ccccc77cc777ccc7777cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc77c77c77cc77cc77777777777777cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc77cc7777cc77cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc777c7777c777cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc777cc77cc777cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc777cc77s7777cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc777ccccs7777cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc7777cccs7777cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc7777ccc77c77cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc7777ccc77c77cc7777cc7777cc77cccccssssss11hh00000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc77c77c77cc77cc7777cc7777cc77cccccssss00000000000000000000000000000000000000000000
000000000000000000000000000000000000000000077cc77c77c77cc77cc7777cc7777cc77ccccc000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000777777c0777cc0777777777777777777c0000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800202a0500000000000000002d05000000310500000000000000002d0500000000000000002a0500000026050000002605000000260500000000000000000000000000000000000000000000002505025050
0108000026050000002a050000002d05024000310502400000000000002d0500000000000000002a0500000034050340503405034050340503405033050330503205000000000000000000000000000000000000
010800002c05000000000000000031050000002a050000000000000000310500000000000000002c050000000000000000310500000000000000002b0502b0502a05000000000000000028050000000000000000
010800002805000000280500000028050000000000000000000000000000000000002805000000280500000028050000000000000000000000000000000000002705027050270502705026050260502605026050
01080000250500000000000000002d05000000310500000000000000002d0500000000000000002a0500000028050000002805000000280500000000000000003405000000340503000034050000003000000000
0108000000000000002a050000002d05000000310500000000000000002d0500000000000000002a0500000031050310503105031050310503105031050310502f05024000000000000000000000000000000000
010800202f0502f0502b0502b0502605026050250502505025050250502f0502f0502b0502b05025050250502d0502d0502a0502a050240502405023050230502305023050290502905026050260502305023050
0108002028050000002805000000280500000000000000000000000000000000000000000000002e0502e0502f050000003105031050320500000036050360503905000000000000000000000000000000000000
01040020240000000000000000000000000000000000000021000210002100021000220002200022000220002d0502d0502d0502d0502d0502d0502d0502d0502e0502e0502e0502e0502e0502e0502e0502e050
010800202f0502f0502f0502f0502f0502f0502e0502e0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502d0502d0502e0502e0502f0502f050360503605036050360503105031050
010800202f0502f0502f0502f0502f0502f0502e0502e0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0502f0002f0502f0502f0502f05030050300503005030050
010800203105031050310503105031050310503005030050310503105031050310503105031050310503105031050310503105031000310503105030050300503105031050380503805038050380503305033050
0108002031050310503105031050310503105033050330502f0502f0502f0502f0502f0502f05031050310503205032050390503905039050390503205032050380502c000380500000038050000000000000000
010400200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01080000260500000000000000002a050000002d0500000000000000002a050000000000000000260500000020050000002005000000200500000000000000000000000000000000000000000000001d0501d050
010800001e0500000026050000002a050000002d0500000000000000002a05000000000000000026050000002c0502c0502c0502c0502c0502c0502b0502b0502a05000000000000000000000000000000000000
010800000000000000000000000028050000000000000000000000000000000000000000000000000000000000000000002805000000000000000000000000000000000000000000000025050000000000000000
010800002405000000240500000024050000000000000000000000000000000000002405000000240500000024050000000000000000000000000000000000002305023050230502305022050220502205022050
01080000210500000000000000002a050000002d0500000000000000002a050000000000000000270500000026050000002605000000260500000000000000002c050000002c050000002c050000000000000000
01080000000000000026050000002a050000002d0500000000000000002a05000000000000000026050000002c0502c0502c0502c0502c0502c0502c0502c0502a05000000000000000000000000000000000000
010800001c0501c0501c0501c0502305000000170501705017050170002505025050250502505025050250501a0501a0501a0501a050210500000015050150501505015000230502305023050230502300023000
0108000025050000002505000000250500000000000000000000000000000000000000000000001f0501f05020050000002205022050230500000026050260502b05000000000000000000000000000000000000
010400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800001c0501c0501c0501c0501f05000000170501705017050170501f0501f0501f0501f050190501905015050000001f0501f0501f0501f0501c0501c0501c0501c0501c0501c05023050230502305023050
010800001a0501a0501a0501a0502105000000150501505015050150502105021050210502105019050190501a050000002105021050210502105015050150501505015050150501505021050210502105021050
01080000200502005020050200502305000000190501905019050190502205022050220502205011050110501205000000220502205022050220500d0500d0500d0500d0500d0500d05022050220502205022050
010800001e0501e0501e0501e0502105000000170501705017050170502105021050210502105021050210501c0501c0501c0501c0501c0501c0501c0501c0002805000000280500000028050000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800001705000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010800000b0500000000000000000000000000000000000000000000000000000000000000000000000000001c0501c0501c0501c0501c0501c0501b0501b0501a05000000000000000000000000000000000000
010800000905000000000000000019050000000000000000000000000010050000000000000000150500000000000000001905000000000000000013050130501205000000000000000000000000000000000000
010800001205000000120500000012050000000000000000000000000000000000001205000000120501800012050000000000000000000000000000000000001405014050140501405013050130501305013050
01080000120500000000000000000000000000000000000000000000000b0500000000000000000f0500000010050000001005000000100500000000000000000000000000000000000000000000000000000000
010800000b0500000000000000000000000000170500000000000000000b050000000000000000000000000010050100501005010050100501005010050100500e05000000000000000000000000000000000000
01080000100501005010050100501f05000000000000000000000000002105021050210502105021050210500e0500e0500e0500e0501e05000000000000000000000000001f0501f0501f0501f0501f0501f050
010800001505000000150500000015050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01080000100501005010050100501c0501c000000000000000000000001c0501c0501c0501c0501c0501c05000000000001c0501c0501c0501c0501c0000000000000000001f000000001f0501f0501f0501f050
010800000e0500e0500e0500e0501e05000000000000000000000000001e0501e0501e0501e0501e0000000000000000001e0501e0501e0501e0501e00000000000000000000000000001e0501e0501e0501e050
01080000140501405014050140501b050000000000000000000000000019050190501905019050000000000000000000001905019050190501905027000000000000000000000000000019050190501905019050
01080000120501205012050120501e05000000000000000000000000001e0501e0501e0501e0501e0501e05010050100501005010050100501005010050100502305000000230500000023050000000000000000
__music__
01 0a1e3244
00 0b1f3344
00 0c203444
00 0d213544
00 0e223644
00 0f233744
00 10243844
00 11253944
00 12263a44
00 13273b44
00 14283c44
00 15293d44
00 162a3e44
02 17424344
