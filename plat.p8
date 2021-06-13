pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
-- some platformer






b=0
bt=0
bp=0

b2=0
bt2=0
bp2=0

parallax=0

function _init()
	new_player(64,64,0,0,11,100,0,0)
end

function _update60()
	update_keys()
	update_ids()
	foreach(part,update_part)
	foreach(player,update_player)
end

function _draw()
	local i,x,y
	cls(1)
	debug_keys()
	draw_part(0)
	foreach(player,draw_player)
	for i=0,1 do
		x=-1+i*129
		y=rnd(128)
		new_part(2,x,y,0,0,7,40,1,1,0)
	end
end


function update_keys()
	b={d=btn(),p=btnp()}
	bt={l=b.d&0b1,r=(b.d&0b10)>>1,u=(b.d&0b100)>>2,d=(b.d&0b1000)>>3,z=(b.d&0b10000)>>4,v=(b.d&0b100000)>>5}
	bp={l=b.p&0b1,r=(b.p&0b10)>>1,u=(b.p&0b100)>>2,d=(b.p&0b1000)>>3,z=(b.p&0b10000)>>4,v=(b.p&0b100000)>>5}
	b2={d=btn()>>>8,p=btnp()>>>8}
	bt2={l=b2.d&0b1,r=(b2.d&0b10)>>1,u=(b2.d&0b100)>>2,d=(b2.d&0b1000)>>3,z=(b2.d&0b10000)>>4,v=(b2.d&0b100000)>>5}
	bp2={l=b2.p&0b1,r=(b2.p&0b10)>>1,u=(b2.p&0b100)>>2,d=(b2.p&0b1000)>>3,z=(b2.p&0b10000)>>4,v=(b2.p&0b100000)>>5}
end

function debug_keys()
	local p1str,p2str
	print(b.d,0,0,7)
	print("    ⬅️➡️⬆️⬇️🅾️❎",0,6,5)
	print("    ⬅️➡️⬆️⬇️🅾️❎",0,12,5)
	p1str="p1: "
	p2str="p2: "
	if bt.l==1 then p1str=p1str.."⬅️" else p1str=p1str.."  " end
	if bt.r==1 then p1str=p1str.."➡️" else p1str=p1str.."  " end
	if bt.u==1 then p1str=p1str.."⬆️" else p1str=p1str.."  " end
	if bt.d==1 then p1str=p1str.."⬇️" else p1str=p1str.."  " end
	if bt.z==1 then p1str=p1str.."🅾️" else p1str=p1str.."  " end
	if bt.v==1 then p1str=p1str.."❎" else p1str=p1str.."  " end
	if bt2.l==1 then p2str=p2str.."⬅️" else p2str=p2str.."  " end
	if bt2.r==1 then p2str=p2str.."➡️" else p2str=p2str.."  " end
	if bt2.u==1 then p2str=p2str.."⬆️" else p2str=p2str.."  " end
	if bt2.d==1 then p2str=p2str.."⬇️" else p2str=p2str.."  " end
	if bt2.z==1 then p2str=p2str.."🅾️" else p2str=p2str.."  " end
	if bt2.v==1 then p2str=p2str.."❎" else p2str=p2str.."  " end
	print(p1str,0,6,12)
	print(p2str,0,12,8)
	p1str="    "
	p2str="    "
	if bp.l==1 then p1str=p1str.."⬅️" else p1str=p1str.."  " end
	if bp.r==1 then p1str=p1str.."➡️" else p1str=p1str.."  " end
	if bp.u==1 then p1str=p1str.."⬆️" else p1str=p1str.."  " end
	if bp.d==1 then p1str=p1str.."⬇️" else p1str=p1str.."  " end
	if bp.z==1 then p1str=p1str.."🅾️" else p1str=p1str.."  " end
	if bp.v==1 then p1str=p1str.."❎" else p1str=p1str.."  " end
	if bp2.l==1 then p2str=p2str.."⬅️" else p2str=p2str.."  " end
	if bp2.r==1 then p2str=p2str.."➡️" else p2str=p2str.."  " end
	if bp2.u==1 then p2str=p2str.."⬆️" else p2str=p2str.."  " end
	if bp2.d==1 then p2str=p2str.."⬇️" else p2str=p2str.."  " end
	if bp2.z==1 then p2str=p2str.."🅾️" else p2str=p2str.."  " end
	if bp2.v==1 then p2str=p2str.."❎" else p2str=p2str.."  " end
	print(p1str,0,6,7)
	print(p2str,0,12,7)
