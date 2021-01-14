pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- main

mode=2
text_x=50
text_y=20
text_i=1
text_enabled=1
boom=0
t=0
t_c=0
menuitem(1,"next",function() next_mode() end)
menuitem(2,"prev",function() prev_mode() end)
menuitem(3,"toggle text",function() toggle_text() end)


function _init()
	poke4(0x5f10,0x8404.0080)
	poke4(0x5f14,0x0a07.8909)
	poke4(0x5f18,0x8e08.0f8f)
	poke4(0x5f1c,0x8581.8802)
	poke(0x5f2e,0b0)
	frame = 0
	scene_init()
end

function _update60()
	update_ids()
	b={d=btn(),p=btnp()}
	bt={l=b.d&0b1,r=(b.d&0b10)>>1,u=(b.d&0b100)>>2,d=(b.d&0b1000)>>3,z=(b.d&0b10000)>>4,v=(b.d&0b100000)>>5}
	bp={l=b.p&0b1,r=(b.p&0b10)>>1,u=(b.p&0b100)>>2,d=(b.p&0b1000)>>3,z=(b.p&0b10000)>>4,v=(b.p&0b100000)>>5}
	b2={d=btn()>>>8,p=btnp()>>>8}
	bt2={l=b2.d&0b1,r=(b2.d&0b10)>>1,u=(b2.d&0b100)>>2,d=(b2.d&0b1000)>>3,z=(b2.d&0b10000)>>4,v=(b2.d&0b100000)>>5}
	bp2={l=b2.p&0b1,r=(b2.p&0b10)>>1,u=(b2.p&0b100)>>2,d=(b2.p&0b1000)>>3,z=(b2.p&0b10000)>>4,v=(b2.p&0b100000)>>5}
	if mode==2 then 
		scene_update(frame)
		scene.camera[1]+=(bt.r-bt.l)*0.2
		scene.camera[2]+=(bt.u-bt.d)*0.2
		scene.camera[3]+=(bt2.u-bt2.d)*0.2
		scene.camera[7]+=(bt.z-bt.v)*0.002
		scene.camera[6]+=(bt2.r-bt2.l)*0.002
		scene.camera[5]+=(bt2.z-bt2.v)*0.002
	elseif mode==3 or mode==4 then
		foreach(t_l,update_tunnel)
		if frame%16==0 then 
			new_tunnel(
				0.5+cos(frame*0.002)*0.4,
				0.5+sin(frame*0.0052)*0.4,
				20,
				1,
				t_c)
			t_c=t_c+1
		end
		sort(t_l, function(t1, t2) return t1.z < t2.z end)
	end
	boom=boom*0.8
	frame+=1
	mode=mode%5
	text_i=text_i%#text_line
end

function _draw()
	t=t+1
	if mode==1 then
		draw_tiles()
	elseif mode==2 then
		cls(14)
		rectfill(0,0,64,128,7)
		draw_scene()
	elseif mode==3 or mode==4 then
		cls(t_c)
		foreach(t_l,draw_tunnel)
	else 
		draw_palette(0,8)
	end
	if text_enabled==1 then
		draw_text(text_x,text_y,text_i+1,6,boom+3)
	end
	if boom>0 then
		efu_smear(boom)
	end
end 


