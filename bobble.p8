pico-8 cartridge // http://www.pico-8.com
version 27
__lua__

function _init()
 poke(0x5f40,0b1111)
 poke(0x5f43,0b1111)
 music(0)
end

function _update60()
 cls()
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01070020240502405523050230552105021050210551f050230502305521050210551f0501f0551d0501d05521050210551f0501f0551d0501c0501c0501c0551f0501f0501f0501f0501f0501f0551c0501a050
0107002018050180551a0501a0551c0501c0551d0501d0551a0501a0551c0501d0501d0501d0551f0501f0551f0501f0552105021055230502105021050210551f0501f0551f0501f05521050210552305023055
0107002018050180551a0501a0551c0501c0551d0501d0551a0501a0551c0501d0501d0501d0551f0501f0551f0501f0552105021055230501f0501f0501f05524050240551f0501f05521050210552205022055
0107002023050230552b0502b0552d0502d0552e0502e0552f0502f0551f0501f0552105021055230502305524050240552b0502b0552d0502d0552f0502f05530050300551f0501f05521050210552305023055
0107002026050260552b0502b0552d0502d0552f0502f05532050320551f0501f0552105021055230502305528050280552b0502b0552d0502d0552f0502f0553405034055240502405526050260552805028055
010700202905029055290502905029050290552905029050290502905528050280552605026050260502605528050280502805028050280402804028030280302802028020280102801528050280502805028055
0107002026050260502605026040260302602521050210502105021045210402104528050280502805028055260502605026050260502604026030260202601500000000001f0501f05521050210552205022055
010700202605026050260502604026030260251f0501f0501f0501f04528040280451f0501f0552805028055240502405024050240502404024030240202401500000000001f0501f05521050210552305023055
010700000c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c05018050180500b0500b0501705017050
010700000905009050150501505009050090501505015050090500905015050150500905009050150501505009050090501505015050090500905015050150500705007050130501305007050070501305013050
010700000c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c050180501805008050080501405014050
010700000905009050150501505009050090501505015050090500905015050150500905009050150501505007050070501305013050070500705013050130501805018050130501305015050150501605016050
010700000b0500b05017050170500b0500b05017050170500b0500b05017050170500b0500b05017050170500c0500c05018050180500c0500c05018050180500c0500c05018050180500c0500c0501805018050
010700000b0500b05017050170500b0500b05017050170500b0500b05017050170500b0500b05017050170500c0500c05018050180500c0500c05018050180500c0500c05018050180501a0501a0501c0501c050
0107000011050110501d0501d05011050110501d0501d05011050110501d0501d05011050110501d0501d05010050100501c0501c05010050100501c0501c05010050100501c0501c05010050100501c0501c050
010700000e0500e0501a0501a0500e0500e0501a0501a050090500905015050150500905009050150501505007050070501305013050070500705013050130500e0500e050130501305015050150501605016050
010700000e0500e0501a0501a0500e0500e0501a0501a05007050070501005010050070500705010050100500c0500c0500c0500c0500c0500c0500c0500c0510c0000c000130501305015050150501605016050
000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0107002030030300352f0302f0352d0302d0302d0352b0302f0302f0352d0302d0352b0302b03529030290352d0302d0352b0302b035290302803028030280352b0302b0302b0302b0302b0302b0352803026030
0107002024030240352603026035280302803529030290352603026035280302903029030290352b0302b0352b0302b0352d0302d0352f0302d0302d0302d0352b0302b0352b0302b0352d0302d0352f0302f035
0107002024030240352603026035280302803529030290352603026035280302903029030290352b0302b0352b0302b0352d0302d0352f0302b0302b0302b03500000300002b0002b0002d0002d0002e0002e000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 08102044
00 09112144
00 08122044
00 0a132244
00 0b144344
00 0c154344
00 0d164344
00 0e174344
00 0b144344
00 0c154344
00 0d164344
02 0f184344

