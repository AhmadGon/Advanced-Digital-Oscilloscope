//================================================================
//     Fraction BCD LUT Module
//		 
//		 This module is for fraction part of the floating point value
//		 expressed as BCD Look-Up table 
//================================================================
module Fraction_BCD_LUT(
	input Main_CLK,
	input [7:0] Exponent,
	input [31:0] Fraction_Binary,
	output reg [7:0] Fraction_BCD
);
always @(Main_CLK)
	begin
	if (Exponent >= 127)
		begin
		case(Fraction_Binary)
		0: Fraction_BCD <= 0; 
		1: Fraction_BCD <= 0; 
		2: Fraction_BCD <= 1; 
		3: Fraction_BCD <= 1; 
		4: Fraction_BCD <= 2; 
		5: Fraction_BCD <= 2; 
		6: Fraction_BCD <= 2; 
		7: Fraction_BCD <= 3; 
		8: Fraction_BCD <= 3; 
		9: Fraction_BCD <= 4; 
		10: Fraction_BCD <= 4; 
		11: Fraction_BCD <= 4; 
		12: Fraction_BCD <= 5; 
		13: Fraction_BCD <= 5; 
		14: Fraction_BCD <= 5; 
		15: Fraction_BCD <= 6; 
		16: Fraction_BCD <= 6; 
		17: Fraction_BCD <= 7; 
		18: Fraction_BCD <= 7; 
		19: Fraction_BCD <= 7; 
		20: Fraction_BCD <= 8; 
		21: Fraction_BCD <= 8; 
		22: Fraction_BCD <= 9; 
		23: Fraction_BCD <= 9; 
		24: Fraction_BCD <= 9; 
		25: Fraction_BCD <= 16; 
		26: Fraction_BCD <= 16; 
		27: Fraction_BCD <= 17; 
		28: Fraction_BCD <= 17; 
		29: Fraction_BCD <= 17; 
		30: Fraction_BCD <= 18; 
		31: Fraction_BCD <= 18; 
		32: Fraction_BCD <= 19; 
		33: Fraction_BCD <= 19; 
		34: Fraction_BCD <= 19; 
		35: Fraction_BCD <= 20; 
		36: Fraction_BCD <= 20; 
		37: Fraction_BCD <= 20; 
		38: Fraction_BCD <= 21; 
		39: Fraction_BCD <= 21; 
		40: Fraction_BCD <= 22; 
		41: Fraction_BCD <= 22; 
		42: Fraction_BCD <= 22; 
		43: Fraction_BCD <= 23; 
		44: Fraction_BCD <= 23; 
		45: Fraction_BCD <= 24; 
		46: Fraction_BCD <= 24; 
		47: Fraction_BCD <= 24; 
		48: Fraction_BCD <= 25; 
		49: Fraction_BCD <= 25; 
		50: Fraction_BCD <= 32; 
		51: Fraction_BCD <= 32; 
		52: Fraction_BCD <= 32; 
		53: Fraction_BCD <= 33; 
		54: Fraction_BCD <= 33; 
		55: Fraction_BCD <= 33; 
		56: Fraction_BCD <= 34; 
		57: Fraction_BCD <= 34; 
		58: Fraction_BCD <= 35; 
		59: Fraction_BCD <= 35; 
		60: Fraction_BCD <= 35; 
		61: Fraction_BCD <= 36; 
		62: Fraction_BCD <= 36; 
		63: Fraction_BCD <= 37; 
		64: Fraction_BCD <= 37; 
		65: Fraction_BCD <= 37; 
		66: Fraction_BCD <= 38; 
		67: Fraction_BCD <= 38; 
		68: Fraction_BCD <= 39; 
		69: Fraction_BCD <= 39; 
		70: Fraction_BCD <= 39; 
		71: Fraction_BCD <= 40; 
		72: Fraction_BCD <= 40; 
		73: Fraction_BCD <= 41; 
		74: Fraction_BCD <= 41; 
		75: Fraction_BCD <= 41; 
		76: Fraction_BCD <= 48; 
		77: Fraction_BCD <= 48; 
		78: Fraction_BCD <= 48; 
		79: Fraction_BCD <= 49; 
		80: Fraction_BCD <= 49; 
		81: Fraction_BCD <= 50; 
		82: Fraction_BCD <= 50; 
		83: Fraction_BCD <= 50; 
		84: Fraction_BCD <= 51; 
		85: Fraction_BCD <= 51; 
		86: Fraction_BCD <= 52; 
		87: Fraction_BCD <= 52; 
		88: Fraction_BCD <= 52; 
		89: Fraction_BCD <= 53; 
		90: Fraction_BCD <= 53; 
		91: Fraction_BCD <= 54; 
		92: Fraction_BCD <= 54; 
		93: Fraction_BCD <= 54; 
		94: Fraction_BCD <= 55; 
		95: Fraction_BCD <= 55; 
		96: Fraction_BCD <= 56; 
		97: Fraction_BCD <= 56; 
		98: Fraction_BCD <= 56; 
		99: Fraction_BCD <= 57; 
		100: Fraction_BCD <= 57; 
		101: Fraction_BCD <= 57; 
		102: Fraction_BCD <= 64; 
		103: Fraction_BCD <= 64; 
		104: Fraction_BCD <= 65; 
		105: Fraction_BCD <= 65; 
		106: Fraction_BCD <= 65; 
		107: Fraction_BCD <= 66; 
		108: Fraction_BCD <= 66; 
		109: Fraction_BCD <= 67; 
		110: Fraction_BCD <= 67; 
		111: Fraction_BCD <= 67; 
		112: Fraction_BCD <= 68; 
		113: Fraction_BCD <= 68; 
		114: Fraction_BCD <= 69; 
		115: Fraction_BCD <= 69; 
		116: Fraction_BCD <= 69; 
		117: Fraction_BCD <= 70; 
		118: Fraction_BCD <= 70; 
		119: Fraction_BCD <= 70; 
		120: Fraction_BCD <= 71; 
		121: Fraction_BCD <= 71; 
		122: Fraction_BCD <= 72; 
		123: Fraction_BCD <= 72; 
		124: Fraction_BCD <= 72; 
		125: Fraction_BCD <= 73; 
		126: Fraction_BCD <= 73; 
		127: Fraction_BCD <= 80; 
		128: Fraction_BCD <= 80; 
		129: Fraction_BCD <= 80; 
		130: Fraction_BCD <= 81; 
		131: Fraction_BCD <= 81; 
		132: Fraction_BCD <= 82; 
		133: Fraction_BCD <= 82; 
		134: Fraction_BCD <= 82; 
		135: Fraction_BCD <= 83; 
		136: Fraction_BCD <= 83; 
		137: Fraction_BCD <= 84; 
		138: Fraction_BCD <= 84; 
		139: Fraction_BCD <= 84; 
		140: Fraction_BCD <= 85; 
		141: Fraction_BCD <= 85; 
		142: Fraction_BCD <= 85; 
		143: Fraction_BCD <= 86; 
		144: Fraction_BCD <= 86; 
		145: Fraction_BCD <= 87; 
		146: Fraction_BCD <= 87; 
		147: Fraction_BCD <= 87; 
		148: Fraction_BCD <= 88; 
		149: Fraction_BCD <= 88; 
		150: Fraction_BCD <= 89; 
		151: Fraction_BCD <= 89; 
		152: Fraction_BCD <= 89; 
		153: Fraction_BCD <= 96; 
		154: Fraction_BCD <= 96; 
		155: Fraction_BCD <= 97; 
		156: Fraction_BCD <= 97; 
		157: Fraction_BCD <= 97; 
		158: Fraction_BCD <= 98; 
		159: Fraction_BCD <= 98; 
		160: Fraction_BCD <= 99; 
		161: Fraction_BCD <= 99; 
		162: Fraction_BCD <= 99; 
		163: Fraction_BCD <= 100; 
		164: Fraction_BCD <= 100; 
		165: Fraction_BCD <= 100; 
		166: Fraction_BCD <= 101; 
		167: Fraction_BCD <= 101; 
		168: Fraction_BCD <= 102; 
		169: Fraction_BCD <= 102; 
		170: Fraction_BCD <= 102; 
		171: Fraction_BCD <= 103; 
		172: Fraction_BCD <= 103; 
		173: Fraction_BCD <= 104; 
		174: Fraction_BCD <= 104; 
		175: Fraction_BCD <= 104; 
		176: Fraction_BCD <= 105; 
		177: Fraction_BCD <= 105; 
		178: Fraction_BCD <= 112; 
		179: Fraction_BCD <= 112; 
		180: Fraction_BCD <= 112; 
		181: Fraction_BCD <= 113; 
		182: Fraction_BCD <= 113; 
		183: Fraction_BCD <= 113; 
		184: Fraction_BCD <= 114; 
		185: Fraction_BCD <= 114; 
		186: Fraction_BCD <= 115; 
		187: Fraction_BCD <= 115; 
		188: Fraction_BCD <= 115; 
		189: Fraction_BCD <= 116; 
		190: Fraction_BCD <= 116; 
		191: Fraction_BCD <= 117; 
		192: Fraction_BCD <= 117; 
		193: Fraction_BCD <= 117; 
		194: Fraction_BCD <= 118; 
		195: Fraction_BCD <= 118; 
		196: Fraction_BCD <= 119; 
		197: Fraction_BCD <= 119; 
		198: Fraction_BCD <= 119; 
		199: Fraction_BCD <= 120; 
		200: Fraction_BCD <= 120; 
		201: Fraction_BCD <= 121; 
		202: Fraction_BCD <= 121; 
		203: Fraction_BCD <= 121; 
		204: Fraction_BCD <= 128; 
		205: Fraction_BCD <= 128; 
		206: Fraction_BCD <= 128; 
		207: Fraction_BCD <= 129; 
		208: Fraction_BCD <= 129; 
		209: Fraction_BCD <= 130; 
		210: Fraction_BCD <= 130; 
		211: Fraction_BCD <= 130; 
		212: Fraction_BCD <= 131; 
		213: Fraction_BCD <= 131; 
		214: Fraction_BCD <= 132; 
		215: Fraction_BCD <= 132; 
		216: Fraction_BCD <= 132; 
		217: Fraction_BCD <= 133; 
		218: Fraction_BCD <= 133; 
		219: Fraction_BCD <= 134; 
		220: Fraction_BCD <= 134; 
		221: Fraction_BCD <= 134; 
		222: Fraction_BCD <= 135; 
		223: Fraction_BCD <= 135; 
		224: Fraction_BCD <= 136; 
		225: Fraction_BCD <= 136; 
		226: Fraction_BCD <= 136; 
		227: Fraction_BCD <= 137; 
		228: Fraction_BCD <= 137; 
		229: Fraction_BCD <= 137; 
		230: Fraction_BCD <= 144; 
		231: Fraction_BCD <= 144; 
		232: Fraction_BCD <= 145; 
		233: Fraction_BCD <= 145; 
		234: Fraction_BCD <= 145; 
		235: Fraction_BCD <= 146; 
		236: Fraction_BCD <= 146; 
		237: Fraction_BCD <= 147; 
		238: Fraction_BCD <= 147; 
		239: Fraction_BCD <= 147; 
		240: Fraction_BCD <= 148; 
		241: Fraction_BCD <= 148; 
		242: Fraction_BCD <= 149; 
		243: Fraction_BCD <= 149; 
		244: Fraction_BCD <= 149; 
		245: Fraction_BCD <= 150; 
		246: Fraction_BCD <= 150; 
		247: Fraction_BCD <= 150; 
		248: Fraction_BCD <= 151; 
		249: Fraction_BCD <= 151; 
		250: Fraction_BCD <= 152; 
		251: Fraction_BCD <= 152; 
		252: Fraction_BCD <= 152; 
		253: Fraction_BCD <= 153; 
		254: Fraction_BCD <= 153;
		default: Fraction_BCD <= 0;
		endcase
		end
	if (Exponent < 127)
		begin
		case(Fraction_Binary)
		0: Fraction_BCD <= 0; 
		1: Fraction_BCD <= 0; 
		2: Fraction_BCD <= 0; 
		3: Fraction_BCD <= 0; 
		4: Fraction_BCD <= 0; 
		5: Fraction_BCD <= 0; 
		6: Fraction_BCD <= 0; 
		7: Fraction_BCD <= 0; 
		8: Fraction_BCD <= 0; 
		9: Fraction_BCD <= 0; 
		10: Fraction_BCD <= 0; 
		11: Fraction_BCD <= 0; 
		12: Fraction_BCD <= 0; 
		13: Fraction_BCD <= 0; 
		14: Fraction_BCD <= 0; 
		15: Fraction_BCD <= 0; 
		16: Fraction_BCD <= 0; 
		17: Fraction_BCD <= 0; 
		18: Fraction_BCD <= 0; 
		19: Fraction_BCD <= 0; 
		20: Fraction_BCD <= 0; 
		21: Fraction_BCD <= 0; 
		22: Fraction_BCD <= 0; 
		23: Fraction_BCD <= 0; 
		24: Fraction_BCD <= 0; 
		25: Fraction_BCD <= 0; 
		26: Fraction_BCD <= 0; 
		27: Fraction_BCD <= 0; 
		28: Fraction_BCD <= 0; 
		29: Fraction_BCD <= 0; 
		30: Fraction_BCD <= 0; 
		31: Fraction_BCD <= 0; 
		32: Fraction_BCD <= 0; 
		33: Fraction_BCD <= 0; 
		34: Fraction_BCD <= 0; 
		35: Fraction_BCD <= 0; 
		36: Fraction_BCD <= 0; 
		37: Fraction_BCD <= 0; 
		38: Fraction_BCD <= 0; 
		39: Fraction_BCD <= 0; 
		40: Fraction_BCD <= 0; 
		41: Fraction_BCD <= 0; 
		42: Fraction_BCD <= 0; 
		43: Fraction_BCD <= 0; 
		44: Fraction_BCD <= 0; 
		45: Fraction_BCD <= 0; 
		46: Fraction_BCD <= 0; 
		47: Fraction_BCD <= 0; 
		48: Fraction_BCD <= 0; 
		49: Fraction_BCD <= 0; 
		50: Fraction_BCD <= 0; 
		51: Fraction_BCD <= 0; 
		52: Fraction_BCD <= 0; 
		53: Fraction_BCD <= 0; 
		54: Fraction_BCD <= 0; 
		55: Fraction_BCD <= 0; 
		56: Fraction_BCD <= 0; 
		57: Fraction_BCD <= 0; 
		58: Fraction_BCD <= 0; 
		59: Fraction_BCD <= 0; 
		60: Fraction_BCD <= 0; 
		61: Fraction_BCD <= 0; 
		62: Fraction_BCD <= 0; 
		63: Fraction_BCD <= 0; 
		64: Fraction_BCD <= 0; 
		65: Fraction_BCD <= 0; 
		66: Fraction_BCD <= 0; 
		67: Fraction_BCD <= 0; 
		68: Fraction_BCD <= 0; 
		69: Fraction_BCD <= 0; 
		70: Fraction_BCD <= 0; 
		71: Fraction_BCD <= 0; 
		72: Fraction_BCD <= 0; 
		73: Fraction_BCD <= 0; 
		74: Fraction_BCD <= 0; 
		75: Fraction_BCD <= 0; 
		76: Fraction_BCD <= 0; 
		77: Fraction_BCD <= 0; 
		78: Fraction_BCD <= 0; 
		79: Fraction_BCD <= 0; 
		80: Fraction_BCD <= 0; 
		81: Fraction_BCD <= 0; 
		82: Fraction_BCD <= 0; 
		83: Fraction_BCD <= 0; 
		84: Fraction_BCD <= 0; 
		85: Fraction_BCD <= 0; 
		86: Fraction_BCD <= 0; 
		87: Fraction_BCD <= 0; 
		88: Fraction_BCD <= 0; 
		89: Fraction_BCD <= 0; 
		90: Fraction_BCD <= 0; 
		91: Fraction_BCD <= 0; 
		92: Fraction_BCD <= 0; 
		93: Fraction_BCD <= 0; 
		94: Fraction_BCD <= 0; 
		95: Fraction_BCD <= 0; 
		96: Fraction_BCD <= 0; 
		97: Fraction_BCD <= 0; 
		98: Fraction_BCD <= 0; 
		99: Fraction_BCD <= 0; 
		100: Fraction_BCD <= 0; 
		101: Fraction_BCD <= 0; 
		102: Fraction_BCD <= 0; 
		103: Fraction_BCD <= 0; 
		104: Fraction_BCD <= 0; 
		105: Fraction_BCD <= 0; 
		106: Fraction_BCD <= 0; 
		107: Fraction_BCD <= 0; 
		108: Fraction_BCD <= 0; 
		109: Fraction_BCD <= 0; 
		110: Fraction_BCD <= 0; 
		111: Fraction_BCD <= 0; 
		112: Fraction_BCD <= 0; 
		113: Fraction_BCD <= 0; 
		114: Fraction_BCD <= 0; 
		115: Fraction_BCD <= 0; 
		116: Fraction_BCD <= 0; 
		117: Fraction_BCD <= 1; 
		118: Fraction_BCD <= 1; 
		119: Fraction_BCD <= 1; 
		120: Fraction_BCD <= 1; 
		121: Fraction_BCD <= 1; 
		122: Fraction_BCD <= 1; 
		123: Fraction_BCD <= 1; 
		124: Fraction_BCD <= 1; 
		125: Fraction_BCD <= 1; 
		126: Fraction_BCD <= 1; 
		127: Fraction_BCD <= 1; 
		128: Fraction_BCD <= 1; 
		129: Fraction_BCD <= 1; 
		130: Fraction_BCD <= 1; 
		131: Fraction_BCD <= 1; 
		132: Fraction_BCD <= 1; 
		133: Fraction_BCD <= 1; 
		134: Fraction_BCD <= 1; 
		135: Fraction_BCD <= 1; 
		136: Fraction_BCD <= 1; 
		137: Fraction_BCD <= 1; 
		138: Fraction_BCD <= 1; 
		139: Fraction_BCD <= 1; 
		140: Fraction_BCD <= 1; 
		141: Fraction_BCD <= 1; 
		142: Fraction_BCD <= 1; 
		143: Fraction_BCD <= 2; 
		144: Fraction_BCD <= 2; 
		145: Fraction_BCD <= 2; 
		146: Fraction_BCD <= 2; 
		147: Fraction_BCD <= 2; 
		148: Fraction_BCD <= 2; 
		149: Fraction_BCD <= 2; 
		150: Fraction_BCD <= 2; 
		151: Fraction_BCD <= 2; 
		152: Fraction_BCD <= 2; 
		153: Fraction_BCD <= 2; 
		154: Fraction_BCD <= 3; 
		155: Fraction_BCD <= 3; 
		156: Fraction_BCD <= 3; 
		157: Fraction_BCD <= 3; 
		158: Fraction_BCD <= 3; 
		159: Fraction_BCD <= 3; 
		160: Fraction_BCD <= 3; 
		161: Fraction_BCD <= 3; 
		162: Fraction_BCD <= 4; 
		163: Fraction_BCD <= 4; 
		164: Fraction_BCD <= 4; 
		165: Fraction_BCD <= 4; 
		166: Fraction_BCD <= 4; 
		167: Fraction_BCD <= 4; 
		168: Fraction_BCD <= 5; 
		169: Fraction_BCD <= 5; 
		170: Fraction_BCD <= 5; 
		171: Fraction_BCD <= 5; 
		172: Fraction_BCD <= 5; 
		173: Fraction_BCD <= 6; 
		174: Fraction_BCD <= 6; 
		175: Fraction_BCD <= 6; 
		176: Fraction_BCD <= 6; 
		177: Fraction_BCD <= 7; 
		178: Fraction_BCD <= 7; 
		179: Fraction_BCD <= 7; 
		180: Fraction_BCD <= 8; 
		181: Fraction_BCD <= 8; 
		182: Fraction_BCD <= 9; 
		183: Fraction_BCD <= 9; 
		184: Fraction_BCD <= 9; 
		185: Fraction_BCD <= 16; 
		186: Fraction_BCD <= 16; 
		187: Fraction_BCD <= 17; 
		188: Fraction_BCD <= 17; 
		189: Fraction_BCD <= 17; 
		190: Fraction_BCD <= 18; 
		191: Fraction_BCD <= 18; 
		192: Fraction_BCD <= 19; 
		193: Fraction_BCD <= 19; 
		194: Fraction_BCD <= 20; 
		195: Fraction_BCD <= 21; 
		196: Fraction_BCD <= 22; 
		197: Fraction_BCD <= 22; 
		198: Fraction_BCD <= 23; 
		199: Fraction_BCD <= 24; 
		200: Fraction_BCD <= 25; 
		201: Fraction_BCD <= 32; 
		202: Fraction_BCD <= 32; 
		203: Fraction_BCD <= 33; 
		204: Fraction_BCD <= 34; 
		205: Fraction_BCD <= 35; 
		206: Fraction_BCD <= 35; 
		207: Fraction_BCD <= 36; 
		208: Fraction_BCD <= 37; 
		209: Fraction_BCD <= 39; 
		210: Fraction_BCD <= 40; 
		211: Fraction_BCD <= 48; 
		212: Fraction_BCD <= 49; 
		213: Fraction_BCD <= 51; 
		214: Fraction_BCD <= 52; 
		215: Fraction_BCD <= 54; 
		216: Fraction_BCD <= 56; 
		217: Fraction_BCD <= 57; 
		218: Fraction_BCD <= 65; 
		219: Fraction_BCD <= 66; 
		220: Fraction_BCD <= 68; 
		221: Fraction_BCD <= 69; 
		222: Fraction_BCD <= 71; 
		223: Fraction_BCD <= 72; 
		224: Fraction_BCD <= 80; 
		225: Fraction_BCD <= 83; 
		226: Fraction_BCD <= 86; 
		227: Fraction_BCD <= 89; 
		228: Fraction_BCD <= 99; 
		229: Fraction_BCD <= 102; 
		230: Fraction_BCD <= 105; 
		231: Fraction_BCD <= 114; 
		232: Fraction_BCD <= 117; 
		233: Fraction_BCD <= 120; 
		234: Fraction_BCD <= 129; 
		235: Fraction_BCD <= 132; 
		236: Fraction_BCD <= 136; 
		237: Fraction_BCD <= 145; 
		238: Fraction_BCD <= 148; 
		239: Fraction_BCD <= 151; 
		240: Fraction_BCD <= 160; 
		241: Fraction_BCD <= 166; 
		242: Fraction_BCD <= 179; 
		243: Fraction_BCD <= 185; 
		244: Fraction_BCD <= 197; 
		245: Fraction_BCD <= 209; 
		246: Fraction_BCD <= 216; 
		247: Fraction_BCD <= 228; 
		248: Fraction_BCD <= 240; 
		249: Fraction_BCD <= 246; 
		250: Fraction_BCD <= 259; 
		251: Fraction_BCD <= 265; 
		252: Fraction_BCD <= 277; 
		253: Fraction_BCD <= 289; 
		254: Fraction_BCD <= 296;
		default: Fraction_BCD <= 0;
		endcase
		end
	end
endmodule 