function draw_palette(x,y)
	local w=8
	local i
	cls()
	print("press a key",0,1,7)
	for i=0,15 do
		rectfill(x+(i%4)*w,y+(i\4)*w,x+(i%4)*w+w,y+(i\4)*w+w,3-i%4+i\4*4)
		rectfill(x+0+i*w,y+w*4+1,x+w+i*w,y+w*4+w,i)
	end
	rectfill(x+w*0,y+5*w+1,x+w*1-1,y+5*w+w,6)
	rectfill(x+w*1,y+5*w+1,x+w*2-1,y+5*w+w,5)
	rectfill(x+w*2,y+5*w+1,x+w*3-1,y+5*w+w,4)
	rectfill(x+w*3,y+5*w+1,x+w*4-1,y+5*w+w,11)
	rectfill(x+w*4,y+5*w+1,x+w*5-1,y+5*w+w,13)
	rectfill(x+w*5,y+5*w+1,x+w*6-1,y+5*w+w,14)
	rectfill(x+w*6,y+5*w+1,x+w*7-1,y+5*w+w,15)
	
	rectfill(x+w*0,y+6*w+1,x+w*1-1,y+6*w+w,0)
	rectfill(x+w*1,y+6*w+1,x+w*2-1,y+6*w+w,1)
	rectfill(x+w*2,y+6*w+1,x+w*3-1,y+6*w+w,2)
	rectfill(x+w*3,y+6*w+1,x+w*4-1,y+6*w+w,3)
	rectfill(x+w*4,y+6*w+1,x+w*5-1,y+6*w+w,10)
	rectfill(x+w*5,y+6*w+1,x+w*6-1,y+6*w+w,9)
	rectfill(x+w*6,y+6*w+1,x+w*7-1,y+6*w+w,8)
	rectfill(x+w*7,y+6*w+1,x+w*8-1,y+6*w+w,7)
	rectfill(x+w*8,y+6*w+1,x+w*9-1,y+6*w+w,6)
	rectfill(x+w*9,y+6*w+1,x+w*10-1,y+6*w+w,5)
	rectfill(x+w*10,y+6*w+1,x+w*11-1,y+6*w+w,4)
	rectfill(x+w*11,y+6*w+1,x+w*12-1,y+6*w+w,11)
	rectfill(x+w*12,y+6*w+1,x+w*13-1,y+6*w+w,12)
	rectfill(x+w*13,y+6*w+1,x+w*14-1,y+6*w+w,13)
	rectfill(x+w*14,y+6*w+1,x+w*15-1,y+6*w+w,14)
	rectfill(x+w*15,y+6*w+1,x+w*16-1,y+6*w+w,15)
end

function draw_tiles()
	local x,y,i
	for i=0,127 do
		tline(0,i,128,i,0,i/8)
	end
end

function draw_model()
	print("model here",0,1,7)
	
	draw_lines({0,0,0},{0,0,0})
end

function update_ids()
	local ii
	for ii=1,#t_l do
		t_l[ii].i=ii
	end
end



function rectf(x,y,w,h,c)
	rectfill(x,y,x+w,y+h,c)
end


