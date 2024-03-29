pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--main


function _init()
	
	poke(0x5f10,0x00)
	poke(0x5f12,0x81)
	poke(0x5f14,0x01)
	poke(0x5f16,0x8c)
	poke(0x5f18,0x0c)
	poke(0x5f1a,0x07)
	poke(0x5f1c,0x8a)
	poke(0x5f1e,0x0b)
	
	poke(0x5f11,0x00)
	poke(0x5f13,0x80)
	poke(0x5f15,0x85)
	poke(0x5f17,0x86)
	poke(0x5f19,0x0a)
	poke(0x5f1b,0x87)
	poke(0x5f1d,0x09)
	poke(0x5f1f,0x08)
	
	
end


p1={32,32}
p2={32,96}
p3={96,96}
p4={96,32}
v1={0,0}
v2={0,0}
v3={0,0}
v4={0,0}


function _update60()
	for i=1,2 do
--		p1[i]=p1[i]+v1[i]
--		p2[i]=p2[i]+v2[i]
--		p3[i]=p3[i]+v3[i]
--		p4[i]=p4[i]+v4[i]
--		v1[i]=v1[i]*0.9+(0.5-rnd(1))*0.3
--		v2[i]=v2[i]*0.9+(0.5-rnd(1))*0.3
--		v3[i]=v3[i]*0.9+(0.5-rnd(1))*0.3
--		v4[i]=v4[i]*0.9+(0.5-rnd(1))*0.3
	end
	p1[1]=64+cos(t()*1.01)*48
	p2[1]=64+cos(t()*0.97+0.25)*48
	p3[1]=64+cos(t()*0.98+0.5)*48
	p4[1]=64+cos(t()*1.02+0.75)*48
	
	p1[2]=64+sin(t())*48
	p2[2]=64+sin(t()*0.99+0.25)*48
	p3[2]=64+sin(t()*0.97+0.5)*48
	p4[2]=64+sin(t()*1.01+0.75)*48
end


f=0
function _draw()
	local x
	local y
	f=f+1
	cls(3)
	poke(0x5f5e,0b11111111)
	for x=1,128 do
		for y=1,128 do
			pset(x-1,y-1,((128-y)\26%5*2+2))
		end
	end
	poke(0x5f5e,0b11110001)
	trifill(p1,p2,p3,13)
	trifill(p1,p4,p3,13)
	trifill(p4,p2,p3,13)
	trifill(p1,p4,p2,13)
	poke(0x5f5e,0b11111111)
	--debug_palette()
	--efu_smear()
end



function debug_palette()
	--rectfill(0,0,128,128,0)
	for i=0,15 do
		print(@(0x5f10+i),0,6*i,i)
		
		print(i,4*4,6*i,i)
	end
end 

