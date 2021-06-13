pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
-- maybe chess
--[[
p=1
k=2
b=3
r=4
q=5
k=6
--]]

b={}
v={
{0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0}}
sx=0
sy=1
mfx=0
mfy=0
mtx=0
mty=0
move=0
wcap=0
bcap=0
input=""
movemode=0

function _init()
	reset_board()
	valids(sx,sy)
	poke(0x5f2d,0x1)
	
	
	poke4(0x5f10,0x8285.0100)
	poke4(0x5f14,0x0706.0506)
	poke4(0x5f18,0x058b.8608)
	poke4(0x5f1c,0x0f0e.0d0c)
end

function reset_board()
	b={
	{-4,-2,-3,-5,-6,-3,-2,-4},
	{-1,-1,-1,-1,-1,-1,-1,-1},
	{ 0, 0, 0, 0, 0, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 0},
	{ 0, 0, 0, 0, 0, 0, 0, 0},
	{ 1, 1, 1, 1, 1, 1, 1, 1},
	{ 4, 2, 3, 5, 6, 3, 2, 4}}
end

function _update60()

	if movemode==0 then
		if btnp(0) then
			sx=(sx-1)%8
			valids(sx,sy)
		end
		if btnp(1) then
			sx=(sx+1)%8
			valids(sx,sy)
		end
		if btnp(2) then
			sy=(sy-1)%8
			valids(sx,sy)
		end
		if btnp(3) then
			sy=(sy+1)%8
			valids(sx,sy)
		end
	else
		if btnp(0) then
			sx=(sx-1)%8
			mtx=sx+1
			mty=sy+1
		end
		if btnp(1) then
			sx=(sx+1)%8
			mtx=sx+1
			mty=sy+1
		end
		if btnp(2) then
			sy=(sy-1)%8
			mtx=sx+1
			mty=sy+1
		end
		if btnp(3) then
			sy=(sy+1)%8
			mtx=sx+1
			mty=sy+1
		end
	end
	if stat(30) then
		inp=stat(31)
		if inp=="\b" then
			input=sub(input,1,-2)
		elseif inp=="\t" and movemode==0 then
			mfx=sx+1
			mfy=sy+1
			mtx=sx+1
			mty=sy+1
			movemode=1
		elseif inp=="\t" and movemode==1 then
			mtx=sx+1
			mty=sy+1
			move=make_move(chr(mfx+96)..chr(mfy+48)..chr(mtx+96)..chr(mty+48))
			movemode=0
			valids(sx,sy)
		elseif inp=="\r" then
			if input=="reset" then
				reset_board()
				move=0
			elseif input=="help" then
				move=-2
			elseif input=="cl" then
				b[sy+1][sx+1]=0
			elseif input=="wp" then
				b[sy+1][sx+1]=-1
			elseif input=="wr" then
				b[sy+1][sx+1]=-4
			elseif input=="wh" then
				b[sy+1][sx+1]=-2
			elseif input=="wb" then
				b[sy+1][sx+1]=-3
			elseif input=="wq" then
				b[sy+1][sx+1]=-5
			elseif input=="wk" then
				b[sy+1][sx+1]=-6
			elseif input=="bp" then
				b[sy+1][sx+1]=1
			elseif input=="br" then
				b[sy+1][sx+1]=4
			elseif input=="bh" then
				b[sy+1][sx+1]=2
			elseif input=="bb" then
				b[sy+1][sx+1]=3
			elseif input=="bq" then
				b[sy+1][sx+1]=5
			elseif input=="bk" then
				b[sy+1][sx+1]=6
			else
				move=make_move(input)
			end
			input=""
			valids(sx,sy)
		else
			input=input..inp
		end
	end
end

function _draw()
	cls(0)
	draw_board(sx+1,sy+1)
	print("> ",0,94,6)
	if movemode==1 then
		print("  "..chr(mfx+96)..chr(mfy+48)..chr(mtx+96)..chr(mty+48),0,94,10)
	else
		print("  "..input,0,94,7)
	end
	if move==-1 then
		print(" invalid",0,100,8)
	elseif move==0 then
	
	elseif move==-2 then
		print("  move with arrows, tab to grab",0,94,9)
		print("you can also write your move",0,100,9)
		print("write reset to reset board",0,106,9)
		print(" p r h b q k  p r h b q k",0,112,9)
		print("w w w w w w ",0,112,7)
		print("             b b b b b b ",0,112,1)
		spr(17,0,118)
		spr(18,7,118)
		spr(19,15,118)
		spr(20,23,118)
		spr(21,31,118)
		spr(22,39,118)
		spr(1,0+52,118)
		spr(2,7+52,118)
		spr(3,15+52,118)
		spr(4,23+52,118)
		spr(5,31+52,118)
		spr(6,39+52,118)
	else
		print(" move: "..move,0,100,6)
	end
