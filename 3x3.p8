pico-8 cartridge // http://www.pico-8.com
version 29
__lua__





function _draw()
	local x,y
	cls()
	for i=0,127 do
		x=(i*4)%128
		y=9+(i*4)\128
		print3(chr(i),x,y*4,7)
	end
	for i=0,255 do
		if i>127 then
			x=(i*8)%128
			y=5+(i*8)\128
		else
			x=(i*4)%128
			y=9+(i*4)\128
		end
		print(chr(i),x,y*6-2,7)
	end
	print3("this 3x3 font is made with fillp",0,8,7)
	print3("that means its aligned to screen",0,12,7)
	print3("and so this is very hard to read",0,18,7)
	print3("it's surprisingly readable i say",0,24,7)
	print3("as long as coordinates are %4",0,28,7)
end

-->8
--3x3 font

fnt={
0b1111111111111111.1,--0
0b0011101100011111.1,--1
0b0011101110011111.1,--2
0b0001100100011111.1,--3
0b0101000111011111.1,--4
0b1001101100111111.1,--5
0b0111000100011111.1,--6
0b0001110111011111.1,--7
0b1001000100011111.1,--8
0b1111111111111111.1,--9
0b1111111111111111.1,--10
0b0011000100011111.1,--11
0b0001011100011111.1,--12
0b1111111111111111.1,--13
0b0001001100011111.1,--14
0b0001001101111111.1,--15
0b0001000100010001.1,--16
0b0001000100011111.1,--17
0b0001010100011111.1,--18
0b0101101101011111.1,--19
0b0101111101011111.1,--20
0b0101010101011111.1,--21
0b1011001110111111.1,--22
0b1011100110111111.1,--23
0b0001011101111111.1,--24
0b1101110100011111.1,--25
0b0101000110111111.1,--26
0b1111101111111111.1,--27
0b1111101111011111.1,--28
0b1111100110011111.1,--29
0b0101010111111111.1,--30 
0b1011010110111111.1,--31
0b1111111111111111.1,--32
0b0001111110111111.1,--33 !
0b0101010111111111.1,--34 "
0b0101000100010101.1,--35 #
0b0011101110011011.1,--36 $
0b0101101101011111.1,--37 %
0b0011000100011111.1,--38 &
0b1011011111111111.1,--39 
0b1011011110111111.1,--40 (
0b1011110110111111.1,--41 )
0b0101101101011111.1,--42 *
0b1011000110111111.1,--43 + 
0b1111101101111111.1,--44 ,
0b1111000111111111.1,--45 -
0b1111111110111111.1,--46 .
0b0111101111011111.1,--47 /
0b0001010100011111.1,--48 0
0b0011101100011111.1,--49 1
0b0011101110011111.1,--50 2
0b0001100100011111.1,--51 3
0b0101000111011111.1,--52 4
0b1001101100111111.1,--53 5
0b0111000100011111.1,--54 6
0b0001110111011111.1,--55 7
0b1001000100011111.1,--56 8
0b0001000111011111.1,--57 9
0b1011111110111111.1,--58 :
0b1011111100111111.1,--59 ;
0b1001011110011111.1,--60 <
0b0001111100011111.1,--61 =
0b0011110100111111.1,--62 >
0b0001110110111111.1,--63 ?
0b1011010100011111.1,--64 @
0b1011000101011111.1,--65 a
0b0011000100011111.1,--66
0b0001011100011111.1,--67
0b0011010100111111.1,--68
0b0001001100011111.1,--69
0b0001001101111111.1,--70
0b0011010100011111.1,--71
0b0101000101011111.1,--72
0b0001101100011111.1,--73
0b1101010100011111.1,--74
0b0101001101011111.1,--75
0b0111011100011111.1,--76
0b0001000101011111.1,--77
0b0001010101011111.1,--78
0b0001010100011111.1,--79
0b0001000101111111.1,--80
0b1011010110011111.1,--81
0b0001011101111111.1,--82
0b1001101100111111.1,--83
0b0001101110111111.1,--84
0b0101010100011111.1,--85
0b0101010110111111.1,--86
0b0101000100011111.1,--87
0b0101101101011111.1,--88
0b0101101110111111.1,--89
0b0011101110011111.1,--90 z
0b1001101110011111.1,--91 [
0b0111101111011111.1,--92 \
0b0011101100111111.1,--93 ]
0b1011010111111111.1,--94 ^
0b1111111100011111.1,--95 _
0b1011110111111111.1,--96 `
0b1011000101011111.1,--97 a
0b0011000100011111.1,--98
0b0001011100011111.1,--99
0b0011010100111111.1,--100
0b0001001100011111.1,--101
0b0001001101111111.1,--102
0b0011010100011111.1,--103
0b0101000101011111.1,--104
0b0001101100011111.1,--105
0b1101010100011111.1,--106
0b0101001101011111.1,--107
0b0111011100011111.1,--108
0b0001000101011111.1,--109
0b0001010101011111.1,--110
0b0001010100011111.1,--111
0b0001000101111111.1,--112
0b1011010110011111.1,--113
0b0001011101111111.1,--114
0b1001101100111111.1,--115
0b0001101110111111.1,--116
0b0101010100011111.1,--117
0b0101010110111111.1,--118
0b0101000100011111.1,--119
0b0101101101011111.1,--120
0b0101101110111111.1,--121
0b0011101110011111.1,--122z
0b1001001110011111.1,--123{
0b1011101110111111.1,--124|
0b0011100100111111.1,--125}
0b1101000101111111.1,--126
0b1011010110111111.1,--127
}


function print3(str,xx,yy,co)
	local x,y=xx,yy--xx\4*4,yy\4*4
	local oldfp=peek2(0x5f31)+peek(0x5f33)/2
	local i,c
	for i=1,#str do
		c=sub(str,i,i)
		fillp(fnt[ord(c)+1])
		rectfill(x+i*4-4,y,x+i*4+3-4,y+3,co)
	end
	fillp(oldfp)
end
__gfx__
00000000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
