import 'package:adventofcode2024/solutions/day03_solution.dart';
import 'package:flutter_test/flutter_test.dart';

String rawData1 =
    "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))";

String rawData2 =
    "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";

String rawData2a =
    r"]select(23,564)/$!where()>%mul(747,16)*why()mul(354,748)how()<?mul(29,805)where()mul(480,119)!,why()mul(685,393)(~'&[what()what()mul(376,146)-,<)do()^(mul(735,916)/~~,] what()where()mul(321,623)select()$#what() %#who()<*mul(363,643)where()[mul(360,266),:do()'mul(95,167)who()-select()@[{,)$select()mul(802,119) how()^: {from()mul(147,169)*select())^mul(488,194)$?when()mul(540,154)from()from()*^select()who()mul(8,750)where()mul(140,841)when()] >$(when()<:mul(428,793) where()from()how()/how()]*?mul(156,996))what()!,what()~@((mul(976,569)]-,>$-~%;mul(426,703)/mul(948,128)>+?+>?%select()*mul(477,567)why()%select()?!(@~how(){mul(182,79),mul(203,707)?[mul(186,170)select(283,626)*/*when()mul(130,392)')^&when(),[;mul(563,902)where()}*}<$/)how()mul(953,129)!!what()#what()!who()mul(852,652)~)+mul(973,163)$?why()]where()mul(158,596)when()@}what(29,454)mul(968,252)<'^'how()when()<*^mul(617,885)when()) +&;'mul(264,456)/mul(713,804),-mul(803,862)mul(575,310)[ why(527,60) )from()mul(475,876)from()when()*^$@:do()mul(557,2)'{^:-*what()mul(611,157) >- when()mul(894,415)!mul(856,397)from(),where()mul(13,373),!where(),do() {how()select()^:(#select(622,699)[mul(395,375)-##>+[what()?mul(535,15)/(];)mul(115,296)mul(201,604)^+[>+do()&:}how()/:mul(34,586)?where(375,645)?:-who()select()'why()>mul(389,101)don't()<^}who()mul(501,691)'select()mul(551,120),]?from(545,381)?*%~mul(492,926),:(who() {$ when()mul(348,721)'?/)?!what(784,670)mul(811,483): where()why()why()>$[when()do(),~*# {/mul(312,382),}*what(944,486)?^{+%mul(224,412)~why();?<]who()*^mul(199,783)what()from()@why()where()what()?select()(}mul(267,247) mul(126,337)select()mul(534,156)($%%}+*@mul(103,848):;'%mul(237,35)<&-where()mul(423,484),!]where()#!mul(281,866)select(750,996)(( *{<^%who()mul(437,982)}:mul(357,682)@< mul(124,834)}~mul(668,671)mul(787,282)</{[@+mul(669,479)&+who(324,639)when()mul(217,891)why()who(),who()!+~%who()from()mul(157,768)what()why()/mul(654,217)/?]+how()($mul(173,829))#(what()mul(78,373)(+{?&${([from()mul >from():where()'[mul(985,702)*{: -&where()how()mul(180,738)(from()@mul(240,76),[:'#!:select() mul(822,179)*#how()~!%!<mul(806;+from(28,284);@select()why()?what()how()#don't()select();;?how()[<mul(682,60)%+mul(166,261)!#<~who()'@who()/mul(991;mul(602,939)why()*how()mul(815 ~>who()who()how()where(184,532)#from() [mul(771,388)how()'~!^!@+mul(646,938)+,(({-mul(486,708)^%^from()-(;what()]mul(144,833)~why()%select()&<~how())mul(439,873)mul(677[[;{:?{>[ (mul(25,577))@:mul(727,412)why();?select()?what()};from()*mul(826,116)#*)/where()who();<@<mul(457,847)mul(145,20)^when()mul(547,892)}mul(368>!where()~when()where(597,883)-mul(835,616)'((where(808,96)',mul(649,224)&/ mul(35,958)who(871,394) :!-who()where()where()(mul(322,104^what()%,}[why()what()**who()mul(983,838)mul(614,657)what()&,mul(238,871)-{},select()>who()#>mul(943,599)select()select(558,572)?^who() <:mul(572,265))who()[why()!$,-mul(454,326)<mul(620,631)[who()]from()>mul(300,416)what()who()what()[;when()mul(786,381!<who()@}mul(588,123)mul(912}?-,&mul(757,105)*!!mul(646,183)~*^mul(208,472)^>&who()when()where(381,479) from()<!mul(374,508)',mul(936,836)&when()don't()<mul(87,618)";

