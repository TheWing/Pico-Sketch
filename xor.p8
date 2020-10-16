pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
scrstart=0x6000
scrend=0x7fff
t=0
b=0
c=0
p=0
p1=0
p2=0
po=0

poke(0x5f40,0b1111)
//music(0)

function _init()
	poke4(0x5f10,0x8301.8100)
	poke4(0x5f14,0x8e08.888d)
	poke4(0x5f18,0x070f.0a09)
	poke4(0x5f1c,0x8085.050d)
	poke(0x5f2e,0)
	
end

function _draw()
-- if b!=0x000 then
	memcpy(0x1000,0x6000,0x2000)
	
	efu_smear()
	for mem=scrstart,scrend do
		c=((mem%64)^^(mem>>>7))*0.4--(1+sin(t)*8)
		p=@(mem)
		p1=(p>>>4)\b
		p2=((p\12)|((c\8)*(b))\4)|(p2&b&c)
		po=((p2&0b1111)<<4)|(p2&0b1111)
		poke(mem,po)//(((p1\1)<<4)|p2)) 
	end
	if btn()==0 then 
--		rectfill(0,0,52,6,0)
--		print("press buttons",1,1,8)
	end
end

function efu_smear()
	local i
	for i=1,127 do
		smcpy(0x6000+i*63+(2-rnd(3)),0x1000+i*63,128)
	end
end

function _update60()
  b=btn()
end


function smcpy(to_mem,fr_mem,len)
	if to_mem<0x6000 then to_mem=0x6000 end
	if to_mem>0x7ffe then
		to_mem=0x7ffe
		len=1
	end
	if to_mem+len>0x7fff then len=0x7fff-to_mem end
	if fr_mem>0x7ffe then
		fr_mem=0x7ffe
		len=1
	end
	if fr_mem+len>0x7fff then len=0x7fff-fr_mem end
	memcpy(to_mem,fr_mem,len)
end


function efu_fade()
	local i
	for i=1,127 do
		memcpy(0x6000+i*63,0x1000+i*63,128)
	end
end