function next_mode()
	frame=0
	boom=8
	mode=mode+1
	text_i=text_i+1
	text_i=text_i%#text_line
	text_x=12+rnd(104-#text_line[text_i+1]*4)
	text_y=2+rnd(117)
	for ii=1,#t_l do
		t_l[ii].d=mode-2
	end
end

function prev_mode()
	frame=0
	boom=8
	mode=mode-1
	text_i=text_i-1
	text_i=text_i%#text_line
	text_x=12+rnd(104-#text_line[text_i+1]*4)
	text_y=2+rnd(117)
	for ii=1,#t_l do
		t_l[ii].d=mode-2
	end
end

function toggle_text()
	if text_enabled==1 then 
		text_enabled=0
	else
		text_enabled=1
	end
end


-->8
--tunnel

t_l={{i=0,
     d=0,
     x=0,
     y=0,
     z=0,
     s=1,
     c=0}}

function update_tunnel(t)
	if t.d>0 then 
		t.z=t.z-0.1
		t.x=t.x+(bt.l-bt.r)*0.02
		t.y=t.y+(bt.u-bt.d)*0.02
		if t.z<0.5 then
			t.d=0
		end
	else
		deli(t_l,t.i)
	end
end

function draw_tunnel(t)
	local x,y,dx,dy,dx2,dy2
	local d=scene.camera[4]
	local f=(frame/4)%16
	local ff=(frame/4)\16
	if t.d==1 then 
		for x=-t.z\2-3,t.z\2+4 do
			for y=-t.z\2-3,t.z\2+4 do
				if (x+y)%2==1 then 
					dx=64+(t.x+x)*(d/t.z)
					dy=64+(t.y+y)*(d/t.z)
					dx2=64+((t.x+x)+t.s)*(d/t.z)
					dy2=64+((t.y+y)+t.s)*(d/t.z)
					rectfill(dx,dy,dx2,dy2,t.c)
				end
			end
		end
	elseif t.d==2 then 
		for x=-2,0 do
			for y=-2,0 do
				if x==-1 and y==-1 then
				
				else
					dx=64+(t.x+x)*(d/t.z)
					dy=64+(t.y+y)*(d/t.z)
					dx2=64+((t.x+x)+t.s)*(d/t.z)
					dy2=64+((t.y+y)+t.s)*(d/t.z)
					
					if x==-2 then
						dx=min(0,dx)
					end
					if x==0 then 
						dx2=max(128,dx2)
					end
					if y==-2 then
						dy=min(0,dy)
					end
					if y==0 then 
						dy2=max(128,dy2)
					end
					rectfill(dx,dy,dx2,dy2,t.c)
				end
			end
		end
	end
end



function new_tunnel(x,y,z,s,c)
	add(t_l,{i=0,
	        d=mode-2,
	        x=x,
	        y=y,
	        z=z,
	        s=s,
	        c=c},
	        #t_l+1)
end

-->8
--3d engine
quality=1

function scene_init()

end

function scene_update(frame)
	scale = 1
	scene_transform(scene.camera[5],scene.camera[6],scene.camera[7], scale, scale, scale)
end

function scene_transform(rx, ry, rz, sx, sy, sz)
	local vertices, points = {}, {}
	for vertex in all(model.vertices) do
		local v = transform_vertex(vertex, rx, ry, rz, sx, sy, sz)
		add(vertices, v)
		add(points, project(v, scene.camera))
	end
	model.transformed_vertices = vertices
	model.points = points
end

function draw_scene()
	-- face depth and normal calculation
	for triangle in all(model.triangles) do
		local v1 = model.transformed_vertices[triangle[1]]
		local v2 = model.transformed_vertices[triangle[2]]
		local v3 = model.transformed_vertices[triangle[3]]
		local p  = {v1[1]-v2[1], v1[2]-v2[2], v1[3]-v2[3]}
		local q  = {v1[1]-v3[1], v1[2]-v3[2], v1[3]-v3[3]}
		triangle[5] = min(v1[3], min(v2[3], v3[3]))
		triangle[6] = normalize(cross_product(p, q))
	end
	
	-- painter's algorithm
	sort(model.triangles, function(t1, t2) return t1[5] < t2[5] end)
	
	-- render
	for triangle in all(model.triangles) do
		--if dot_product(scene.camera, triangle[6]) < 0 then
		local p1 = model.points[triangle[1]]
		local p2 = model.points[triangle[2]]
		local p3 = model.points[triangle[3]]
		trifill(p1, p2, p3, triangle[4])
		rasterize_mesh(p1, p2, p3, triangle[4])
		--end
	end
end

function rasterize_mesh(p1, p2, p3, col)
	line(p1[1], p1[2], p2[1], p2[2], col)
	line(p2[1], p2[2], p3[1], p3[2], col)
	line(p1[1], p1[2], p3[1], p3[2], col)
end

-- http://www-users.mat.uni.torun.pl/~wrona/3d_tutor/tri_fillers.html
function rasterize_triangle(p1, p2, p3, col)
	-- sort
	if p1[2] > p2[2] then
		p1, p2 = p2, p1
	end
	if p1[2] > p3[2] then
		p1, p3 = p3, p1
	end
	if p2[2] > p3[2] then
		p2, p3 = p3, p2
	end
	
	-- lerp
	local dy1 = (p2[2] - p1[2])
	local dy2 = (p3[2] - p1[2])
	local dy3 = (p3[2] - p2[2])
	
	local dx1, dx2, dx3 = 0, 0, 0
	if dy1 > 0 then
		dx1 = (p2[1] - p1[1]) / dy1
	end
	if dy2 > 0 then
		dx2 = (p3[1] - p1[1]) / dy2
	end
	if dy3 > 0 then
		dx3 = (p3[1] - p2[1]) / dy3
	end
	
	local x1, x2 = p1[1], p1[1]
	
	if dx1 > dx2 then
		for y=p1[2],p2[2] do
			hline(x1, x2, y, col)
			x1 += dx2
			x2 += dx1
		end
		for y=p2[2],p3[2] do
			hline(x1, x2, y, col)
			x1 += dx2
			x2 += dx3
		end
	else
		for y=p1[2],p2[2] do
			hline(x1, x2, y, col)
			x1 += dx1
			x2 += dx2
		end
		for y=p2[2],p3[2] do
			hline(x1, x2, y, col)
			x1 += dx3
			x2 += dx2
		end
	end
end

function hline(x1, x2, y, col)
	line(x1, y, x2, y, col)
end

function project(vertex, cam)
	local mult = cam[4]
	local d = max(1,(vertex[3]-cam[3]))
	local x = 64 + (vertex[1]-cam[1]) * mult / d
	local y = 64 - (vertex[2]-cam[2]) * mult / d
	return {x,y}
end

function transform_vertex(v, rx, ry, rz, sx, sy, sz)
	nv = {v[1] * sx, v[2] * sy, v[3] * sz}
	nv = rotate_vertex(nv, 1, rx)
	nv = rotate_vertex(nv, 2, ry)
	return rotate_vertex(nv, 3, rz)
end

function rotate_vertex(v,a,r)
	if a==1 then
		x,y,z = 3,2,1
	elseif a==2 then
		x,y,z = 1,3,2
	elseif a==3 then
		x,y,z = 1,2,3
	end
	_x = cos(r)*(v[x]) - sin(r) * (v[y])
	_y = sin(r)*(v[x]) + cos(r) * (v[y])
	nv = {}
	nv[x] = _x
	nv[y] = _y
	nv[z] = v[z]
	return nv
end

function cross_product(v1, v2)
	return {
		v1[2]*v2[3] - v1[3]*v2[2],
		v1[3]*v2[1] - v1[1]*v2[3],
		v1[1]*v2[2] - v1[2]*v2[1]
	}
end

function dot_product(v1, v2)
	return v1[1]*v2[1] + v1[2]*v2[2] + v1[3]*v2[3]
end

function normalize(v)
	local s = 1 / magnitude(v)
	return {v[1] * s, v[2] * s, v[3] * s}
end

function magnitude(v)
 return sqrt(dot_product(v, v))
end

function sort(a, greater_than)
	for i=1,#a do
		local j = i
		while j > 1 and greater_than(a[j-1], a[j]) do
			a[j],a[j-1] = a[j-1],a[j]
			j -= 1
		end
	end
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


function lerp(v0,v1,t)
	return v0+t*(v1-v0)
end

function ilerp(x,y,a)
	return (a-x)/(y-x)
end
-->8
--qsort

-- common comparators
function  ascending(a,b) return a.z<b.z end
function descending(a,b) return a.z>b.z end

-- a: array to be sorted in-place
-- c: comparator (optional, defaults to ascending)
-- l: first index to be sorted (optional, defaults to 1)
-- r: last index to be sorted (optional, defaults to #a)
function qsort(a,c,l,r)
	c,l,r=c or ascending,l or 1,r or #a
	if l<r then
		if c(a[r],a[l]) then
			a[l],a[r]=a[r],a[l]
		end
		local lp,rp,k,p,q=l+1,r-1,l+1,a[l],a[r]
		while k<=rp do
			if c(a[k],p) then
				a[k],a[lp]=a[lp],a[k]
				lp+=1
			elseif not c(a[k],q) then
				while c(q,a[rp]) and k<rp do
					rp-=1
				end
				a[k],a[rp]=a[rp],a[k]
				rp-=1
				if c(a[k],p) then
					a[k],a[lp]=a[lp],a[k]
					lp+=1
				end
			end
			k+=1
		end
		lp-=1
		rp+=1
		a[l],a[lp]=a[lp],a[l]
		a[r],a[rp]=a[rp],a[r]
		qsort(a,c,l,lp-1       )
		qsort(a,c,  lp+1,rp-1  )
		qsort(a,c,       rp+1,r)
	end
end
-->8
--scene 

model = {}
--[[ cube
model.vertices = {
	{-1,  1,  1},--1
	{ 1,  1,  1},--2
	{-1,  1, -1},--3
	{ 1,  1, -1},--4
	
	{-1, -1,  1},--5 
	{ 1, -1,  1},--6
	{-1, -1, -1},--7
	{ 1, -1, -1},--8
}
model.triangles = {
	
	{3, 4, 7, 4, nil, nil},
	{8, 4, 7, 4, nil, nil},
	
	{1, 2, 5, 8, nil, nil},
	{6, 2, 5, 8, nil, nil},
	
	{1, 3, 5, 5, nil, nil},
	{7, 3, 5, 5, nil, nil},
	
	{2, 4, 6, 12, nil, nil},
	{8, 4, 6, 12, nil, nil},
}
--]]


model.vertices = {
-- x  y  z
	{ 5, 0, 0},--1
	{ 3, 0, 0},
	{ 1, 0, 0},
	{-1, 0, 0},
	{-3, 0, 0},
	{-5, 0, 0},--6
	
	{ 5, 20, 0},--7
	{ 3, 20, 0},
	{ 1, 20, 0},
	{-1, 20, 0},
	{-3, 20, 0},
	{-5, 20, 0},--12
	
	{ 5, 0,10},--13
	{ 3, 0,10},
	{ 1, 0,10},
	{-1, 0,10},
	{-3, 0,10},
	{-5, 0,10},--18
	
	{ 5,20,10},
	{-5,20,10},
	
	{ 5,-10,10},--21
	{ 3,-10,10},
	{ 1,-10,10},
	{-1,-10,10},
	{-3,-10,10},
	{-5,-10,10},--26
	
	{ 6,-10,10},--27
	{-6,-10,10},
}
model.triangles = {
-- v1 v2 v3  c  nil nil
	{ 1, 7,13, 7, nil,nil},
	{ 7,19,13, 7, nil,nil},
	{12, 6,18,14, nil,nil},
	{12,20,18,14, nil,nil},
	
	
	{ 1, 2, 7, 4, nil,nil},
	{ 2, 8, 7, 4, nil,nil},
	{14, 1,13, 4, nil,nil},
	{ 1, 2,14, 4, nil,nil},
	{14,21,13, 4, nil,nil},
	{21,22,14, 4, nil,nil},
	
	{ 2, 3, 8, 5, nil,nil},
	{ 3, 9, 8, 5, nil,nil},
	{15, 2,14, 5, nil,nil},
	{ 2, 3,15, 5, nil,nil},
	{15,22,14, 5, nil,nil},
	{22,23,15, 5, nil,nil},
	
	{ 3, 4, 9,10, nil,nil},
	{ 4,10, 9,10, nil,nil},
	{16, 3,15,10, nil,nil},
	{ 3, 4,16,10, nil,nil},
	{16,23,15,10, nil,nil},
	{23,24,16,10, nil,nil},
	
	{ 4, 5,10,12, nil,nil},
	{ 5,11,10,12, nil,nil},
	{17, 4,16,12, nil,nil},
	{ 4, 5,17,12, nil,nil},
	{17,24,16,12, nil,nil},
	{24,25,17,12, nil,nil},
	
	{ 5, 6,11,15, nil,nil},
	{ 6,12,11,15, nil,nil},
	{18, 5,17,15, nil,nil},
	{ 5, 6,18,15, nil,nil},
	{18,25,17,15, nil,nil},
	{25,26,18,15, nil,nil},
}

function model:new(o)
  self.__index = self
  return setmetatable(o or {}, self)
end



scene = {}   -- x  y  z  f
scene.camera = {0, 2, -18, 128,0,0.5,0.0001}

-->8
-- gfx stuff


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

function efu_smear(str)
	local i
	local r
	for i=1,127 do
		smcpy(0x6000+i*63-str*(rnd(2+((t\4)%6)*0.25)),0x6000+i*63-str*(rnd(2+((t\4)%8)*0.25)),rnd(128)) 
		if rnd(90)\1>88 then
			r=0x7//rnd(0xf)\1
			memset(0x6000+i*64,r|(r<<4),64)
		end
	end 
end


function smear_y(str,sy,ey)
	local i
	local r
	for i=sy,ey do
		smcpy(0x6000+i*63-str*(rnd(2+((t\4)%6)*0.25)),0x6000+i*63-str*(rnd(2+((t\4)%8)*0.25)),rnd(128)) 
		if rnd(90)\1>88 then
			r=0x7//rnd(0xf)\1
			memset(0x6000+i*64,r|(r<<4),64)
		end
	end 
end
-->8
--text overlay

text_line={
"this is 1",
"next is 2",
"this should work"
}

function draw_text(x,y,i,c,pow)
	c=c or 6
	pow=pow or 0
	local str=text_line[i]
	rectfill(0,y,128,y+6,1)
	rect(-1,y,129,y+6,2)
	rectfill(x-10,y+1,x+10+#str*4,y+5,3)
	print(str,x+1,y+1,11)
	if pow>0.1 then
		print(str,x-1,y+1,11)
		smear_y(pow,y-1,y+7)
	end
	print(str,x,y+1,c)
end


function smear_y(str,sy,ey)
	local i
	local r
	for i=sy,ey do
		smcpy(0x6000+i*63-str*(rnd(2+((t\4)%6)*0.25)),0x6000+i*63-str*(rnd(2+((t\4)%8)*0.25)),rnd(128)) 
		if rnd(90)\1>88 then
			r=0x7//rnd(0xf)\1
			memset(0x6000+i*64,r|(r<<4),64)
		end
	end 
end
__gfx__
66666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666555555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666665555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666655555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeefffffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666666666555555555554444444444bbbbbbbbbbddddddddddeeeeeeeeeeefffffffffffffffffffffffffffffffffffff
666666666666666666666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddeeeeeeeeeeeffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffff
6666666666666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeffffffffffffffffffffffffffffffffffff
66666666666666666666666666666666666666666555555555544444444444bbbbbbbbbbdddddddddddeeeeeeeeeeeeeefffffffffffffffffffffffffffffff
66666666666666666666666666666666666666666555555555554444444444bbbbbbbbbbdddddddddddeeeeeeeeeeeeeeeeeefffffffffffffffffffffffffff
66666666666666666666666666666666666666666655555555554444444444bbbbbbbbbbbddddddddddeeeeeeeeeeeeeeeeeeeeeffffffffffffffffffffffff
666666666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffffffff
666666666666666666666666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeffffffffffffff
666666666666666666666666666666666666666666655555555554444444444bbbbbbbbbbbdddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeefeeefffff
6666666666666666666666666666666666666666666555555555544444444444bbbbbbbbbbddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666555555555554444444444bbbbbbbbbbbddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666655555555554444444444bbbbbbbbbbbbddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666655555555554444444444bbbbbbbbbbbbbddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666655555555555444444444bbbbbbbbbbbbbddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666655555555555444444444bbbbbbbbbbbbbbddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666665555555555444444444bbbbbbbbbbbbbbbddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666665555555555444444444bbbbbbbbbbbbbbbdddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666666555555554444444444bbbbbbbbbbbbbbbbdddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666666555555544444444444bbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddeeeeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666665555555544444444444bbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddeeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666655555555544444444444bbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddeeeeeeeeeeeeeeee
6666666666666666666666666666666666666666666555555555444444444444bbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddeeeeeeeeeeeeee
6666666666666666666666666666666666666666665555555554444444444444bbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddeeeeeeeeeee
6666666666666666666666666666666666666666665555555554444444444444bbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddeeeeeeeeee
6666666666666666666666666666666666666666555555555554444444444444bbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddddeeeeeee
6666666666666666666666666666666666666666555555555544444444444444bbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddddeeeeee
6666666666666666666666666666666666666665555555555444444444444444bbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddddddeee
6666666666666666666666666666666666666655555555555444444444444444bbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddddddee
6666666666666666666666666666666666666555555555554444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddddddd
6666666666666666666666666666666666665555555555554444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddddd
6666666666666666666666666666666666655555555555554444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddddd
6666666666666666666666666666666666655555555555544444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddddd
6666666666666666666666666666666666555555555555444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddd
6666666666666666666666666666666665555555555555444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddddd
6666666666666666666666666666666655555555555555444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddddd
6666666666666666666666666666666555555555555554444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddd
6666666666666666666666666666665555555555555544444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddddd
6666666666666666666666666666665555555555555544444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddddd
6666666666666666666666666666555555555555555544444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddddd
6666666666666666666666666666555555555555555444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddddd
6666666666666666666666666665555555555555554444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddd
6666666666666666666666666655555555555555554444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddddd
6666666666666666666666666555555555555555554444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddddd
6666666666666666666666665555555555555555544444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddddd
6666666666666666666666655555555555555555444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddd
6666666666666666666666655555555555555555444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddddd
6666666666666666666666555555555555555554444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddddd
6666666666666666666665555555555555555554444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddd
6666666666666666666655555555555555555554444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddddd
6666666666666666666555555555555555555544444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddddd
6666666666666666666555555555555555555444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddddd
6666666666666666655555555555555555555444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddddd
6666666666666666555555555555555555555444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddd
6666666666666666555555555555555555554444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddddd
6666666666666665555555555555555555544444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddddd
6666666666666655555555555555555555544444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddddd
6666666666666555555555555555555555544444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddd
6666666666665555555555555555555555444444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddddd
6666666666655555555555555555555554444444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbddddddddddddddddd
6666666666655555555555555555555554444444444444444444444444444444bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbdddddddddddddddd
__label__
aaaaaa9999999999pppppppppppp888888888882222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaa9999999999pppppppppppp88888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaa9999999999pppppppppppp88888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaa9999999999pppppppppppp888888888882222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888222222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222llllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222lllllllllllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222lllllllllllllllllllllllllllllllllllhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllllllllllllllllllllllllhhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222lllllllllllllllllllllllllllllllllllhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllllllllllllllllllllllllhhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppppp88888888888822222222222lllllllllllllllllllllllllllllllllllhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222llllllllllllllllllllllllllllllllllhhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp88888888888822222222222222llllllllllllllllllllllllllllllllhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp8888888888882222222222222222222lllllllllllllllllllllllllllhhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp8888888888882222222222222222222222llllllllllllllllllllllllhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888222222222222222222222222llllllllllllllllllllllhhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888222222222222222222222222llllllllllllllllllllllhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888822222222222222222222222llllllllllllllllllllllhhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888822222222222222222222222llllllllllllllllllllllhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888882222222222222222222222llllllllllllllllllllllhhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppp888888888888882222222222222222222222llllllllllllllllllllllhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppppp888888888888888222222222222222222222llllllllllllllllllllllhhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999ppppppppppp8888888888888888222222222222222222222llllllllllllllllllllllhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999pppppppppp8888888888888888822222222222222222222llllllllllllllllllllllhh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppp88888888888888888822222222222222222222llllllllllllllllllllllh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999ppppppppp88888888888888888822222222222222222222llllllllllllllllllllllh
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999ppppppppppp88888888888888888822222222222222222222llllllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999ppppppppppp88888888888888888822222222222222222222llllllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999ppppppppppp888888888888888888822222222222222222222lllllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999pppppppppppp888888888888888888822222222222222222222lllllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999pppppppppppp8888888888888888888822222222222222222222llllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999ppppppppppppp8888888888888888888822222222222222222222llllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999pppppppppppppp8888888888888888888822222222222222222222lllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999ppppppppppppppp8888888888888888888822222222222222222222lllllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999pppppppppppppppp8888888888888888888822222222222222222222llllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999ppppppppppppppppp8888888888888888888822222222222222222222llllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppppppppp8888888888888888888822222222222222222222lllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999ppppppppppppppppppp8888888888888888888822222222222222222222lllllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999ppppppppppppppppppp8888888888888888888822222222222222222222llllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999ppppppppppppppppppp8888888888888888888822222222222222222222lllllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999ppppppppppppppppppp8888888888888888888822222222222222222222llllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa9999999999999999999pppppppppppppppppppp888888888888888888822222222222222222222lllllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888222222222222222222222lllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lllll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222llll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222lll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222ll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999999999999999ppppppppppppppppppp8888888888888888888822222222222222222222ll
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222l
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999999999999999ppppppppppppppppppp8888888888888888888822222222222222222222l
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp8888888888888888888822222222222222222222
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999999999999999999999ppppppppppppppppppp8888888888888888888822222222222222222222
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999999999999999999pppppppppppppppppppp888888888888888888882222222222222222222

__map__
800102030405060708090a0b0c0d0e0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101112131415161718191a1b1c1d1e1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
202122232425262728292a2b2c2d2e2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
303132333435363738393a3b3c3d3e3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
404142434445464748494a4b4c4d4e4f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
505152535455565758595a5b5c5d5e5f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
606162636465666768696a6b6c6d6e6f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
707172737475767778797a7b7c7d7e7f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
808182838485868788898a8b8c8d8e8f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
909192939495969798999a9b9c9d9e9f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0a1a2a3a4a5a6a7a8a9aaabacadaeaf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b0b1b2b3b4b5b6b7b8b9babbbcbdbebf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0c1c2c3c4c5c6c7c8c9cacbcccdcecf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d0d1d2d3d4d5d6d7d8d9dadbdcdddedf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e0e1e2e3e4e5e6e7e8e9eaebecedeeef00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