-->8
--trifill
--bitplanes only work if
--quality==-1 or quality==3
--(other qualities use memcpy
quality=3


function trifill(p1,p2,p3,c)
	local y
	local ly
	local miny=min(p1[2],min(p2[2],p3[2]))
	local maxy=max(p1[2],max(p2[2],p3[2]))
	local x1
	local x2
	local top
	local mdl={0,0}
	local bot
	color(c)
	if quality>=0 then
		if miny==p1[2] then top=p1[1] end
		if miny==p2[2] then top=p2[1] end
		if miny==p3[2] then top=p3[1] end
		if maxy==p1[2] then bot=p1[1] end
		if maxy==p2[2] then bot=p2[1] end
		if maxy==p3[2] then bot=p3[1] end
		
		if top==p1[1] then
			if (bot==p2[1]) then
				mdl={p3[1],p3[2]} 
			else
				mdl={p2[1],p2[2]}
			end
		elseif top==p2[1] then
			if (bot==p1[1]) then
				mdl={p3[1],p3[2]} 
			else
				mdl={p1[1],p1[2]}
			end
		elseif top==p3[1] then
			if (bot==p2[1]) then
				mdl={p1[1],p1[2]} 
			else
				mdl={p2[1],p2[2]}
			end
		end
		for y=miny,maxy do
			x1=lerp(top,bot,ilerp(miny,maxy,y))
			if y<mdl[2] then
				x2=lerp(top,mdl[1],ilerp(miny,mdl[2],y))
			elseif y>mdl[2] then
				x2=lerp(mdl[1],bot,ilerp(mdl[2],maxy,y))
			else
				x2=mdl[1]
			end
			if quality==3 then
				line(x1,y,x2,y)
			else
				if x1<x2 then
					x1=x1\2
					x2=x2\2+1
					memset(0x6000+(y\1)*64+x1,(c\1)<<4|c,(x2-x1))
				else
					x1=x1\2+1
					x2=x2\2
					memset(0x6000+(y\1)*64+x2,(c\1)<<4|c,(x1-x2)\1)
				end
			end
		end
		if quality==2 then
			line(top-1,miny,mdl[1]-1,mdl[2])
			line(bot,maxy,mdl[1],mdl[2])
			line(top+1,miny,mdl[1]+1,mdl[2])
			
			line(bot-1,maxy,mdl[1]-1,mdl[2])
			line(bot,maxy,mdl[1],mdl[2])
			line(bot+1,maxy,mdl[1]+1,mdl[2])
			
			line(bot-1,maxy,top-1,miny)
			line(bot,maxy,top,miny)
			line(bot+1,maxy,top+1,miny)
		elseif quality==1 then
			line(bot,maxy,top,miny)
			line(bot,maxy,mdl[1],mdl[2])
			line(bot,maxy,mdl[1],mdl[2])
		end
	else
		line(p1[1],p1[2],p2[1],p2[2])
		line(p3[1],p3[2],p2[1],p2[2])
		line(p1[1],p1[2],p3[1],p3[2])
	end
end

function lerp(v0,v1,t)
	return v0+t*(v1-v0)
end

function ilerp(x,y,a)
	return (a-x)/(y-x)
end
-->8
--screen memory effects


function efu_smear()
	local i
	for i=1,63 do
		memcpy(0x6000+i*125,0x6000+i*(125+(0.5-rnd(1))*0.1),256) 
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
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
7777777777777777777777777777777777777777777777777n777777777777777777777777777777777777777777777777777777777777777777777777777777
777777777777777777777777777777777777777777777777nnnn7777777777777777777777777777777777777777777777777777777777777777777777777777
777777777777777777777777777777777777777777777777nnnnnn77777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777nnnnnnnnn777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777nnnnnnnnnnn7777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777nnnnnnnnnnnnn77777777777777777777777777777777777777777777777777777777777777777777
7777777777777777777777777777777777777777777777nnnnnnnnnnnnnnnn777777777777777777777777777777777777777777777777777777777777777777
ccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaccccccccccccccccc
cccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccc
ccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccc
ccccccccccccccccccccccccccccccccccccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaacccccccccccccccccc
ssssssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssss
sssssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssss
sssssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssss
ssssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssss
ssssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssss
ssssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssss
sssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssss
sssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssss
ssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssss
ssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssss
ssssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssss
sssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssss
sssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssss
sssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssss
ssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssss
ssssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssssss
sssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssssss
sssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssssss
sssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssssss
ssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssssss
ssssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssssssss
sssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssssssss
sssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssssssss
sssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssssssss
ssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssssssss
ssssssssssssssssssssssssssmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssssssssss
1111111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll11111111111111111111111111111
1111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111
1111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111
111111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111
111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll1111111111111111111111111111111
11111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll1111111111111111111111111111111
11111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll11111111111111111111111111111111
11111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll11111111111111111111111111111111
1111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll11111111111111111111111111111111
1111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111111
1111111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111111
111111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll1111111111111111111111111111111111
111111111111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll1111111111111111111111111111111111
111111111111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll1111111111111111111111111111111111
111111111111111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllllllllllllll11111111111111111111111111111111111
111111111111111111111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllllllll11111111111111111111111111111111111
111111111111111111111111111111111111111111llllllllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111111111
111111111111111111111111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111111111
11111111111111111111111111111111111111111111111lllllllllllllllllllllllllllllllllllllllllllll111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111lllllllllllllllllllllllllllllllllllllllll1111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111llllllllllllllllllllllllllllllllllllll1111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111llllllllllllllllllllllllllllllllll11111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111lllllllllllllllllllllllllllllll11111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111llllllllllllllllllllllllllll11111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111llllllllllllllllllllllll111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111lllllllllllllllllllll111111111111111111111111111111111111111
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhgggggggggggggggggghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhggggggggggggggghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhgggggggggggghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhgggggggghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhggggghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