end


function draw_board(sx,sy)
	local x,y,p,c,c2
	rectfill(7,0,86,93,2)
	rectfill(0,7,93,86,2)
	circfill(7,7,7,3)
	circfill(86,7,7,3)
	circfill(7,86,7,3)
	circfill(86,86,7,3)
	circfill(8,8,8,2)
	circfill(85,8,8,2)
	circfill(8,85,8,2)
	circfill(85,85,8,2)
	for x=1,8 do
		for y=1,8 do
			c2=5-((x+y%2)%2)
			c=4+((x+y%2)%2)*5
			rectfill(7+(x-1)*10,7+(y-1)*10,6+x*10,6+y*10,c)
			
			if y==1 then
				print(chr(96+x),11+(x-1)*10,1,11)
				print(chr(96+x),11+(x-1)*10,88,11)
			end
			if x==1 then 
				print(y,2,10+(y-1)*10,11)
				print(y,89,10+(y-1)*10,11)
			end
			p=b[y][x]
			if p<0 then 
				p=abs(p)
				p=p+16
			end
			--print(p,6+(x-1)*16,6+(y-1)*16,c2)
			spr(abs(p),8+(x-1)*10,8+(y-1)*10)
			if v[y][x]==0 then
				rect(7+(x-1)*10,7+(y-1)*10,6+x*10,6+y*10,11-movemode)
			end
			if sx==x and sy==y then
				rect(7+(x-1)*10,7+(y-1)*10,6+x*10,6+y*10,7)
			end
		end
	end
end

function make_move(str)
	local fx,fy,tx,ty
	if #str==4 then
		fx=sub(str,1,1)
		fy=sub(str,2,2)
		tx=sub(str,3,3)
		ty=sub(str,4,4)
		fy=ord(fy)-48
		ty=ord(ty)-48
		if fy<1 or fy>8 then
			return -1
		end
		if ty<1 or ty>8 then
			return -1
		end
		fx=ord(fx)-96
		tx=ord(tx)-96
		if fx<1 or fx>8 then
			return -1
		end
		if tx<1 or tx>8 then 
			return -1
		end
		
		if validate(b[fy][fx],tx,ty,fx,fy)==-1 then
			return -1
		else 
			if b[ty][tx]==0 then
				b[ty][tx]=b[fy][fx]
				b[fy][fx]=0
			else
				if b[ty][tx]<0 and b[fy][fx]>0 then
					--white captures
					wcap=wcap+b[ty][tx]
				elseif b[ty][tx]>0 and b[fy][fx]<0 then
					--black captures
					bcap=bcap+b[ty][tx]
				elseif b[ty][tx]<0 and b[fy][fx]<0 then
					--both black
					return -1
				elseif b[ty][tx]>0 and b[fy][fx]>0 then
					--both white
					return -1
				end
				b[ty][tx]=b[fy][fx]
				b[fy][fx]=0
			end
		end
	else
		if str=="" then
			return 0
		else
			return -1
		end
	end
	return chr(fx+96)..chr(fy+48)..chr(tx+96)..chr(ty+48)
end

function validate(p,tx,ty,fx,fy)
	local res
	if p==0 then 
		res=-1
	elseif p==1 then 
		res=valid_wpawn(tx,ty,fx,fy)
	elseif p==-1 then 
		res=valid_bpawn(tx,ty,fx,fy)
	elseif p==2 or p==-2 then
		res=valid_knight(tx,ty,fx,fy)
	elseif p==3 or p==-3 then
		res=valid_bishop(tx,ty,fx,fy)
	elseif p==4 or p==-4 then
		res=valid_rook(tx,ty,fx,fy)
	elseif p==5 or p==-5 then
		res=valid_queen(tx,ty,fx,fy)
	elseif p==6 or p==-6 then
		res=valid_king(tx,ty,fx,fy)
	end
	if res==0 then 
		if b[ty][tx]>0 and p>0 then
			res=-1
		end
		if b[ty][tx]<0 and p<0 then	
			res=-1
		end
	end
	return res