__label__
0000000000000000000000000000000000000000000000000000091515151505050505052ca8a8a8a8a8a8a8a8a89094949494848484c484aca8a8a8a8a8a4a4
08880888088800880088000008880808088808880088088000880515151515050505050564a8a8a8a8a8a8a8a8a8949494948484848484a4a8a8a8a8a8a8a4a4
08080808080008000800000008080808008000800808080808000905151505150505050d8428a8a8a8a8a8a8a8a09894949484948484848ca4a8a8a8a8a8a4a4
088808800880088808880000088008080080008008080808088809051515051505050505a468a8a8a8a8a8a8a8a49894949484848484b488a4a8a8a8a8a8a4a4
080008080800000800080000080808080080008008080808000809251505151505050509a8a42ca8a8a8a8a88088a8a49484949484848488a8a4aca8a8a8b4a4
080008080888088008800000088800880080008008800808088009251505151504050509a8a464a8a8a8a8a88488a8a48484949444b48488a8a4a8a8a8a8a4a4
000000000000000000000000000000000000000000000000000009250515151505050509989c8428a8a8a8a09898a8a48494949484c48488a8acb4b8a8888494
454545455555454545555555454545490d05352929292925190929250515151505050509a4a4a468a8a8a8a48888a8a484849494b4848488a8a8a4a8a8888484
45455555554545454545454555555549290905052539292515151509292901152ca8a8a405050509a8a88088a8a8a8a48484848494848488a8a8a8a4a8b89494
45455555554545454545454555455549290905252d292925151515092929051524a8a8a405050509a8a88488a8a8a8a4848084b494948488a8a8a8a4a8989494
454555554555454545454545555545592929050515292925151505192929190d8428a8a405050509a8a08888a8a8a8a48484848494948488a8a8a8acb4989494
4545555545554545454545455555455929290d05352929251515051929251505a408888405050509a8a48888a8a8a8a48484b48494948488a8a8a8a8a4989494
5555454545455545454545455545555929292909051525351505151909192929a8841c94050505098098a8a8a8a8a8a48484848494848488a8a8a8a8a8949494
555545054545554545454545554555592929290905352d251505151905192929a0a424a4050505098488a8a8a8a8a8a484b4848484848488a8a8a88888b4b4b4
5555454545454555454545454555555929292929051515050505151919092909989c8404050505018888a8a8a8a8a8a48484848484848488a8a8a8a8a8a8b4b4
55554545454545454545454545555559292929290d0515050515151519092929a4848404050505058888a8a8a8a8a8a4b484848484848488a8a8a8a8a8949494
5555554545454545554545454545455929290915151515052539292929292929a8a8a8a8a8a8909405050505eca8a8a4aca8a8a8a8a8a8a49494948484848484
5555554545454515554545454545455929290515151515052d29292929292929a8a8a8a8a8a894940505050564a8a8a4a8a8a8a8a8a8a8a494948484848484b4
5555455545454545455545454545554929291905151505151529292929292929a8a8a8a8a8a088840505050da4e8a8aca4a8a8a8a8a8a8a494948494848484c4
5555454545454545455545454545554929251905151505153529292929292929a8a8a8a8a8a4888405050505a468a8a8a4a8a8a8a8a8a8a4949484848484b484
5545555545454545454555455555656909192925150515190515253929292929a8a8a8a88088a8a405050509a8a4eca8a8a4aca8a8a8a8a49484949484848484
5545554545454545454555454555656905192925150515190535292929292929a8a8a8a88488a8a405050509a8a464a8a8a4a8a8a8a8a8a48484949084b48484
4555555545454545454545555545454919092925051515190515152929292929a8a8a8a08888a8a405050509988ca4e8a8acb4b8a8a8a8b48494949484848484
4555555545354545454545555545454519092925051515190905352929292929a8a8a8a48888a8a405050509a4a4a468a8a8a4a8a8a8a8a484849494b4848484
4545454555555545454555555545454515151509292909192909050525392929a8a88088a8a8a8a42ca8a8a405050509a8aca8a4aca8a8a48484848494949484
4545450555455545454545555545454515151509292905192909052529292929a8a88488a8a8a8a464a8a8a405050509a8a8a8a4a8a8a8a4848484b494948484
4545454555554555454555554555454515150519292919092929050515292929a8a08888a888888c8428a8a405050509a8a8a8aca4a8a8a48484848494948494
4545454555554545454555454555454515150519292519092929090535292929a8a48888a8a8a4a4a468a8a405050509a8a8a8a8a4a8a8a48484b48494948484
45454545554555555555454545455545150515190919292929292909051525398088a8a8a8a8a8a8a884149005050509a8a8a8a8a8a4aca48484848494849494
45454545554555554555454545455545150515190519292929292909053529298488a8a8a8a8a8a8a8a464a405050509a8a8a8a8a8a4a8a484b4848484849494
45454545455555555555454545454545051515191909292929292929051515018888a8a8a8a8a898888cb4f405050509a8a8a8a8a8acb4b48484848484949494
45454545455555555545454545454555051515151909292929292929090515058888a8a8a8a8a8a8a4b4b47405050509a8a8a8a8a8b8b4b4b484848484849494
35392929292929292929111515151505554545454545455555555545454545459494948484848484aca8a8a8a8a8a8a405050505eca8a8a8a8a8a8a8a8a89494
3d292929292929292929051515051505554545454545455555555545454545459494948484c48484a8a8a8a8a8a8a8a4050505e464a8a8a8a8a8a8a8a8989494
1539292929292929292919151515051545454545454555455555454545454545949484948484848ca4a8a8a8a8a8aca40505050da4e8a8a8a8a8a8a8a8a49c94
3539292929292929292519051515051545554545454555155555455545454d459494849484848488a4a8a8a8a8a8a8a40505f405a468a8a8a8a8a8a098a48888
05153539292929291919292515051515454555454555454555455545454545459484949484848488a8a4aca8a8a8a8a405050509a8a4eca8a8a8a8a88488a888
05352029292929290519292515051515454555454555454555455555454545459484949484848488a8a4a8a8a8a8a8a405f40509a8a46ca8a8a8a8a88488a088
05151539292929291919292505151515454545555545454545455555453545458494949484848488a8acb4b8a8a8a8a405050509989cb4f8a8a8a8a088c8a8a8
0d053539292929251909292505151515454545555545454545555555454545458494949484848488a8a8a4a8a8a8a8a4f4050509a4a4a468a8a8a8a4888898a8
29090505353929251515150929290515450545555545454545454505554555458480848494848488a8a8a8a4aca8a8a4eca8a8a405050509a8a88088a8a8a8a8
290905253d2929251515150929290515454545555545454545454545555555458484848494949488a8a8a8a4a8a8a8a464a8a8a4050505f8a8888488a8a8a8a8
29290505153929251515051929291505454555454555454545454545555545558484848494948488a8a8a8acb498989ca4e8a8a405050509a8a08888a8a8a8a8
29290d05353929251515051929251505454555454555454545454545555545558484848494948488a8a8a8a8a4a8a4a4a468a8a40505f40998a48888a8a8a8a8
29292909051535350505151919190505455545454545554145454545554555558484848494848488a8a8a8a8a8a4aca8a894dc94050505098088a8a8a8a8a8a8
2929290905353d251505151905190505455545454545554545454545554555554484848494848488a8a8a8a8a8a4a8a8a8a464a405f405098488a898a8a8a8a8
29292929051515350515151919090505554545454545455545454545455555558484848484848488a8a8a8a8a8aca4a8a0a0b4f4050505019898a8a8a8a8a8a8
292929290d0535350515151519090505554545454545455545454545455555558484848484848488a8a8a8a8a8a8a4a8a4b4b474f4050505888898a8a8a8a8a8
2929191515151505353929292909050555555545454545455545454545454d55aca8a8a8a8a8a8a49494948484848488a8a8a8a8a8a8909405050505e0a8a8a8
29291515151515082d2929292909050555555545454545455545454545454555a8a8a8a8a8a8a8a49494948484848488a8a8a8a8a0989494050505e46ca8a8a8
292919151515051515392929290905055555455545454545454545454535554da4a8a8a8a8a8a8a49494849484848488a8a8a8a8a8a0989405050501a42ca8a8
2925191515150505352929292909050555554555454545454555454545455549a4a8a8a8a8a8a8a49494849484848488a8a8a8a898a488840505f40da468a8a8
191929250505151905153539290905055545555545454545454555454555656988a4aca8a8a8b8a49484949084848488a8a8a8a88088a8a405050509a8a4e0b8
151929251505151905352d292909050555455555454545454545554545556569a8a4a8a8a8a8a8a49484949484848488a8a8a8a88488a89405f40509a8a46ca8
0919292505151519051515392909051545455555454545454545454555456569a8aca4a8a8a8a8b48494949484848488a8a8a8a09898a8a405050509b0b0b4f4
19192925051515190d0535292909051545555555454545454545455555456569a8a8a4a8a8a8a8a48494949484848488a8a8a8a4888898a4f4050509acbcb474
1515150929291919290905053519051545454545555555414545455555456569a8a8a8a4aca8a8a48484848494848488a8a88088a8a8a8a4eca8a8a405050505
1515150929291519290905252d09051545454545555555454545455555456569a8a8a8a4a8a8a8a48484848494949488a8888488a8a8a8a46ca8a8a4050505f4
1515051929291919292905051509051545454545555545554545554545556569a8a8a8aca4a8a8a48484848494948488a8a08888a888888ca4e8a8a405050505
151505192925190c29290d053509051545454545555545554545554545556569a8a8a8a8a4a8a8a4848484849494848898a48888a0a8acaca468a8a40505f405
1505151919192929292929090515051545054545554555554555450545457569a8a8a8a8a8a4aca484848484948484888088a8a8a8a8a8a8a894dc9405050505
1505151915192929292929090515051545454545554555514555454545457569a8a8a8a8a8a4a8a484848484948484888488a898a8a8a8a8a8a464a005f40505
0515151919192929292929290515150545454545455555555545454545456579a8a8a8a8acac848484848484849484809898a8a8a8a8a898989cb4f405050505
0505151519192929292929290d05050545454545455555555515454545456579a8a8a8a8a8b8b4b48484848484948484888898a8a8a8a8a8acbcb474f4050505
05050505e4eca8a8a8a8a8a8a8a898949494948484848484a4a8a8a8a88884845545454545454555555555454545454535292929292929292929111515151505
05050504e0a8a8a8a8a8a8a8a8a894949494948484848484a8a8a8a8a88884845545454545355555555555454545454539292929292929292919051515150505
05050505c4ecaca8a8a8a8a8a8a888949494849484848484a4a8a8a8a88884844555454545455545555545554545454535392929292929292921191515150515
05050501a4e8a8a8a8a8a8a8a8a498949494849484848488a4a8a8a8a88884844555454545455555555545554545454535392929292929291925190515150505
0505050da8a4e4e8a8a8a8a88888a8a49484949484848488a8a4a4a8a88894844545554545554545554555554545454905353529292929291119292515051515
05050509a8a4e0a8a8a8a8a88488a8a49484949484848488a8a4a8a8a88894844545554555554545554555554545454905353929292929290519291505051515
0505050d8c84c4f8a8a8a8a88888a8a48494949484848488a8a4a4a8a88884944545455555454535455555554545454905053539292929211919292505151515
05050509b0a0a42ca8a8a8a48888a8a4849494948c848488a8a8a4a8a88884944545455555554545455555554545454909053539292929251909192505051515
e4eca8a405050509a8a88888a8a8a8a48484848494848488a8a8a8a4a49894944545455555454545454545455555554929090525352929251515150929291515
e0a8a8a405050509a8a88488a8a8a8a48484848494949488a8a8a8a4a89894944545455555454545454545455555554929090525392929251515050929191515
84dc9c940505050ca8a88888a8a8a8a48484848494948488a8a8a8a4849894944545554545554545454545455555455929290505353929251515051929251111
a4e8a8a405050509a8a48888a8a8a8a48484848494948488a8a8a8a8a49894944545551545454545454545455555455929290905353929251515050919251d0d
a8a4c4c4050505098888a8a8a8a8a8a48484848494848488a8a8a8a8a88494844555454545455545454545455545555929292909053539251505151915192929
b8b4f0b4050505098488a8a8a8a8a8a48484848494848488a8a8a8a888948484455545454545554545454545554555592929290905353925050515190519211d
8c84c4f40505050988c8a8a8a8a8a8a48484848484848488a8a8a8a8a8a484945545454545454555454545454555555929292929050535350515151119192929
b0b0b4f4050505058888a8a8a8a8a8a48484848484848488a8a8a8a8a88894945545454545454555454545454555555929292929090515150505151519091929
a8a8a8a8a8a8989405050505e4eca8a4a4a8a8a8a8a8a8a494949484848484845555554545454545554545454545555929291115151515053529292929292929
a8a8a8a8a8a894940505050520a8a8a4a8a8a8a8a8a8a8a494949484848484845555554545454545554545454545555929190515151505053929292929292929
a8a8a8a8a8a8889405050505c42caca4a4a8a8a8a8a8a8a494948494848484845555455545454515455545454545555929211915151505153539292929292929
a8a8a8a8a8a4989405050501a428a8a8a4a8a8a8a8a8a8a494948494848484845555455545454545455545454545555919251905151505053539292929292929
a8a8a8a88888a8a40505050da8a424e8a8a4a4a8a8a8b8a494849494848484845545555545454545454555455555656911192925150515190535352929292929
a8a88888c488a8a405050509a8a420a8a8a4a8a8a8a8a8a494849494848484845545555545354545454555455555453905192915050515190535392929292929
a8a8a8a88898a8a40505050d8c84c428a8a4a4a8a8a8a8b484949494848484844555555545454545454545555555454119192925051515190505353929292929
a8a8a8a49898a8a405050509b0a0a428a8a8a4a8a8a8a8b484949494848484844555555545454545454545555555454519091925050515190905353929292929
a8a88888a8a8a8a4e4eca8a405050509a8a0a8a4a4a8a8a48484848494949484454545455545554545454555554545451515150929291119290d05253d292929
a8a88488a8a8a8a420a8a8a405050509a8a8a8a4a8a8a8a484848484949494844545454555555545454555555565656515150509291905192909052539292929
a8a88888a8888884c4e8a8a405050509a8a8a8a4a4a8a8a484848484949484944545454555554555454555554555454515150519292119192929050535392929
a8a48888a8a8a0a0a428a8a405050509a8a8a8a8a4a8a8a484848484949484944545454555554555454555554555454515150509192519092929090535392929
8888a8a8a8a8acaca8a4fcb405050509a8a8a8a8a8a4a4a484848484948494944545454555455545455545454545554515051519111929292929290915353d29
8488a8a8a8a8a8a8a8b430b405050509a8a8a8a8a8a4a8a484848484948494944545454555455555555545454545554505051519051929192929290905353929
8898a8a8a8a8a88c8c84c4f405050509a8aca8a8a8a484848484848484949494454545454555555555454545454545550515151119192929292929290d053535
9898a8a8a8a8a8b8b080840405050509a8a8a8a8a888848484848484849494944545454545455555555545454545454505051515190919292929292929253525
9494948484848484a4a8a8a8a8a8a8a40505050524e8a8a8a8a8a8a8a8a894842529292929292929292901151515150555454545454d55555555554545454545
9494948484848484a8a8a8a8a8a8a8a40505050520a8a8a8a8a8a8a8a8a884842929292929292929292915151515150545454545455555555555454545454535
9494849484848484a4a8a8a8a8a8a8a405050505c428a8a8a8a8a8a8a8a884941529292929292929292119151515051545554545454555555555455545454545
9494849484848488a4a8a8a8a8a8a8a405050501a428a8a8a8a8a8a8a8a498943529292929292921292519151515050545454545554555555555454545453545
9484949484848488a8a4a4a8a8a8aca40505050da8a424e8a8a8a8a88888a8880515252929292929010c29251505151545455545555545455545555545354545
9484949484848488a8a4a8a8a8a8a8a405050509a8a420a8a8a8a8a88488a8880535292929292929051921251505151545454545555545554545555545354545
849494948c848488a8a4a4a8a8a8a8a4050505098884c428a8a8a8a88888a8a80505152929292931190929250515151545454555555545454545555545454545
8494949484848488a8a8a4a8a8a8a8a405050509b0a0a428a8a8a8a48888a8a80905352929292925190929250515151545454545555555454545555535454545
8484848494848488a8a8a8a4a4a8a8a424eca8a405050509a8a88888a8a8a8a82909050525292925151515092929151545455555554545454545454555555545
8484848494848488a8a8a8a4a8a8a8a420a8a8a405050509a8a88488a8a8a8a82909052539292925151515092929051545555555454545454545453555554545
8484848494848488a8a8a8a484888884c42caca405050509a8a88888a8b8a8a82929050515292925151505192921151545455555455545454545454555554555
8484848494948488a8a8a8a8a4b8b0a0a428a8a405050509a8a48888a8a8a8a82929090535392925151505192925151555455555454545454545354555554545
8484848494848488a8a8a8a8a8a4a4aca88404c4050505098888a8a8a8a8a8a82929290905152525150515191119050555554545454555454505454555455555
c484848494848488a8a8a8a8a8a4a8a8a8b430b4050505098488a8a8a8a8a8a82929290915353925150515190519050555554555454545454535454545455555
8484848484848488a8a8a8a8a8a4848c8c84c404050505098888a8a8a8a8a8a82929292905051505051515111919050555154545454545454545454545455555
8484848484848488a8a8a8a8acaca4b8b0808404050505058888a8a8a8a8a8a82929292909051515051515151909050555555545454545453545454545455555
a4a8a8a8a8a8a8a49494948484848488a8a8a8a8a8a898940505050424e8a8a82929011515051505252929292909050555555545454545455545454545355555
a8a8a8a8a8a8a8a49494948484848488a8a8a8a8a8a894940505050524a8a8b829290515151515053929292929090505555545454545451545454d0545555555
b4a8a8a8a8a8a8a49494849484848488a8a8a8a8a8a8888405050505c428a8a82921190515150515152929292909050555554555454545454545454545455559
a4a8a8a8a8a8a8a49494849484848488a8a8a8a8a8a4888405050505a428a8a82925191515150515353929292909050555554545454535454545454555455559
a8a4a4a8a8a8b8a49484949484848488a8a8a8a88888a8a405050509a8a424e80119292515051519051525292909050555455555454545454545554555556569
a8a4a8a8a8a8a8a49484949484848488a8a8a8a88488a8a405050509a8a424a80519292515051519153539292909050545455555453545454545454555556559
a8a4a4b8a8a8a8b48494949484848488a8a8a8a88888a8a4050505098884c4101909292505151519050535392909051545555555454545454545455555556569
a8a8b4b8a8a8a8b48494949484848488a8a8a8a48888a8a405050509a48494141909292505151519091535392909051545455555354545454545454555555569
a8a8a8a4a4a8a8a48484848494848488a8a88888a8a8a8a424e8a8a4050505051515150929290119090905253509051545454545555555454505555555456569
a8a8a8a4a8a8a8a48484848494949488a8a88488a8a8a8a420a8a8a4050505051515150929290519290905253909051545454535555545454555555545456569
a8a8a8a4a4a8a8a48484848494948488a8a88888a8888884c428a8a4050505051515051929211909292905053519051545454545555545454545551545456569
a8a8a8a8a4a8a8a48484848494948488a8a48888a8a8a0a0a428a8a405050d051515051929251909292909053539253545453545555545455545555545456569
a8a8a8a8a8a4a4a484848484948484888888a8a8a8a8a8a8a88404c405050505150515190119292c292929090515151545454545554555555555454545457569
a8a8a8a8a8a4a8a484848484948484888488a8a8a8a8a8a8a8a424a4050505051505151905192929292929090515151545354545454555555555455545456569
a8a8a8a8a4a4a4b484848484849484888888a8a8a8a8a8888884c404050505050515151119092929292929292525353545454545455555555515454545456579
a8a8a8a8a8a8b4b484848484849484848888a8a8a8a8a8a8a4848404050505050515151519092929292921290905151535454545454555555555554545454545

__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400081807300715000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 0a404344

