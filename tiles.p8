pico-8 cartridge // http://www.pico-8.com
version 30
__lua__
--tile based stuff

__gfx__
00000000d77777777777777777777776111111111111111111111111d777777600000000d7777777777777777777777d333333333333333333333333d777777d
00000000711111111111111111111117111111111111111111111111711111170000000073333333333333333333333733333333333333333333333373333337
00000000711111111111111111111117111111111111111111111111711111170000000073333333333333333333333733333333333333333333333373333337
00000000711111111111111111111117111111111111111111111111711111170000000073333333333333333333333733333333333333333333333373333337
00000000711111111111111111111117111111111111111111111111577777750000000073333333333333333333333733333333333333333333333357777775
00000000711111111111111111111117111111177111111171111117555555550000000073333333333333333333333733333337733333337333333755555555
00000000711111111111111111111117111111177111111171111117555555550000000073333333333333333333333733333337733333337333333755555555
00000000711111111111111111111117111111177111111171111117d55555510000000073333333333333333333333733333337733333337333333715555551
00000000711111111111111111111117d77777777777777777777776dddd666600000000733333333333333333333337d7777777777777777777777ddddd6ddd
00000000711111111111111111111117711111111111111111111117dddd666600000000733333333333333333333337733333333333333333333337ddddddd6
000000007111111111111111111111177111111111111111111111176666dddd00000000733333333333333333333337733333333333333333333337dd6ddddd
000000007111111111111111111111177111111111111111111111176666dddd00000000733333333333333333333337733333333333333333333337ddddd6dd
00000000711111111111111111111117577777777777777777777775dddd6666000000007333333333333333333333375777777777777777777777756ddddddd
00000000711111111111111111111117555555555555555555555555dddd666600000000733333333333333333333337555555555555555555555555ddd6dddd
000000007111111111111111111111175555555555555555555555556666dddd00000000733333333333333333333337555555555555555555555555dddddd6d
00000000711111111111111111111117d555555555555555555555516666dddd00000000733333333333333333333337155555555555555555555551d6dddddd
000000007111111111111111111111177111111771111117d77777761111dddd000000007333333333333333333333377333333773333337d777777d1111d111
000000007111111111111111111111177111111771111117711111171111dddd000000007333333333333333333333377333333773333337733333371111111d
00000000711111111111111111111117711111177111111771111117dddd11110000000073333333333333333333333773333337733333377333333711d11111
000000007111111111111111111111177111111771111117711111176666dddd00000000733333333333333333333337733333377333333773333337ddddd6dd
00000000577777777777777777777775577777757111111771111117dddd6666000000005777777777777777777777755777777573333337733333376ddddddd
00000000555555555555555555555555555555557111111771111117dddd666600000000555555555555555555555555555555557333333773333337ddd6dddd
000000005555555555555555555555555555555571111117711111176666dddd00000000555555555555555555555555555555557333333773333337dddddd6d
00000000d55555555555555555555551d555555171111117711111176666dddd00000000155555555555555555555551155555517333333773333337d6dddddd
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00444400004444000044440000444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0044f500005f440000f5f50000444f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00ffff0000ffff0000ffff0000ffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00999990099999000999999000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00999900009999000099990000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00dddd0000dddd0000dddd0000dddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00dddd0000dddd0000dddd0000dddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000077777777777777777777770222222222222222222222222077777700000000007777777777777777777777044444444444444444444444407777770
00000000722222222222222222222227222222222222222222222222722222270000000074444444444444444444444744444444444444444444444474444447
00000000722222222222222222222227222222222222222222222222722222270000000074444444444444444444444744444444444444444444444474444447
00000000722222222222222222222227222222222222222222222222722222270000000074444444444444444444444744444444444444444444444474444447
00000000722222222222222222222227222222222222222222222222577777750000000074444444444444444444444744444444444444444444444457777775
00000000722222222222222222222227222222277222222272222227555555550000000074444444444444444444444744444447744444447444444755555555
00000000722222222222222222222227222222277222222272222227555555550000000074444444444444444444444744444447744444447444444755555555
00000000722222222222222222222227222222277222222272222227055555500000000074444444444444444444444744444447744444447444444705555550
00000000722222222222222222222227077777777777777777777770000000000000000074444444444444444444444707777777777777777777777000000000
00000000722222222222222222222227722222222222222222222227000000000000000074444444444444444444444774444444444444444444444700000000
00000000722222222222222222222227722222222222222222222227000000000000000074444444444444444444444774444444444444444444444700000000
00000000722222222222222222222227722222222222222222222227000000000000000074444444444444444444444774444444444444444444444700000000
00000000722222222222222222222227577777777777777777777775000000000000000074444444444444444444444757777777777777777777777500000000
00000000722222222222222222222227555555555555555555555555000000000000000074444444444444444444444755555555555555555555555500000000
00000000722222222222222222222227555555555555555555555555000000000000000074444444444444444444444755555555555555555555555500000000
00000000722222222222222222222227055555555555555555555550000000000000000074444444444444444444444705555555555555555555555000000000
00000000722222222222222222222227722222277222222707777770000000000000000074444444444444444444444774444447744444470777777000000000
00000000722222222222222222222227722222277222222772222227000000000000000074444444444444444444444774444447744444477444444700000000
00000000722222222222222222222227722222277222222772222227000000000000000074444444444444444444444774444447744444477444444700000000
00000000722222222222222222222227722222277222222772222227000000000000000074444444444444444444444774444447744444477444444700000000
00000000577777777777777777777775577777757222222772222227000000000000000057777777777777777777777557777775744444477444444700000000
00000000555555555555555555555555555555557222222772222227000000000000000055555555555555555555555555555555744444477444444700000000
00000000555555555555555555555555555555557222222772222227000000000000000055555555555555555555555555555555744444477444444700000000
00000000055555555555555555555550055555507222222772222227000000000000000005555555555555555555555005555550744444477444444700000000
__map__
042222222222222222220622222222050c2a2a2a2a2a2a2a2a2a2a2a2a2a2a0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
132727272727272727272527272727111b2f2f2f2f2f2f2f2f2f2f2f2f2f2f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171717171717172417171717111b1f1f1f1f1f1f1f1f1f1f1f1f1f1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171717171717172717171717111b1f1f1f1f1f1f1f1f2e1f1f1f1f1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171717171717171717171717111b1f1f1f1f1f1f1f1c0e1e1f1f1f1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171717171717171717171717111b1f1c1d1e1f1f1f2f2c2f1f1f1f1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171726171717171717171701121b1f2f2f2f1f1f1f1f2f1f1f1f1f1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171406161717261717171721051b1f1f1f1f1f1f1f1f090b1f1f090a1a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717172724271717251717171727111b1f1f1f1f1f1f1f090c2b1f1c0e2a0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171727171717241707171415051b1f1f1f0f1f1f1f292b2f1f2f2d2f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171717171717271727172727111b1f1f1f2f1f1f1f2f2f1f1f1f2d1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171717261717171717171717111b1f1f1f1f1f1f1f1f1f1f1f1f2c1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
131717171717251717171717171717111b1f1f1f1f1f1f1f1f1f1f1f1f2f1f19000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
120202020202120202020202020202121a0a0a0a0a0a0a0a0a0a0a0a0a0a0a1a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