end
-->8
-- player stuff

c_grounded =0b00000001
c_wall     =0b00000010
c_rwall    =0b00000100
c_lwall    =0b00001000

player={{i=0, --index
         x=0, --position
         y=0,
         xv=0,--speed
         yv=0,
         c=0, --color
         l=0, --life
         d=0,
         t=0, --state
         pc=0,
         dead=1}}
        
        
        
function update_player(p)
	if p.dead==0 then 
		parallax=p.xv*4
		p.xv=p.xv*(0.95-0.05*(p.t&c_grounded))+(bt.r-bt.l)*0.2
		if p.t&c_wall!=c_wall then
			p.yv=p.yv+0.1
		else
			p.yv=0
		end
		if p.yv>0 then
			p.yv=p.yv-bp.u*3
		else
			p.yv=p.yv
		end--*(p.t&c_grounded+p.t&c_wall>>1)
		if p.y+p.yv>128 then 
			p.t=p.t|c_grounded
		else
			p.t=p.t&~c_grounded
		end
		if p.x+p.xv<128 and p.x+p.xv>0 then
			p.t=p.t&~c_wall
		else
			p.t=p.t|c_wall
		end
		if p.x+p.xv<128 then
			p.t=p.t&~c_rwall
		else
			p.t=p.t|c_rwall
		end
		if p.x+p.xv>0 then 
			p.t=p.t&~c_lwall
		else
			p.t=p.t|c_lwall
		end
		if p.t&c_grounded==c_grounded then
			if p.yv>1 then
				p.yv=-p.yv*(0.5+0.6*bt.v)
			else
				p.yv=0
			end
		end
		if p.t&c_wall==c_wall then
			p.xv=0
		end
		p.x=p.x+p.xv
		p.y=p.y+p.yv
			
	else
	-- death related stuff
		deli(player,p.i)
	end
end

function draw_player(p)
	pset(p.x,p.y,p.c)
	if p.t&c_grounded==c_grounded then
		pset(p.x,p.y-1,8)
	end
	if p.t&c_rwall==c_rwall then
		pset(p.x-1,p.y,9)
	end
	if p.t&c_lwall==c_lwall then
		pset(p.x+1,p.y,9)
	end
end