end

function valids(sx,sy)
	local x,y
	for x=1,8 do
		for y=1,8 do
			v[y][x]=validate(b[sy+1][sx+1],x,y,sx+1,sy+1)
		end
	end
end

-->8
--chess validations


function valid_wpawn(tx,ty,fx,fy)
	if tx==fx then 
		if ty==fy-1 or (ty==fy-2 and fy==7) then
			return 0
		else
			return -1
		end
	elseif tx==fx+1 or tx==fx-1 then
		if ty==fy-1 then
			if b[ty][tx]<0 then
				return 0
			else
				return -1
			end
		else
			return -1
		end
	else
		return -1
	end
end

function valid_bpawn(tx,ty,fx,fy)
	if tx==fx then 
		if ty==fy+1 or (ty==fy+2 and fy==2) then
			return 0
		else
			return -1
		end
	elseif tx==fx+1 or tx==fx-1 then
		if ty==fy+1 then
			if b[ty][tx]>0 then
				return 0
			else
				return -1
			end
		else
			return -1
		end
	else
		return -1
	end
end

function valid_knight(tx,ty,fx,fy)
	if tx==fx-1 or tx==fx+1 then 
		if ty==fy-2 or ty==fy+2 then
			return 0
		else
			return -1
		end
	elseif tx==fx-2 or tx==fx+2 then 
		if ty==fy-1 or ty==fy+1 then
			return 0
		else
			return -1
		end
	else
		return -1
	end
end

function valid_rook(tx,ty,fx,fy)
	local i,occu,y
	if tx==fx and ty!=fy then
		if ty>fy then
			y=ty
			occu=0
			while y>fy do
				if b[y][fx]!=0 then
					occu=occu+1
				end
				if b[y][fx]==0 and occu==0 then
					occu=occu+1
				end
				y=y-1
			end
			if occu<2 then
				return 0
			else
				return -1
			end
		elseif ty<fy then
			y=fy
			occu=0
			while y>ty do
				if b[y][fx]!=0 then
					occu=occu+1
				end
				if b[y][fx]==0 and occu==0 then
					occu=occu+1
				end
				y=y-1
			end
			if occu<2 then
				return 0
			else
				return -1
			end
		end
	elseif ty==fy and tx!=fx then 
		if tx>fx then
			y=tx
			occu=0
			while y>fx do
				if b[fy][y]!=0 then
					occu=occu+1
				end
				if b[fy][y]==0 and occu==0 then
					occu=occu+1
				end
				y=y-1
			end
			if occu<2 then
				return 0
			else
				return -1
			end
		elseif tx<fx then
			y=fx
			occu=0
			while y>tx do
				if b[fy][y]!=0 then
					occu=occu+1
				end
				if b[fy][y]==0 and occu==0 then
					occu=occu+1
				end
				y=y-1
			end
			if occu<2 then
				return 0
			else
				return -1
			end
		end
	else
		return -1
	end
end

function valid_bishop(tx,ty,fx,fy)
	local i,occu,x,y,res
	if tx-ty==fx-fy then
		if tx>fx then
			x=fx
			y=fy
			occu=0
			while x<tx do
				if b[y][x]!=0 and x!=fx and y!=fy then
					occu=occu+1
				end
				if b[y][x]==0 and occu>0 then
					occu=occu+1
				end
				x=x+1
				y=y+1
			end
			if occu<1 then
				res=0
			else
				res=-1
			end
		elseif tx<fx then
			x=fx
			y=fy
			occu=0
			while x>tx do
				if b[y][x]==0 and occu>0 then
					occu=occu+1
				end
				if b[y][x]!=0 and x!=fx and y!=fy then
					occu=occu+1
				end
				x=x-1
				y=y-1
			end
			if occu<1 then
				res=0
			else
				res=-1
			end
		else
			res=-1
		end
	elseif tx+ty==fx+fy then
		if tx>fx then
			x=fx
			y=fy
			occu=0
			while x<tx do
				if b[y][x]!=0 and x!=fx and y!=fy then
					occu=occu+1
				end
				if b[y][x]==0 and occu>0 then
					occu=occu+1
				end
				x=x+1
				y=y-1
			end
			if occu<1 then
				res=0
			else
				res=-1
			end
		elseif tx<fx then
			x=fx
			y=fy
			occu=0
			while x>tx do
				if b[y][x]==0 and occu>0 then
					occu=occu+1
				end
				if b[y][x]!=0 and x!=fx and y!=fy then
					occu=occu+1
				end
				x=x-1
				y=y+1
			end
			if occu<1 then
				res=0
			else
				res=-1
			end
		else
			res=-1
		end
	else
		res=-1
	end
	return res
