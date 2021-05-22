pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
-- main
cam={-0.25,0.25}
alpha=0

cube={
{x=1 ,y=1 ,z=1 },--1
{x=-1,y=1 ,z=1 },--2
{x=-1,y=-1,z=1 },--3
{x=1 ,y=-1,z=1 },--4
{x=1 ,y=1 ,z=-1},--5
{x=-1,y=1 ,z=-1},--6
{x=-1,y=-1,z=-1},--7
{x=1 ,y=-1,z=-1}}--8
cube_tris={
{1,2,5,0},
{5,6,1,0},
{3,4,8,5},
{3,7,8,5},
{8,1,4,5},
{5,8,1,5},
{2,3,6,0},
{3,6,7,0},
{1,2,3,6}, -- p1,p2,p3,c
{1,3,4,6},
{5,6,7,0},
{5,7,8,0}}


function draw_cube(x,y,coff,s)
	local r_cube={}
	local p1,p2,p3
	local off
	off={x,y}
	p1={}
	p2={}
	p3={}
	for i=1,#cube do
		r_cube[i]=tri2iso(cube[i],cam,coff)
	end
	
	for tri in all(cube_tris) do
		p1={
		r_cube[tri[1]].x*s+off[1],
		r_cube[tri[1]].y*s+off[2]}
		p2={
		r_cube[tri[2]].x*s+off[1],
		r_cube[tri[2]].y*s+off[2]}
		p3={
		r_cube[tri[3]].x*s+off[1],
		r_cube[tri[3]].y*s+off[2]}
		if tri[4]!=alpha then
			trifill(p1,p2,p3,tri[4])
		end
	end
	
end
t=0

function _update60()
	t=t+0.01
	cam={-0,1}
end

function _draw()
	cls()
	local st2,x,y
	for x=1,10 do
		for y=1,10 do 
			st2=sin(t+x/10+y/10)
			draw_cube(64,64,{(x-6)*3,(y-5)*3,st2*4},3)
		end
	end

end
-->8
-- isometric projection stuff


function tri2iso(tri,ax,off)
	local dx,dy
	local x,y,z
	x=-tri.x+off[1]
	y=-tri.y+off[2]
	z=tri.z+off[3]
	dx=x-ax[1]*z
	dy=y-ax[2]*z
	return {x=dx,y=dy}
end


-->8
-- triangles
quality=1

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
				x1=x1
				x2=x2+1
				
				hline(x1, x2, y, c)
				--memset(0x6000+(y\1)*64+x1,(c\1)<<4|c,(x2-x1))
			else
				x1=x1+1
				x2=x2
				hline(x1, x2, y, c)
				--memset(0x6000+(y\1)*64+x2,(c\1)<<4|c,(x1-x2)\1)
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

function drawtri(p1,p2,p3,c)
	color(c)
	line(p1[1],p1[2],p2[1],p2[2])
	line(p3[1],p3[2],p2[1],p2[2])
	line(p1[1],p1[2],p3[1],p3[2])
end