function new_player(x,y,xv,yv,c,l,t,pc)
	add(player,{i =0,
	    x =x,
	    y =y,
	    xv=xv,
	    yv=yv,
	    c =c,
	    l =l,
	    d =0,
	    t =t,
	    pc=pc,
	    dead=0},
	    #player+1)
end
-->8
-- id stuff

function update_ids()
	local ii
	for ii=1,#player do
		player[ii].i=ii
	end
	for ii=1,#part do
		part[ii].i=ii
	end
end


-->8
-- particles


-- color values the particle
-- goes through
-- particles are removed at 0
-- the sequence loops at -1
firegrad={ 7,10, 9, 9, 9, 8, 8, 8, 2, 2,2,2,0}
smokgrad={ 7, 6,12,12,12, 5, 5, 5, 1, 1,1,1,0}
specgrad={10, 9, 9, 9, 9, 9, 4, 4, 4, 4,4,0}
spe2grad={ 8, 8,13,13,13,13, 2, 2, 2, 2,2,0}
stargrad={ 1, 1, 1, 5, 6, 1, 1, 1, 1, 1,1,6,5,1,1,1,1,1,1,6,6,5,5,5,1,1,1,1,5,1,1,1,1,1,1,1,1,1,1,1,-1}
astegrad={ 2, 2, 2, 2, 5, 5, 5, 5, 5, 5,1,5,1,5,1,5,1,5,1,5,1,5,1,1,1,1,1,0}
shipgrad={ 7, 7,11,11,11,11,11,11,11,11,3,3,3,3,3,3,3,3,1,3,1,3,1,1,1,1,1,0}


part={{i=0,  -- index
       t=0,  -- type
       x=0,  -- position
       y=0,
       xv=0, -- speed
       yv=0,
       c=0,  
       l=0,
       d=0,
       o=0,
       la=0}}
pa={}


function draw_part(layer)
	for pa in all(part) do
		if pa.la==layer and (max(0,pa.c)%16)!=0 then
			if pa.o==1 then
				line(pa.x,pa.y,pa.x-pa.xv,pa.y-pa.yv,min(15,max(0,pa.c))\2)
			end
		end
	end
	for pa in all(part) do
		if pa.la==layer and (max(0,pa.c)%16)!=0 then
		pset(pa.x,pa.y,min(15,max(0,pa.c)))
		end
	end
end



function update_part(pa)
	pa.x=pa.x+pa.xv
	pa.y=pa.y+pa.yv
	
	if pa.t==0 then     -- fire
		pa.c=firegrad[pa.l]
		pa.xv=pa.xv*0.9
		pa.yv=pa.yv
	elseif pa.t==1 then -- spec
		pa.c=specgrad[pa.l]
		pa.xv=pa.xv*0.9
		pa.yv=pa.yv*0.9
	elseif pa.t==2 then -- star
		pa.c=stargrad[pa.l]
		pa.yv=pa.yv
		pa.xv=-parallax
		pa.la=pa.d\8
	elseif pa.t==3 then -- aste
		pa.c=astegrad[pa.l]
		pa.xv=pa.xv*1
		pa.yv=pa.yv*1+0.01
	elseif pa.t==4 then -- smoke
		pa.c=smokgrad[pa.l]
		pa.xv=pa.xv*0.9
		pa.yv=pa.yv
	elseif pa.t==5 then -- ship
		pa.c=shipgrad[pa.l]
		pa.xv=pa.xv*1.1
		pa.yv=pa.yv*1.1
	elseif pa.t==6 then -- spec
		pa.c=spe2grad[pa.l]
		pa.xv=pa.xv*0.9
		pa.yv=pa.yv*0.9
	else
		pa.c=0
	end
	if pa.c==0 or pa.l>99 or pa.x>130 or pa.x<-2 then 
		deli(part,pa.i)
	end
	pa.l=pa.l+1
	if pa.c==-1 then 
		pa.l=0
	end
end 



function new_part(t,x,y,xv,yv,c,l,d,o,la)
	add(part,{i =0,
	    t=t,
	    x=x,
	    y=y,
	    xv=xv,
	    yv=yv,
	    c=c,
	    l=l,
	    d=d,
	    o=o,
	    la=la},
	    #part+1)
end
__gfx__
bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b5555555555555555555555b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555555555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555555555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555555555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000550555555550500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
77711111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11711111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
77711111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
71111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
77711111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
ccc1cc1111111111155555111ccccc11155555111555551115555511155555111111111111111111111111111111111111111111111111111111111111111111
c1c11c111c11111155511551cc11ccc1555155515511155155111551551515511111111111111111111111111111111111111111111111111111111111111111
ccc11c111111111155111551cc111cc1551115515511155155151551555155511111111111111111111111111111111111111111111111111111111111111111
c1111c111c11111155511551cc11ccc1551115515551555155111551551515511111111111111111111111111111111111111111111111111111111111111111
c111ccc111111111155555111ccccc11155555111555551115555511155555111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
88818881111111111555551115555511155555111555551115555511155555111111111111111111111111111111111111111111111111111111111111111111
81811181181111115551155155115551555155515511155155111551551515511111111111111111111111111111111111111111111111111111111111111111
88818881111111115511155155111551551115515511155155151551555155511111111111111111111111111111111111111111111111111111111111111111
81118111181111115551155155115551551115515551555155111551551515511111111111111111111111111111111111111111111111111111111111111111
81118881111111111555551115555511155555111555551115555511155555111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111b11111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