end

function valid_queen(tx,ty,fx,fy)
	if valid_rook(tx,ty,fx,fy)==0 or valid_bishop(tx,ty,fx,fy)==0 then
		return 0
	else
		return -1
	end
end

function valid_king(tx,ty,fx,fy)
	if tx-1==fx or tx+1==fx or tx==fx then
		if ty-1 ==fy or ty+1==fy or ty==fy then	
			if ty==fy and tx==fx then	
				return -1
			else
				return 0
			end
		end
	end
	return -1
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000100000000000000000000010010001000010000000000000000000000000000000000000000000000000000000000000000000000000
00000000000110000001110000011000001001000010010001100110000000000000000000000000000000000000000000000000000000000000000000000000
00000000000110000011110000011000001111000111111001111110000000000000000000000000000000000000000000000000000000000000000000000000
00000000000110000000110000111100001111000011110000111100000000000000000000000000000000000000000000000000000000000000000000000000
00000000000110000001110000011000001111000011110000111100000000000000000000000000000000000000000000000000000000000000000000000000
00000000001111000011110000111100001111000011110000111100000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000700000000000000000000070070007000070000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000007770000077000007007000070070007700770000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000077770000077000007777000777777007777770000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000000770000777700007777000077770000777700000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000007770000077000007777000077770000777700000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000077770000777700007777000077770000777700000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000illlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllli000000000000000000000000000000000000000
000illlllll555lllllll555llllllll55lllllll55llllllll555lllllll555llllllll55lllllll5l5lllllli0000000000000000000000000000000000000
00illllllll5l5lllllll5l5lllllll5lllllllll5l5lllllll5lllllllll5lllllllll5lllllllll5l5llllllli000000000000000000000000000000000000
0illlllllll555lllllll55llllllll5lllllllll5l5lllllll55llllllll55llllllll5lllllllll555lllllllli00000000000000000000000000000000000
0llllllllll5l5lllllll5l5lllllll5lllllllll5l5lllllll5lllllllll5lllllllll5l5lllllll5l5lllllllll00000000000000000000000000000000000
illllllllll5l5lllllll555llllllll55lllllll555lllllll555lllllll5lllllllll555lllllll5l5llllllllli0000000000000000000000000000000000
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmm7mmmm6666666666mmm7mm7mmm6676666766mmmmmmmmmm6666676666mmmmmmmmmmlllllll0000000000000000000000000000000000
ll55lll6667667666mmmm777mmm6666776666mmm7mm7mmm6677667766mmmm77mmmm6666777666mmm7mm7mmmll55lll0000000000000000000000000000000000
lll5lll6667777666mmm7777mmm6666776666mm777777mm6677777766mmmm77mmmm6667777666mmm7777mmmlll5lll0000000000000000000000000000000000
lll5lll6667777666mmmmm77mmm6667777666mmm7777mmm6667777666mmm7777mmm6666677666mmm7777mmmlll5lll0000000000000000000000000000000000
lll5lll6667777666mmmm777mmm6666776666mmm7777mmm6667777666mmmm77mmmm6666777666mmm7777mmmlll5lll0000000000000000000000000000000000
ll555ll6667777666mmm7777mmm6667777666mmm7777mmm6667777666mmm7777mmm6667777666mmm7777mmmll555ll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm7777777777mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm7666666667mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm7666666667mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
ll555llmmmm77mmmm6666776666mmmm77mmmm7666776667mmmm77mmmm6666776666mmmm77mmmm6666776666ll555ll0000000000000000000000000000000000
llll5llmmmm77mmmm6666776666mmmm77mmmm7666776667mmmm77mmmm6666776666mmmm77mmmm6666776666llll5ll0000000000000000000000000000000000
ll555llmmmm77mmmm6666776666mmmm77mmmm7666776667mmmm77mmmm6666776666mmmm77mmmm6666776666ll555ll0000000000000000000000000000000000
ll5llllmmmm77mmmm6666776666mmmm77mmmm7666776667mmmm77mmmm6666776666mmmm77mmmm6666776666ll5llll0000000000000000000000000000000000
ll555llmmm7777mmm6667777666mmm7777mmm7667777667mmm7777mmm6667777666mmm7777mmm6667777666ll555ll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm7666666667mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm7777777777mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm666666666655555555556666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
ll555ll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmll555ll0000000000000000000000000000000000
llll5ll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmllll5ll0000000000000000000000000000000000
lll55ll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmlll55ll0000000000000000000000000000000000
llll5ll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmllll5ll0000000000000000000000000000000000
ll555ll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmll555ll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm66666666665mmmmmmmm56666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm666666666655555555556666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm5555555555mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
ll5l5llmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll5l5ll0000000000000000000000000000000000
ll5l5llmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll5l5ll0000000000000000000000000000000000
ll555llmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll555ll0000000000000000000000000000000000
llll5llmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666llll5ll0000000000000000000000000000000000
llll5llmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666llll5ll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm5666666665mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm5555555555mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
ll555ll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmll555ll0000000000000000000000000000000000
ll5llll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmll5llll0000000000000000000000000000000000
ll555ll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmll555ll0000000000000000000000000000000000
llll5ll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmllll5ll0000000000000000000000000000000000
ll555ll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmll555ll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
ll5llllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll5llll0000000000000000000000000000000000
ll5llllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll5llll0000000000000000000000000000000000
ll555llmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll555ll0000000000000000000000000000000000
ll5l5llmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll5l5ll0000000000000000000000000000000000
ll555llmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666ll555ll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
ll555ll6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmmll555ll0000000000000000000000000000000000
llll5ll6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmmllll5ll0000000000000000000000000000000000
llll5ll6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmmllll5ll0000000000000000000000000000000000
llll5ll6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmm6666116666mmmm11mmmmllll5ll0000000000000000000000000000000000
llll5ll6661111666mmm1111mmm6661111666mmm1111mmm6661111666mmm1111mmm6661111666mmm1111mmmllll5ll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllll6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmmlllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666616666mmmmmmmmmm6661661666mm1mmmm1mm6666666666mmmmm1mmmm6666666666lllllll0000000000000000000000000000000000
ll555llmmm1mm1mmm6666111666mmmm11mmmm6661661666mm11mm11mm6666116666mmmm111mmm6661661666ll555ll0000000000000000000000000000000000
ll5l5llmmm1111mmm6661111666mmmm11mmmm6611111166mm111111mm6666116666mmm1111mmm6661111666ll5l5ll0000000000000000000000000000000000
ll555llmmm1111mmm6666611666mmm1111mmm6661111666mmm1111mmm6661111666mmmmm11mmm6661111666ll555ll0000000000000000000000000000000000
ll5l5llmmm1111mmm6666111666mmmm11mmmm6661111666mmm1111mmm6666116666mmmm111mmm6661111666ll5l5ll0000000000000000000000000000000000
ll555llmmm1111mmm6661111666mmm1111mmm6661111666mmm1111mmm6661111666mmm1111mmm6661111666ll555ll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
lllllllmmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666mmmmmmmmmm6666666666lllllll0000000000000000000000000000000000
llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0000000000000000000000000000000000
illllllllll555lllllll555llllllll55lllllll55llllllll555lllllll555llllllll55lllllll5l5llllllllli0000000000000000000000000000000000
0llllllllll5l5lllllll5l5lllllll5lllllllll5l5lllllll5lllllllll5lllllllll5lllllllll5l5lllllllll00000000000000000000000000000000000
0illlllllll555lllllll55llllllll5lllllllll5l5lllllll55llllllll55llllllll5lllllllll555lllllllli00000000000000000000000000000000000
00illllllll5l5lllllll5l5lllllll5lllllllll5l5lllllll5lllllllll5lllllllll5l5lllllll5l5llllllli000000000000000000000000000000000000
000illlllll5l5lllllll555llllllll55lllllll555lllllll555lllllll5lllllllll555lllllll5l5lllllli0000000000000000000000000000000000000
00000illlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllli000000000000000000000000000000000000000
60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
06000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