function hline(x1, x2, y, col)
	line(x1, y, x2, y, col)
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
__label__
70000000077077707070777000007770777007700770000007707070777077700770707000707770077007707770777077707770777007700000000000000000
07000000700070707070700000007070070070007070000070007070700007007000707007000700700070707770700007007070070070000000000000000000
00700000777077707070770000007770070070007070777077707700770007007000777007000700777070707070770007007700070070000000000000000000
07000000007070707770700000007000070070007070000000707070700007007000707007000700007070707070700007007070070070000000000000000000
70000000770070700700777000007000777007707700000077007070777007000770707070007770770077007070777007007070777007700000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06606660606066606600000066600660066066606660666066606660066000006660666000000000000000000000000000000000000000000000000000000000
60006060606060006060000006006000606066606000060060600600600000006060606000000000000000000000000000000000000000000000000000000000
66606660606066006060000006006660606060606600060066000600600000006660666000000000000000000000000000000000000000000000000000000000
00606060666060006060000006000060606060606000060060600600600000006000606000000000000000000000000000000000000000000000000000000000
66006060060066606660000066606600660060606660060060606660066006006000666000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70000000888800000000000006666666606666666606666666600000000000000000000000000000000000000000000000000000000000000000000000000000
07000000888800000000000006666666606666666606666666600000000000000000000000000000000000000000000000000000000000000000000000000000
00700000888800000000000006666666606666666606666666600000000000000000000000000000000000000000000000000000000000000000000000000000
07000000888800000000000006666666606666666606666666600000000000000000000000000000000000000000000000000000000000000000000000000000
70000000888800000000000006666666606666666606666666600000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666606666666605555555506666666600000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666605555555505555555506666666600000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666606666666605555555505555555506666666600000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666606666666605555555505555555506666666600000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666606666666606666666605555555506666666600000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666606666666606666666605555555506666666600000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666606666666606666666605555555506666666600000000000000000000000000000000000000000000000000000000000000000000
00000000000000006666666606666666606666666605555555506666666600000000000000000000000000000000000006666666600000000000000000000000
00000000000000006666666606666666606666666600000000006666666600000000000000000000000000000000000006666666600000000000000000000000
00000000000000006666666605555555506666666600000000005555555506666666600000000000000000000000000006666666600000000000000000000000
00000000000000005555555505555555506666666600000000005555555506666666600000000000000000000000000006666666600000000000000000000000
00000000000000006666666605555555505555555506666666605555555506666666600000000000000000000000000006666666600000000000000000000000
00000000000000006666666605555555505555555506666666605555555506666666600000000000000000000000000006666666600000000000000000000000
00000000000000006666666606666666605555555506666666605555555506666666600000000000000000000000000006666666600000000000000000000000
00000000000000006666666606666666605555555506666666605555555506666666600000000000000000006666666606666666600000000000000000000000
00000000000000006666666606666666605555555506666666600000000006666666606666666600000000006666666606666666600000000000000000000000
00000000000000006666666606666666605555555506666666600000000005555555506666666606666666606666666606666666600000000000000000000000
00000000000000006666666606666666600000000006666666600000000005555555506666666606666666606666666606666666600000000000000000000000
00000000000000005555555506666666600000000005555555506666666605555555506666666606666666606666666606666666600000000000000000000000
00000000000000005555555506666666600000000005555555506666666605555555506666666606666666606666666605555555500000000000000000000000
00000000000000005555555505555555506666666605555555506666666605555555506666666606666666606666666606666666600000000000000000000000
00000000000000005555555505555555506666666605555555506666666605555555506666666606666666606666666606666666600000000000000000000000
00000000000000006666666605555555506666666605555555506666666600000000005555555506666666606666666606666666600000000000000000000000
00000000000000006666666605555555506666666605555555506666666600000000005555555506666666606666666606666666600000000000000000000000
00000000000000006666666605555555506666666600000000006666666606666666605555555506666666606666666606666666600000000000000000000000
00000000000000006666666605555555506666666600000000005555555506666666606666666606666666606666666606666666600000000000000000000000
00000000000000006666666600000000006666666600000000005555555506666666606666666606666666606666666606666666600000000000000000000000
00000000000000006666666600000000005555555506666666605555555506666666606666666606666666606666666605555555500000000000000000000000
00000000000000006666666600000000005555555506666666605555555506666666606666666606666666605555555505555555500000000000000000000000
00000000000000005555555506666666605555555506666666605555555506666666606666666606666666606666666605555555500000000000000000000000
00000000000000005555555506666666605555555506666666605555555506666666606666666606666666606666666605555555500000000000000000000000
00000000000000005555555506666666605555555506666666600000000005555555506666666606666666606666666606666666600000000000000000000000
00000000000000005555555506666666605555555506666666600000000005555555506666666606666666606666666606666666600000000000000000000000
00000000000000005555555506666666600000000006666666606666666605555555506666666606666666606666666606666666600000000000000000000000
00000000000000005555555506666666600000000005555555506666666606666666606666666606666666606666666606666666600000000000000000000000
00000000000000000000000006666666600000000005555555506666666606666666606666666606666666606666666606666666600000000000000000000000
00000000000000000000000005555555506666666605555555506666666606666666606666666606666666605555555506666666600000000000000000000000
00000000000000000000000005555555506666666605555555506666666606666666606666666605555555505555555506666666600000000000000000000000
00000000000000006666666605555555506666666605555555506666666606666666606666666606666666605555555505555555500000000000000000000000
00000000000000006666666605555555506666666605555555506666666606666666606666666606666666605555555505555555500000000000000000000000
00000000000000006666666605555555506666666600000000005555555506666666606666666606666666606666666605555555500000000000000000000000
00000000000000006666666605555555506666666600000000005555555506666666606666666606666666606666666605555555500000000000000000000000
00000000000000006666666600000000006666666606666666605555555506666666606666666606666666606666666605555555500000000000000000000000
00000000000000006666666600000000005555555506666666606666666606666666606666666606666666606666666605555555500000000000000000000000
00000000000000006666666600000000005555555506666666606666666606666666606666666606666666606666666600000000000000000000000000000000
00000000000000005555555506666666605555555506666666606666666606666666606666666605555555506666666600000000000000000000000000000000
00000000000000005555555506666666605555555506666666606666666606666666605555555505555555506666666600000000000000000000000000000000
00000000000000005555555506666666605555555506666666606666666606666666606666666605555555505555555506666666600000000000000000000000
00000000000000005555555506666666605555555506666666606666666606666666606666666605555555505555555506666666600000000000000000000000
00000000000000005555555506666666600000000005555555506666666606666666606666666606666666605555555506666666600000000000000000000000
00000000000000005555555506666666600000000005555555506666666606666666606666666606666666605555555506666666600000000000000000000000
00000000000000000000000006666666606666666605555555506666666606666666606666666606666666605555555506666666600000000000000000000000
00000000000000000000000005555555506666666606666666606666666606666666606666666606666666605555555506666666600000000000000000000000
00000000000000000000000005555555506666666606666666606666666606666666606666666606666666600000000006666666600000000000000000000000
00000000000000006666666605555555506666666606666666606666666606666666605555555506666666600000000005555555500000000000000000000000
00000000000000006666666605555555506666666606666666606666666605555555505555555506666666600000000005555555500000000000000000000000
00000000000000006666666605555555506666666606666666606666666606666666605555555505555555506666666605555555500000000000000000000000
00000000000000006666666605555555506666666606666666606666666606666666605555555505555555506666666605555555500000000000000000000000
00000000000000006666666600000000005555555506666666606666666606666666606666666605555555506666666605555555500000000000000000000000
00000000000000006666666600000000005555555506666666606666666606666666606666666605555555506666666605555555500000000000000000000000
00000000000000006666666606666666605555555506666666606666666606666666606666666605555555506666666600000000000000000000000000000000
00000000000000005555555506666666606666666606666666606666666606666666606666666605555555506666666600000000000000000000000000000000
00000000000000005555555506666666606666666606666666606666666606666666606666666600000000006666666600000000000000000000000000000000
00000000000000005555555506666666606666666606666666606666666605555555506666666600000000005555555506666666600000000000000000000000
00000000000000005555555506666666606666666606666666605555555505555555506666666600000000005555555506666666600000000000000000000000
00000000000000005555555506666666606666666606666666606666666605555555505555555506666666605555555506666666600000000000000000000000
00000000000000005555555506666666606666666606666666606666666605555555505555555506666666605555555506666666600000000000000000000000
00000000000000000000000005555555506666666606666666606666666606666666605555555506666666605555555506666666600000000000000000000000
00000000000000000000000005555555506666666606666666606666666606666666605555555506666666605555555506666666600000000000000000000000
00000000000000006666666605555555506666666606666666606666666606666666605555555506666666600000000006666666600000000000000000000000
00000000000000006666666606666666606666666606666666606666666606666666605555555506666666600000000005555555500000000000000000000000
00000000000000006666666606666666606666666606666666606666666606666666600000000006666666600000000005555555500000000000000000000000
00000000000000006666666606666666606666666606666666605555555506666666600000000005555555506666666605555555500000000000000000000000
00000000000000006666666606666666606666666605555555505555555506666666600000000005555555506666666605555555500000000000000000000000
00000000000000006666666606666666606666666606666666605555555505555555506666666605555555506666666605555555500000000000000000000000
00000000000000006666666606666666606666666606666666605555555505555555506666666605555555506666666605555555500000000000000000000000
00000000000000005555555506666666606666666606666666606666666605555555506666666605555555506666666600000000000000000000000000000000
00000000000000005555555506666666606666666606666666606666666605555555506666666605555555506666666600000000000000000000000000000000
00000000000000005555555506666666606666666606666666606666666605555555506666666600000000006666666606666666600000000000000000000000
00000000000000006666666606666666606666666606666666606666666605555555506666666600000000005555555506666666600000000000000000000000
00000000000000006666666606666666606666666606666666606666666600000000006666666600000000005555555505666666600000000000000000000000
00000000000000006666666606666666606666666605555555506666666600000000005555555506666666605555555505506666600000000000000000000000
00000000000000006666666606666666605555555505555555506666666600000000005555555506666666605555555505506666600000000000000000000000
00000000000000006666666606666666605555555505555555505555555506666666605555555506666666605555555505500666600000000000000000000000
00000000000000006666666606666666605555555505555555505555555506666666605555555506666666605555555505555556600000000000000000000000
00000000000000006666666606666666605555555505555555505555555506666666605555555506666666600000000005555555500000000000000000000000
00000000000000006666666606666666605555555505555555505555555506666666605555555506666666600000000005555555500000000000000000000000
00000000000000006666666606666666605555555500000000005555555506666666600000000006666666606666666605555555500000000000000000000000
00000000000000006666666605555555500000000000000000005555555506666666600000000005555555506666666605555555500000000000000000000000
00000000000000006666666605555555500000000000000000000000000006666666600000000005555555506666666605555555500000000000000000000000
00000000000000006666666605555555500000000000000000000000000005555555506666666605555555506666666605555555500000000000000000000000
00000000000000006666666605555555500000000000000000000000000005555555506666666605555555506666666600000000000000000000000000000000
00000000000000006666666605555555500000000000000000000000000005555555506666666605555555506666666600000000000000000000000000000000
00000000000000006666666605555555500000000000000000000000000005555555506666666605555555506666666600000000000000000000000000000000
00000000000000006666666600000000000000000000000000000000000005555555506666666600000000005555555500000000000000000000000000000000
00000000000000005555555500000000000000000000000000000000000005555555506666666600000000005555555500000000000000000000000000000000
00000000000000005555555500000000000000000000000000000000000000000000006666666606666666605555555500000000000000000000000000000000
00000000000000005555555500000000000000000000000000000000000000000000005555555506666666606666666600000000000000000000000000000000
00000000000000005555555500000000000000000000000000000000000000000000005555555506666666606666666600000000000000000000000000000000
00000000000000005555555500000000000000000000000000000000000000000000005555555506666666606666666600000000000000000000000000000000
00000000000000005555555500000000000000000000000000000000000000000000005555555506666666606666666600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000005555555506666666606666666600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000005555555506666666606666666600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005555555506666666600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005555555505555555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005555555505555555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005555555505555555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005555555505555555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000005555555505555555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000005555555500000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