String rawData2b =
    r"#-#$&?,mul(549,158):>!?$,what(),who()mul(429,727)}from(401,661)>{?<?:)mul(883,372);when()&who()mul(778,374)[+*+select(896,509):?(why()<mul(156,180)why(),don't()why()mul(186,452)-who()+don't()mul(801,495)what(226,680)( who()do()//~how()mul(810,508)}:from(){$where(285,907)'mul(101,25)?>%mul(518,766)-@who()!mul(276,326),select()%{mul(211,710)/mul(414,532)@!-,>mul(494,611)?%((@)[&who()mul(547/why()]who()*% $'who(675,908)mul(90,974)}mul(427,683)how()[:;mul(443,135)*^+~^{when()who()}[mul(579,135)@:who()mul(267,452)[&!;;where()$}who()mul(662,85)~>what()mul(724,771)$!mul(206,909)@^%mul)when()select(567,468)mul(260,632)who()what()</><}what()}@do()mul(866,137why()~)mul(13,816)^!*(mul(351,795)from()(?^ ;;,~'mul(313,157)?mul(222,186)!> &how()$mul(558,129)how()[select()from()'/&when()[^mul(927,606)@?<+how()-}(mul(749,285)!![%~>mul(919,804)+&-->where()!&$/mul(889,472):why() <]++from():)mul(597,828)!*~@mul(61,536)(why()what(): >why()*mul(50,308)mul(980,618){-! ?*why() *mul(506,77)#/where()^~';who()%<do(){&{mul(540,5)%&'mul(128,695)!mul(96,956):(${'where()<(mul(45,167)mul$?what()>who():mul(11,806)mul(226,600)?how()% /{//mul(601[><<&mul(70,238)select(176,735)mul(447,978)(^#mul(583,880)@[<mul(509,562)[&why(){-select(513,478)who()~mul(966,836when(763,296)](?-mul(131,634)from(261,473)%mul(212,467)(why()mul(876,253~mul(426,669)&select()>mul(722,873)>mul(110,728)/+mul(948,566)where(760,139)[ -*why()-mul(92*,:-$how(),where()<mul(873,257)select()/!*don't()&#?from()why()where()%}mul(210,425)how()--mul(819,836where()<!why()'>select(),+mul(954,569)&<what()$(&-'[mul(514,751)?#);#mul(570,718)where()mul(369,56)mul(701,888)select()when()why()when(932,357)mul(954,415)select()^!&mul(975,208)<select()when()#}mul(123,114)#?/where()'-]do()>?#+(mul(482,680)]mul how()&what()%-mul(455,447)-from()+>?[/where()!:mul(502,951)?~mul(953,617)[/]&>^when()mul(234,738who(134,419))&$<what()mul(351,35)!mul(450,397)~@why()/$why()mul(315,592)?('$)]mul(361,911),+ $$, @?mul(648,348)why()*(~mul(741,895)]don't()who()/$<from()<what()@where()mul(914?!from()select()mul(221,704)mul(869,570)']/ '&why() ;who(970,163)mul(891,301{what()what()who()?$])mul(304,61)[,mul(380,797):'mul(134,245<}>-${)when()#why()/mul(266,78)&- ;mul(336,100)?$'#{'~:^mul(963,726)/&@mul(738,99){where(903,414)how()<mul(433,254)mul'%who()*where()mul(612,425):how()%mul(925,380)'('#/:mul(590,924)&where()%'mul(629,151)**;%<%?when()mul(231,925)mul(535,69),mul(695,901),?{+-~select()@mul(173,181)#what()/<^-select(),]what()mul(478,661)how()'/mul(269,398)}?$mul(203,769):select()^<<,^-mul(440,541)( (why()mul(264,622));where()mul(53,921)when()]mul(802,877)where()&?when()mul(24,441)where()mul(83,37)/where()--/how()'mul(278,236)]from(380,409)mul(486,676)-+]<mul(332,224)%#~'$$from(){how()(mul(786,79),>>)mul(249,770)$&@ ]from()$how()!select(521,465)mul(617,783)}<>):[,select(333,996)mul(416,179)[[don't()$]>why()@:mul(148,463)from()-do()when()-/how()when()&from(930,269)[mul(10,173)#mul(613,997)(<where()^<  mul(359,962)where()#what()what(), mul(276,357)!who()){!where()'}'mul(860,748)";

String rawData2Custom = "mul(1,1)do()mul(1,1)don't()mul(1,1)\n"
    "mul(1,1)do()mul(1,1)don't()mul(1,1)\n"
    "mul(1,1)do()mul(1,1)don't()mul(1,1)\n"
    "mul(1,1)do()mul(1,1)don't()mul(1,1)\n";

void main() async {
  test('Part 2custom', () async {
    Day03Solution solution = Day03Solution();
    solution.parse(rawData2Custom);
    solution.part2();
    expect(solution.answer2, '5');
  });
  test('Part 1', () async {
    Day03Solution solution = Day03Solution();
    solution.parse(rawData1);
    solution.part1();
    expect(solution.answer1, '161');
  });

  test('Part 2', () async {
    Day03Solution solution = Day03Solution();
    solution.parse(rawData2);
    solution.part2();
    expect(solution.answer2, '48');
  });

  test('Part 2a', () async {
    Day03Solution solution = Day03Solution();
    solution.parse(rawData2a);
    solution.part2();
    expect(solution.answer2, '14183448');
  });

  test('Part 2b', () async {
    Day03Solution solution = Day03Solution();
    solution.parse(rawData2b);
    solution.part2();
    expect(solution.answer2, '16213912');
  });
}
