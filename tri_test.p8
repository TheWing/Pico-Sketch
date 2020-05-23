pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--trifill tests

--0= no outline
--1= single line (still jagged)
--2= tripled (smoothest but slow)
--3= line instead of memset
quality=3



function _init()
	
	
end

function _update60()
	
end
f=0
function _draw()
	cls()
	--[
	for i=1,15 do
		trifill({rnd(128),rnd(128)},
		        {rnd(128),rnd(128)},
		        {rnd(128),rnd(128)},rnd(15))
	end
	--]]
	--trifill({10,10},{128,(f*0.01)%128},{30,80},1)
	--trifill({80,20},{30,80},{10,10},2)
	--trifill({30,80},{10,10},{80,20},3)
	f=f+1
	poke(0x6000,flr(f)*128)
end


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
	color(c)
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
end

function lerp(v0,v1,t)
	return v0+t*(v1-v0)
end

function ilerp(x,y,a)
	return (a-x)/(y-x)
end
 



__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
