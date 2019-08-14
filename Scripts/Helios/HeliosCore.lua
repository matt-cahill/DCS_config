----------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMPATIBLE WIDTH: CapLoz A10C Helios profile																											--
-- 					 CaptZeen KA50, SU-25T, F-15C, TF-51D/P-51D/P-51D-30-NA and SA342-L/M/Mistral/Minigun  Helios profiles			        			--
--					 CaptZeen A10C RADIO fix																											--
--					 CaptZeen/Sliker55 MIG-21bis Helios profile																							--
--					 CaptZeen A10C TACAN fix																											--
--					 CaptZeen L39ZA Forward Cockpit v1.0									  											  				--
--					 CaptZeen F/A-18C Beta	UPDATE 2																									--
--					 CaptZeen MI-8 V2.0																													--
--					 CaptZeen KA50 V2.0																													--
--					 Bluefinbima AV8B									  											  									--
--					 CaptZeen UH1H V2.0								  											  										--
--																																						--
-- IMPORTANT NOTICE: This export.lua uses the new Helios 1.4.2019.0611 version, so you need to install it.		  										--  
--																																						--
-- THANKS:			 DCS Export integration restructured by Loophole: 16/06/2018																		--
--																																						--
-- RELEASE DATE:     13/JUL/2019 																														--
----------------------------------------------------------------------------------------------------------------------------------------------------------


-- variables for flash effects
DoOnce= 0
gFlashing_Counter =0 
gFlashing_State = 1
--

-- variables for A10C radio freq control
gAM_digit_1 = 0
freq_digit_1 = 0
gAM_digit_2 = 0
freq_digit_2 = 0
gAM_digit_3 = 0
freq_digit_3 = 0
gFM_digit_1 = 0
freq_FM_digit_1 = 0
gFM_digit_2 = 0
freq_FM_digit_2 = 0
gFM_digit_3 = 0
freq_FM_digit_3 = 0
am_radio_freq_inicialized = 0
fm_radio_freq_inicialized = 0
--------



-- Debugging using Zerobrane...
--require('mobdebug').start()

gHighImportanceArguments = {}
gLowImportanceArguments = {} 
ProcessHighImportance = ProcessNoHighImportance
ProcessLowImportance  = ProcessNoLowImportance

---------------
-- DEBUGGING --
---------------

debug_output_file = nil

----------
-- DATA --
----------

gHost = "127.0.0.1"
gPort = 9089
gExportInterval = 0.1        -- frequency of export events (sec)
gExportLowTickInterval = 2   -- export events call ProcessLowImportance every this many events.

-- Find argument values in the relevant mods\aircrafts\??\Cockpit\Scripts\mainpanel_inits.lua, "arg_number" values.
gA10HighImportanceArguments = 
{ 
	[4] = "%.4f",		-- AOA
	[12] = "%.4f",		-- Variometer
	[13] = "%.4f",		-- 
	[14] = "%.4f",		-- 
	[17] = "%.4f",		-- ADI Pitch
	[18] = "%.4f",		-- ADI Bank
	[19] = "%0.1f",		-- ADI Course Warning Flag
	[20] = "%.4f",		-- ADI Bank Steering Bar
	[21] = "%.4f",		-- ADI Pitch Steering Bar
	[23] = "%.4f",		-- ADI Turn Needle
	[24] = "%.4f",		-- ADI Slip Ball
	[25] = "%0.1f",		-- ADI Attitude Warning Flag
	[26] = "%0.1f",		-- ADI Glide-Slope Warning Flag
	[27] = "%.4f",		-- ADI Glide-Slope Indicator
	[32] = "%0.1f",		-- HSI Range Flag
	[33] = "%.4f",		-- HSI Bearing #1
	[34] = "%.4f",		-- HSI Heading
	[35] = "%.4f",		-- HSI Bearing #2
	[36] = "%.4f",		-- HSI Heading Marker
	[40] = "%0.1f",		-- HSI Power Flag
	[41] = "%.4f",		-- HSI Deviation
	[46] = "%0.1f",		-- HSI Bearing Flag
	[47] = "%.4f",		-- HSI Course Arrow
	[48] = "%.4f",		-- Airspeed
	[55] = "%0.1f",		-- AOA Power Flag
	[63] = "%.4f",		-- Standby Attitude Indicator pitch
	[64] = "%.4f",		-- Standby Attitude Indicator bank
	[65] = "%0.1f",		-- Standby Attitude Indicator warning flag
	[70] = "%.4f",		-- 
	[73] = "%.4f",		-- 
	[76] = "%.4f",		-- EngineLeftFanSpeed
	[77] = "%.4f",		-- EngineRightFanSpeed
	[78] = "%.4f",		-- EngineLeftCoreSpeedTenth
	[80] = "%.4f",		-- EngineRightCoreSpeedTenth
	[82] = "%.4f",		-- 
	[83] = "%.4f",		-- 
	[84] = "%.4f",		-- EngineLeftFuelFlow
	[85] = "%.4f",		-- EngineRightFuelFlow
	[88] = "%.4f",		-- 
	[89] = "%.4f",		-- 
	[129] = "%1d",		-- 
	[178] = "%0.1f",	-- 
	[179] = "%0.1f",	-- 
	[181] = "%0.1f",	-- 
	[182] = "%0.1f",	-- 
	[185] = "%1d",		-- 
	[186] = "%1d",		-- 
	[187] = "%1d",		-- 
	[188] = "%1d",		-- 
	[191] = "%0.1f",	-- 
	[215] = "%0.1f",	-- 
	[216] = "%0.1f",	-- 
	[217] = "%0.1f",	-- 
	[260] = "%0.1f",	-- 
	[269] = "%.4f",		-- HARS Sync
	[274] = "%.4f",		-- 
	[281] = "%.4f",		-- 
	[289] = "%1d",		-- 
	[372] = "%0.1f",	-- CMSC Missile Launch Indicator
	[373] = "%0.1f",	-- 
	[374] = "%0.1f",	-- 
	[404] = "%0.1f",	-- 
	[480] = "%0.1f",	-- 
	[481] = "%0.1f",	-- 
	[482] = "%0.1f",	-- 
	[483] = "%0.1f",	-- 
	[484] = "%0.1f",	-- 
	[485] = "%0.1f",	-- 
	[486] = "%0.1f",	-- 
	[487] = "%0.1f",	-- 
	[488] = "%0.1f",	-- 
	[489] = "%0.1f",	-- 
	[490] = "%0.1f",	-- 
	[491] = "%0.1f",	-- 
	[492] = "%0.1f",	-- 
	[493] = "%0.1f",	-- 
	[494] = "%0.1f",	-- 
	[495] = "%0.1f",	-- 
	[496] = "%0.1f",	-- 
	[497] = "%0.1f",	-- 
	[498] = "%0.1f",	-- 
	[499] = "%0.1f",	-- 
	[500] = "%0.1f",	-- 
	[501] = "%0.1f",	-- 
	[502] = "%0.1f",	-- 
	[503] = "%0.1f",	-- 
	[504] = "%0.1f",	-- 
	[505] = "%0.1f",	-- 
	[506] = "%0.1f",	-- 
	[507] = "%0.1f",	-- 
	[508] = "%0.1f",	-- 
	[509] = "%0.1f",	-- 
	[510] = "%0.1f",	-- 
	[511] = "%0.1f",	-- 
	[512] = "%0.1f",	-- 
	[513] = "%0.1f",	-- 
	[514] = "%0.1f",	-- 
	[515] = "%0.1f",	-- 
	[516] = "%0.1f",	-- 
	[517] = "%0.1f",	-- 
	[518] = "%0.1f",	-- 
	[519] = "%0.1f",	-- 
	[520] = "%0.1f",	-- 
	[521] = "%0.1f",	-- 
	[522] = "%0.1f",	-- 
	[523] = "%0.1f",	-- 
	[524] = "%0.1f",	-- 
	[525] = "%0.1f",	-- 
	[526] = "%0.1f",	-- 
	[527] = "%0.1f",	-- 
	[540] = "%0.1f",	-- AOA_INDEXER_HIGH
	[541] = "%0.1f",	-- AOA_INDEXER_NORM
	[542] = "%0.1f",	-- AOA_INDEXER_LOW
	[600] = "%0.1f",	-- 
	[604] = "%.4f",		-- 
	[606] = "%0.1f",	-- 
	[608] = "%0.1f",	-- 
	[610] = "%0.1f",	-- 
	[612] = "%0.1f",	-- 
	[614] = "%0.1f",	-- 
	[616] = "%0.1f",	-- 
	[618] = "%0.1f",	-- 
	[619] = "%0.1f",	-- 
	[620] = "%0.1f",	-- 
	[647] = "%.4f",		-- 
	[648] = "%.4f",		-- 
	[653] = "%.4f",		-- 
	[654] = "%1d",		-- 
	[659] = "%0.1f",	-- 
	[660] = "%0.1f",	-- 
	[661] = "%0.1f",	-- 
	[662] = "%0.1f",	-- 
	[663] = "%0.1f",	-- 
	[664] = "%0.1f",	-- 
	[665] = "%0.1f",	-- 
	[715] = "%.4f",		-- Standby Attitude Indicator manual pitch adjustment
	[730] = "%0.1f",	-- AIR_REFUEL_READY
	[731] = "%0.1f",	-- AIR_REFUEL_LATCHED
	[732] = "%0.1f",	-- AIR_REFUEL_DISCONNECT
	[737] = "%0.1f",	-- 
	[798] = "%0.1f",	-- 
	[799] = "%0.1f"		-- 
}

gA10LowImportanceArguments = 
{
	[22] = "%.3f",
	[101] = "%.1f",
	[102] = "%1d",
	[103] = "%1d",
	[104] = "%1d",
	[105] = "%1d",
	[106] = "%1d",
	[107] = "%1d",
	[108] = "%1d",
	[109] = "%1d",
	[110] = "%1d",
	[111] = "%1d",
	[112] = "%1d",
	[113] = "%1d",
	[114] = "%1d",
	[115] = "%.1f",
	[116] = "%.3f",
	[117] = "%1d",
	[118] = "%1d",
	[119] = "%1d",
	[120] = "%1d",
	[121] = "%1d",
	[122] = "%1d",
	[123] = "%1d",
	[124] = "%1d",
	[125] = "%1d",
	[126] = "%1d",
	[127] = "%.1f",
	[130] = "%1d",
	[131] = "%.1f",
	[132] = "%1d",
	[133] = "%.3f",  -- VHF AM volume
	[134] = "%1d",
	[135] = "%0.1f",
	[136] = "%.1f",
	[137] = "%0.3f",  -- am preset channel
	[138] = "%0.1f",
	--[139] = "%0.2f",  -- VHF AM first encoder
	--[140] = "%0.2f",  -- VHF AM second encoder
	--[141] = "%0.2f",  -- VHF AM third encoder
	[142] = "%0.2f",
	[147] = "%.3f",
	[148] = "%1d",
	[149] = "%0.1f",
	[150] = "%.1f",
	[151] = "%0.3f",  -- fm preset channel
	[152] = "%0.1f",
	--[153] = "%0.2f",   -- VHF FM first encoder
	--[154] = "%0.2f",   -- VHF FM second encoder
	--[155] = "%0.2f",   -- VHF FM third encoder
	[156] = "%0.2f",
	[161] = "%0.2f",
	[162] = "%0.1f",
	[163] = "%0.2f",
	[164] = "%0.2f",
	[165] = "%0.2f",
	[166] = "%0.2f",
	[167] = "%0.1f",
	[168] = "%0.1f",
	[169] = "%1d",
	[170] = "%1d",
	[171] = "%.3f",
	[172] = "%.1f",
	[173] = "%.1f",
	[174] = "%1d",
	[175] = "%1d",
	[176] = "%0.1f",
	[177] = "%1d",
	[180] = "%1d",
	[183] = "%1d",
	[184] = "%1d",
	[189] = "%1d",
	[190] = "%.1f",
	[192] = "%.3f",
	[193] = "%.3f",
	[194] = "%0.1f",
	[195] = "%.3f",
	[196] = "%1d",
	[197] = "%.1f",
	[198] = "%.1f",
	[199] = "%0.1f",
	[200] = "%0.1f",
	[201] = "%1d",
	[202] = "%1d",
	[203] = "%1d",
	[204] = "%1d",
	[205] = "%1d",
	[206] = "%1d",
	[207] = "%1d",
	[208] = "%1d",
	[209] = "%0.2f",
	[210] = "%0.2f",
	[211] = "%0.2f",
	[212] = "%0.2f",
	[213] = "%0.2f",
	[214] = "%0.2f",
	[221] = "%.3f",
	[222] = "%1d",
	[223] = "%.3f",
	[224] = "%1d",
	[225] = "%.3f",
	[226] = "%1d",
	[227] = "%.3f",
	[228] = "%1d",
	[229] = "%.3f",
	[230] = "%1d",
	[231] = "%.3f",
	[232] = "%1d",
	[233] = "%.3f",
	[234] = "%1d",
	[235] = "%.3f",
	[236] = "%1d",
	[237] = "%1d",
	[238] = "%.3f",
	[239] = "%0.1f",
	[240] = "%.1f",
	[241] = "%1d",
	[242] = "%1d",
	[243] = "%1d",
	[244] = "%1d",
	[245] = "%1d",
	[246] = "%1d",
	[247] = "%1d",
	[248] = "%0.1f",
	[249] = "%.3f",
	[250] = "%0.1f",
	[251] = "%0.1f",
	[252] = "%0.1f",
	[258] = "%0.2f",
	[259] = "%.1f",
	[261] = "%.3f",
	[262] = "%0.1f",
	[266] = "%1d",
	[267] = "%.1f",
	[268] = "%.3f",
	[270] = "%1d",
	[271] = "%.3f",
	[272] = "%1d",
	[273] = "%1d",
	[275] = "%.1f",
	[276] = "%1d",
	[277] = "%.3f",
	[278] = "%1d",
	[279] = "%1d",
	[280] = "%1d",
	[282] = "%1d",
	[283] = "%1d",
	[284] = "%.3f",
	[287] = "%1d",
	[288] = "%.3f",
	[290] = "%.3f",
	[291] = "%1d",
	[292] = "%.3f",
	[293] = "%.3f",
	[294] = "%1d",
	[295] = "%1d",
	[296] = "%.3f",
	[297] = "%.3f",
	[300] = "%.1f",
	[301] = "%.1f",
	[302] = "%.1f",
	[303] = "%.1f",
	[304] = "%.1f",
	[305] = "%.1f",
	[306] = "%.1f",
	[307] = "%.1f",
	[308] = "%.1f",
	[309] = "%.1f",
	[310] = "%.1f",
	[311] = "%.1f",
	[312] = "%.1f",
	[313] = "%.1f",
	[314] = "%.1f",
	[315] = "%.1f",
	[316] = "%.1f",
	[317] = "%.1f",
	[318] = "%.1f",
	[319] = "%.1f",
	[320] = "%1d",
	[321] = "%1d",
	[322] = "%1d",
	[323] = "%1d",
	[324] = "%1d",
	[325] = "%0.1f",
	[326] = "%.1f",
	[327] = "%.1f",
	[328] = "%.1f",
	[329] = "%.1f",
	[330] = "%.1f",
	[331] = "%.1f",
	[332] = "%.1f",
	[333] = "%.1f",
	[334] = "%.1f",
	[335] = "%.1f",
	[336] = "%.1f",
	[337] = "%.1f",
	[338] = "%.1f",
	[339] = "%.1f",
	[340] = "%.1f",
	[341] = "%.1f",
	[342] = "%.1f",
	[343] = "%.1f",
	[344] = "%.1f",
	[345] = "%.1f",
	[346] = "%1d",
	[347] = "%1d",
	[348] = "%1d",
	[349] = "%1d",
	[350] = "%1d",
	[351] = "%0.1f",
	[352] = "%.1f",
	[353] = "%.1f",
	[354] = "%.1f",
	[355] = "%.1f",
	[356] = "%1d",
	[357] = "%.1f",
	[358] = "%1d",
	[359] = "%.3f",
	[360] = "%0.1f",
	[361] = "%0.1f",
	[362] = "%0.1f",
	[363] = "%0.1f",
	[364] = "%0.1f",
	[365] = "%.1f",
	[366] = "%.1f",
	[367] = "%.3f",
	[368] = "%.3f",
	[369] = "%.1f",
	[370] = "%.1f",
	[371] = "%.1f",
	[375] = "%0.1f",
	[376] = "%0.1f",
	[377] = "%0.1f",
	[378] = "%1d",
	[379] = "%0.1f",
	[380] = "%1d",
	[381] = "%1d",
	[382] = "%1d",
	[383] = "%1d",
	[384] = "%0.1f",
	[385] = "%.1f",
	[386] = "%.1f",
	[387] = "%.1f",
	[388] = "%.1f",
	[389] = "%.1f",
	[390] = "%.1f",
	[391] = "%.1f",
	[392] = "%.1f",
	[393] = "%.1f",
	[394] = "%.1f",
	[395] = "%.1f",
	[396] = "%.1f",
	[397] = "%.1f",
	[398] = "%.1f",
	[399] = "%.1f",
	[400] = "%.1f",
	[401] = "%.1f",
	[402] = "%.1f",
	[403] = "%.1f",
	[405] = "%1d",
	[406] = "%1d",
	[407] = "%1d",
	[408] = "%1d",
	[409] = "%1d",
	[410] = "%.1f",
	[411] = "%.1f",
	[412] = "%.1f",
	[413] = "%.1f",
	[414] = "%.1f",
	[415] = "%.1f",
	[416] = "%.1f",
	[417] = "%.1f",
	[418] = "%.1f",
	[419] = "%.1f",
	[420] = "%.1f",
	[421] = "%.1f",
	[422] = "%.1f",
	[423] = "%.1f",
	[424] = "%1d",
	[425] = "%.1f",
	[426] = "%.1f",
	[427] = "%.1f",
	[428] = "%.1f",
	[429] = "%.1f",
	[430] = "%.1f",
	[431] = "%.1f",
	[432] = "%.1f",
	[433] = "%.1f",
	[434] = "%.1f",
	[435] = "%.1f",
	[436] = "%.1f",
	[437] = "%.1f",
	[438] = "%.1f",
	[439] = "%.1f",
	[440] = "%.1f",
	[441] = "%.1f",
	[442] = "%.1f",
	[443] = "%.1f",
	[444] = "%.1f",
	[445] = "%.1f",
	[446] = "%.1f",
	[447] = "%.1f",
	[448] = "%.1f",
	[449] = "%.1f",
	[450] = "%.1f",
	[451] = "%.1f",
	[452] = "%.1f",
	[453] = "%.1f",
	[454] = "%.1f",
	[455] = "%.1f",
	[456] = "%.1f",
	[457] = "%.1f",
	[458] = "%.1f",
	[459] = "%.1f",
	[460] = "%.1f",
	[461] = "%.1f",
	[462] = "%.1f",
	[463] = "%1d",
	[466] = "%.1f",
	[467] = "%.1f",
	[468] = "%.1f",
	[469] = "%1d",
	[470] = "%.1f",
	[471] = "%.1f",
	[472] = "%1d",
	[473] = "%0.1f",
	[474] = "%1d",
	[475] = "%0.1f",
	[476] = "%1d",
	[477] = "%1d",
	[531] = "%.1f",
	[532] = "%.1f",
	[533] = "%.1f",
	[601] = "%1d",
	[602] = "%1d",
	[603] = "%1d",
	[605] = "%.1f",
	[607] = "%.1f",
	[609] = "%.1f",
	[611] = "%.1f",
	[613] = "%.1f",
	[615] = "%.1f",
	[617] = "%.1f",
	[621] = "%1d",
	[622] = "%0.1f",
	[623] = "%1d",
	[624] = "%.3f",
	[626] = "%.3f",
	[628] = "%.1f",
	[630] = "%.1f",
	[632] = "%.1f",
	[634] = "%.1f",
	[636] = "%0.2f",
	[638] = "%0.2f",
	[640] = "%0.2f",
	[642] = "%0.2f",
	[644] = "%1d",
	[645] = "%0.1f",
	[646] = "%.1f",
	[651] = "%.1f",
	[655] = "%0.1f",
	[704] = "%.3f",
	[705] = "%.3f",
	[711] = "%.1f",
	[712] = "%0.2f",
	[716] = "%1d",		-- Gear Handle Position
	[718] = "%1d",
	[722] = "%.1f",
	[733] = "%1d}",
	[734] = "%1d",
	[735] = "%.1f",
	[772] = "%1d",
	[778] = "%1d",
	[779] = "%1d",
	[780] = "%1d",
	[781] = "%0.1f",
	[782] = "%0.1f",
	[783] = "%0.1f",
	[784] = "%1d",
}

gKa50HighImportanceArguments = 
{
	[44]="%0.1f", 
	[46]="%0.1f", 
	[47]="%0.1f", 
	[48]="%0.1f", 
	[78]="%0.1f", 
	[79]="%0.1f", 
	[80]="%0.1f", 
	[81]="%0.1f", 
	[82]="%0.1f", 
	[83]="%0.1f", 
	[84]="%0.1f", 
	[85]="%0.1f", 
	[86]="%0.1f", 
	[24]="%.4f", 
	[100]="%.4f", 
	[101]="%.4f", 
	[102]="%0.1f", 
	[109]="%0.1f", 
	[107]="%.4f", 
	[106]="%.4f", 
	[111]="%.4f", 
	[103]="%.4f", 
	[526]="%.4f", 
	[108]="%.4f", 
	[87]="%.4f", 
	[88]="%0.2f", 
	[89]="%.4f", 
	[112]="%.4f", 
	[118]="%.4f", 
	[124]="%.4f", 
	[115]="%.4f", 
	[119]="%0.1f", 
	[114]="%0.1f", 
	[125]="%0.1f", 
	[117]="%0.4f", 
	[527]="%0.4f", 
	[528]="%0.4f", 
	[127]="%.4f", 
	[128]="%.4f", 
	[116]="%0.1f", 
	[121]="%0.1f", 
	[53]="%.4f", 
	[52]="%.4f", 
	[94]="%.4f", 
	[93]="%.4f", 
	[95]="%0.1f", 
	[92]="%0.1f", 
	[51]="%.4f", 
	[97]="%0.2f", 
	[98]="%0.2f", 
	[99]="%0.2f", 
	[68]="%.4f", 
	[69]="%.4f", 
	[70]="%.4f", 
	[75]="%0.1f", 
	[72]="%.4f", 
	[531]="%.4f", 
	[73]="%.4f", 
	[532]="%.4f", 
	[142]="%.4f", 
	[143]="%.4f", 
	[144]="%.4f", 
	[145]="%0.1f", 
	[133]="%.4f", 
	[134]="%.4f", 
	[135]="%.4f", 
	[136]="%.4f", 
	[138]="%.4f", 
	[137]="%.4f", 
	[139]="%0.1f", 
	[140]="%0.1f", 
	[392]="%0.1f", 
	[393]="%0.1f", 
	[394]="%0.1f", 
	[395]="%0.1f", 
	[388]="%0.1f", 
	[389]="%0.1f", 
	[390]="%0.1f", 
	[391]="%0.1f", 
	[63]="%0.1f", 
	[64]="%0.1f", 
	[61]="%0.1f", 
	[62]="%0.1f", 
	[59]="%0.1f", 
	[60]="%0.1f", 
	[170]="%0.1f", 
	[175]="%0.1f", 
	[172]="%0.1f", 
	[165]="%0.1f", 
	[171]="%0.1f", 
	[176]="%0.1f", 
	[166]="%0.1f", 
	[164]="%0.1f", 
	[178]="%0.1f", 
	[173]="%0.1f", 
	[177]="%0.1f", 
	[211]="%0.1f", 
	[187]="%0.1f", 
	[204]="%0.1f", 
	[213]="%0.1f", 
	[11]="%.4f", 
	[12]="%.4f", 
	[14]="%.4f", 
	[167]="%0.1f", 
	[180]="%0.1f", 
	[179]="%0.1f", 
	[188]="%0.1f", 
	[189]="%0.1f", 
	[206]="%0.1f", 
	[212]="%0.1f", 
	[205]="%0.1f", 
	[181]="%0.1f", 
	[190]="%0.1f", 
	[207]="%0.1f", 
	[183]="%0.1f", 
	[182]="%0.1f", 
	[191]="%0.1f", 
	[208]="%0.1f", 
	[184]="%0.1f", 
	[200]="%0.1f", 
	[209]="%0.1f", 
	[185]="%0.1f", 
	[202]="%0.1f", 
	[201]="%0.1f", 
	[210]="%0.1f", 
	[186]="%0.1f", 
	[203]="%0.1f", 
	[159]="%0.1f", 
	[150]="%0.1f", 
	[161]="%0.1f", 
	[15]="%0.1f", 
	[16]="%0.1f", 
	[17]="%0.1f", 
	[18]="%0.1f", 
	[19]="%0.1f", 
	[20]="%0.1f", 
	[21]="%0.1f", 
	[22]="%0.1f", 
	[23]="%0.1f", 
	[50]="%0.1f", 
	[25]="%0.1f", 
	[28]="%0.1f", 
	[26]="%0.1f", 
	[27]="%0.1f", 
	[31]="%0.1f", 
	[32]="%0.1f", 
	[33]="%0.1f", 
	[34]="%0.1f", 
	[582]="%0.1f", 
	[541]="%0.1f", 
	[542]="%0.1f", 
	[315]="%0.1f", 
	[519]="%0.1f", 
	[316]="%0.1f", 
	[520]="%0.1f", 
	[317]="%0.1f", 
	[521]="%0.1f", 
	[318]="%0.1f", 
	[313]="%0.1f", 
	[314]="%0.1f", 
	[522]="%0.1f", 
	[319]="%0.1f", 
	[320]="%0.1f", 
	[321]="%0.1f", 
	[322]="%0.1f", 
	[323]="%0.1f", 
	[330]="%0.1f", 
	[332]="%0.1f", 
	[331]="%0.1f", 
	[333]="%0.1f", 
	[334]="%0.1f", 
	[375]="%0.1f", 
	[419]="%0.1f", 
	[577]="%.3f", 
	[574]="%.2f", 
	[575]="%.2f", 
	[576]="%.2f", 
	[437]="%0.1f", 
	[438]="%0.1f", 
	[439]="%0.1f", 
	[440]="%0.1f", 
	[441]="%0.1f", 
	[163]="%0.1f", 
	[162]="%0.1f", 
	[168]="%0.1f", 
	[169]="%0.1f", 
	[174]="%0.1f", 
	[6]="%.4f", 
	[586]="%0.1f", 
	[261]="%0.1f", 
	[461]="%0.1f", 
	[237]="%0.1f", 
	[239]="%0.1f", 
	[568]="%0.1f", 
	[241]="%0.1f", 
	[243]="%0.1f", 
	[244]="%0.1f", 
	[245]="%0.1f", 
	[592]="%.4f", 
	[234]="%0.2f", 
	[235]="%0.2f", 
	[252]="%.4f", 
	[253]="%.4f", 
	[254]="%.4f", 
	[255]="%.4f", 
	[256]="%.4f", 
	[257]="%.4f", 
	[469]="%0.1f", 
	[470]="%0.1f", 
	[471]="%.4f", 
	[472]="%.4f", 
	[473]="%.4f", 
	[474]="%.4f", 
	[475]="%.4f", 
	[476]="%.4f", 
	[342]="%0.1f", 
	[339]="%0.4f", 
	[594]="%0.4f", 
	[337]="%0.4f", 
	[596]="%0.4f"
}
gKa50LowImportanceArguments = 
{
	[110]="%.1f", 
	[113]="%.1f", 
	[54]="%1d", 
	[56]="%1d", 
	[57]="%1d", 
	[55]="%.1f", 
	[96]="%.1f", 
	[572]="%.1f", 
	[45]="%.1f", 
	[230]="%1d", 
	[131]="%.1f", 
	[132]="%.1f", 
	[616]="%.1f", 
	[512]="%.1f", 
	[513]="%.1f", 
	[514]="%.1f", 
	[515]="%.1f", 
	[516]="%.1f", 
	[523]="%.1f", 
	[517]="%.3f", 
	[130]="%0.1f", 
	[8]="%.3f", 
	[9]="%1d", 
	[7]="%.1f", 
	[510]="%0.1f", 
	[387]="%1d", 
	[402]="%.1f", 
	[396]="%1d", 
	[403]="%1d", 
	[399]="%1d", 
	[400]="%0.1f", 
	[398]="%1d", 
	[397]="%.1f", 
	[404]="%1d", 
	[406]="%.3f", 
	[407]="%.3f", 
	[405]="%.3f", 
	[408]="%0.1f", 
	[409]="%1d", 
	[382]="%0.1f", 
	[383]="%1d", 
	[381]="%0.2f", 
	[384]="%.1f", 
	[385]="%.1f", 
	[386]="%0.1f", 
	[442]="%.1f", 
	[65]="%1d", 
	[66]="%1d", 
	[67]="%1d", 
	[146]="%0.1f", 
	[147]="%0.1f", 
	[539]="%1d", 
	[151]="%1d", 
	[153]="%1d", 
	[154]="%0.1f", 
	[156]="%.1f", 
	[35]="%.1f", 
	[583]="%1d", 
	[584]="%.1f", 
	[36]="%0.1f", 
	[37]="%0.1f", 
	[38]="%.1f", 
	[39]="%.1f", 
	[41]="%.1f", 
	[43]="%.1f", 
	[42]="%.1f", 
	[40]="%.1f", 
	[496]="%1d", 
	[497]="%1d", 
	[498]="%1d", 
	[499]="%1d", 
	[312]="%0.1f", 
	[303]="%0.1f", 
	[304]="%0.1f", 
	[305]="%0.1f", 
	[306]="%0.1f", 
	[307]="%0.1f", 
	[308]="%0.1f", 
	[309]="%0.1f", 
	[310]="%0.1f", 
	[311]="%0.1f", 
	[324]="%0.1f", 
	[325]="%1d", 
	[326]="%1d", 
	[327]="%.3f", 
	[328]="%0.1f", 
	[329]="%0.1f", 
	[335]="%0.1f", 
	[336]="%0.1f", 
	[355]="%.1f", 
	[354]="%1d", 
	[353]="%.3f", 
	[356]="%1d", 
	[357]="%0.1f", 
	[371]="%0.1f", 
	[372]="%.3f", 
	[373]="%.1f", 
	[374]="%1d", 
	[376]="%.1f", 
	[377]="%.1f", 
	[378]="%.1f", 
	[379]="%.1f", 
	[380]="%1d", 
	[418]="%.1f", 
	[417]="%1d", 
	[421]="%1d", 
	[422]="%1d", 
	[420]="%1d", 
	[423]="%1d", 
	[432]="%1d", 
	[431]="%0.1f", 
	[436]="%1d", 
	[433]="%1d", 
	[435]="%1d", 
	[434]="%1d", 
	[412]="%.1f", 
	[413]="%.1f", 
	[414]="%.1f", 
	[415]="%0.1f", 
	[416]="%0.1f", 
	[428]="%0.2f", 
	[554]="%1d", 
	[555]="%1d", 
	[556]="%1d", 
	[301]="%0.1f", 
	[224]="%.1f", 
	[262]="%1d", 
	[263]="%1d", 
	[543]="%1d", 
	[544]="%1d", 
	[264]="%1d", 
	[265]="%1d", 
	[267]="%1d", 
	[268]="%1d", 
	[269]="%1d", 
	[270]="%0.1f", 
	[271]="%1d", 
	[272]="%1d", 
	[273]="%1d", 
	[274]="%1d", 
	[275]="%1d", 
	[276]="%1d", 
	[277]="%1d", 
	[278]="%1d", 
	[279]="%1d", 
	[280]="%1d", 
	[281]="%1d", 
	[282]="%1d", 
	[283]="%1d", 
	[284]="%1d", 
	[285]="%1d", 
	[286]="%1d", 
	[287]="%1d", 
	[288]="%1d", 
	[289]="%1d", 
	[547]="%1d", 
	[548]="%1d", 
	[214]="%1d", 
	[215]="%1d", 
	[216]="%1d", 
	[217]="%1d", 
	[462]="%0.1f", 
	[460]="%.1f", 
	[220]="%1d", 
	[221]="%1d", 
	[218]="%1d", 
	[219]="%1d", 
	[222]="%1d", 
	[229]="%0.1f", 
	[228]="%1d", 
	[296]="%1d", 
	[297]="%0.1f", 
	[290]="%1d", 
	[291]="%1d", 
	[292]="%1d", 
	[293]="%1d", 
	[294]="%1d", 
	[569]="%1d", 
	[295]="%0.1f", 
	[570]="%0.1f", 
	[457]="%.1f", 
	[458]="%.1f", 
	[459]="%.1f", 
	[300]="%1d", 
	[299]="%1d", 
	[298]="%1d", 
	[236]="%.1f", 
	[238]="%.1f", 
	[240]="%.1f", 
	[242]="%.1f", 
	[248]="%0.1f", 
	[249]="%0.1f", 
	[250]="%1d", 
	[246]="%1d", 
	[247]="%1d", 
	[258]="%0.1f", 
	[259]="%1d", 
	[483]="%0.1f", 
	[484]="%0.1f", 
	[485]="%1d", 
	[486]="%1d", 
	[489]="%.1f", 
	[490]="%1d", 
	[491]="%1d", 
	[492]="%1d", 
	[487]="%1d", 
	[488]="%1d", 
	[452]="%1d", 
	[453]="%1d", 
	[340]="%.3f", 
	[341]="%1d", 
	[338]="%.3f",
	[450]="%1d", 	-- added by capt zeen to ka50 interface
	[90]="%0.2f",	-- added by capt zeen to ka50 interface
	[451]="%0.2f",	-- added by capt zeen to ka50 interface
	[507]="%0.2f",	-- added by capt zeen to ka50 interface
	[593]="%0.2f",	-- added by capt zeen to ka50 interface
	[508]="%0.2f", 	-- added by capt zeen to ka50 interface
	[587]="%0.2f", 	-- added by capt zeen to ka50 interface
	[599]="%0.2f", 	-- added by capt zeen to ka50 interface
	[613]="%0.2f", 	-- added by capt zeen to ka50 interface
	[1001]="%.1f" 	-- added by capt zeen to ka50 interface
	
}

gAV8BHighImportanceArguments = {[196]="%0.1f", [197]="%0.1f", [283]="%0.1f", [285]="%0.1f", [281]="%0.1f", [276]="%0.1f", [277]="%0.1f", [278]="%0.1f", [279]="%0.1f", [326]="%0.1f", [327]="%0.1f", [328]="%0.1f", [329]="%0.1f", [330]="%0.1f", [331]="%0.1f", [334]="%0.1f", [335]="%0.1f", [336]="%0.1f", [337]="%0.1f", [338]="%0.1f", [339]="%0.1f", [340]="%0.1f", [341]="%0.1f", [342]="%0.1f", [343]="%0.1f", [344]="%0.1f", [750]="%0.1f", [751]="%0.1f", [752]="%0.1f", [560]="%0.1f", [561]="%0.1f", [562]="%0.1f", [563]="%0.1f", [564]="%0.1f", [565]="%0.1f", [566]="%0.1f", [567]="%0.1f", [568]="%0.1f", [569]="%0.1f", [570]="%0.1f", [571]="%0.1f", [572]="%0.1f", [573]="%0.1f", [574]="%0.1f", [575]="%0.1f", [576]="%0.1f", [577]="%0.1f", [578]="%0.1f", [579]="%0.1f", [580]="%0.1f", [581]="%0.1f", [582]="%0.1f", [583]="%0.1f", [584]="%0.1f", [585]="%0.1f", [586]="%0.1f", [587]="%0.1f", [588]="%0.1f", [589]="%0.1f", [590]="%0.1f", [591]="%0.1f", [592]="%0.1f", [593]="%0.1f", [594]="%0.1f", [595]="%0.1f", [596]="%0.1f", [597]="%0.1f", [598]="%0.1f", [599]="%0.1f", [600]="%0.1f", [601]="%0.1f", [602]="%0.1f", [603]="%0.1f", [604]="%0.1f", [605]="%0.1f", [606]="%0.1f", [446]="%0.1f", [462]="%0.1f", [463]="%0.1f", [464]="%0.1f", [465]="%0.1f", [466]="%0.1f", [467]="%0.1f", [469]="%0.1f", [468]="%0.1f", [451]="%0.1f", [452]="%0.1f", [453]="%0.1f", [473]="%.4f", [474]="%.4f", [406]="%0.1f", [408]="%0.1f", [410]="%0.1f", [412]="%0.1f", [414]="%0.1f", [416]="%0.1f", [418]="%0.1f", [385]="%.4f", [386]="%.4f", [387]="%.4f", [271]="%.4f", [266]="%.4f", [177]="%0.1f", [608]="%.4f", [559]="%.4f", [607]="%.4f", [362]="%.4f", [361]="%.4f", [360]="%0.1f", [346]="%.4f", [349]="%.4f", [348]="%.4f", [347]="%0.1f", [363]="%.4f", [652]="%.4f", [654]="%0.1f"}
gAV8BLowImportanceArguments = {[200]="%1d", [201]="%1d", [202]="%1d", [203]="%1d", [204]="%1d", [205]="%1d", [206]="%1d", [207]="%1d", [208]="%1d", [209]="%1d", [210]="%1d", [211]="%1d", [212]="%1d", [213]="%1d", [214]="%1d", [215]="%1d", [216]="%1d", [217]="%1d", [218]="%1d", [219]="%1d", [194]="%.3f", [220]="%1d", [221]="%1d", [222]="%1d", [223]="%1d", [224]="%.1f", [225]="%.1f", [226]="%.1f", [227]="%.1f", [228]="%.1f", [229]="%.1f", [230]="%.1f", [231]="%.1f", [232]="%.1f", [233]="%.1f", [234]="%.1f", [235]="%.1f", [236]="%.1f", [237]="%.1f", [238]="%.1f", [239]="%.1f", [240]="%.1f", [241]="%.1f", [242]="%.1f", [243]="%.1f", [195]="%.3f", [244]="%1d", [245]="%1d", [246]="%1d", [247]="%1d", [302]="%.1f", [303]="%.1f", [304]="%.1f", [306]="%.1f", [307]="%.1f", [308]="%.1f", [310]="%.1f", [311]="%.1f", [312]="%.1f", [315]="%.1f", [316]="%.1f", [313]="%.1f", [314]="%.1f", [305]="%.1f", [294]="%.1f", [324]="%.1f", [318]="%.1f", [319]="%.1f", [320]="%.1f", [317]="%.1f", [325]="%.1f", [296]="%.1f", [322]="%.1f", [321]="%.1f", [323]="%.1f", [297]="%.1f", [309]="%.1f", [198]="%.1f", [199]="%.1f", [295]="%.3f", [298]="%.3f", [299]="%.3f", [300]="%.3f", [301]="%.3f", [178]="%.1f", [179]="%.1f", [288]="%.1f", [289]="%.3f", [290]="%.1f", [291]="%.3f", [292]="%.3f", [293]="%1d", [282]="%.1f", [284]="%.1f", [280]="%.1f", [250]="%.1f", [251]="%.1f", [252]="%.1f", [248]="%.1f", [249]="%.1f", [380]="%.3f", [3379]="%0.1f", [3273]="%0.1f", [3274]="%0.1f", [3275]="%0.1f", [461]="%1d", [458]="%.1f", [448]="%.1f", [447]="%1d", [470]="%1d", [449]="%.1f", [450]="%.1f", [454]="%.1f", [460]="%.1f", [457]="%.1f", [459]="%.1f", [422]="%1d", [423]="%1d", [424]="%1d", [425]="%.1f", [426]="%1d", [427]="%.1f", [429]="%1d", [3421]="%.1f", [481]="%1d", [482]="%1d", [484]="%1d", [485]="%.3f", [486]="%.3f", [490]="%.3f", [489]="%.3f", [487]="%.3f", [488]="%.3f", [471]="%.1f", [483]="%.1f", [476]="%1d", [477]="%.1f", [475]="%1d", [478]="%1d", [479]="%1d", [480]="%1d", [504]="%1d", [508]="%1d", [509]="%1d", [505]="%.1f", [506]="%.1f", [507]="%.1f", [472]="%.1f", [503]="%.1f", [510]="%.3f", [511]="%.1f", [512]="%1d", [513]="%1d", [514]="%1d", [515]="%1d", [516]="%1d", [517]="%1d", [518]="%1d", [287]="%1d", [396]="%1d", [397]="%1d", [398]="%1d", [399]="%1d", [400]="%1d", [401]="%1d", [402]="%1d", [403]="%1d", [420]="%1d", [407]="%.1f", [409]="%.1f", [411]="%.1f", [413]="%.1f", [415]="%.1f", [417]="%.1f", [419]="%.1f", [286]="%.1f", [3404]="%0.1f", [405]="%.1f", [3395]="%0.2f", [502]="%1d", [519]="%1d", [520]="%1d", [614]="%.3f", [615]="%.3f", [3616]="%0.1f", [617]="%.1f", [618]="%.1f", [3619]="%0.2f", [620]="%.1f", [621]="%1d", [622]="%1d", [623]="%1d", [624]="%1d", [625]="%1d", [626]="%1d", [627]="%1d", [628]="%.1f", [632]="%.1f", [633]="%.1f", [629]="%.3f", [630]="%.3f", [3631]="%0.1f", [634]="%.1f", [635]="%.3f", [636]="%.3f", [637]="%.3f", [638]="%.3f", [150]="%.3f", [151]="%.3f", [152]="%.3f", [153]="%.3f", [154]="%.3f", [155]="%.3f", [156]="%.3f", [157]="%.3f", [158]="%.3f", [159]="%.3f", [801]="%1d", [802]="%1d", [803]="%1d", [800]="%1d", [501]="%1d", [121]="%.1f", [122]="%.1f", [639]="%.3f", [640]="%0.1f", [641]="%0.1f", [642]="%0.1f", [643]="%0.1f", [655]="%.1f", [272]="%.3f", [613]="%.1f", [612]="%.1f", [611]="%1d", [610]="%.1f", [609]="%.1f", [653]="%.3f", [364]="%.3f", [351]="%.3f"}


gP51HighImportanceArguments = 
{
}
gP51LowImportanceArguments = 
{
}

gU1H1HighImportanceArguments = 
{
}
gU1H1LowImportanceArguments = 
{
}




-- Export arguments for the SA342 using the KA50 interface
SA342ExportArguments = {}
-- Format: device,button number, multiplier
-- arguments with multiplier 100, 101,102 or 300 are special conversion cases, and are computed in different way

	--NADIR
	SA342ExportArguments["20,3001"] = "23,3009,5"	-- NADIR_0 > PVI 0
	SA342ExportArguments["20,3002"] = "23,3010,5"	-- NADIR_1
	SA342ExportArguments["20,3003"] = "23,3011,5"	-- NADIR_2
	SA342ExportArguments["20,3004"] = "23,3012,5"	-- NADIR_3
	SA342ExportArguments["20,3005"] = "23,3013,5"	-- NADIR_4
	SA342ExportArguments["20,3006"] = "23,3014,5"	-- NADIR_5
	SA342ExportArguments["20,3007"] = "23,3015,5"	-- NADIR_6
	SA342ExportArguments["20,3008"] = "23,3016,5"	-- NADIR_7
	SA342ExportArguments["20,3009"] = "23,3017,5"	-- NADIR_8
	SA342ExportArguments["20,3010"] = "23,3018,5"	-- NADIR_9
	SA342ExportArguments["20,3011"] = "23,3004,5"	-- NADIR_ENT
	SA342ExportArguments["20,3012"] = "23,3005,5"	-- NADIR_DES
	SA342ExportArguments["20,3013"] = "23,3006,5"	-- NADIR_AUX
	SA342ExportArguments["20,3014"] = "23,3007,5"	-- NADIR_IC
	SA342ExportArguments["20,3015"] = "23,3008,5"	-- NADIR_DOWN
	SA342ExportArguments["20,3016"] = "23,3019,5"	-- NADIR_POL
	SA342ExportArguments["20,3017"] = "23,3020,5"	-- NADIR_GEO
	SA342ExportArguments["20,3018"] = "23,3021,5"	-- NADIR_POS
	SA342ExportArguments["20,3019"] = "23,3022,5"	-- NADIR_GEL
	SA342ExportArguments["20,3020"] = "23,3023,5"	-- NADIR_EFF
	SA342ExportArguments["20,3026"] = "23,3002,2"	-- NADIR mode
	SA342ExportArguments["46,3002"] = "23,3003,2"	-- NADIR parameter
	--RWR
	SA342ExportArguments["20,3021"] = "24,3002,5"	-- rwr marquer
	SA342ExportArguments["20,3022"] = "24,3003,5"	-- rwr page
	SA342ExportArguments["7,3002"] = "24,3001,1"	-- rwr on/off/croc   >   HUD night/day/standby
	--Main panel
	SA342ExportArguments["25,3015"] = "9,3007,3.3"	-- SA342 Source ArtVisVhfDop  >  datalink data mode
	SA342ExportArguments["20,3023"] = "2,3004,5"	-- SA342 Voltmeter Test        
	SA342ExportArguments["2,3001"] = "2,3001,1"		-- SA342 Battery	2 > dc power
	SA342ExportArguments["2,3002"] = "2,3002,1"		-- SA342 Alternator	2  > guarda dc power
	SA342ExportArguments["2,3003"] = "2,3003,1"		-- SA342 Generator	2 > batt 2
	SA342ExportArguments["2,3023"] = "2,3004,5"		-- SA342 Voltmeter Test b
	SA342ExportArguments["2,3004"] = "2,3005,1"		-- SA342 Pitot	2  > guarda batt 2
	SA342ExportArguments["2,3005"] = "2,3006,1"		-- SA342 Fuel Pump	2  > batt 1
	SA342ExportArguments["2,3006"] = "2,3007,1"		-- SA342 Additionnal Fuel Tank	2 > guarda batt 1
	SA342ExportArguments["12,3007"] = "2,3008,100"	-- SA342 Starter Start/Stop/Air	3  > weapons laser code
	SA342ExportArguments["2,3007"] = "2,3009,5"		-- SA342 Test b  >  ac gnd power
	SA342ExportArguments["12,3004"] = "2,3010,100"	-- SA342 Copilot Wiper	3 >  Weapon Burst Length
	SA342ExportArguments["22,3001"] = "2,3011,100"	-- SA342 Pilot Wiper	3 > UV_26 Release Select Switch
	SA342ExportArguments["2,3008"] = "2,3012,1"		-- SA342 space			2  >  ac left generator
	SA342ExportArguments["3,3001"] = "2,3013,5"		-- SA342 HYD Test b  >  "Fuel System", "Forward Fuel Tank Pumps"
	SA342ExportArguments["3,3002"] = "2,3014,5"		-- SA342 Alter Rearm b  >  "Fuel System", "Rear Fuel Tank Pumps"
	SA342ExportArguments["3,3003"] = "2,3015,5"		-- SA342 Gene Rearm b  >  "Fuel System", "Inner External Fuel Tank Pumps"
	SA342ExportArguments["3,3004"] = "2,3016,1"		-- SA342 Convoy Tank On/Off	2 > "Outer External Fuel Tank Pumps"
	SA342ExportArguments["3,3005"] = "2,3017,1"		-- SA342 Sand Filter On/Off	2 > "Fuel Meter power"
	SA342ExportArguments["2,3009"] = "15,3008,1"	-- SA342 Panels Lighting On/Off	2 > "AC Right Generator"
	SA342ExportArguments["3,3006"] = "7,3006,1"		-- SA342 Trim On/Off	2 > "Left Engine Fuel Shutoff Valve"
	SA342ExportArguments["3,3007"] = "7,3007,1"		-- SA342 Magnetic Brake On/Off	2 > "GUARD Left Engine Fuel Shutoff Valve"
	SA342ExportArguments["46,3005"] = "26,3001,1"	-- SA342 master arm	2 > ark22 ndb mode
	--LIGHTS
	SA342ExportArguments["4,3012"] = "15,3001,100"	-- SA342 nav lights	3 >  engines start mode
	SA342ExportArguments["2,3010"] = "15,3002,100"	-- SA342 anticol lights	3 > dc ac inverter
	SA342ExportArguments["46,3004"] = "15,3011,1"	-- form light on off >  ark22 adf mode
	--TV
	SA342ExportArguments["3,3008"] = "13,3001,1"	-- SA342 TV On/Off	2 > "Right Engine Fuel Shutoff Valve"
	SA342ExportArguments["7,3001"] = "13,3003,2"	-- SA342 TV brightness axis > hud brightness
	SA342ExportArguments["8,3003"] = "13,3002,2"	-- SA342 TV Contrast axis > Shkval contrast
	--GYRO
	SA342ExportArguments["3,3010"] = "7,3015,1"		-- SA342 Gyro Test Switch On/Off 2 > APU Fuel Shutoff Valve
	SA342ExportArguments["3,3011"] = "7,3014,1"		-- SA342 Gyro Test Cover On/Off  2 > APU Fuel Shutoff Valve guard
	SA342ExportArguments["4,3014"] = "7,3016,101"	-- SA342 Left/Center/Right	  3 > Enginges De-icing / dust-protection system
	SA342ExportArguments["34,3007"] = "7,3017,2.5"	-- SA342 CM/A/GM/D/GD   multipos   > Windshield Wiper Switch	
	--PE
	SA342ExportArguments["12,3022"] = "16,3006,1"	-- SA342 PE system M/A	 2 > weapons armed
	SA342ExportArguments["12,3005"] = "16,3001,1"	-- SA342 PE centering	 2 > weapons auto manual
	SA342ExportArguments["12,3006"] = "16,3002,1"	-- SA342 PE VDO/VTH	 2 > weapons HE/PA 
	SA342ExportArguments["6,3005"] = "16,3007,2.5"	-- SA342 PE mode	 2 > eject syst circuit selector 
	SA342ExportArguments["33,3006"] = "16,3005,1"	-- SA342 PE CTH	 3 > baro/radar alt
	SA342ExportArguments["45,3003"] = "16,3003,1"	-- SA342 PE zoom -	  3 > autopik track/heading
	SA342ExportArguments["33,3007"] = "16,3004,101"	-- SA342 PE zoom +	  3 > autopik track/heading
	--PH
	SA342ExportArguments["12,3014"] = "27,3001,2.5"	-- SA342 PH cle  >  Targeting Control Mode - Weapons System Mode 431
	SA342ExportArguments["49,3001"] = "27,3002,1.25"-- SA342 PH station selection  >  r828 channel
	--WP2
	SA342ExportArguments["12,3019"] = "26,3011,1"	-- SA342 weapon cover left		2 > weapons power cover
	SA342ExportArguments["12,3018"] = "26,3010,1"	-- SA342 weapon left		2	> weapons power
	SA342ExportArguments["3,3013"] = "26,3013,1"	-- SA342 weapon cover right		2 > crossfeed valve cover
	SA342ExportArguments["3,3012"] = "26,3012,1"	-- SA342 weapon right		2 > crossfeed valve
	SA342ExportArguments["12,3020"] = "26,3014,1"	-- SA342 weapon riple single	2 > weapons rate fire low hi
	SA342ExportArguments["28,3001"] = "26,3004,100"	-- SA342 weapons power	3 >  nav interface heading source
	--FD
	SA342ExportArguments["56,3004"] = "25,3002,1"	-- SA342 FD seq switch 2 > stby adi power
	SA342ExportArguments["40,3005"] = "25,3001,100"	-- SA342 FD G+D	3 > fire ext work off test
	SA342ExportArguments["4,3017"] = "25,3003,100"	-- SA342 FD LE VE AR 3 > engine pwr turb test
	--AUTOPILOT
	SA342ExportArguments["34,3001"] = "7,3001,1"	-- SA342 PA on off > CPT MECH gear
	SA342ExportArguments["34,3009"] = "7,3002,1"	-- SA342 PA pitch on 2 > CPT MECH pitot static
	SA342ExportArguments["34,3010"] = "7,3003,1"	-- SA342 PA roll on 2 > CPT MECH pitot ram
	SA342ExportArguments["4,3013"] = "7,3004,1"		-- SA342 PA yaw on 2 > engine rotor de icing
	SA342ExportArguments["25,3014"] = "7,3005,100"	-- SA342 PA mode 3 > datalink self id
	--UHF
	SA342ExportArguments["8,3006"] = "31,3001,1.67"	-- SA342 UHF left rot >SHKVAL scan rate
	SA342ExportArguments["9,3001"] = "31,3002,1"	-- SA342 UHF drw > ABRIS button 1
	SA342ExportArguments["9,3002"] = "31,3003,1"	-- SA342 UHF vld > ABRIS button 2
	SA342ExportArguments["9,3003"] = "31,3005,1"	-- SA342 UHF conf > ABRIS button 3
	SA342ExportArguments["9,3004"] = "31,3006,1"	-- SA342 UHF 1 > ABRIS button 4
	SA342ExportArguments["9,3005"] = "31,3007,1"	-- SA342 UHF 2 > ABRIS button 5
	SA342ExportArguments["9,3007"] = "31,3008,1"	-- SA342 UHF 3 > ABRIS button 6
	SA342ExportArguments["34,3011"] = "31,3009,1"	-- SA342 UHF 4 > CPT MECH Pitot heat system test
	SA342ExportArguments["22,3004"] = "31,3010,1"	-- SA342 UHF 5 > UV26 Num of sequences
	SA342ExportArguments["22,3005"] = "31,3011,1"	-- SA342 UHF 6 > UV26 Num in sequence
	SA342ExportArguments["22,3006"] = "31,3012,1"	-- SA342 UHF 7 > UV26 Dispence interval
	SA342ExportArguments["22,3007"] = "31,3013,1"	-- SA342 UHF 8 > UV26 Start dispense
	SA342ExportArguments["22,3008"] = "31,3014,1"	-- SA342 UHF 9 > UV26 Reset to default program
	SA342ExportArguments["22,3009"] = "31,3015,1"	-- SA342 UHF 0 > UV26 Stop dispense
	--FM
	SA342ExportArguments["12,3023"] = "28,3001,2.5"	--  SA342 selector > weapons ballistic seletor
	SA342ExportArguments["37,3001"] = "28,3002,1.43"--  SA342 channels > ppk atgm temp
	--AM
	SA342ExportArguments["36,3002"] = "5,3003,1"	-- SA342 AM 25-50 > laser warning sys power
	SA342ExportArguments["50,3002"] = "5,3001,3"	-- SA342 AM radio A-M-SQ-TEST > spu9 source
	SA342ExportArguments["30,3001"] = "5,3004,1"	-- SA342 left freq rotary > hsi commanded course
	SA342ExportArguments["30,3002"] = "5,3002,1"	-- SA342 right freq rotary > hsi commanded heading
	--ADF
	SA342ExportArguments["11,3003"] = "21,3001,1"	-- SA342 ADF select > laser-ranger
	SA342ExportArguments["11,3002"] = "21,3002,1"	-- SA342 ADF tune > laser-ranger guard
	SA342ExportArguments["8,3002"] = "21,3003,1"	-- SA342 ADF on/ant/adf/test  >  abris bright
	SA342ExportArguments["31,3001"] = "21,3007,1"	-- ADF 1 decimal rot >  adi zero pitch
	SA342ExportArguments["38,3001"] = "21,3006,1"	-- ADF 1 decenas rot >  radar altimeter
	SA342ExportArguments["56,3003"] = "21,3005,1"	-- ADF 1 centenas rot >  stby adi cage
	SA342ExportArguments["9,3006"] = "21,3010,1"	-- ADF 2 decimal rot >  abris cursor
	SA342ExportArguments["48,3007"] = "21,3009,1"	-- ADF 2 decenas rot >  r800 1 ot
	SA342ExportArguments["48,3008"] = "21,3008,1"	-- ADF 2 centenas rot >  r800 2 rot
	SA342ExportArguments["23,3001"] = "21,3004,1"	-- ADF gain rot >  hms bright
	--instruments buttons
	SA342ExportArguments["11,3004"] = "17,3001,1"	-- torque test >  laser ranger reset
	SA342ExportArguments["48,3009"] = "17,3002,1"	-- torque safe % bug >  r800 3 rot
	SA342ExportArguments["13,3002"] = "18,3002,102"	-- RALT On / Off >  VMS Emergency Mode Switch
	SA342ExportArguments["30,3003"] = "18,3003,1"	-- Ralt test > HSI button test
	SA342ExportArguments["12,3003"] = "9,3002,1"	-- HA pull > PUI-800 External Stores Jettison
	SA342ExportArguments["12,3021"] = "9,3004,1"	-- stby HA pull > PUI-800 Emergency ATGM launch
	--Clock
	SA342ExportArguments["4,3022"] = "20,3002,1"	-- SA342 Clock start stop > Engine Running EGT Test Button
	SA342ExportArguments["31,3003"] = "20,3003,1"	-- SA342 Clock Reset > ADI test
	--Intercom
	SA342ExportArguments["59,3001"] = "4,3001,1"	-- IC1 VHF >  ZMS-3 Magnetic Variation
	SA342ExportArguments["58,3001"] = "4,3003,1"	-- IC1 UHF >  PShK-7 Latitude Entry
	SA342ExportArguments["20,3029"] = "4,3002,1"	-- IC1 FM1 >  PVI-800 Control Panel Brightness
	--Collective
	SA342ExportArguments["44,3002"] = "25,3004,1"	-- SA342 flare dispenser guard > Landing Light Primary/Backup Select
	SA342ExportArguments["13,3004"] = "25,3005,1"	-- SA342 flare dispenser fire > Landing Light Primary/Backup Select
	SA342ExportArguments["44,3001"] = "15,3003,101"	--  SA342 Landing Light Off/Vario/On	3 > Landing Light", "On/Off/Retract
	SA342ExportArguments["13,3001"] = "15,3004,1"	--  SA342 Landing Light Extend	2 > VMS Cease Message
	SA342ExportArguments["13,3003"] = "15,3006,-1"	--  SA342 Landing Light Retract	2 > VMS Repeat Message
	--Special case
	SA342ExportArguments["48,3010"] = "24,3005,300" -- Special case, several encoders and axis in the same KA50 encoder

		

-------------------------------------------------------------------------------------------------------------------------------- end SA342






-- Export arguments for the L39ZA using the A10C interface
L39ZA_ExportArguments = {}
-- Format: device,button number, multiplier
-- arguments with multiplier 100, 101,102 or >300 are special conversion cases, and are computed in different way
--                     A10C        L39C

	


 
L39ZA_ExportArguments["1,3000"] = "1,3003,1"   -- ASP-3NMU Gunsight Mode, GYRO/FIXED 101 sw 2 pos > 
L39ZA_ExportArguments["1,3000"] = "1,3004,1"   -- ASP-3NMU Gunsight Brightness Knob 102 axis 0.2 > 
L39ZA_ExportArguments["1,3000"] = "1,3001,1"   -- ASP-3NMU Gunsight Target Wingspan Adjustment Dial (meters) 103 axis -0.1 > 
L39ZA_ExportArguments["1,3000"] = "1,3012,1"   -- ASP-3NMU Gunsight Color Filter, ON/OFF 104 lever 2.0 > 
L39ZA_ExportArguments["1,3000"] = "1,3011,1"   -- ASP-3NMU Gunsight Fixed Reticle Mask Lever 105 lever 7.0 > 
L39ZA_ExportArguments["1,3000"] = "1,3016,1"   -- ASP-3NMU Gunsight Mirror Depression 106 axis 0.05 > 
L39ZA_ExportArguments["1,3000"] = "1,3002,1"   -- ASP-3NMU Gunsight Target Distance 107 axis 0.1 > 
	L39ZA_ExportArguments["49,3008"] = "12,3001,1"  -- Mech clock left lever (left click) 335 btn 1.0 > "Light System", "Position Flash" 132
	L39ZA_ExportArguments["38,3001"] = "12,3002,1"  -- Mech clock left lever (right click) 335 btn -1.0 > "Autopilot", "Mode Selection" 132
	L39ZA_ExportArguments["8,3028"] = "12,3003,0.1"  -- Mech clock left lever  336 lever 0.04 > "UFC", "HUD Brightness"   rocker --
	L39ZA_ExportArguments["8,3029"] = "12,3003,0.1"  -- Mech clock left lever  336 lever 0.04 > "UFC", "HUD Brightness"   rocker --
	L39ZA_ExportArguments["9,3043"] = "12,3004,1"  -- Mech clock right lever 337 btn > "CDU", "Q" 453
	L39ZA_ExportArguments["5,3007"] = "12,3005,1"  -- Mech clock right lever 338 lever 0.1> "CMSC", "RWR Volume" 368
	L39ZA_ExportArguments["9,3066"] = "9,3001,1"   -- Baro pressure QFE knob 57 axis 0.6 >  "CDU", "+/-" 472  rocker --
	L39ZA_ExportArguments["9,3067"] = "9,3001,1"   -- Baro pressure QFE knob 57 axis 0.6 >  "CDU", "+/-" 472  rocker --
	L39ZA_ExportArguments["9,3064"] = "14,3001,0.1"  -- RV-5M Radio Altimeter Decision Height Knob 61 axis 0.2 > "CDU", "Blank"  rocker --
	L39ZA_ExportArguments["9,3065"] = "14,3001,0.1"  -- RV-5M Radio Altimeter Decision Height Knob 61 axis 0.2 > "CDU", "Blank"  rocker --
	L39ZA_ExportArguments["9,3041"] = "14,3002,1"  -- RV-5M Radio Altimeter Test Button 60 sw 2 pos > "CDU", "O" 451
	L39ZA_ExportArguments["54,3010"] = "17,3002,102"  -- GMK-1AE GMC Hemisphere Selection Switch, N(orth)/S(outh) 204 sw 2 pos >  "UHF Radio", "Squelch" 170
	L39ZA_ExportArguments["54,3014"] = "17,3004,102"  -- GMK-1AE GMC Mode Switch, MC(Magnetic Compass Mode)/GC(Directional Gyro Mode) 207 sw 2 pos >  "UHF Radio", "Cover" 734
	L39ZA_ExportArguments["43,3018"] = "17,3003,1"  -- GMK-1AE GMC Test Switch, 0(degrees)/OFF/300(degrees) - Use to check heading indication accuracy 205 sw 3 pos -1 0 1> "IFF", "M-3/A Switch" 204
	L39ZA_ExportArguments["43,3019"] = "17,3005,1"  -- GMK-1AE GMC Course Selector Switch, CCW/OFF/CW 208 sw 3 pos -1 0 1 >  "IFF", "M-C Switch" 205
	L39ZA_ExportArguments["4,3005"] = "17,3006,300"  -- GMK-1AE GMC Latitude Selector Knob 209 axis 0.02 > "CMSP", "Page Cycle" rocker --
	L39ZA_ExportArguments["4,3006"] = "17,3006,301"  -- GMK-1AE GMC Latitude Selector Knob 209 axis 0.02 > "CMSP", "Page Cycle" rocker --
	L39ZA_ExportArguments["12,3014"] = "17,3012,1"  -- MC Synchronization Button - Push to synchronize (level flight only) 124 btn > "IFFCC", "Ext Stores Jettison" 101
L39ZA_ExportArguments["44,3007"] = "17,3014,1"  -- Magnetic Declination set knob {0.0, 1.0} in 0.05 Steps 532 axis 0.05 > "HARS", "Sync Button Rotate" 268
	L39ZA_ExportArguments["9,3040"] = "22,3002,1"  -- KPP-1273K Attitude Director Indicator (ADI) Cage Button 30 btn > "CDU", "N" 450
	L39ZA_ExportArguments["38,3013"] = "22,3003,1"  -- KPP-1273K Attitude Director Indicator (ADI) Pitch Trim Knob 39 axis 0.05 -1 1 > "Autopilot", "Yaw Trim" 192
	L39ZA_ExportArguments["69,3007"] = "41,3001,1"  -- SDU Switch, ON/OFF 177 sw 2 pos > "KY-58 Secure Voice", "Power Switch" 784
L39ZA_ExportArguments["22,3000"] = "22,3008,1"  -- AGD Pitch Failure 460 sw 2 pos > 
L39ZA_ExportArguments["22,3000"] = "22,3009,1"  -- AGD Bank Failure 461 sw 2 pos > 
	L39ZA_ExportArguments["9,3060"] = "24,3001,0.1"  -- HSI Course set knob 48 axis 0.15 > "CDU", "Brightness" rocker --
	L39ZA_ExportArguments["9,3061"] = "24,3001,0.1"  -- HSI Course set knob 48 axis 0.15 > "CDU", "Brightness" rocker --
L39ZA_ExportArguments["25,3000"] = "25,3002,1"  -- Course Accordance 526 btn > 
L39ZA_ExportArguments["24,3000"] = "24,3002,1"  -- GMK Failure 458 sw 2 pos > 
	L39ZA_ExportArguments["3,3036"] = "31,3001,1"  -- RSBN Mode Switch, LANDING/NAVIGATION/GLIDE PATH {0.0,0.1,0.2} 178 sw 3 pos > "Right MFCD", "Day/Night/Off" 351
	L39ZA_ExportArguments["2,3001"] = "31,3002,1"  -- RSBN Identification Button 179 btn >       "Left MFCD", "OSB1" 300
	L39ZA_ExportArguments["2,3002"] = "31,3003,1"  -- RSBN Test Button - Push to test 180 btn >  "Left MFCD", "OSB2" 301
	L39ZA_ExportArguments["49,3009"] = "31,3004,1"  -- RSBN Control Box Lighting Intensity Knob 181 axis 0.04 0.0, 0.8 > "Light System", "Formation Lights" 288
	L39ZA_ExportArguments["49,3002"] = "31,3005,1"  -- RSBN Volume Knob 184 axis 0.04 0.0, 0.8 > "Light System", "Flight Instruments Lights" 292
	L39ZA_ExportArguments["43,3016"] = "31,3006,1"  -- Initial Azimuth 187 spr sw 3 pos -1.0,0.0,1.0> "IFF", "M-1 Switch" 202
	L39ZA_ExportArguments["43,3017"] = "31,3007,1"  -- Initial Range 188 spr sw 3 pos -1.0,0.0,1.0>   "IFF", "M-2 Switch" 203
	L39ZA_ExportArguments["12,3003"] = "31,3008,1"  -- RSBN Navigation Channel Selector Knob 191 multi sw 40 0.025 > "TISL", "Altitude above target tens of thousands of feet" 624
	L39ZA_ExportArguments["12,3004"] = "31,3009,1"  -- RSBN Landing Channel Selector Knob 192 multi sw 40 0.025  >   "TISL", "Altitude above target thousands of feet" 626
	L39ZA_ExportArguments["2,3004"] = "31,3010,1"  -- Set 0 Azimuth 193 btn > "Left MFCD", "OSB4" 303
	L39ZA_ExportArguments["49,3006"] = "31,3011,1"  -- RSBN Field Elevation Knob 201 axis 0.02 > "Light System", "Console Lights" 297
	L39ZA_ExportArguments["2,3009"] = "31,3012,1"  -- RSBN Listen Callsign Button - Push to listen 297 btn > "Left MFCD", "OSB9" 308
L39ZA_ExportArguments["31,3000"] = "31,3013,1"  -- RSBN Emergency Landing Switch, ON/OFF 527 sw 2 pos > 
	L39ZA_ExportArguments["9,3062"] = "15,3001,0.5"  -- Variometer adjustment knob 569 axis 0.1 > "CDU", "Page"    rocker --
	L39ZA_ExportArguments["9,3063"] = "15,3001,0.5"  -- Variometer adjustment knob 569 axis 0.1 > "CDU", "Page"    rocker --
	L39ZA_ExportArguments["67,3001"] = "21,3011,1"  -- RKL-41 ADF Outer-Inner Beacon (Far-Near NDB) Switch 119 sw 2 pos > "Radar Altimeter", "Normal/Disabled" 130
	L39ZA_ExportArguments["12,3005"] = "21,3001,1"  -- RKL-41 ADF Volume Knob 157 axis 0.05 >     "TISL", "TISL Code Wheel 1" 636
	L39ZA_ExportArguments["12,3006"] = "21,3013,1"  -- RKL-41 ADF Brightness Knob 161 axis 0.05 > "TISL", "TISL Code Wheel 2" 638
	L39ZA_ExportArguments["50,3002"] = "21,3002,1"  -- RKL-41 ADF Mode Switch, TLF(A3)/TLG(A1,A2) 159 sw 2 pos > "Fire System", "APU Fire Pull" 103
	L39ZA_ExportArguments["4,3018"] = "21,3003,1"  -- RKL-41 ADF Function Selector Switch, OFF/COMP(AUTO)/COMP(MAN)/ANT/LOOP 160 multi sw 5 pos 0.1 > "CMSP", "Mode Select Dial" 364 - 5 pos
	L39ZA_ExportArguments["50,3004"] = "21,3010,1"  -- RKL-41 ADF Loop Switch, LEFT/OFF/RIGHT {-1.0,0.0,1.0} 162 spr sw 3 pos > "Fire System", "Discharge Switch" 105
	L39ZA_ExportArguments["50,3003"] = "21,3012,1"  -- RKL-41 ADF Control Switch, TAKE CONTROL/HAND OVER CONTROL 158 sw 2 pos > "Fire System", "Right Engine Fire Pull" 104
	L39ZA_ExportArguments["12,3007"] = "21,3004,1"  -- RKL-41 ADF Far NDB Frequency Tune 165 axis 0.05  > "TISL", "TISL Code Wheel 3" 640
	L39ZA_ExportArguments["58,3002"] = "21,3005,1"  -- RKL-41 ADF Far NDB 100kHz rotary 163  weel arc 0.0588 0.0,0.938 > "Intercom", "INT Volume" 221
	L39ZA_ExportArguments["58,3004"] = "21,3006,1"  -- RKL-41 ADF Far NDB 10kHz rotary 164 weel arc 0.1 0.0,0.9 >        "Intercom", "FM Volume" 223
	L39ZA_ExportArguments["12,3008"] = "21,3007,1"  -- RKL-41 ADF Near NDB Frequency Tune 168 axis 0.05 > "TISL", "TISL Code Wheel 4" 642
	L39ZA_ExportArguments["41,3003"] = "21,3008,1"  -- RKL-41 ADF Near NDB 100kHz rotary 166  weel arc 0.0588 0.0,0.938  > "Environmental Control", "Canopy Defog" 277
	L39ZA_ExportArguments["41,3009"] = "21,3009,1"  -- RKL-41 ADF Near ND  10kHz rotary 167 weel arc 0.1 0.0,0.9 >         "Environmental Control", "Flow Level" 284
L39ZA_ExportArguments["21,3000"] = "21,3027,1"  -- RKL-41 ARK Failure 459 sw 2 pos >
	L39ZA_ExportArguments["37,3001"] = "4,3001,1"   -- Battery Switch, ON/OFF 141 sw 2 pos > "Engine System", "Left Engine Fuel Flow Control" 122
	L39ZA_ExportArguments["37,3002"] = "4,3002,1"   -- Main Generator Switch, ON/OFF 142 sw 2 pos > "Engine System", "Right Engine Fuel Flow Control" 123
	L39ZA_ExportArguments["37,3005"] = "4,3003,1"   -- Emergency Generator Switch, ON/OFF 143 sw 2 pos > "Engine System", "APU" 126
	L39ZA_ExportArguments["69,3003"] = "4,3072,1"   -- Emergency Engine Instruments Power Switch, ON/OFF 169 sw 2 pos > "KY-58 Secure Voice", "Delay" 780
	L39ZA_ExportArguments["58,3007"] = "4,3006,1"	-- Turbo Button Cover, Open/Close 314 sw 2 pos > "Intercom", "UHF Switch"228
	L39ZA_ExportArguments["2,3014"] = "4,3005,1"   -- Turbo Button 315 btn > "Left MFCD", "OSB14" 313
	L39ZA_ExportArguments["58,3009"] = "4,3010,1"   -- Stop Turbo Switch Cover, Open/Close 312 sw 2 pos > "Intercom", "AIM Switch" 230
	L39ZA_ExportArguments["58,3001"] = "4,3009,1"   -- Stop Turbo Switch, ON/OFF 313 sw 2 pos > "Intercom", "INT Switch" 222
	L39ZA_ExportArguments["58,3011"] = "4,3012,1"   -- Engine Button Cover, Open/Close 325 sw 2 pos > "Intercom", "IFF Switch" 232
	L39ZA_ExportArguments["2,3015"] = "4,3011,1"   -- Engine Button 326 btn >  "Left MFCD", "OSB15" 314
	L39ZA_ExportArguments["58,3013"] = "4,3016,1"   -- Stop Engine Switch Cover, Open/Close 317 sw 2 pos > "Intercom", "ILS Switch" 234
	L39ZA_ExportArguments["58,3003"] = "4,3015,1"   -- Stop Engine Switch 318 sw 2 pos > Intercom", "FM Switch" 224
	L39ZA_ExportArguments["58,3015"] = "4,3020,1"   -- Engine Start Mode Switch Cover, Open/Close 321 sw 2 pos > "Intercom", "TCN Switch" 236
	L39ZA_ExportArguments["54,3009"] = "4,3019,1"   -- Engine Start Mode Switch, START/FALSE START/COLD CRANKING  322 sw 3 pos (-1.0,0.0,1.0 L39ZA) (0.0,0.1,0.2 L39C)> "UHF Radio", "T/Tone Switch" 169
	L39ZA_ExportArguments["58,3017"] = "4,3022,1"   -- Emergency Fuel Switch Cover, Open/Close 319 sw 2 pos > "Intercom", "Hot Mic Switch" 237
	L39ZA_ExportArguments["58,3005"] = "4,3021,1"   -- Emergency Fuel Switch 320 sw 2 pos > "Intercom", "VHF Switch" 226
	L39ZA_ExportArguments["36,3001"] = "4,3025,1"   -- CB Engine Switch, ON/OFF 144 sw 2 pos > "Fuel System", "External Wing Tank Boost Pump" 106
	L39ZA_ExportArguments["36,3002"] = "4,3026,1"   -- CB AGD-GMK Switch, ON/OFF 145 sw 2 pos > "Fuel System", "External Fuselage Tank Boost Pump" 107
	L39ZA_ExportArguments["36,3003"] = "4,3027,1"   -- CB Inverter 1 (AC 115V) Switch, ON/OFF 146 sw 2 pos > "Fuel System", "Tank Gate" 108
	L39ZA_ExportArguments["36,3004"] = "4,3028,1"   -- CB Inverter 2 (AC 115V) Switch, ON/OFF 147 sw 2 pos > "Fuel System", "Cross Feed" 109
	L39ZA_ExportArguments["36,3005"] = "4,3029,1"   -- CB RDO (ICS and Radio) Switch, ON/OFF 148 sw 2 pos > "Fuel System", "Boost Pump Left Wing" 110
	L39ZA_ExportArguments["36,3006"] = "4,3030,1"   -- CB MRP-RV (Marker Beacon Receiver and Radio Altimeter) Switch, ON/OFF 149 sw 2 pos > "Fuel System", "Boost Pump Right Wing" 111
	L39ZA_ExportArguments["36,3007"] = "4,3031,1"   -- CB RSBN (ISKRA) Switch, ON/OFF 150 sw 2 pos > "Fuel System", "Boost Pump Main Fuseloge Left" 112
	L39ZA_ExportArguments["36,3008"] = "4,3032,1"   -- CB IFF (SRO) Emergency Connection Switch, ON/OFF 151 sw 2 pos > "Fuel System", "Boost Pump Main Fuseloge Right" 113
	L39ZA_ExportArguments["36,3009"] = "4,3033,1"   -- CB RSBN (ISKRA) Emergency Connection Switch, ON/OFF 152 sw 2 pos > "Fuel System", "Signal Amplifier" 114
	L39ZA_ExportArguments["36,3015"] = "4,3034,1"   -- CB Wing Tanks Switch, ON/OFF" 153 sw 2 pos > "Fuel System", "Fill Disable Main Right" 120
	L39ZA_ExportArguments["36,3016"] = "4,3035,1"   -- CB RIO-3 De-Icing Signal Switch, ON/OFF 154 sw 2 pos > "Fuel System", "Refuel Control Lever" 121
	L39ZA_ExportArguments["36,3012"] = "4,3036,1"   -- CB SDU Switch, ON/OFF 155 sw 2 pos > "Fuel System", "Fill Disable Wing Left" 117
	L39ZA_ExportArguments["36,3013"] = "4,3037,1"   -- CB Heating AOA Sensor Switch, ON/OFF 628 sw 2 pos --------SOLO L39ZA> "Fuel System", "Fill Disable Wing Right" 118
	L39ZA_ExportArguments["36,3014"] = "4,3038,1"   -- CB Weapon Switch, ON/OFF 629 sw 2 pos > "Fuel System", "Fill Disable Main Left" 119
L39ZA_ExportArguments["4,3000"] = "4,3066,1"   -- CB Weapon, ON/OFF 505 sw 2 pos instructor> 
			L39ZA_ExportArguments["3,3002"] = "4,3040,1"   -- CB Air Conditioning, ON/OFF 211 sw 2 pos > "Right MFCD", "OSB2"
			L39ZA_ExportArguments["3,3003"] = "4,3041,1"   -- CB Anti-Ice, ON/OFF 212 sw 2 pos >         "Right MFCD", "OSB3"
			L39ZA_ExportArguments["3,3004"] = "4,3042,1"   -- CB Pitot Left, ON/OFF 213 sw 2 pos >       "Right MFCD", "OSB4"
			L39ZA_ExportArguments["3,3005"] = "4,3043,1"   -- CB Pitot Right, ON/OFF 214 sw 2 pos >      "Right MFCD", "OSB5"
			L39ZA_ExportArguments["3,3006"] = "4,3044,1"   -- CB PT-500C, ON/OFF 215 sw 2 pos >          "Right MFCD", "OSB6"
			L39ZA_ExportArguments["3,3007"] = "4,3045,1"   -- CB ARC, ON/OFF 216 sw 2 pos >              "Right MFCD", "OSB7"
			L39ZA_ExportArguments["3,3008"] = "4,3046,1"   -- CB SRO, ON/OFF 217 sw 2 pos >              "Right MFCD", "OSB8"
			L39ZA_ExportArguments["3,3009"] = "4,3047,1"   -- CB Seat-Helmet, ON/OFF 218 sw 2 pos >      "Right MFCD", "OSB9"
			L39ZA_ExportArguments["3,3010"] = "4,3048,1"   -- CB Gears, ON/OFF 219 sw 2 pos >            "Right MFCD", "OSB10"
			L39ZA_ExportArguments["3,3011"] = "4,3049,1"   -- CB Control, ON/OFF 220 sw 2 pos >          "Right MFCD", "OSB11"
			L39ZA_ExportArguments["3,3012"] = "4,3050,1"   -- CB Signaling, ON/OFF 221 sw 2 pos >        "Right MFCD", "OSB12"
			L39ZA_ExportArguments["3,3013"] = "4,3051,1"   -- CB Nav. Lights, ON/OFF 222 sw 2 pos >      "Right MFCD", "OSB13"
			L39ZA_ExportArguments["3,3014"] = "4,3052,1"   -- CB Spotlight Left, ON/OFF 223 sw 2 pos >   "Right MFCD", "OSB14"
			L39ZA_ExportArguments["3,3015"] = "4,3053,1"   -- CB Spotlight Right, ON/OFF 224 sw 2 pos >  "Right MFCD", "OSB15"
			L39ZA_ExportArguments["3,3016"] = "4,3054,1"   -- CB Red Lights, ON/OFF 225 sw 2 pos >       "Right MFCD", "OSB16"
			L39ZA_ExportArguments["3,3017"] = "4,3055,1"   -- CB White Lights, ON/OFF 226 sw 2 pos >     "Right MFCD", "OSB17"
			L39ZA_ExportArguments["9,3044"] = "4,3056,1"   -- CB Start Panel, ON/OFF 227 sw 2 pos >         "CDU", "R"
			L39ZA_ExportArguments["9,3045"] = "4,3057,1"   -- CB Booster Pump, ON/OFF 228 sw 2 pos >        "CDU", "S"
			L39ZA_ExportArguments["9,3046"] = "4,3058,1"   -- CB Ignition 1, ON/OFF 229 sw 2 pos >          "CDU", "T"
			L39ZA_ExportArguments["9,3047"] = "4,3059,1"   -- CB Ignition 2, ON/OFF 230 sw 2 pos >          "CDU", "U"
			L39ZA_ExportArguments["9,3048"] = "4,3060,1"   -- CB Engine Instruments, ON/OFF 231 sw 2 pos >  "CDU", "V"
			L39ZA_ExportArguments["9,3049"] = "4,3061,1"   -- CB Fire, ON/OFF 232 sw 2 pos >                "CDU", "W"
			L39ZA_ExportArguments["9,3050"] = "4,3062,1"   -- CB Emergency Jettison, ON/OFF 233 sw 2 pos >  "CDU", "X"
			L39ZA_ExportArguments["9,3051"] = "4,3063,1"   -- CB SARPP, ON/OFF 234 sw 2 pos >               "CDU", "Y"
L39ZA_ExportArguments["4,3000"] = "4,3067,1"   -- CB Ground Intercom, ON/OFF 512 sw 2 pos > 
	L39ZA_ExportArguments["2,3010"] = "4,3068,1"   -- Standby (Left) Pitot Tube Heating Button - Push to turn heating on 294 btn >      "Left MFCD", "OSB10"  309
	L39ZA_ExportArguments["2,3011"] = "4,3070,1"   -- Main (Right) Pitot Tube Heating Button - Push to turn heating on 295 btn >        "Left MFCD", "OSB11"  310
	L39ZA_ExportArguments["2,3012"] = "4,3069,1"   -- Standby (Left) Pitot Tube Heating Off Button - Push to turn heating off 292 btn > "Left MFCD", "OSB12"  311
	L39ZA_ExportArguments["2,3013"] = "4,3071,1"   -- Main (Right) Pitot Tube Heating Off Button - Push to turn heating off 293 btn >   "Left MFCD", "OSB13"  312
	L39ZA_ExportArguments["38,3021"] = "20,3003,103"  -- Navigation Lights Mode Control Switch, FLICKER/OFF/FIXED  176 sw 3 pos 0.0,0.5,1.0 > "Autopilot", "Alieron Emergency Disengage" 177
	L39ZA_ExportArguments["43,3015"] = "20,3004,103"  -- Navigation Lights Intensity Control Switch, DIM(30%)/BRT(60%)/MAX(100%)  175 sw 3 pos 0.0,0.5,1.0> IFF", "Audio Light Switch" 201
	L39ZA_ExportArguments["44,3004"] = "20,3006,1"  -- Taxi and Landing Lights (Searchlights) Control Switch, TAXI/OFF/LANDING  311 sw 3 pos -1.0 0.0 1.0 > "HARS", "Magnetic Variation" 272
    L39ZA_ExportArguments["43,3020"] = "20,3008,1"  -- Instrument Lighting Switch, Red/OFF/White 330 sw 3 pos -1.0 0.0 1.0 > "IFF", "RAD Test/Monitor Switch" 206
	L39ZA_ExportArguments["58,3014"] = "20,3009,1"  -- Instrument Lights Intensity Knob 331 axis 0.1 > "Intercom", "ILS Volume" 233
	L39ZA_ExportArguments["50,3001"] = "20,3005,1"  -- Emergency Instrument Light Switch, ON/OFF 249 sw 2 pos > "Fire System", "Left Engine Fire Pull" 102
	L39ZA_ExportArguments["49,3003"] = "20,3012,1"  -- Warning-Light Intensity Knob 202 axis 0.1 > "Light System", "Auxillary instrument Lights" 293
	L39ZA_ExportArguments["2,3005"] = "20,3013,1"  -- Warning-Light Check Button - Push to check 203 btn > "Left MFCD", "OSB5" 304
	L39ZA_ExportArguments["49,3013"] = "3,3001,1"   -- CB Armament System Power Switch, ON/OFF 254 sw 2 pos > "Light System", "Signal Lights" 294
	L39ZA_ExportArguments["4,3008"] = "3,3002,1"   -- CB Missile Firing Control Circuit Power Switch, ON/OFF 255 sw 2 pos > "CMSP", "ECM Pod Jettison" 358
	L39ZA_ExportArguments["49,3004"] = "3,3003,1"   -- CB ASP-FKP (Gunsight and Gun Camera) Power Switch, ON/OFF 256 sw 2 pos > "Light System", "Accelerometer & Compass Lights" 295
	L39ZA_ExportArguments["8,3030"] = "3,3004,1"   -- CB Missile Seeker Heating Circuit Power Switch, ON/OF  257 sw 2 pos > "UFC", "FWD" 531
	L39ZA_ExportArguments["8,3031"] = "3,3005,1"   -- CB Missile Seeker Glowing Circuit Power Switch, ON/OFF 258 sw 2 pos > "UFC", "MID" 532
	L39ZA_ExportArguments["58,3012"] = "3,3006,1"   -- Missile Seeker Tone Volume Knob 259 axis 0.1 > "Intercom", "IFF Volume" 231
	L39ZA_ExportArguments["49,3007"] = "3,3008,1"   -- Arm/Safe Bombs Emergency Jettison Switch Cover, OPEN/CLOSE 267 sw 2 pos > "Electrical", "Emergency Flood" 243
	L39ZA_ExportArguments["53,3001"] = "3,3009,1"   -- Arm/Safe Bombs Emergency Jettison Switch, LIVE/BLANK 268 sw 2 pos >   "ILS", "Power"                   247
	L39ZA_ExportArguments["2,3036"] = "3,3012,104"   -- Rockets Firing Mode Selector Switch, AUT./2RS/4RS 271 multi sw 3 pos 0.3 0.1 0.2 > "Left MFCD", "Day/Night/Off"
	L39ZA_ExportArguments["41,3002"] = "3,3013,1"   -- EKSR-46 Signal Flare Dispenser Power Switch, ON/OFF 273 sw 2 pos > "Environmental Control", "Windshield Defog/Deice", 276
	L39ZA_ExportArguments["41,3005"] = "3,3017,1"   -- EKSR-46 Yellow Signal Flare Launch Button 274 sw 2 pos >           "Environmental Control", "Pitot heat"              279
	L39ZA_ExportArguments["41,3006"] = "3,3014,1"   -- EKSR-46 Green Signal Flare Launch Button 275 sw 2 pos >            "Environmental Control", "Bleed Air"               280
	L39ZA_ExportArguments["41,3008"] = "3,3015,1"   -- EKSR-46 Red Signal Flare Launch Button 276 sw 2 pos >              "Environmental Control", "Main Air Supply"         283
	L39ZA_ExportArguments["49,3012"] = "3,3016,1"   -- EKSR-46 White Signal Flare Launch Button 277 sw 2 pos >            "Light System", "Nose Illumination"                291
	L39ZA_ExportArguments["7,3007"] = "3,3007,102"   -- Missile/Bomb Release Selector Switch, PORT(Left)/STARB-BOTH(Right for Missiles/Both) 260 sw 2 pos (1,-1)> "AHCP", "HUD Norm/Standbyh" 381
	L39ZA_ExportArguments["7,3004"] = "3,3010,1"   -- Emergency Jettison Outboard Stations Switch, Cover OPEN/CLOSE 269 sw 2 pos >  "AHCP", "TGP Power"  378
	L39ZA_ExportArguments["7,3009"] = "3,3011,1"   -- Emergency Jettison Outboard Stations Switch, ON/OFF 270 sw 2 pos >       "AHCP", "Datalink Power"   383
-- solo L39ZA
	L39ZA_ExportArguments["40,3002"] = "3,3041,1"   -- Gun+PK3 Switch 582 Cover sw 2 pos > "Oxygen System", "Dilution Lever" 602
	L39ZA_ExportArguments["40,3001"] = "3,3042,1"   -- Gun+PK3 Switch 583 sw 2 pos >       "Oxygen System", "Supply Lever"   603
	L39ZA_ExportArguments["44,3002"] = "3,3043,1"   -- Emergency Jettison Inboard Stations Switch, Cover OPEN/CLOSE 589 sw 2 pos > "HARS", "Mode"                 270
	L39ZA_ExportArguments["44,3003"] = "3,3044,1"   -- Emergency Jettison Inboard Stations Switch, ON/OFF 590 sw 2 pos >           "HARS", "Hemisphere Selector"  273
	L39ZA_ExportArguments["12,3002"] = "3,3045,103"   -- Pyro Charge Select 607 sw 3 pos 0.0,0.5,1.0 >  "TISL", "Slant Range" 623
	L39ZA_ExportArguments["8,3004"] = "3,3046,1"   -- Pyro Charge Apply 579 btn > "UFC", "4" 388 
	L39ZA_ExportArguments["8,3032"] = "3,3047,1"   -- Gsh-23 Arm/Safe 576 sw 2 pos > "UFC", "AFT" 533
	L39ZA_ExportArguments["39,3001"] = "3,3048,1"   -- Outboard Stations Select 585 sw 2 pos > "Mechanical", "Landing Gear Lever" 716
	L39ZA_ExportArguments["8,3001"] = "3,3049,1"   -- Outboard Stations Deselect 586 btn > "UFC", "1" 385
	L39ZA_ExportArguments["7,3008"] = "3,3050,1"   -- Inboard Stations Select 587 sw 2 pos >   "AHCP", "CICU Power"               382
	L39ZA_ExportArguments["8,3002"] = "3,3051,1"   -- Inboard Stations Deselect 588 btn > "UFC", "2" 386
	L39ZA_ExportArguments["46,3008"] = "3,3052,1"   -- Charge Outer Guns 577 sw 2 pos > "Navigation Mode Select Panel", "Able - Stow" 621
	L39ZA_ExportArguments["7,3006"] = "3,3053,1"   -- Charge Inner Guns 578 sw 2 pos > "AHCP", "HUD Day/Night" 380
	L39ZA_ExportArguments["1,3001"] = "3,3054,1"   -- Emergency Launch Missiles Cover OPEN/CLOSE 591 sw 2 pos > "Electrical", "APU Generator" 241
	L39ZA_ExportArguments["8,3003"] = "3,3055,1"   -- Emergency Launch Missiles 592 btn > "UFC", "3" 387
	L39ZA_ExportArguments["1,3004"] = "3,3056,1"   -- Arm Outer Guns 597 sw 2 pos > "Electrical", "AC Generator - Left" 244
	L39ZA_ExportArguments["1,3005"] = "3,3057,1"   -- Arm Inner Guns 598 sw 2 pos > "Electrical", "AC Generator - Right" 245
	L39ZA_ExportArguments["1,3006"] = "3,3058,1"   -- Arm Bombs 596 sw 2 pos >      "Electrical", "Battery" 246
	L39ZA_ExportArguments["12,3009"] = "3,3059,1"  -- Bombs Series 584 sw 3 pos -1.0,0.0,1.0 > "TISL", "Code Select"
	L39ZA_ExportArguments["3,3001"] = "3,3077,1"   -- Deblock Guns 599 btn > "Right MFCD", "OSB1" 326
--
	L39ZA_ExportArguments["38,3016"] = "30,3004,1"  -- Emergency Oxygen Switch, ON/OFF 303 sw 2 pos >   "Autopilot", "Pitch/Roll Emergency Override"  175
	L39ZA_ExportArguments["38,3023"] = "30,3006,1"  -- Diluter Demand Switch, 100% / MIX 304 sw 2 pos > "Autopilot", "Flaps Emergency Retract"   183
	L39ZA_ExportArguments["38,3024"] = "30,3008,1"  -- Helmet Ventilation Switch, ON/OFF 307 sw 2 pos > "Autopilot", "Manual Reversion Flight Control System Switch" 184
	L39ZA_ExportArguments["22,3002"] = "30,3009,1"  -- Oxygen Supply Valve (CLOSE - CW, OPEN - CCW) 306 axis 0.05 >   "AAP", "Steer Toggle Switch" 474  rocker --
	L39ZA_ExportArguments["22,3003"] = "30,3009,1"  -- Oxygen Supply Valve (CLOSE - CW, OPEN - CCW) 306 axis 0.05 >    "AAP", "Steer Toggle Switch" 474 rocker --
	L39ZA_ExportArguments["58,3018"] = "30,3003,1"  -- Oxygen Interconnaction Valve (CLOSE - CW, OPEN - CCW) 484 axis 0.05  > "Intercom", "Master Volume" 238
	L39ZA_ExportArguments["38,3015"] = "36,3001,1"  -- SARPP Flight Recorder, ON/OFF 298 sw 2 pos > "Autopilot", "Speed Brake Emergency Retract" 174
	L39ZA_ExportArguments["52,3002"] = "5,3002,1"   -- Fuel Shut-Off Lever 296 lever 0.0 1.0 > "Stall Warning", "Peak Volume" 705 
	L39ZA_ExportArguments["52,3001"] = "7,3001,1"   -- ECS and Pressurization Handle, OFF/CANOPIES SEALED/ECS ON 245 axis 0.1 > "Stall Warning", "Stall Volume" 704
	L39ZA_ExportArguments["55,3004"] = "7,3004,1"   -- Cabin Air Conditioning Control Switch, OFF/HEAT/COOL/AUTOMATIC 172 multi sw 4 pos 0.05 > "VHF AM Radio", "Frequency Selection Dial" 135
	L39ZA_ExportArguments["49,3001"] = "7,3003,1"   -- Cabin Air Temperature Controller Rheostat 173 axis 0.1 > "Light System", "Engine Instrument Lights" 290
	L39ZA_ExportArguments["56,3004"] = "7,3006,1"   -- Diffuser and Flight Suit Air Conditioning Control Switch, HEAT/AUTO/COOL 121 sw 3 pos 0.05 > "VHF FM Radio", "Frequency Selection Dial" 149
	L39ZA_ExportArguments["58,3010"] = "7,3005,1"   -- Diffuser and Flight Suit Temperature Rheostat 120 axis 0.1 > "Intercom", "AIM Volume" 229
L39ZA_ExportArguments["7,3000"] = "7,3008,1"   -- aft Conditioning Shutoff Switch Cover, OPEN/CLOSE 510 sw 2 pos > 
L39ZA_ExportArguments["7,3000"] = "7,3007,1"   -- aft Conditioning Shutoff Switch, OPEN/FRONT PILOT CONTROL/CLOSE 511 sw 3 pos  -1.0 0.0 1.0> 
	L39ZA_ExportArguments["49,3014"] = "7,3009,1"   -- De-Icing Mode Switch, MANUAL/AUTOMATIC/OFF  174 sw 3 pos 0.0 0.1 0.2 > "Light System", "Land/Taxi Lights" 655
	L39ZA_ExportArguments["2,3003"] = "7,3010,1"    -- RIO-3 De-Icing Sensor Heating Circuit Check Button - Push to test 183 btn > "Left MFCD", "OSB3" 302
	L39ZA_ExportArguments["2,3017"] = "7,3011,1"   -- Helmet Visor Quick Heating Button - Push to heat 309 btn > "Left MFCD", "OSB17" 316
	L39ZA_ExportArguments["43,3021"] = "7,3012,103"   -- Helmet Heating Mode Switch, AUTO/OFF/ON 308 sw 3 pos  0.0 0.5 1.0 > "IFF", "Ident/Mic Switch" 207
L39ZA_ExportArguments["7,3000"] = "7,3013,1"   -- Helmet Heating Temperature Rheostat 310 axis 0.1 > 
	L39ZA_ExportArguments["22,3005"] = "34,3004,1"  -- Reserve Intercom Switch, ON/OFF 290 sw 2 pos > "AAP", "CDU Power"   476
	L39ZA_ExportArguments["22,3006"] = "34,3003,1"  -- ADF Audio Switch, ADF/OFF 291 sw 2 pos >       "AAP", "EGI Power"   477
	L39ZA_ExportArguments["58,3006"] = "34,3001,1"  -- Intercom Volume Knob 288 axis lim 0.05 0.0 0.8 >	"Intercom", "VHF Volume" 225
	L39ZA_ExportArguments["58,3008"] = "34,3002,1"  -- Radio Volume Knob 289 axis lim 0.05 0.0 0.8 >   	"Intercom", "UHF Volume" 227
	L39ZA_ExportArguments["2,3019"] = "34,3005,1"  -- Radio Button 134 btn > "Left MFCD", "OSB19" 318
	L39ZA_ExportArguments["2,3020"] = "34,3006,1"  -- Intercom Button 133 btn > "Left MFCD", "OSB20" 319
	L39ZA_ExportArguments["38,3030"] = "19,3003,1"  -- Radio Control Switch, ON/OFF 287 sw 2 pos > "Autopilot", "Emergency Brake" 772
	L39ZA_ExportArguments["38,3031"] = "19,3002,1"  -- Squelch Switch, ON/OFF 286 sw 2 pos > "Autopilot", "HARS-SAS Override/Norm" 196
	L39ZA_ExportArguments["51,3007"] = "19,3001,1"  -- R-832M Preset Channel Selector Knob 284 multi sw 20 pos 0.05 > "TACAN", "Volumne" 261
	L39ZA_ExportArguments["2,3018"] = "6,3001,1"   -- IV-300 Engine Vibration Test Button - Push to test 329 btn > "Left MFCD", "OSB18" 317
	L39ZA_ExportArguments["39,3008"] = "6,3002,1"   -- Fire Extinguish Button Cover OPEN/CLOSE 327 sw 2 pos > "Mechanical", "Auxiliary Landing Gear Handle" 718
	L39ZA_ExportArguments["2,3016"] = "6,3003,1"   -- Fire Extinguish Button - Push to extinguish 328 btn > "Left MFCD", "OSB16" 315
	L39ZA_ExportArguments["40,3003"] = "6,3006,1"   -- Fire Warning Signal Test Switch, I/OFF/II  272 spr sw 3 pos -1.0 0.0 1.0> "Oxygen System", "Emergency Lever" 601
L39ZA_ExportArguments["6,3000"] = "6,3007,1"   -- RT-12 JPT Regulator Manual Disable Switch Cover, ROPEN/CLOSE 323 sw 2 pos > 
L39ZA_ExportArguments["6,3000"] = "6,3008,1"   -- RT-12 JPT Regulator Manual Disable Switch, RT-12 DISABLED/RT-12 ENABLED 324 sw 2 pos > 
		L39ZA_ExportArguments["3,3018"] = "6,3009,1"   -- RT-12 JPT Regulator Power Switch, ON/OFF 243 sw 2 pos > "Right MFCD", "OSB18" 343
	L39ZA_ExportArguments["38,3022"] = "6,3010,1"   -- RT-12 JPT Regulator Test Switch, I/OFF/II  242 sw 3 pos -1.0 0.0 1.0 > "Autopilot", "Elevator Emergency Disengage" 180
L39ZA_ExportArguments["6,3000"] = "6,3011,1"   -- EGT Indicator Switch, FRONT/REAR 499 sw 2 pos > 
	L39ZA_ExportArguments["2,3006"] = "37,3001,1"  -- Flaps Flight Position (0 degrees) Button 281 btn >     "Left MFCD", "OSB6" 305
	L39ZA_ExportArguments["2,3007"] = "37,3002,1"  -- Flaps Takeoff Position (25 degrees) Button 282 btn >   "Left MFCD", "OSB7" 306
	L39ZA_ExportArguments["2,3008"] = "37,3003,1"  -- Flaps Landing Position (44 degrees) Button 283 btn >   "Left MFCD", "OSB8" 307
L39ZA_ExportArguments["37,3000"] = "37,3021,1"  -- Throttle Limiter 549 sw 2 pos > 
L39ZA_ExportArguments["37,3000"] = "37,3008,1"  -- Air Brake Switch 135 btn > 
	L39ZA_ExportArguments["8,3010"] = "37,3007,1"  -- Air Brake Switch 136 sw 2 pos > "UFC", "0" 395
	L39ZA_ExportArguments["38,3011"] = "37,3011,1"  -- Landing Gear Control Lever 118 sw 3 pos  -1.0 0.0 1.0 > "Autopilot", "Monitor Test Left/Right" 189
	L39ZA_ExportArguments["47,3001"] = "37,3016,2"  -- Emergency/Parking Wheel Brake Lever 334 axis lim 0.1 -1.0 1.0 > "ADI", "Pitch Trim Knob" 22 -0.5 a 0.5
								L39ZA_ExportArguments["37,3000"] = "37,3024,1"  -- Parking Brake Lever Flag - Push to remove parking brake 334 sw 1 pos ?? > 
	L39ZA_ExportArguments["8,3005"] = "35,3001,1"  -- Main and Emergency Hydraulic Systems Interconnection Lever, FORWARD(OFF)/BACKWARD(ON) 197 sw 2 pos > "UFC", "5"  389
	L39ZA_ExportArguments["8,3006"] = "35,3003,1"  -- Emergency Landing Gear Extension Lever, FORWARD(OFF)/BACKWARD(ON) 194 sw 2 pos >                     "UFC", "6"  390
	L39ZA_ExportArguments["8,3007"] = "35,3005,1"  -- Emergency Flaps Extension Lever, FORWARD(OFF)/BACKWARD(ON) 195 sw 2 pos >                            "UFC", "7"  391
	L39ZA_ExportArguments["8,3008"] = "35,3007,1"  -- RAT (Emergency Generator) Emergency Lever, FORWARD(OFF)/BACKWARD(ON) 196 sw 2 pos >                  "UFC", "8"  392
L39ZA_ExportArguments["39,3000"] = "39,3002,1"  -- Full pressure failure, ON/STBY/FAILURE 456 sw 3 pos -0.5 0.0 0.5> 
L39ZA_ExportArguments["39,3000"] = "39,3001,1"  -- Static pressure failure, ON/STBY/FAILURE 457 sw 3 pos -0.5 0.0 0.5 > 
	L39ZA_ExportArguments["9,3042"] = "33,3001,1"  -- Reset Limits 89 btn > "CDU", "P" 452
L39ZA_ExportArguments["2,3000"] = "2,3001,1"   -- Canopy Handle 998 sw 2 pos > 
L39ZA_ExportArguments["2,3000"] = "2,3007,1"   -- Forward Canopy Lock Handle 285 lever > 
L39ZA_ExportArguments["2,3000"] = "2,3009,1"   -- Forward Canopy Emergency Jettison Handle 244 btn > 
L39ZA_ExportArguments["2,3000"] = "2,3006,1"   -- CPT2 Instrument Flight Practice Hood Control Handle, EXTEND/RETRACT 1000 sw 2 pos > 
	L39ZA_ExportArguments["8,3009"] = "37,3022,1"  -- Pitot Tube Selector Lever, STBY(Left)/MAIN(Right) 333 sw 2 pos > "UFC", "9" 393
L39ZA_ExportArguments["37,3000"] = "37,3022,1"  -- Panel Visor Extend 627 sw 2 pos > 
L39ZA_ExportArguments["4,3000"] = "4,3004,1"   	-- CPT2 Net Switch, ON/OFF 502 sw 2 pos > 





	L39ZA_ExportArguments["13,3000"] = "13,3001,1"  -- CPT2 Mech clock left lever (left click) 412 btn 1.0 > 
	L39ZA_ExportArguments["13,3000"] = "13,3002,1"  -- CPT2 Mech clock left lever (right click) 412 btn -1.0 > 
	L39ZA_ExportArguments["13,3000"] = "13,3003,1"  -- CPT2 Mech clock left lever 413 lever 0.04 > 
	L39ZA_ExportArguments["13,3000"] = "13,3004,1"  -- CPT2 Mech clock right lever 414 btn > 
	L39ZA_ExportArguments["13,3000"] = "13,3005,1"  -- CPT2 Mech clock right lever {0.0,0.3} in 0.1 steps 415 Rotary > 
	L39ZA_ExportArguments["10,3000"] = "10,3001,1"  -- CPT2 Baro pressure QFE knob axis 0.6 > 
	L39ZA_ExportArguments["14,3000"] = "14,3005,1"  -- CPT2 RV-5M Radio Altimeter Test Button 398 sw 2 pos > 
	L39ZA_ExportArguments["14,3000"] = "14,3004,1"  -- CPT2 RV-5M Radio Altimeter Decision Height Knob 399 axis 0.2 > 
	L39ZA_ExportArguments["17,3000"] = "17,3013,1"  -- CPT2 MC Synchronization Button - Push to synchronize (level flight only) CP2 444 btn > 
	L39ZA_ExportArguments["23,3000"] = "23,3002,1"  -- CPT2 KPP-1273K Attitude Director Indicator (ADI) Cage Button 367 btn > 
	L39ZA_ExportArguments["23,3000"] = "23,3003,1"  -- CPT2 KPP-1273K Attitude Director Indicator (ADI) Pitch Trim Knob 376 axis 0.05 -1.0, 1.0 > 
	L39ZA_ExportArguments["25,3000"] = "25,3001,1"  -- CPT2 HSI Course set knob 385 axis 0.15 > 
	L39ZA_ExportArguments["16,3000"] = "16,3001,1"  -- CPT2 Variometer adjustment knob 419 axis 0.1  > 
	L39ZA_ExportArguments["21,3000"] = "21,3011,1"  -- CPT2 RKL-41 ADF Outer-Inner Beacon (Far-Near NDB) Switch 440 sw 2 pos > 
	L39ZA_ExportArguments["21,3000"] = "21,3001,1"  -- CPT2 RKL-41 ADF Volume Knob 514 axis 0.05 > 
	L39ZA_ExportArguments["21,3000"] = "21,3013,1"  -- CPT2 RKL-41 ADF Brightness Knob 518 axis 0.05 > 
	L39ZA_ExportArguments["21,3000"] = "21,3002,1"  -- CPT2 RKL-41 ADF Mode Switch, TLF(A3)/TLG(A1,A2) 516 sw 2 pos > 
	L39ZA_ExportArguments["21,3000"] = "21,3003,1"  -- CPT2 RKL-41 ADF Function Selector Switch, OFF/COMP(AUTO)/COMP(MAN)/ANT/LOOP 517 multi sw 5 pos 0.1 > 
	L39ZA_ExportArguments["21,3000"] = "21,3010,1"  -- CPT2 RKL-41 ADF Loop Switch, LEFT/OFF/RIGHT {-1.0,0.0,1.0} 519 spr sw 3 pos > 
	L39ZA_ExportArguments["21,3000"] = "21,3012,1"  -- CPT2 RKL-41 ADF Control Switch, TAKE CONTROL/HAND OVER CONTROL 515 sw 2 pos > 
	L39ZA_ExportArguments["21,3000"] = "21,3004,1"  -- CPT2 RKL-41 ADF Far NDB Frequency Tune 522 axis 0.05  > 
	L39ZA_ExportArguments["21,3000"] = "21,3005,1"  -- CPT2 RKL-41 ADF Far NDB 100kHz rotary 520  weel arc 0.0588 0.0,0.938 > 
	L39ZA_ExportArguments["21,3000"] = "21,3006,1"  -- CPT2 RKL-41 ADF Far NDB 10kHz rotary 521 weel arc 0.1 0.0,0.9 > 
	L39ZA_ExportArguments["21,3000"] = "21,3007,1"  -- CPT2 RKL-41 ADF Near NDB Frequency Tune 525 axis 0.05 > 
	L39ZA_ExportArguments["21,3000"] = "21,3008,1"  -- CPT2 RKL-41 ADF Near NDB 100kHz rotary 523  weel arc 0.0588 0.0,0.938  > 
	L39ZA_ExportArguments["21,3000"] = "21,3009,1"  -- CPT2 RKL-41 ADF Near NDB 10kHz rotary  524 weel arc 0.1 0.0,0.9  > 
	L39ZA_ExportArguments["21,3000"] = "21,3008,1"  -- CPT2 Turbo Button Cover, Open/Close 487 sw 2 pos >
	L39ZA_ExportArguments["4,3000"] = "4,3007,1"   -- CPT2 Turbo Button 488 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3014,1"   -- CPT2 Engine Button Cover, Open/Close 493 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3013,1"   -- CPT2 Engine Button 494 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3018,1"   -- CPT2 Stop Engine Switch Cover, Open/Close 489 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3017,1"   -- CPT2 Stop Engine Switch 490 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3024,1"   -- CPT2 Emergency Fuel Switch Cover, Open/Close 491 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3023,1"   -- CPT2 Emergency Fuel Switch 492 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3064,1"   -- CPT2 CB Seat, ON/OFF 503 sw 2 pos > 
	L39ZA_ExportArguments["4,3000"] = "4,3065,1"   -- CPT2 CB Signal, ON/OFF 504 sw 2 pos > 
	L39ZA_ExportArguments["20,3000"] = "20,3007,1"  -- CPT2 Taxi and Landing Lights (Searchlights) Control Switch, TAXI/OFF/LANDING 486 sw 3 pos -1.0 0.0 1.0 > 
	L39ZA_ExportArguments["20,3000"] = "20,3010,1"  -- CPT2 Instrument Lighting Switch, Red/OFF/White 497 sw 3 pos -1.0 0.0 1.0 > 
	L39ZA_ExportArguments["20,3000"] = "20,3011,1"  -- CPT2 Instrument Lights Intensity Knob 498 axis 0.1 > 
	L39ZA_ExportArguments["20,3000"] = "20,3014,1"  -- CPT2 Warning-Light Intensity Knob 537 axis 0.1 > 
	L39ZA_ExportArguments["20,3000"] = "20,3015,1"  -- CPT2 Warning-Light Check Button - Push to check 538 btn > 
	L39ZA_ExportArguments["3,3000"] = "3,3018,1"   -- CPT2 Arm/Safe Bombs Emergency Jettison Switch cover, OPEN/CLOSE 508 sw 2 pos > 
	L39ZA_ExportArguments["3,3000"] = "3,3019,1"   -- CPT2 Arm/Safe Bombs Emergency Jettison Switch, LIVE/BOMBS/BLANK 509 sw 3 pos > 
	L39ZA_ExportArguments["3,3000"] = "3,3022,1"   -- CPT2 Emergency Jettison Switch cover, OPEN/CLOSE 506 sw 2 pos > 
	L39ZA_ExportArguments["3,3000"] = "3,3021,1"   -- CPT2 Emergency Jettison Switch, ON/OFF 507 sw 2 pos > 
	L39ZA_ExportArguments["30,3000"] = "30,3005,1"  -- CPT2 Emergency Oxygen Switch, ON/OFF 479 sw 2 pos > 
	L39ZA_ExportArguments["30,3000"] = "30,3007,1"  -- CPT2 Diluter Demand Switch, 100% / MIX 480 sw 2 pos > 
	L39ZA_ExportArguments["30,3000"] = "30,3002,1"  -- CPT2 Oxygen Supply Valve (CLOSE - CW, OPEN - CCW) 482  axis 0.05 > 
	L39ZA_ExportArguments["5,3000"] = "5,3003,1"   -- CPT2 Fuel Shut-Off Lever 475 lever 0.0 1.0 > 
	L39ZA_ExportArguments["7,3000"] = "7,3002,1"   -- CPT2 ECS and Pressurization Handle, OFF/CANOPIES SEALED/ECS ON 245 axis 0.1 > 
	L39ZA_ExportArguments["34,3000"] = "34,3010,1"  -- CPT2 Reserve Intercom Switch, ON/OFF 473 sw 2 pos > 
	L39ZA_ExportArguments["34,3000"] = "34,3009,1"  -- CPT2 ADF Audio Switch, ADF/OFF 474 sw 2 pos > 
	L39ZA_ExportArguments["34,3000"] = "34,3007,1"  -- CPT2 Intercom Volume Knob 471 axis lim 0.05 0.0 0.8 >  
	L39ZA_ExportArguments["34,3000"] = "34,3008,1"  -- CPT2 Radio Volume Knob 472 axis lim 0.05 0.0 0.8 > 
	L39ZA_ExportArguments["34,3000"] = "34,3011,1"  -- CPT2 Radio Button 547 btn > 
	L39ZA_ExportArguments["34,3000"] = "34,3012,1"  -- CPT2 Intercom Button 546 btn > 
	L39ZA_ExportArguments["19,3000"] = "19,3006,1"  -- CPT2 R-832M Radio Control Switch, ON/OFF 470 sw 2 pos > 
	L39ZA_ExportArguments["19,3000"] = "19,3005,1"  -- CPT2 R-832M Squelch Switch, ON/OFF 469 sw 2 pos > 
	L39ZA_ExportArguments["19,3000"] = "19,3004,1"  -- CPT2 R-832M Preset Channel Selector Knob 468 multi sw 20 pos 0.05  > 
	L39ZA_ExportArguments["6,3000"] = "6,3004,1"   -- CPT2 Fire Extinguish Button Cover, OPEN/CLOSE 495 sw 2 pos > 
	L39ZA_ExportArguments["6,3000"] = "6,3005,1"   -- CPT2 Fire Extinguish Button - Push to extinguish 496 btn > 
	L39ZA_ExportArguments["37,3000"] = "37,3004,1"  -- CPT2 Flaps Flight Position (0 degrees) Button 465 btn > 
	L39ZA_ExportArguments["37,3000"] = "37,3005,1"  -- CPT2 Flaps Takeoff Position (25 degrees) Button 466 btn > 
	L39ZA_ExportArguments["37,3000"] = "37,3006,1"  -- CPT2 Flaps Landing Position (44 degrees) Button 467 btn > 
	L39ZA_ExportArguments["37,3000"] = "37,3009,1"  -- CPT2 Air Brake Switch 548 sw 3 pos  -1.0 0.0 1.0  > 
	L39ZA_ExportArguments["37,3000"] = "37,3012,1"  -- CPT2 Landing Gear Control Lever 437 sw 3 pos  -1.0 0.0 1.0 > 
	L39ZA_ExportArguments["37,3000"] = "37,3017,1"  -- CPT2 Emergency/Parking Wheel Brake Lever 501 axis lim 0.1 0.0 1.0> 
	L39ZA_ExportArguments["35,3000"] = "35,3002,1"  -- CPT2 Main and Emergency Hydraulic Systems Interconnection Lever, FORWARD(OFF)/BACKWARD(ON) 536 sw 2 pos > 
	L39ZA_ExportArguments["35,3000"] = "35,3004,1"  -- CPT2 Emergency Landing Gear Extension Lever, FORWARD(OFF)/BACKWARD(ON) 533 sw 2 pos > 
	L39ZA_ExportArguments["35,3000"] = "35,3006,1"  -- CPT2 Emergency Flaps Extension Lever, FORWARD(OFF)/BACKWARD(ON) 534 sw 2 pos > 
	L39ZA_ExportArguments["35,3000"] = "35,3008,1"  -- CPT2 RAT (Emergency Generator) Emergency Lever, FORWARD(OFF)/BACKWARD(ON) 535 sw 2 pos > 
	L39ZA_ExportArguments["2,3000"] = "2,3002,1"   -- CPT2 Canopy Handle 999 sw 2 pos > 
	L39ZA_ExportArguments["2,3000"] = "2,3008,1"   -- CPT2 Rearward Canopy Lock Handle 485 lever > 
	L39ZA_ExportArguments["2,3000"] = "2,3010,1"   -- CPT2 Rearward Canopy Emergency Jettison Handle 539 btn > 





-------------------------------------------------------------------------------------------------------------------------------- end L30ZA












---------------------------------------------------------------------------------------- Export arguments for the FA18C using the A10C interface
FA18C_ExportArguments = {}
-- Format: device,button number, multiplier
-- arguments with multiplier 100, 101,102 or >300 are special conversion cases, and are computed in different way
--                     A10C        FA18C

	--rockers:
		FA18C_ExportArguments["4,3005"] ="12,3006,1" -- Fire Test Switch, (RMB) TEST A/(LMB) TEST B >> CMSP :: Page Cycle
		FA18C_ExportArguments["4,3006"] ="12,3007,1" -- Fire Test Switch, (RMB) TEST A/(LMB) TEST B >> CMSP :: Page Cycle
		FA18C_ExportArguments["9,3060"] ="3,3008,1" -- Ground Power Switch 1, A ON/AUTO/B ON >> CDU", "Brightness
		FA18C_ExportArguments["9,3061"] ="3,3009,1" -- Ground Power Switch 1, A ON/AUTO/B ON >> CDU", "Brightness
		FA18C_ExportArguments["9,3062"] ="3,3010,1" -- Ground Power Switch 2, A ON/AUTO/B ON >> CDU :: Page
		FA18C_ExportArguments["9,3063"] ="3,3011,1" -- Ground Power Switch 2, A ON/AUTO/B ON >> CDU :: Page
		FA18C_ExportArguments["9,3064"] ="3,3012,1" -- Ground Power Switch 3, A ON/AUTO/B ON >> CDU :: Blank
		FA18C_ExportArguments["9,3065"] ="3,3013,1" -- Ground Power Switch 3, A ON/AUTO/B ON >> CDU :: Blank
		FA18C_ExportArguments["9,3066"] ="3,3014,1" -- Ground Power Switch 4, A ON/AUTO/B ON >> CDU :: +/-
		FA18C_ExportArguments["9,3067"] ="3,3015,1" -- Ground Power Switch 4, A ON/AUTO/B ON >> CDU :: +/-
		FA18C_ExportArguments["8,3020"] ="37,3002,1" -- AMPCD Night/Day brightness selector >> UFC :: Steer
		FA18C_ExportArguments["8,3021"] ="37,3003,1" -- AMPCD Night/Day brightness selector >> UFC :: Steer
		FA18C_ExportArguments["8,3022"] ="37,3004,1" -- AMPCD symbology control >> UFC :: Data
		FA18C_ExportArguments["8,3023"] ="37,3005,1" -- AMPCD symbology control >> UFC :: Data
		FA18C_ExportArguments["8,3024"] ="37,3006,1" -- AMPCD contrast control >> UFC :: Select
		FA18C_ExportArguments["8,3025"] ="37,3007,1" -- AMPCD contrast control >> UFC :: Select
		FA18C_ExportArguments["8,3026"] ="37,3008,1" -- AMPCD gain control >> UFC :: Adjust Depressible Pipper
		FA18C_ExportArguments["8,3027"] ="37,3009,1" -- AMPCD gain control >> UFC :: Adjust Depressible Pipper
		FA18C_ExportArguments["8,3028"] ="35,3004,1" -- Left MDI HDG switch >> UFCHUD :: Brightness
		FA18C_ExportArguments["8,3029"] ="35,3005,1" -- Left MDI HDG switch >> UFCHUD :: Brightness
		FA18C_ExportArguments["22,3002"] ="35,3006,1" -- Left MDI CRS switch >> AAPSteer :: Toggle Switch
		FA18C_ExportArguments["22,3003"] ="35,3007,1" -- Left MDI CRS switch >> AAPSteer :: Toggle Switch
		FA18C_ExportArguments["3,3034"] ="40,3014,1" -- IFF Crypto Switch, HOLD/NORM/ZERO >> Right MFCD :: Entity Level
		FA18C_ExportArguments["3,3033"] ="40,3015,1" -- IFF Crypto Switch, HOLD/NORM/ZERO >> Right MFCD :: Entity Level
		FA18C_ExportArguments["3,3035"] ="40,3015,1" -- IFF Crypto Switch, HOLD/NORM/ZERO >> Right MFCD :: Entity Level (el reposo lo trae un tercer command)
		FA18C_ExportArguments["2,3031"] ="7,3002,1" -- Canopy Control Switch, OPEN/HOLD/CLOSE >> Left MFCD :: Contrast
		FA18C_ExportArguments["2,3030"] ="7,3001,1" -- Canopy Control Switch, OPEN/HOLD/CLOSE >> Left MFCD :: Contrast
		FA18C_ExportArguments["2,3032"] ="7,3001,1" -- Canopy Control Switch, OPEN/HOLD/CLOSE >> Left MFCD :: Contrast
		FA18C_ExportArguments["51,3003"] ="25,3033,1" -- UFC COMM 1 Channel Selector Knob >> TACAN :: Channel Selector (Ones X/Y)
		FA18C_ExportArguments["51,3001"] ="25,3034,1" -- UFC COMM 2 Channel Selector Knob >> TACAN :: Channel Selector (Tens)
		FA18C_ExportArguments["2,3027"] ="5,3006,1" -- emergency park >> Left MFCD :: Brightness   vertical
		FA18C_ExportArguments["2,3029"] ="5,3007,1" -- emergency park >> Left MFCD :: Brightness   horizontal
		FA18C_ExportArguments["7,3009"] ="5,3006,1" -- emergency park >> AHCP :: Datalink Power   unblock last pass
		FA18C_ExportArguments["3,3022"] ="7,3010,1" -- Seat Height Adjustment Switch, UP/HOLD/DOWN >> Right MFCD :: Moving Map Scale
		FA18C_ExportArguments["3,3021"] ="7,3011,1" -- Seat Height Adjustment Switch, UP/HOLD/DOWN >> Right MFCD :: Moving Map Scale
		FA18C_ExportArguments["3,3023"] ="7,3011,1" -- Seat Height Adjustment Switch, UP/HOLD/DOWN >> Right MFCD :: Moving Map Scale (el reposo lo trae un tercer command)

	-- multiple F/A-18C axis in one A10C encoder

		FA18C_ExportArguments["48,3003"] ="25,3034,300" -- Multiple F/A-18C axis in one A10C encoder  >> SAI :: Pitch Trim / Cage

	--switches:

		FA18C_ExportArguments["39,3008"] ="5,3001,1" -- Landing Gear Control Handle, (RMB)UP/(LMB)DOWN/(MW)EMERGENCY DOWN >> Mechanical :: Auxiliary Landing Gear Handle
		FA18C_ExportArguments["39,3010"] ="5,3002,1" -- Landing Gear Control Handle emergency, (RMB)UP/(LMB)DOWN/(MW)EMERGENCY DOWN >> Mechanical :: Seat Arm Handle
		FA18C_ExportArguments["12,3001"] ="23,3011,105" -- Left MDI CRS switch >> TISL :: Mode Select  ( restar 0.1)
		FA18C_ExportArguments["38,3022"] ="2,3011,1" -- Wing Fold Control Handle, (RMB)Pull/(LMB)Stow/(MW)Rotate >> Autopilot :: Elevator Emergency Disengage 
		FA18C_ExportArguments["56,3008"] ="3,3005,1" -- External Power Switch, RESET/NORM/OFF >> VHF FM Radio :: Squelch / Tone* 
		FA18C_ExportArguments["37,3007"] ="12,3003,1" -- Engine Crank Switch, LEFT/OFF/RIGHT >> ENGINE_SYSTEM :: Engine Operate Left* 
		FA18C_ExportArguments["37,3003"] ="12,3002,1" -- Engine Crank Switch, LEFT/OFF/RIGHT >> ENGINE_SYSTEM :: Engine Operate Left* 
		FA18C_ExportArguments["55,3008"] ="3,3025,1" -- MC Switch, 1 OFF/NORM/2 OFF >> VHF AM Radio :: Squelch / Tone*
		FA18C_ExportArguments["55,3007"] ="3,3026,1" -- MC Switch, 1 OFF/NORM/2 OFF >> VHF AM Radio :: Squelch / Tone*
		FA18C_ExportArguments["1,3005"] ="12,3011,1" -- Right Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress >> ELEC_INTERFACE :: AC Generator - Right 245
		FA18C_ExportArguments["1,3004"] ="12,3013,1" -- Right Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress/(RMB) cover control >> ELEC_INTERFACE :: AC Generator - Left 244
		FA18C_ExportArguments["58,3011"] ="12,3011,1" -- Left Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress >> Intercom :: IFF Switch 232
		FA18C_ExportArguments["58,3009"] ="12,3012,1" -- Left Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress/(RMB) cover control >> Intercom :: AIM Switch 230
		FA18C_ExportArguments["8,3018"] ="25,3008,1" -- UFC COMM 2 Channel Selector Knob PULL >> UFC :: Display and Adjust Altitude Alert Values  encoder
		FA18C_ExportArguments["8,3030"] ="25,3009,1" -- UFC COMM 2 Channel Selector Knob PULL >> UFC :: FWD    encoder
		FA18C_ExportArguments["50,3002"] ="2,3010,1" -- Wing Fold Control Handle, (RMB)Pull/(LMB)Stow/(MW)Rotate >> FIRE_SYSTEM :: APU Fire Pull
		FA18C_ExportArguments["8,3031"] ="30,3001,1" -- ID2163A Push to Test Switch >> UFC:: MID
		FA18C_ExportArguments["8,3032"] ="42,3002,1" -- radar Switch pull >> UFC:: AFT
		FA18C_ExportArguments["38,3030"] ="5,3005,1" -- emergency brake pull >> CPT_MECH:: Landing Gear Lever
  
	-- generated:
		FA18C_ExportArguments["56,3007"] ="3,3004,1" -- External Power Switch, RESET/NORM/OFF >> VHF FM Radio :: Squelch / Tone* 
		FA18C_ExportArguments["1,3001"] ="12,3009,102" -- APU Fire Warning/Extinguisher Light >> ELEC_INTERFACE :: APU Generator  241
		FA18C_ExportArguments["12,3008"] ="40,3017,1" -- ILS Channel Selector Switch >> TISL :: TISL Code Wheel 4 
		FA18C_ExportArguments["3,3036"] ="0,3104,100" -- Selector Switch, HMD/LDDI/RDDI >> Right MFCD :: Day/Night/Off 
		FA18C_ExportArguments["36,3013"] ="7,3003,102" -- Canopy Jettison Lever, Pull to jettison >> Fuel System :: Fill Disable Wing Right 
		FA18C_ExportArguments["8,3017"] ="7,3004,1" -- Canopy Jettison Handle Unlock Button - Press to unlock >> UFC :: Create Overhead Mark Point 
		FA18C_ExportArguments["44,3003"] ="7,3006,102" -- Ejection Seat SAFE/ARMED Handle, SAFE/ARMED >> HARS :: Hemisphere Selecto 
		FA18C_ExportArguments["44,3002"] ="7,3007,102" -- Ejection Seat Manual Override Handle, PULL/PUSH >> HARS :: Mode 
		FA18C_ExportArguments["5,3002"] ="7,3012,1" -- Rudder Pedal Adjust Lever >> CMSC :: Cycle MWS Program Button 
		FA18C_ExportArguments["5,3001"] ="54,3002,1" -- Dispense Button - Push to dispense flares and chaff >> CMSC :: Cycle JMR Program Button
		FA18C_ExportArguments["41,3003"] ="9,3005,1" -- CHART Light Dimmer Control >> Environmental Control :: Canopy Defog
        FA18C_ExportArguments["49,3005"] ="9,3006,1" -- WARN/CAUTION Dimmer Control >> Light System :: Flood Light
        FA18C_ExportArguments["36,3004"] ="9,3007,102" -- LT TEST Switch, TEST/OFF >> Fuel System :: Cross Feed
        FA18C_ExportArguments["51,3006"] ="9,3008,1" -- MASTER CAUTION Reset Switch, Press to reset >> TACAN :: Test
        FA18C_ExportArguments["58,3001"] ="9,3009,102" -- HOOK BYPASS Switch, FIELD/CARRIER >> Intercom :: INT Switch
        FA18C_ExportArguments["36,3016"] ="10,3001,102" -- OBOGS Control Switch, ON/OFF >> Fuel System :: Refuel Control Lever
        FA18C_ExportArguments["53,3005"] ="10,3002,1" -- OXY FLOW Knob >> ILS :: Volume
		FA18C_ExportArguments["54,3008"] ="11,3001,1" -- Bleed Air Switch, R OFF/NORM/L OFF/OFF >> UHF Radio :: Frequency Dial
        FA18C_ExportArguments["44,3006"] ="11,3002,1" -- Bleed Air Switch, AUG PULL >> HARS :: Sync Button Push
        FA18C_ExportArguments["41,3007"] ="11,3003,1" -- ECS Mode Switch, AUTO/MAN/OFF(RAM) >> Environmental Control :: Temp/Press
        FA18C_ExportArguments["49,3008"] ="11,3004,1" -- Cabin Pressure Switch, NORM/DUMP/RAM(DUMP) >> Light System :: Position Flash
	FA18C_ExportArguments["38,3013"] ="11,3005,1" -- Defog Handle >> Autopilot :: Yaw Trim
        FA18C_ExportArguments["51,3007"] ="11,3006,1" -- Cabin Temperature Knob >> TACAN :: Volumne
        FA18C_ExportArguments["56,3005"] ="11,3007,1" -- Suit Temperature Knob >> VHF FM Radio :: Volume
        FA18C_ExportArguments["9,3058"] ="12,3008,1" -- Fire Extinguisher Switch >> CDU :: CLR
        FA18C_ExportArguments["9,3057"] ="23,3001,1" -- A/A Master Mode Switch >> CDU :: SPC
        FA18C_ExportArguments["9,3056"] ="23,3002,1" -- A/G Master Mode Switch >> CDU :: BCK
        FA18C_ExportArguments["36,3015"] ="23,3003,102" -- Master Arm Switch >> Fuel System :: Fill Disable Main Right
        FA18C_ExportArguments["9,3026"] ="23,3004,1" -- Emergency Jettison Button >> CDU :: Slash
        FA18C_ExportArguments["41,3008"] ="23,3012,102" -- Auxiliary Release Switch, ENABLE/NORM >> Environmental Control :: Main Air Supply
        FA18C_ExportArguments["41,3006"] ="23,3005,102" -- Jett Station Center >> Environmental Control :: Bleed Air
        FA18C_ExportArguments["41,3005"] ="23,3006,102" -- Jett Station Left In >> Environmental Control :: Pitot heat
        FA18C_ExportArguments["4,3008"] ="23,3007,102" -- Jett Station Left Out >> CMSP :: ECM Pod Jettison
        FA18C_ExportArguments["49,3012"] ="23,3008,102" -- Jett Station Right In >> Light System :: Nose Illumination
        FA18C_ExportArguments["36,3002"] ="23,3009,102" -- Jett Station Righr Out >> Fuel System :: External Fuselage Tank Boost Pump
        FA18C_ExportArguments["9,3025"] ="23,3010,1" -- Selective Jettison >> CDU :: Point
		FA18C_ExportArguments["36,3017"] ="23,3011,1" -- Selective Jettison Knob, L FUS MSL/SAFE/R FUS MSL/ RACK/LCHR /STORES >> Fuel System :: Fuel Display Selector
        FA18C_ExportArguments["55,3003"] ="23,3013,1" -- IR COOLING, ORIDE/NORM/OFF >> VHF AM Radio :: Frequency Mode Dial
        FA18C_ExportArguments["54,3002"] ="34,3001,1" -- HUD Symbology Reject Switch >> UHF Radio :: 100Mhz Selector
        FA18C_ExportArguments["52,3001"] ="34,3002,1" -- HUD Symbology Brightness Control >> Stall Warning :: Stall Volume
        FA18C_ExportArguments["7,3007"] ="34,3003,102" -- HUD Symbology Brightness Selector Knob >> AHCP :: HUD Norm/Standbyh
        FA18C_ExportArguments["58,3018"] ="34,3004,1" -- Black Level Control >> Intercom :: Master Volume
        FA18C_ExportArguments["49,3014"] ="34,3005,1" -- HUD Video Control Switch >> Light System :: Land/Taxi Lights
        FA18C_ExportArguments["58,3014"] ="34,3006,1" -- Balance Control >> Intercom :: ILS Volume
        FA18C_ExportArguments["58,3004"] ="34,3007,1" -- AOA Indexer Control >> Intercom :: FM Volume
        FA18C_ExportArguments["7,3008"] ="34,3008,102" -- Altitude Switch >> AHCP :: CICU Power
        FA18C_ExportArguments["44,3004"] ="34,3009,1" -- Attitude Selector Switch >> HARS :: Magnetic Variation
        FA18C_ExportArguments["7,3005"] ="35,3001,1" -- Left MDI Off/Night/Day switch >> AHCP :: Altimeter Source
        FA18C_ExportArguments["41,3009"] ="35,3002,1" -- Left MDI brightness control >> Environmental Control :: Flow Level
        FA18C_ExportArguments["58,3010"] ="35,3003,1" -- Left MDI contrast control >> Intercom :: AIM Volume
        FA18C_ExportArguments["2,3001"] ="35,3011,1" -- Left MDI PB 1 >> Left MFCD :: OSB1
        FA18C_ExportArguments["2,3002"] ="35,3012,1" -- Left MDI PB 2 >> Left MFCD :: OSB2
        FA18C_ExportArguments["2,3003"] ="35,3013,1" -- Left MDI PB 3 >> Left MFCD :: OSB3
        FA18C_ExportArguments["2,3004"] ="35,3014,1" -- Left MDI PB 4 >> Left MFCD :: OSB4
        FA18C_ExportArguments["2,3005"] ="35,3015,1" -- Left MDI PB 5 >> Left MFCD :: OSB5
        FA18C_ExportArguments["2,3006"] ="35,3016,1" -- Left MDI PB 6 >> Left MFCD :: OSB6
        FA18C_ExportArguments["2,3007"] ="35,3017,1" -- Left MDI PB 7 >> Left MFCD :: OSB7
        FA18C_ExportArguments["2,3008"] ="35,3018,1" -- Left MDI PB 8 >> Left MFCD :: OSB8
        FA18C_ExportArguments["2,3009"] ="35,3019,1" -- Left MDI PB 9 >> Left MFCD :: OSB9
        FA18C_ExportArguments["2,3010"] ="35,3020,1" -- Left MDI PB 10 >> Left MFCD :: OSB10
        FA18C_ExportArguments["2,3011"] ="35,3021,1" -- Left MDI PB 11 >> Left MFCD :: OSB11
        FA18C_ExportArguments["2,3012"] ="35,3022,1" -- Left MDI PB 12 >> Left MFCD :: OSB12
        FA18C_ExportArguments["2,3013"] ="35,3023,1" -- Left MDI PB 13 >> Left MFCD :: OSB13
        FA18C_ExportArguments["36,3009"] ="40,3016,102" -- ILS UFC/MAN Switch, UFC/MAN >> Fuel System :: Signal Amplifier
		FA18C_ExportArguments["55,3004"] ="41,3001,1" -- KY-58 Mode Select Knob, P/C/LD/RV >> VHF AM Radio :: Frequency Selection Dial
        FA18C_ExportArguments["58,3016"] ="41,3005,1" -- KY-58 Volume Control Knob >> Intercom :: TCN Volume
		FA18C_ExportArguments["22,3001"] ="41,3004,1" -- KY-58 Power Select Knob, OFF/ON/TD >> AAP :: Steer Point Dial
        FA18C_ExportArguments["9,3011"] ="40,3018,1" -- Warning Tone Silence Button - Push to silence >> CDU :: WP MENU
        FA18C_ExportArguments["46,3002"] ="53,3001,1" -- ALR-67 POWER Pushbutton >> Navigation Mode Select Panel :: EGI
        FA18C_ExportArguments["46,3001"] ="53,3002,1" -- ALR-67 DISPLAY Pushbutton >> Navigation Mode Select Panel :: HARS
        FA18C_ExportArguments["46,3005"] ="53,3003,1" -- ALR-67 SPECIAL Pushbutton >> Navigation Mode Select Panel :: ANCHR
        FA18C_ExportArguments["46,3003"] ="53,3004,1" -- ALR-67 OFFSET Pushbutton >> Navigation Mode Select Panel :: TISL
        FA18C_ExportArguments["46,3004"] ="53,3005,1" -- ALR-67 BIT Pushbutton >> Navigation Mode Select Panel :: STEERPT
        FA18C_ExportArguments["52,3002"] ="53,3006,1" -- ALR-67 DMR Control Knob >> Stall Warning :: Peak Volume
		FA18C_ExportArguments["51,3008"] ="53,3007,1" -- ALR-67 DIS TYPE Switch, N/I/A/U/F >> TACAN :: Mode
        FA18C_ExportArguments["49,3018"] ="53,3008,1" -- RWR Intensity Knob >> Light System :: Refueling Lighting Dial"
		FA18C_ExportArguments["9,3010"] ="54,3001,1" -- Dispense Button - Push to dispense flares and chaff >> CDU :: NAV
        FA18C_ExportArguments["7,3002"] ="54,3001,1" -- DISPENSER Switch, BYPASS/ON/OFF >> AHCP :: Gun Arm 
        FA18C_ExportArguments["54,3010"] ="54,3003,1" -- ECM JETT JETT SEL Button - Push to jettison >> UHF Radio :: Squelch
		FA18C_ExportArguments["4,3018"] ="0,3116,1" -- ECM Mode Switch, XMIT/REC/BIT/STBY/OFF >> CMSP :: Mode Select Dial
		FA18C_ExportArguments["36,3007"] ="0,3100,102" -- NUC WPN Switch, ENABLE/DISABLE (no function) >> Fuel System :: Boost Pump Main Fuseloge Left
        FA18C_ExportArguments["7,3010"] ="0,3105,100" -- Selector Switch, HUD/LDIR/RDDI >> AHCP :: IFFCC Power 
        FA18C_ExportArguments["7,3001"] ="0,3106,100" -- Mode Selector Switch, MAN/OFF/AUTO >> AHCP :: Master Arm
	FA18C_ExportArguments["9,3014"] ="0,3107,1" -- HUD Video BIT Initiate Pushbutton - Push to initiate BIT >> CDU :: PREV
        FA18C_ExportArguments["49,3009"] ="58,3001,1" -- HMD OFF/BRT Knob >> Light System :: Formation Lights
        FA18C_ExportArguments["49,3017"] ="0,3110,106" -- FLIR Switch, ON/STBY/OFF >> Light System :: Nightvision Lights
        FA18C_ExportArguments["2,3036"] ="0,3111,106" -- LTD/R Switch, ARM/SAFE/AFT >> Left MFCD :: Day/Night/Off 
        FA18C_ExportArguments["22,3006"] ="0,3112,102" -- LST/NFLR Switch, ON/OFF >> AAP :: EGI Power
	FA18C_ExportArguments["5,3004"] ="0,3127,1" -- Left Video Sensor BIT Initiate Pushbutton - Push to initiate BIT >> CMSC :: Separate Button
	FA18C_ExportArguments["9,3013"] ="0,3128,1" -- Right Video Sensor BIT Initiate Pushbutton - Push to initiate BIT >> CDU :: FPMENU
        FA18C_ExportArguments["54,3009"] ="12,3014,1" -- Engine Anti-Ice Switch, ON/OFF/TEST >> UHF Radio :: T/Tone Switch
        FA18C_ExportArguments["36,3003"] ="11,3008,102" -- AV COOL Switch, NORM/EMERG >> Fuel System :: Tank Gate
        FA18C_ExportArguments["43,3020"] ="11,3009,1" -- Windshield Anti-Ice/Rain Switch, ANTI ICE/OFF/RAIN >> IFF :: RAD Test/Monitor Switch
		FA18C_ExportArguments["37,3005"] ="2,3005,102" -- GAIN Switch Cover >> Engine System :: APU
        FA18C_ExportArguments["36,3005"] ="2,3006,102" -- GAIN Switch, NORM/ORIDE >> Fuel System :: Boost Pump Left Wing
        FA18C_ExportArguments["43,3019"] ="2,3007,1" -- FLAP Switch, AUTO/HALF/FULL >> IFF :: M-C Switch
		FA18C_ExportArguments["37,3002"] ="2,3008,102" -- SPIN Recovery Switch Cover >> Engine System :: Right Engine Fuel Flow Control
		FA18C_ExportArguments["36,3006"] ="2,3009,102" -- SPIN Recovery Switch, RCVY/NORM >> Fuel System :: Boost Pump Right Wing
		FA18C_ExportArguments["9,3059"] ="2,3004,1" -- CS BIT switch >> CDU :: FA
        FA18C_ExportArguments["50,3004"] ="3,3001,1" -- Battery Switch, ON/OFF/ORIDE >> Fire System :: Discharge Switch
        FA18C_ExportArguments["7,3006"] ="3,3003,1" -- Right Generator Switch, NORM/OFF >> AHCP :: HUD Day/Night
        FA18C_ExportArguments["69,3003"] ="3,3007,102" -- Generator TIE Control Switch Cover, OPEN/CLOSE >> KY-58 Secure Voice :: Delay
        FA18C_ExportArguments["50,3003"] ="3,3006,1" -- Generator TIE Control Switch, NORM/RESET >> FIRE_SYSTEM :: Right Engine Fire Pull
        FA18C_ExportArguments["39,3001"] ="3,3004,1" -- External Power Switch, RESET/NORM/OFF >> CPT_MECH :: Landing Gear Lever
        FA18C_ExportArguments["58,3005"] ="3,3016,102" -- Anti Ice Pitot Switch, ON/AUTO >> Intercom :: VHF Switch
		FA18C_ExportArguments["58,3013"] ="3,3017,1" -- CB FCS CHAN 1, ON/OFF >> Intercom :: ILS Switch
		FA18C_ExportArguments["38,3016"] ="3,3018,1" -- CB FCS CHAN 2, ON/OFF >> Autopilot :: Pitch/Roll Emergency Override
		FA18C_ExportArguments["38,3024"] ="3,3019,1" -- CB SPD BRK, ON/OFF >> Autopilot :: Manual Reversion Flight Control System Switch
		FA18C_ExportArguments["58,3003"] ="3,3020,1" -- CB LAUNCH BAR, ON/OFF >> Intercom :: FM Switch
		FA18C_ExportArguments["58,3017"] ="3,3021,1" -- CB FCS CHAN 3, ON/OFF >> Intercom :: Hot Mic Switch
		FA18C_ExportArguments["58,3015"] ="3,3022,1" -- CB FCS CHAN 4, ON/OFF >> Intercom :: TCN Switch
		FA18C_ExportArguments["38,3015"] ="3,3023,1" -- CB HOOK, ON/OFF >> Autopilot :: Speed Brake Emergency Retract
		FA18C_ExportArguments["38,3023"] ="3,3024,1" -- CB LG, ON/OFF >> Autopilot :: Flaps Emergency Retract
        FA18C_ExportArguments["7,3004"] ="3,3002,1" -- Left Generator Switch, NORM/OFF >> AHCP :: TGP Power
        FA18C_ExportArguments["50,3001"] ="12,3001,1" -- APU Control Switch - ON/OFF >> FIRE_SYSTEM :: Left Engine Fire Pull
        FA18C_ExportArguments["69,3007"] ="4,3001,102" -- Hydraulic Isolate Override Switch, NORM/ORIDE >> KY-58 Secure Voice :: Power Switch
        FA18C_ExportArguments["4,3003"] ="5,3003,1" -- Down Lock Override Button - Push to unlock >> CMSP :: OSB 3
        FA18C_ExportArguments["36,3012"] ="5,3004,102" -- Anti Skid Switch, ON/OFF >> Fuel System :: Fill Disable Wing Left
        FA18C_ExportArguments["54,3014"] ="5,3008,1" -- Launch Bar Control Switch, EXTEND/RETRACT >> UHF Radio :: Cover
        FA18C_ExportArguments["38,3031"] ="5,3009,102" -- Arresting Hook Handle, UP/DOWN >> Autopilot :: HARS-SAS Override/Norm
        FA18C_ExportArguments["36,3008"] ="6,3001,102" -- Internal Wing Tank Fuel Control Switch, INHIBIT/NORM >> Fuel System :: Boost Pump Main Fuseloge Right
        FA18C_ExportArguments["43,3015"] ="6,3002,1" -- Probe Control Switch, EXTEND/RETRACT/EMERG EXTD >> IFF :: Audio Light Switch
        FA18C_ExportArguments["46,3008"] ="6,3003,1" -- Fuel Dump Switch, ON/OFF >> NMSP :: Able - Stow
        FA18C_ExportArguments["43,3018"] ="6,3004,1" -- External Tanks CTR Switch, STOP/NORM/ORIDE >> IFF :: M-3/A Switch
        FA18C_ExportArguments["43,3021"] ="6,3005,1" -- External Tanks WING Switch, STOP/NORM/ORIDE >> IFF :: Ident/Mic Switch
		FA18C_ExportArguments["41,3001"] ="7,3004,1" -- Canopy Jettison Lever Safety Button, Press to unlock >> Environmental Control :: Oxygen Indicator Test
		FA18C_ExportArguments["36,3013"] ="7,3003,102" -- Canopy Jettison Lever, Pull to jettison >> Fuel System :: Fill Disable Wing Right
        FA18C_ExportArguments["54,3011"] ="8,3001,1" -- POSITION Lights Dimmer Control >> UHF Radio :: Volume
        FA18C_ExportArguments["58,3008"] ="8,3002,1" -- FORMATION Lights Dimmer Control >> Intercom :: UHF Volume
        FA18C_ExportArguments["38,3021"] ="8,3003,1" -- STROBE Lights Switch, BRT/OFF/DIM >> Autopilot :: Alieron Emergency Disengage
        FA18C_ExportArguments["49,3013"] ="8,3004,102" -- LDG/TAXI LIGHT Switch, ON/OFF >> Light System :: Signal Lights
        FA18C_ExportArguments["49,3001"] ="9,3001,1" -- CONSOLES Lights Dimmer Control >> Light System :: Engine Instrument Lights
        FA18C_ExportArguments["58,3006"] ="9,3002,1" -- INST PNL Dimmer Control >> Intercom :: VHF Volume
        FA18C_ExportArguments["49,3006"] ="9,3003,1" -- FLOOD Light Dimmer Control >> Light System :: Console Lights
        FA18C_ExportArguments["38,3001"] ="9,3004,1" -- MODE Switch, NVG/NITE/DAY >> Autopilot :: Mode Selection
        FA18C_ExportArguments["2,3014"] ="35,3024,1" -- Left MDI PB 14 >> Left MFCD :: OSB14
        FA18C_ExportArguments["2,3015"] ="35,3025,1" -- Left MDI PB 15 >> Left MFCD :: OSB15
        FA18C_ExportArguments["55,3005"] ="2,3001,102" -- RUD TRIM Control >> VHF AM Radio :: Volume
        FA18C_ExportArguments["4,3001"] ="2,3002,1" -- T/O TRIM PUSH Switch >> CMSP :: OSB 1
        FA18C_ExportArguments["4,3002"] ="2,3003,1" -- FCS RESET Switch >> CMSP :: OSB 2
        FA18C_ExportArguments["2,3016"] ="35,3026,1" -- Left MDI PB 16 >> Left MFCD :: OSB16
        FA18C_ExportArguments["2,3017"] ="35,3027,1" -- Left MDI PB 17 >> Left MFCD :: OSB17
        FA18C_ExportArguments["2,3018"] ="35,3028,1" -- Left MDI PB 18 >> Left MFCD :: OSB18
        FA18C_ExportArguments["2,3019"] ="35,3029,1" -- Left MDI PB 19 >> Left MFCD :: OSB19
        FA18C_ExportArguments["2,3020"] ="35,3030,1" -- Left MDI PB 20 >> Left MFCD :: OSB20
        FA18C_ExportArguments["7,3003"] ="36,3001,1" -- Right MDI Off/Night/Day switch >> AHCP :: Laser Arm
        FA18C_ExportArguments["3,3001"] ="36,3011,1" -- Right MDI PB 1 >> Right MFCD :: OSB1
        FA18C_ExportArguments["3,3002"] ="36,3012,1" -- Right MDI PB 2 >> Right MFCD :: OSB2
        FA18C_ExportArguments["3,3003"] ="36,3013,1" -- Right MDI PB 3 >> Right MFCD :: OSB3
        FA18C_ExportArguments["3,3004"] ="36,3014,1" -- Right MDI PB 4 >> Right MFCD :: OSB4
        FA18C_ExportArguments["3,3005"] ="36,3015,1" -- Right MDI PB 5 >> Right MFCD :: OSB5
        FA18C_ExportArguments["3,3006"] ="36,3016,1" -- Right MDI PB 6 >> Right MFCD :: OSB6
        FA18C_ExportArguments["3,3007"] ="36,3017,1" -- Right MDI PB 7 >> Right MFCD :: OSB7
        FA18C_ExportArguments["3,3008"] ="36,3018,1" -- Right MDI PB 8 >> Right MFCD :: OSB8
        FA18C_ExportArguments["3,3009"] ="36,3019,1" -- Right MDI PB 9 >> Right MFCD :: OSB9
        FA18C_ExportArguments["3,3010"] ="36,3020,1" -- Right MDI PB 10 >> Right MFCD :: OSB10
        FA18C_ExportArguments["3,3011"] ="36,3021,1" -- Right MDI PB 11 >> Right MFCD :: OSB11
        FA18C_ExportArguments["3,3012"] ="36,3022,1" -- Right MDI PB 12 >> Right MFCD :: OSB12
        FA18C_ExportArguments["3,3013"] ="36,3023,1" -- Right MDI PB 13 >> Right MFCD :: OSB13
        FA18C_ExportArguments["3,3014"] ="36,3024,1" -- Right MDI PB 14 >> Right MFCD :: OSB14
        FA18C_ExportArguments["3,3015"] ="36,3025,1" -- Right MDI PB 15 >> Right MFCD :: OSB15
        FA18C_ExportArguments["3,3016"] ="36,3026,1" -- Right MDI PB 16 >> Right MFCD :: OSB16
        FA18C_ExportArguments["3,3017"] ="36,3027,1" -- Right MDI PB 17 >> Right MFCD :: OSB17
        FA18C_ExportArguments["44,3005"] ="36,3002,1" -- Right MDI brightness control >> HARS :: Latitude Correction
        FA18C_ExportArguments["49,3003"] ="36,3003,1" -- Right MDI contrast control >> Light System :: Auxillary instrument Lights
        FA18C_ExportArguments["3,3018"] ="36,3028,1" -- Right MDI PB 18 >> Right MFCD :: OSB18
        FA18C_ExportArguments["3,3019"] ="36,3029,1" -- Right MDI PB 19 >> Right MFCD :: OSB19
        FA18C_ExportArguments["3,3020"] ="36,3030,1" -- Right MDI PB 20 >> Right MFCD :: OSB20
        FA18C_ExportArguments["58,3012"] ="37,3001,1" -- AMPCD Off/brightness control >> Intercom :: IFF Volume
        FA18C_ExportArguments["9,3027"] ="37,3011,1" -- AMPCD PB 1 >> CDU :: A
        FA18C_ExportArguments["9,3028"] ="37,3012,1" -- AMPCD PB 2 >> CDU :: B
        FA18C_ExportArguments["9,3029"] ="37,3013,1" -- AMPCD PB 3 >> CDU :: C
        FA18C_ExportArguments["9,3030"] ="37,3014,1" -- AMPCD PB 4 >> CDU :: D
        FA18C_ExportArguments["9,3031"] ="37,3015,1" -- AMPCD PB 5 >> CDU :: E
        FA18C_ExportArguments["9,3032"] ="37,3016,1" -- AMPCD PB 6 >> CDU :: F
        FA18C_ExportArguments["9,3033"] ="37,3017,1" -- AMPCD PB 7 >> CDU :: G
        FA18C_ExportArguments["9,3034"] ="37,3018,1" -- AMPCD PB 8 >> CDU :: H
        FA18C_ExportArguments["9,3035"] ="37,3019,1" -- AMPCD PB 9 >> CDU :: I
        FA18C_ExportArguments["9,3036"] ="37,3020,1" -- AMPCD PB 10 >> CDU :: J
        FA18C_ExportArguments["9,3037"] ="37,3021,1" -- AMPCD PB 11 >> CDU :: K
        FA18C_ExportArguments["9,3038"] ="37,3022,1" -- AMPCD PB 12 >> CDU :: L
        FA18C_ExportArguments["9,3039"] ="37,3023,1" -- AMPCD PB 13 >> CDU :: M
        FA18C_ExportArguments["9,3040"] ="37,3024,1" -- AMPCD PB 14 >> CDU :: N
        FA18C_ExportArguments["9,3041"] ="37,3025,1" -- AMPCD PB 15 >> CDU :: O
        FA18C_ExportArguments["9,3042"] ="37,3026,1" -- AMPCD PB 16 >> CDU :: P
        FA18C_ExportArguments["9,3043"] ="37,3027,1" -- AMPCD PB 17 >> CDU :: Q
        FA18C_ExportArguments["9,3044"] ="37,3028,1" -- AMPCD PB 18 >> CDU :: R
        FA18C_ExportArguments["9,3045"] ="37,3029,1" -- AMPCD PB 19 >> CDU :: S
        FA18C_ExportArguments["9,3046"] ="37,3030,1" -- AMPCD PB 20 >> CDU :: T
		FA18C_ExportArguments["12,3012"] ="32,3002,1" -- Cage Standby Attitude Indicator >> TISL :: Bite
        FA18C_ExportArguments["9,3055"] ="32,3001,1" -- SAI test >> CDU :: MK
        FA18C_ExportArguments["9,3047"] ="33,3001,1" -- IFEI Mode button >> CDU :: U
        FA18C_ExportArguments["9,3048"] ="33,3002,1" -- IFEI QTY button >> CDU :: V
        FA18C_ExportArguments["9,3049"] ="33,3003,1" -- IFEI up arrow button >> CDU :: W
        FA18C_ExportArguments["9,3050"] ="33,3004,1" -- IFEI down arrow button >> CDU :: X
        FA18C_ExportArguments["9,3051"] ="33,3005,1" -- IFEI ZONE button >> CDU :: Y
        FA18C_ExportArguments["9,3052"] ="33,3006,1" -- IFEI ET button >> CDU :: Z
	FA18C_ExportArguments["12,3011"] ="29,3001,1" -- ABU-43 Clock Wind/Set Control >> TISL :: OverTemp
	FA18C_ExportArguments["36,3010"] ="29,3003,1" -- ABU-43 Clock Stop/Reset Control >> Fuel System :: Line Check
        FA18C_ExportArguments["8,3006"] ="25,3001,1" -- UFC Function Pushbutton, A/P >> UFC :: 6
        FA18C_ExportArguments["8,3007"] ="25,3002,1" -- UFC Function Pushbutton, IFF >> UFC :: 7
        FA18C_ExportArguments["8,3008"] ="25,3003,1" -- UFC Function Pushbutton, TCN >> UFC :: 8
        FA18C_ExportArguments["8,3009"] ="25,3004,1" -- UFC Function Pushbutton, ILS >> UFC :: 9
        FA18C_ExportArguments["8,3010"] ="25,3005,1" -- UFC Function Pushbutton, D/L >> UFC :: 0
        FA18C_ExportArguments["8,3011"] ="25,3006,1" -- UFC Function Pushbutton, BCN >> UFC :: Space
        FA18C_ExportArguments["8,3012"] ="25,3007,1" -- UFC Function Pushbutton, ON(OFF) >> UFC :: Display Hack Time
        FA18C_ExportArguments["8,3001"] ="25,3010,1" -- UFC Option Select Pushbutton 1 >> UFC :: 1
        FA18C_ExportArguments["8,3002"] ="25,3011,1" -- UFC Option Select Pushbutton 2 >> UFC :: 2
        FA18C_ExportArguments["8,3003"] ="25,3012,1" -- UFC Option Select Pushbutton 3 >> UFC :: 3
        FA18C_ExportArguments["8,3004"] ="25,3013,1" -- UFC Option Select Pushbutton 4 >> UFC :: 4
        FA18C_ExportArguments["8,3005"] ="25,3014,1" -- UFC Option Select Pushbutton 5 >> UFC :: 5
        FA18C_ExportArguments["9,3015"] ="25,3019,1" -- UFC Keyboard Pushbutton, 1 >> CDU :: 1
        FA18C_ExportArguments["9,3016"] ="25,3020,1" -- UFC Keyboard Pushbutton, 2 >> CDU :: 2
        FA18C_ExportArguments["9,3017"] ="25,3021,1" -- UFC Keyboard Pushbutton, 3 >> CDU :: 3
        FA18C_ExportArguments["9,3018"] ="25,3022,1" -- UFC Keyboard Pushbutton, 4 >> CDU :: 4
        FA18C_ExportArguments["9,3019"] ="25,3023,1" -- UFC Keyboard Pushbutton, 5 >> CDU :: 5
        FA18C_ExportArguments["9,3020"] ="25,3024,1" -- UFC Keyboard Pushbutton, 6 >> CDU :: 6
        FA18C_ExportArguments["9,3021"] ="25,3025,1" -- UFC Keyboard Pushbutton, 7 >> CDU :: 7
        FA18C_ExportArguments["9,3022"] ="25,3026,1" -- UFC Keyboard Pushbutton, 8 >> CDU :: 8
        FA18C_ExportArguments["9,3023"] ="25,3027,1" -- UFC Keyboard Pushbutton, 9 >> CDU :: 9
        FA18C_ExportArguments["9,3024"] ="25,3018,1" -- UFC Keyboard Pushbutton, 0 >> CDU :: 0
        FA18C_ExportArguments["8,3015"] ="25,3028,1" -- UFC Keyboard Pushbutton, CLR >> UFC :: Clear
        FA18C_ExportArguments["8,3016"] ="25,3029,1" -- UFC Keyboard Pushbutton, ENT >> UFC :: Enter
        FA18C_ExportArguments["8,3013"] ="25,3015,1" -- UFC I/P Pushbutton >> UFC :: Select Funciton Mode
        FA18C_ExportArguments["8,3014"] ="25,3017,1" -- UFC EMCON Select Pushbutton >> UFC :: Select Letter Mode
        FA18C_ExportArguments["12,3002"] ="25,3016,1" -- UFC ADF Function Select Switch, 1/OFF/2 >> TISL :: Slant Range 
        FA18C_ExportArguments["49,3016"] ="25,3030,1" -- UFC COMM 1 Volume Control Knob >> Light System :: Weapon Station Lights Brightness
        FA18C_ExportArguments["49,3015"] ="25,3031,1" -- UFC COMM 2 Volume Control Knob >> Light System :: Refuel Status Indexer Brightness
        FA18C_ExportArguments["49,3002"] ="25,3032,1" -- UFC Brightness Control Knob >> Light System :: Flight Instruments Lights
        FA18C_ExportArguments["12,3007"] ="40,3003,1" -- ICS Volume Control Knob >> TISL :: TISL Code Wheel 3
        FA18C_ExportArguments["58,3002"] ="40,3004,1" -- RWR Volume Control Knob >> Intercom :: INT Volume;
        FA18C_ExportArguments["12,3004"] ="40,3005,1" -- WPN Volume Control Knob >> TISL :: Altitude above target thousands of feet
        FA18C_ExportArguments["12,3003"] ="40,3007,1" -- MIDS B Volume Control Knob >> TISL :: Altitude above target tens of thousands of feet
        FA18C_ExportArguments["12,3005"] ="40,3006,1" -- MIDS A Volume Control Knob >> TISL :: TISL Code Wheel 1
        FA18C_ExportArguments["12,3006"] ="40,3008,1" -- TACAN Volume Control Knob >> TISL :: TISL Code Wheel 2
        FA18C_ExportArguments["5,3007"] ="40,3009,1" -- AUX Volume Control Knob >> CMSC :: RWR Volume
        FA18C_ExportArguments["40,3003"] ="40,3010,1" -- COMM RLY Select Switch, CIPHER/OFF/PLAIN >> Oxygen System :: Emergency Lever
        FA18C_ExportArguments["43,3016"] ="40,3011,1" -- COMM G XMT Switch, COMM 1/OFF/COMM 2 >> IFF :: M-1 Switch
        FA18C_ExportArguments["22,3005"] ="40,3012,102" -- IFF Master Switch, EMER/NORM >> AAP :: CDU Power
        FA18C_ExportArguments["12,3009"] ="40,3013,1" -- IFF Mode 4 Switch, DIS-AUD/DIS/OFF >> TISL :: Code Select
        FA18C_ExportArguments["41,3004"] ="50,3001,1" -- COMM 1 ANT SEL Switch, UPPER/AUTO/LOWER >> Environmental Control :: Windshield Remove/Wash
        FA18C_ExportArguments["43,3017"] ="50,3002,1" -- IFF ANT SEL Switch, UPPER/BOTH/LOWER >> IFF :: M-2 Switch







-------------------------------------------------------------------------------------------------------------------------------- end FA18C













	-- Export arguments for the MIG-21 using the A10C interface
	MIG21ExportArguments = {}
	-- Format: device,button number, multiplier
	-- arguments with multiplier 100, 101,102 or >300 are special conversion cases, and are computed in different way
				
	-- DC & AC buses & giro devices 1 - 2
	MIG21ExportArguments["50,3001"] = "1,3001,1"	-- Battery On/Off  165 2 > "Fire System", "Left Engine Fire Pull" 102 --
	MIG21ExportArguments["50,3002"] = "1,3002,1"	-- Battery Heat On/Off  155 2 > "Fire System", "APU Fire Pull" 103 --
	MIG21ExportArguments["50,3003"] = "1,3003,1"	-- DC Generator On/Off  166 2 > "Fire System", "Right Engine Fire Pull"104  --
	MIG21ExportArguments["39,3001"] = "2,3004,1"	-- AC Generator On/Off  169 2 > "Mechanical", "Landing Gear Lever" 716 --
	MIG21ExportArguments["7,3004"] = "2,3005,1"		-- PO-750 Inverter #1 On/Off  153 2 > "AHCP", "TGP Power" 378 --
	MIG21ExportArguments["7,3006"] = "2,3006,1"		-- PO-750 Inverter #2 On/Off  154 2 > "AHCP", "HUD Day/Night" 380 --
	MIG21ExportArguments["7,3007"] = "2,3007,1"		-- Emergency Inverter  164 2 > "AHCP", "HUD Norm/Standbyh" 381 --
	-- GIRO 21
	MIG21ExportArguments["7,3008"] = "21,3008,1"	-- Giro, NPP, SAU, RLS Signal, KPP Power On/Off  162 2 > "AHCP", "CICU Power" 382 --
	MIG21ExportArguments["7,3009"] = "21,3009,1"	-- DA-200 Signal, Giro, NPP, RLS, SAU Power On/Off  163 2 > "AHCP", "Datalink Power" 383 --
	-- FUEL_PUMPS & FUEL_SYSTEM  4
	MIG21ExportArguments["46,3008"] = "4,3010,1"	-- Fuel Tanks 3rd Group, Fuel Pump  159 2 > "Navigation Mode Select Panel", "Able - Stow" 621 --
	MIG21ExportArguments["1,3001"] = "4,3011,1"		-- Fuel Tanks 1st Group, Fuel Pump  160 2 > "Electrical", "APU Generator" 241 --
	MIG21ExportArguments["49,3007"] = "4,3012,1"	-- Drain Fuel Tank, Fuel Pump  161 2 > "Electrical", "Emergency Flood" 243 --
		MIG21ExportArguments["41,3009"] = "5,3013,1"	-- Fuel Quantity Set  274 axis 0.02>  "Environmental Control", "Flow Level" 284  --
	-- ENGINE START DEVICE 3
	MIG21ExportArguments["1,3004"] = "3,3014,1"		-- APU On/Off  302 2 > "Electrical", "AC Generator - Left" 244 --
	MIG21ExportArguments["1,3005"] = "3,3015,1"		-- Engine Cold / Normal Start  288 2 > "Electrical", "AC Generator - Right" 245 --
		MIG21ExportArguments["2,3001"] = "3,3016,1"	-- Start Engine  289 btn > "Left MFCD", "OSB1" 300 --
	MIG21ExportArguments["1,3006"] = "3,3017,1"		-- Engine Emergency Air Start  301 2 > "Electrical", "Battery" 246 --
		MIG21ExportArguments["2,3002"] = "3,3238,1"	-- Engine Stop/Lock  616 btn > "Left MFCD", "OSB2" 301
	-- ACCELEROMETER 35
		MIG21ExportArguments["2,3003"] = "35,3018,1"	-- Accelerometer Reset  228 btn > "Left MFCD", "OSB3" 302 --
	-- PITOT TUBES and related things that use dc bus for heating 27
	MIG21ExportArguments["40,3002"] = "27,3019,1"	-- Pitot tube Selector Main/Emergency 229 2 > "Oxygen System", "Dilution Lever" 602 --
	MIG21ExportArguments["40,3001"] = "27,3020,1"	-- Pitot tube/Periscope/Clock Heat  279 2 > "Oxygen System", "Supply Lever" 603 --
	MIG21ExportArguments["4,3008"] = "27,3021,1"	-- Secondary Pitot Tube Heat  280 2 > "CMSP", "ECM Pod Jettison" 358 --
	-- DA-200 34
		MIG21ExportArguments["38,3013"] = "34,3203,1"	-- variometer Set  261 axis lim 0.0001   (-1,1) > "Autopilot", "Yaw Trim" 192 --
	-- ENGINE 6
	MIG21ExportArguments["41,3002"] = "6,3022,1"	-- Anti surge doors - Auto/Manual 308 2 > "Environmental Control", "Windshield Defog/Deice" 276 --
	MIG21ExportArguments["41,3005"] = "6,3023,1"	-- Afterburner/Maximum Off/On  300 2 > "Environmental Control", "Pitot heat" 279 --
	MIG21ExportArguments["41,3006"] = "6,3024,1"	-- Emergency Afterburner Off/On  320 2 > "Environmental Control", "Bleed Air" 280 --
	-- FIRE EXTINGUISHER 53 
	MIG21ExportArguments["49,3012"] = "53,3025,1"	-- Fire Extinguisher Off/On  303 2 > "Light System", "Nose Illumination" 291 --
	MIG21ExportArguments["49,3013"] = "53,3026,1"	-- Fire Extinguisher Cover  324 2 > "Light System", "Signal Lights" 294 --
		MIG21ExportArguments["2,3004"] = "53,3027,1"	-- Fire Extinguisher  325 btn > "Left MFCD", "OSB4" 303 --
	-- Radio  55 intercom 25
	MIG21ExportArguments["36,3001"] = "22,3041,1"	-- Radio System On/Off  173 2 > "Fuel System", "External Wing Tank Boost Pump" 106 --
	MIG21ExportArguments["36,3002"] = "22,3042,1"	-- Radio / Compass  208 2 > "Fuel System", "External Fuselage Tank Boost Pump" 107 --
	MIG21ExportArguments["36,3003"] = "22,3043,1"	-- Squelch On/Off  209 2 > "Fuel System", "Tank Gate" 108 --
		MIG21ExportArguments["54,3011"] = "22,3044,1"	-- Radio Volume  210 axis 0.1 >  "UHF Radio", "Volume" 171   --
	MIG21ExportArguments["51,3007"] = "22,3045,1"	-- Radio Channel  211 multi sw 20 0.05 > "TACAN", "Volumne" 261 --
		MIG21ExportArguments["2,3005"] = "55,3046,1"	-- Radio PTT  315 btn > "Left MFCD", "OSB5" 304
	-- ARK 24
	MIG21ExportArguments["36,3004"] = "24,3047,1"	-- ARK On/Off  174 2 > "Fuel System", "Cross Feed" 109 --
		MIG21ExportArguments["58,3002"] = "24,3048,1"	-- ARK Sound  198 axis 0.1 > "Intercom", "INT Volume" 221  --
	MIG21ExportArguments["2,3006"] = "24,3049,1"	-- ARK Change  212 btn > "Left MFCD", "OSB6" 305 --
		MIG21ExportArguments["53,3005"] = "24,3050,1"	-- ARK Channel  213 multi sw 10 0.1 > "ILS", "Volume" 249 --
	MIG21ExportArguments["52,3002"] = "24,3051,1"	-- ARK Zone  189 multi sw lim 8 0.14 > "Stall Warning", "Peak Volume" 705 --
	MIG21ExportArguments["36,3005"] = "24,3052,1"	-- ARK Mode - Antenna / Compass  197 2 > "Fuel System", "Boost Pump Left Wing" 110 --
	MIG21ExportArguments["36,3006"] = "24,3053,1"	-- Marker Far/Near  254 2 > "Fuel System", "Boost Pump Right Wing"	 111 --
	-- RSBN 25
	MIG21ExportArguments["22,3005"] = "25,3054,1"	-- RSBN On/Off  176 2 > "AAP", "CDU Power" 476  
	MIG21ExportArguments["43,3016"] = "25,3055,103"	-- RSBN Mode Land/Navigation/Descend  240 multi sw lim 3 0.5 > "IFF", "M-1 Switch" 202 --
	MIG21ExportArguments["22,3006"] = "25,3056,1"	-- RSBN / ARK  340 2 > "AAP", "EGI Power" 477 --
		MIG21ExportArguments["2,3007"] = "25,3057,1"	-- RSBN Identify  294 btn > "Left MFCD", "OSB7" 306 --
		MIG21ExportArguments["2,3008"] = "25,3080,1"	-- RSBN self-test  347 btn > "Left MFCD", "OSB8" 307 --
	--RSBN Panel 25
		MIG21ExportArguments["58,3004"] = "25,3058,1"	-- RSBN Sound  345 axis 0.1 > "Intercom", "FM Volume" 223  --
	MIG21ExportArguments["12,3003"] = "25,3059,1"	-- RSBN Navigation  351 multi sw 100 0.01 > "TISL", "Altitude above target tens of thousands of feet" 624 --
	MIG21ExportArguments["12,3004"] = "25,3060,1"	-- PRMG Landing  352 multi sw 100 0.01  >   "TISL", "Altitude above target thousands of feet" 626 --
		MIG21ExportArguments["2,3009"] = "25,3061,1"	-- RSBN Reset  366 btn > "Left MFCD", "OSB9" 308 --
	MIG21ExportArguments["44,3002"] = "25,3062,1"	-- RSBN Bearing  367 2 > "HARS", "Mode" 270 --
	MIG21ExportArguments["44,3003"] = "25,3063,1"	-- RSBN Distance  368 2 > "HARS", "Hemisphere Selector" 273 --
	-- SAU 8
	MIG21ExportArguments["37,3001"] = "8,3064,1"	-- SAU On/Off 179 2 > "Engine System", "Left Engine Fuel Flow Control" 122 --
	MIG21ExportArguments["37,3002"] = "8,3065,1"	-- SAU Pitch On/Off 180 2 > "Engine System", "Right Engine Fuel Flow Control" 123 --
	MIG21ExportArguments["2,3010"] = "8,3066,1"	-- SAU - Stabilize  	343 btn > "Left MFCD", "OSB10" 309
		MIG21ExportArguments["2,3011"] = "8,3067,1"	-- SAU cancel current mode  	376 btn > "Left MFCD", "OSB11" 310
		MIG21ExportArguments["2,3012"] = "8,3068,1"	-- SAU - Recovery 	377 btn > "Left MFCD", "OSB12" 311
	MIG21ExportArguments["37,3005"] = "8,3069,1"	-- SAU Preset - Limit Altitude 344 2 > "Engine System", "APU" 126 --
	MIG21ExportArguments["2,3013"] = "8,3070,1"	-- SAU - Landing - Command  	341 btn > "Left MFCD", "OSB13" 312
	MIG21ExportArguments["2,3014"] = "8,3071,1"	-- SAU - Landing - Auto  	342 btn > "Left MFCD", "OSB14" 313
	MIG21ExportArguments["2,3015"] = "8,3072,1"	-- SAU Reset/Off  	348 btn > "Left MFCD", "OSB15" 314  --
	-- LIGHTS 46
		MIG21ExportArguments["58,3006"] = "46,3231,1"	-- Cockpit Texts Back-light  612 axis 0.1 +300 dwn> "Intercom", "VHF Volume"  225  --
		MIG21ExportArguments["58,3008"] = "46,3232,1"	-- Instruments Back-light  156 axis 0.1 +300 dwn>   "Intercom", "UHF Volume"  227  --
		MIG21ExportArguments["58,3010"] = "46,3233,1"	-- Main Red Lights  157 axis 0.1 +300 dwn>          "Intercom", "AIM Volume"  229  --
		MIG21ExportArguments["58,3012"] = "46,3234,1"	-- Main White Lights  222 axis 0.1 +300 dwn>        "Intercom", "IFF Volume"  231  --
	MIG21ExportArguments["49,3018"] = "46,3032,1"	-- Navigation Lights Off/Min/Med/Max  194 multi sw 4 0.33 >  "Light System", "Refueling Lighting Dial" 116 --
	MIG21ExportArguments["43,3015"] = "46,3333,103"	-- Landing Lights Off/Taxi/Land  323 mlti sw lim 3 0.5 > 	"IFF", "Audio Light Switch", 201 
	-- SPO 37
	MIG21ExportArguments["69,3003"] = "37,3083,1"	-- SPO-10 RWR On/Off 202 2 > "KY-58 Secure Voice", "Delay" 780 --
		MIG21ExportArguments["2,3016"] = "37,3084,1"	-- SPO-10 Test 226 btn > "Left MFCD", "OSB16" 315 --
		MIG21ExportArguments["69,3007"] = "37,3085,1"	-- SPO-10 Night / Day  	227 2 > "KY-58 Secure Voice", "Power Switch" 784 --
		MIG21ExportArguments["58,3014"] = "37,3086,1"	-- SPO-10 Volume  	225 axis 0.1 > "Intercom", "ILS Volume" 233  --
	-- SRZO IFF
	MIG21ExportArguments["38,3030"] = "38,3087,1"	-- SRZO IFF Coder/Decoder On/Off 188 2 > "Autopilot", "Emergency Brake" 772 --
	MIG21ExportArguments["49,3016"] = "38,3088,1"	-- SRZO Codes 192 multi sw 12 0.08 >  "Light System", "Weapon Station Lights Brightness" 195 --
	MIG21ExportArguments["38,3015"] = "38,3089,1"	-- IFF System 'Type 81' On/Off 346 2 > "Autopilot", "Speed Brake Emergency Retract" 174 --
	MIG21ExportArguments["38,3016"] = "38,3210,1"	-- Emergency Transmitter Cover 190 2 > "Autopilot", "Pitch/Roll Emergency Override" 175
	MIG21ExportArguments["38,3023"] = "38,3211,1"	-- Emergency Transmitter On/Off 191 2 > "Autopilot", "Flaps Emergency Retract" 183
	MIG21ExportArguments["38,3024"] = "38,3229,1"	-- SRZO Self Destruct Cover 427 2 > "Autopilot", "Manual Reversion Flight Control System Switch" 184
		MIG21ExportArguments["2,3017"] = "38,3230,1"	-- SRZO Self Destruct 428 btn > "Left MFCD", "OSB17" 316 --
	-- SOD (increase radar signal for ATC radar, most likely won't be implemented)  39
	MIG21ExportArguments["41,3008"] = "39,3090,1"	-- SOD IFF On/Off 200 2 > "Environmental Control", "Main Air Supply" 283 --
		MIG21ExportArguments["2,3018"] = "39,3091,1"	-- SOD Identify 199 btn > "Left MFCD", "OSB18" 317 --
	MIG21ExportArguments["43,3017"] = "39,3092,103"	-- SOD Wave Selector 3/1/2 201 multi sw 3 0.5 > "IFF", "M-2 Switch" 203 --
	MIG21ExportArguments["44,3005"] = "39,3093,1"	-- SOD Modes 204 multi sw 5 0.25 > "HARS", "Latitude Correction" 271 --
	-- RADAR 40
	MIG21ExportArguments["43,3018"] = "40,3094,103"	-- Radar Off/Prep/On 205 multi sw 3 0.5 > "IFF", "M-3/A Switch" 204 --
	MIG21ExportArguments["43,3019"] = "40,3095,103"	-- Low Altitude Off/Comp/On 206 multi sw 3 0.5 > "IFF", "M-C Switch" 205 --
	MIG21ExportArguments["49,3004"] = "40,3096,1"	-- Locked Beam On/Off 207 2 > "Light System", "Accelerometer & Compass Lights" 295 --
		MIG21ExportArguments["2,3019"] = "40,3097,1"	-- Radar Screen Magnetic Reset 266 btn > "Left MFCD", "OSB19" 318 --
		MIG21ExportArguments["2,3020"] = "40,3098,1"	-- Radar Interferes - Continues 330 btn > "Left MFCD", "OSB20" 319
		MIG21ExportArguments["3,3001"] = "40,3099,1"	-- Radar Interferes - Temporary 331 btn > "Right MFCD", "OSB1" 326
		MIG21ExportArguments["3,3002"] = "40,3100,1"	-- Radar Interferes - Passive	 332 btn > "Right MFCD", "OSB2" 327
		MIG21ExportArguments["3,3003"] = "40,3101,1"	-- Radar Interferes - Weather 333 btn > "Right MFCD", "OSB3" 328
		MIG21ExportArguments["3,3004"] = "40,3102,1"	-- Radar Interferes - IFF 334 btn > "Right MFCD", "OSB4" 329
		MIG21ExportArguments["3,3005"] = "40,3103,1"	-- Radar Interferes - Low Speed 335 btn > "Right MFCD", "OSB5" 330
		MIG21ExportArguments["3,3006"] = "40,3104,1"	-- Radar Interferes - Self-test 336 btn > "Right MFCD", "OSB6" 331
		MIG21ExportArguments["3,3007"] = "40,3105,1"	-- Radar Interferes - Reset 337 btn > "Right MFCD", "OSB7" 332
		MIG21ExportArguments["3,3008"] = "40,3190,1"	-- Lock Target  378 btn >  "Right MFCD", "OSB8"   333                   STICK
		MIG21ExportArguments["58,3016"] = "40,3239,1"	-- Radar Polar Filter 623 axis 0.1 > "Intercom", "TCN Volume" 235  --
	-- SPRD 48                3,3010
	MIG21ExportArguments["36,3007"] = "48,3106,1"	-- SPRD (RATO) System On/Off 167 2 > "Fuel System", "Boost Pump Main Fuseloge Left" 112 --
	MIG21ExportArguments["36,3008"] = "48,3107,1"	-- SPRD (RATO) Drop System On/Off 168 2 > "Fuel System", "Boost Pump Main Fuseloge Right" 113 --
	MIG21ExportArguments["36,3009"] = "48,3108,1"	-- SPRD (RATO) Start Cover 252 2 > "Fuel System", "Signal Amplifier" 114 --
		MIG21ExportArguments["3,3009"] = "48,3110,1"	-- SPRD (RATO) Start 253 btn > "Right MFCD", "OSB9" 334 --
	MIG21ExportArguments["36,3012"] = "48,3109,1"	-- SPRD (RATO)t Drop Cover 317 2 > "Fuel System", "Fill Disable Wing Left" 117 --
		MIG21ExportArguments["3,3010"] = "48,3111,1"	-- SPRD (RATO) Drop 318 btn > "Right MFCD", "OSB10" 335 --
	-- SPS 10
	MIG21ExportArguments["53,3001"] = "10,3112,1"	-- SPS System Off/On 293 2 > "ILS", "Power" 247 --
	-- ARU 11
	MIG21ExportArguments["67,3001"] = "11,3113,1"	-- ARU System - Manual/Auto 295 2 > "Radar Altimeter", "Normal/Disabled" 130 --
	MIG21ExportArguments["38,3021"] = "11,3114,1"	-- ARU System - Low Speed/Neutral/High Speed 296 spr 3 sw -1 0 1 > "Autopilot", "Alieron Emergency Disengage"  177
	MIG21ExportArguments["38,3022"] = "11,3115,1"	-- ARU System - Low Speed/Neutral/High Speed 296 spr 3 sw -1 0 1 > "Autopilot", "Elevator Emergency Disengage"  180
	-- Airbrake 12
		MIG21ExportArguments["36,3013"] = "12,3116,1"	-- Airbrake - Out/In 316 2 > "Fuel System", "Fill Disable Wing Right" 118
	-- Gear brakes
	MIG21ExportArguments["36,3014"] = "13,3117,1"	-- ABS Off/On 299 2 > "Fuel System", "Fill Disable Main Left" 119 --
	MIG21ExportArguments["36,3015"] = "13,3118,1"	-- Nosegear Brake Off/On 238 2 > "Fuel System", "Fill Disable Main Right" 120 --
	MIG21ExportArguments["36,3016"] = "13,3119,1"	-- Emergency Brake 237 2 > "Fuel System", "Refuel Control Lever" 121 --
	-- Gears 14
	MIG21ExportArguments["54,3010"] = "14,3120,1"	-- Gear Handle Fixator 326 2 > "UHF Radio", "Squelch" 170 --
	MIG21ExportArguments["50,3004"] = "14,3121,1"	-- Gear Up/Neutral/Down 327 multi sw 3 1.0 > "Fire System", "Discharge Switch" 105 ----------- -1 0 1
		MIG21ExportArguments["12,3008"] = "14,3122,1"	-- Main Gears Emergency Release Handle 223 axis 0.2 > "TISL Code Wheel 4" 642 --
	MIG21ExportArguments["54,3014"] = "14,3123,1"	-- Nose Gear Emergency Release Handle 281 2 > "UHF Radio", "Cover" 734 --
	-- Flaps 15
		MIG21ExportArguments["12,3010"] = "15,3124,1"	-- Flaps Neutral 311 2 > "TISL", "Enter" 628 --
		MIG21ExportArguments["12,3011"] = "15,3125,1"	-- Flaps Take-Off 312 2 > "TISL", "OverTemp" 630 --
		MIG21ExportArguments["12,3012"] = "15,3126,1"	-- Flaps Landing 313 2 > "TISL", "Bite" 632 --
		MIG21ExportArguments["12,3013"] = "15,3127,1"	-- Flaps Reset buttons 314 btn > "TISL", "Track" 634 --
	-- Drag chute 16
		MIG21ExportArguments["3,3012"] = "16,3128,1"	-- Release Drag Chute 298 btn > "Right MFCD", "OSB12" 337 --
	MIG21ExportArguments["43,3022"] = "16,3129,1"	-- Drop Drag Chute Cover 304 2 > "IFF", "IFF On/Out" 208 --
		MIG21ExportArguments["3,3013"] = "16,3130,1"	-- Drop Drag Chute 305 btn > "Right MFCD", "OSB13" 338 --
	--TRIMER
	MIG21ExportArguments["38,3031"] = "9,3131,1"	-- Trimmer On/Off" 172 2 > "Autopilot", "HARS-SAS Override/Norm" 196 --
	-- KONUS 17
	MIG21ExportArguments["58,3001"] = "17,3133,1"	-- Nosecone On/Off 170 2 > "Intercom", "INT Switch" 222 --
	MIG21ExportArguments["58,3003"] = "17,3134,1"	-- Nosecone Control - Manual/Auto 309 2 > "Intercom", "FM Switch" 224 --
		MIG21ExportArguments["12,3005"] = "17,3135,1"	-- Nosecone manual position controller 236 axis 0.05 > "TISL", "TISL Code Wheel 1" 636  --
	-- SOPLO 18
	MIG21ExportArguments["58,3005"] = "18,3136,1"	-- Engine Nozzle 2 Position Emergency Control 291 2 > "Intercom", "VHF Switch" 226 --
	--MAIN_HYDRO and BUSTER_HYDRO   44 
	MIG21ExportArguments["58,3007"] = "44,3137,1"	-- Emergency Hydraulic Pump On/Off 171 2 > "Intercom", "UHF Switch" 228 --
	MIG21ExportArguments["58,3009"] = "44,3138,1"	-- Aileron Booster - Off/On 319 2 >        "Intercom", "AIM Switch" 230 --
		--KPP 28
	MIG21ExportArguments["58,3011"] = "28,3139,1"	-- KPP Main/Emergency 177 2 > "Intercom", "IFF Switch" 232 --
		MIG21ExportArguments["3,3014"] = "28,3140,1"	-- KPP Cage 259 btn > "Right MFCD", "OSB14" 339 --
		MIG21ExportArguments["9,3064"] = "28,3141,301"	-- KPP Set 260 axis lim 0.0001 > "CDU", "Blank" 469 rocker --
		MIG21ExportArguments["9,3065"] = "28,3141,301"	-- KPP Set 260 axis lim 0.0001 > "CDU", "Blank" 469 rocker --
		--IAS / TAS / KSI (NPP) 23
	MIG21ExportArguments["58,3013"] = "23,3142,1"	-- NPP On/Off 178 2 > "Intercom", "ILS Switch" 234 --
		MIG21ExportArguments["3,3015"] = "23,3143,1"	-- NPP Adjust 258 btn > "Right MFCD", "OSB15" 340  --
		--MIG21ExportArguments["47,3001"] = "23,3144,1"	-- NPP Course set 263 axis 0.1 > "ADI", "Pitch Trim Knob" 22  --
		MIG21ExportArguments["9,3062"] = "23,3144,302"	-- NPP Course set 263 axis 0.1 > "CDU", "Page" 463 rocker  --
		MIG21ExportArguments["9,3063"] = "23,3144,302"	-- NPP Course set 263 axis 0.1 > "CDU", "Page" 463 rocker  --
	-- ALTIMETER and radioALTIMETER 32 33
	MIG21ExportArguments["58,3015"] = "33,3145,1"	-- Radio Altimeter/Marker On/Off 175 2 > "Intercom", "TCN Switch" 236 --
	MIG21ExportArguments["5,3007"] = "33,3146,1"	-- Dangerous Altitude Warning Set 284 multi sw 8 0.14 > "CMSC", "RWR Volume" 368 --
	MIG21ExportArguments["9,3066"] = "32,3073,300"	-- Altimeter pressure knob 262 axis lim 0.02 -1 0 1> "CDU", "+/-" 472  rocker --
	MIG21ExportArguments["9,3067"] = "32,3073,300"	-- Altimeter pressure knob 262 axis lim 0.02 -1 0 1> "CDU", "+/-" 472  rocker --
	--OXYGENE_SYSTEM 19
	MIG21ExportArguments["58,3017"] = "19,3147,1"	-- Helmet Air Condition Off/On 285 2 > "Intercom", "Hot Mic Switch" 237 --
	MIG21ExportArguments["39,3008"] = "19,3148,1"	-- Emergency Oxygen Off/On 286 2 > "Mechanical", "Auxiliary Landing Gear Handle" 718 --
	MIG21ExportArguments["39,3010"] = "19,3149,1"	-- Mixture/Oxygen 287 2 > "Mechanical", "Seat Arm Handle" 733 --
	--CANOPY 43
	MIG21ExportArguments["8,3010"] = "43,3150,1"	-- Hermetize Canopy 328 2 > "UFC", "0" 395 --
	MIG21ExportArguments["8,3011"] = "43,3151,1"	-- Secure Canopy 329 2 > "UFC", "Space" 396
		MIG21ExportArguments["3,3016"] = "43,3152,1"	-- Canopy Open 375 btn > "Right MFCD", "OSB16" 341
		MIG21ExportArguments["3,3017"] = "43,3194,1"	-- Canopy Close 385 btn > "Right MFCD", "OSB17" 342
	MIG21ExportArguments["3,3018"] = "43,3153,1"	-- -- Canopy Anti Ice 239 btn > "Right MFCD", "OSB18" 343 --
	MIG21ExportArguments["8,3012"] = "43,3154,1"	-- Canopy Emergency Release Handle 224 2 > "UFC", "Display Hack Time" 394
		MIG21ExportArguments["0,0000"] = "43,3272,1"	-- Canopy Ventilation System 649 lever > ojo difieren los ids
	-- ASP Gunsight 41
	MIG21ExportArguments["8,3013"] = "41,3155,1"	-- ASP Optical sight On/Off 186 2 >         "UFC", "Select Funciton Mode"      397 --
	MIG21ExportArguments["8,3014"] = "41,3156,1"	-- -- ASP Main Mode - Manual/Auto 241 2 >      "UFC", "Select Letter Mode"     398 --
	MIG21ExportArguments["8,3015"] = "41,3157,1"	-- -- ASP Mode - Bombardment/Shooting 242 2 >  "UFC", "Clear"       399 --
	MIG21ExportArguments["8,3016"] = "41,3158,1"	-- -- ASP Mode - Missiles-Rockets/Gun 243 2 >  "UFC", "Enter"        400 --
	MIG21ExportArguments["8,3017"] = "41,3159,1"	-- ASP Mode - Giro/Missile 244 2 >          "UFC", "Create Overhead Mark Point"  401 --
	MIG21ExportArguments["8,3018"] = "41,3160,1"	-- Pipper On/Off 249 2 >                    "UFC", "Display and Adjust Altitude Alert Values"  402 --
	MIG21ExportArguments["8,3030"] = "41,3161,1"	-- Fix net On/Off 250 2 >                   "UFC", "FWD"    531 --
		MIG21ExportArguments["49,3009"] = "41,3162,1"	-- Target Size 245 axis 0.1 >                      "Light System", "Formation Lights"            288  --
		MIG21ExportArguments["49,3001"] = "41,3163,1"	-- Intercept Angle 246 axis 0.1 >                  "Light System", "Engine Instrument Lights"    290  --
		MIG21ExportArguments["49,3002"] = "41,3164,1"	-- Scale Backlights control 247 axis 0.1 >         "Light System", "Flight Instruments Lights"   292  --
		MIG21ExportArguments["49,3003"] = "41,3165,1"	-- Pipper light control 248 axis 0.1 >             "Light System", "Auxillary instrument Lights" 293  --
		MIG21ExportArguments["49,3005"] = "41,3166,1"	-- Fix Net light control 251 axis 0.1 >            "Light System", "Flood Light"                 296  --
		MIG21ExportArguments["49,3006"] = "41,3213,1"	-- TDC Range / Pipper Span control 384 axis 0.1 >  "Light System", "Console Lights"              297  --
	-- WEAPON_CONTROL 42
	MIG21ExportArguments["9,3015"] = "42,3167,1"	-- Missiles - Rockets Heat On/Off  181 2 >          "CDU", "1"  425 --
	MIG21ExportArguments["9,3016"] = "42,3168,1"	-- Missiles - Rockets Launch On/Off  182 2 >        "CDU", "2"  426 --
	MIG21ExportArguments["9,3017"] = "42,3169,1"	-- Pylon 1-2 Power On/Off  183 2 >                  "CDU", "3"  427 --
	MIG21ExportArguments["9,3018"] = "42,3170,1"	-- Pylon 3-4 Power On/Off  184 2 >                  "CDU", "4"  428 --
	MIG21ExportArguments["9,3019"] = "42,3171,1"	-- GS-23 Gun On/Off  185 2 >                        "CDU", "5"  429 --
	MIG21ExportArguments["9,3020"] = "42,3172,1"	-- Guncam On/Off  187 2 >                           "CDU", "6"  430 --
	MIG21ExportArguments["9,3021"] = "42,3173,1"	-- Tactical Drop Cover  277 2 >                     "CDU", "7"  431 --
	MIG21ExportArguments["9,3022"] = "42,3174,1"	-- Tactical Drop  278 2 >                           "CDU", "8"  432 --
	MIG21ExportArguments["9,3023"] = "42,3175,1"	-- Emergency Missile/Rocket Launcher Cover  275 2 > "CDU", "9"  433 --
		MIG21ExportArguments["3,3019"] = "42,3176,1"	-- Emergency Missile/Rocket Launcher  276 btn > "Right MFCD", "OSB19" 344 --
	MIG21ExportArguments["9,3024"] = "42,3177,1"	-- Drop Wing Fuel Tanks Cover  256 2 >				"CDU", "0" 434 --
		MIG21ExportArguments["3,3020"] = "42,3178,1"	-- Drop Wing Fuel Tanks"  257 btn > "Right MFCD", "OSB20" 345 --
		MIG21ExportArguments["8,3001"] = "42,3196,1"	-- Drop Center Fuel Tank  386 btn > "UFC", "1"  385        STICK
	MIG21ExportArguments["8,3031"] = "42,3179,1"	-- Drop Payload - Outer Pylons Cover  269 2 > "UFC", "MID" 532 --
		MIG21ExportArguments["8,3002"] = "42,3180,1"	-- Drop Payload - Outer Pylons  270 btn > "UFC", "2" 386 --
	MIG21ExportArguments["8,3032"] = "42,3181,1"	-- Drop Payload - Inner Pylons Cover  271 2 > "UFC", "AFT" 533 --
		MIG21ExportArguments["8,3003"] = "42,3182,1"	-- Drop Payload - Inner Pylons  272 btn > "UFC", "3" 387 --
	MIG21ExportArguments["24,3001"] = "42,3183,1"	-- -- Weapon Mode - Air/Ground  230 2 > "UFC", "Master Caution" 403 --
	MIG21ExportArguments["43,3020"] = "42,3184,103"	-- Weapon Mode - IR Missile/Neutral/SAR Missile  231 multi sw 3 0.5 > "IFF", "RAD Test/Monitor Switch" 206 --
		MIG21ExportArguments["8,3004"] = "42,3185,1"	-- Activate Gun Loading Pyro - 1  232 btn > "UFC", "4"  388
		MIG21ExportArguments["8,3005"] = "42,3186,1"	-- Activate Gun Loading Pyro - 2  233 btn > "UFC", "5" 389
		MIG21ExportArguments["8,3006"] = "42,3187,1"	-- Activate Gun Loading Pyro - 3  234 btn > "UFC", "6" 390
	MIG21ExportArguments["52,3001"] = "42,3188,1"	-- Weapon Selector  235 multi sw 11 0.10 > "Stall Warning", "Stall Volume" 704 ------------
		MIG21ExportArguments["49,3015"] = "42,3189,1"	-- Missile Seeker Sound  297 axis 0.1 > "Light System", "Refuel Status Indexer Brightness" 193  --
	--HELMET_VISOR
	MIG21ExportArguments["3,3011"] = "45,3205,1"	-- Helmet Heat - Manual/Auto  306 2 > "Right MFCD", "OSB11" 336 --
		MIG21ExportArguments["8,3007"] = "45,3206,1"	-- Helmet Quick Heat  310 btn >  "UFC", "7" 391 --
		MIG21ExportArguments["12,3014"] = "45,3207,1"	-- Helmet visor - off/on  369 2 > "IFFCC", "Ext Stores Jettison" 101
	--AIR CONDITIONING
		MIG21ExportArguments["0,0000"] = "50,3208,1"	-- Cockpit Air Condition Off/Cold/Auto/Warm  292 multi sw 4 0.33 > ----------------NOT SIMULATED-----------------------------------------------------------
	-- SARPP
	MIG21ExportArguments["5,3001"] = "49,3209,1"	-- SARPP-12 Flight Data Recorder On/Off  193 2 > "CMSC", "Cycle JMR Program Button" 365
	--Dummy buttons/switches
	MIG21ExportArguments["5,3002"] = "40,3254,1"	-- Radar emission - Cover  632 2 >            "CMSC", "Cycle MWS Program Button"   366 --
	MIG21ExportArguments["5,3003"] = "40,3255,1"	-- Radar emission - Combat/Training  633 2 >  "CMSC", "Priority Button"));         369 --
	MIG21ExportArguments["5,3004"] = "17,3260,1"	-- 1.7 Mach Test Button - Cover  638 2 >      "CMSC", "Separate Button"));         370
		MIG21ExportArguments["5,3005"] = "17,3261,1"	-- 1.7 Mach Test Button  639 2 >              "CMSC", "Unknown Button"));          371 --
	-- IAB PBK-3
	MIG21ExportArguments["46,3001"] = "56,3197,1"	-- Emergency Jettison  387 2 >                       "Navigation Mode Select Panel", "HARS"  605 --
	MIG21ExportArguments["46,3002"] = "56,3198,1"	-- Emergency Jettison Armed / Not Armed  388 2 >     "Navigation Mode Select Panel", "EGI"   607 --
	MIG21ExportArguments["46,3003"] = "56,3199,1"	-- Tactical Jettison  389 2 >                        "Navigation Mode Select Panel", "TISL"  609 --
	MIG21ExportArguments["46,3004"] = "56,3200,1"	-- Special AB / Missile-Rocket-Bombs-Cannon  390 2 > "Navigation Mode Select Panel", "STEERPT"  611 --
	MIG21ExportArguments["46,3005"] = "56,3201,1"	-- Brake Chute  391 2 >                              "Navigation Mode Select Panel", "ANCHR" 613 --
	MIG21ExportArguments["46,3006"] = "56,3202,1"	-- Detonation Air / Ground  392 2 >                  "Navigation Mode Select Panel", "TCN"   615 --
	-- SPS 141-100
	MIG21ExportArguments["9,3001"] = "57,3214,1"	-- On / Off  393 2 >             "CDU", "LSK 3L"  410 --
	MIG21ExportArguments["9,3002"] = "57,3215,1"	-- Transmit / Receive  394 2 >   "CDU", "LSK 5L"  411 --
	MIG21ExportArguments["9,3003"] = "57,3216,1"	-- Program I / II  395 2 >       "CDU", "LSK 7L"  412 --
	MIG21ExportArguments["9,3004"] = "57,3217,1"	-- Continuous / Impulse  396 2 > "CDU", "LSK 9L"  413 --
		MIG21ExportArguments["8,3008"] = "57,3218,1"	-- Test  397 btn >  "UFC", "8" 392  --
	MIG21ExportArguments["9,3005"] = "57,3219,1"	-- Dispenser Auto / Manual  398 2 > "CDU", "LSK 3R" 414 --
	MIG21ExportArguments["43,3021"] = "57,3220,103"	-- Off / Parallel / Full  399 multi sw 3 0.5 > "IFF", "Ident/Mic Switch" 207 --
	MIG21ExportArguments["9,3006"] = "57,3221,1"	-- Manual Activation button - Cover  400 2 > "CDU", "LSK 5R" 415 --
		MIG21ExportArguments["8,3009"] = "57,3222,1"	-- Manual Activation button  401 btn >  "UFC", "9" 393 --
	-- GUV Control Box 
	MIG21ExportArguments["9,3007"] = "42,3223,1"	-- On / Off  420 2 >            "CDU", "LSK 7R"  416 --
	MIG21ExportArguments["9,3008"] = "42,3224,1"	-- MAIN GUN / UPK Guns  421 2 > "CDU", "LSK 9R"  417 --
	MIG21ExportArguments["9,3027"] = "42,3225,1"	-- LOAD 1  422 2 > "CDU", "A"  437 --
	MIG21ExportArguments["9,3028"] = "42,3226,1"	-- LOAD 2  425 2 > "CDU", "B"  438 --
	MIG21ExportArguments["9,3029"] = "42,3227,1"	-- LOAD 3  424 2 > "CDU", "C"  439 --
	-- Warning lights
	MIG21ExportArguments["9,3030"] = "47,3034,1"	-- Check Warning Lights T4    369 2 >  "CDU", "D" 440 --
	MIG21ExportArguments["9,3031"] = "47,3035,1"	-- Check Warning Lights T10   370 2 >  "CDU", "E" 441 --
	MIG21ExportArguments["9,3032"] = "47,3036,1"	-- Check Warning Lights T4-2  371 2 >  "CDU", "F" 442 --
	MIG21ExportArguments["9,3033"] = "47,3037,1"	-- Check Warning Lights T4-3  372 2 >  "CDU", "G" 443 --
	MIG21ExportArguments["9,3034"] = "47,3038,1"	-- Check Warning Lights T10-2 373 2 >  "CDU", "H" 444 --
	MIG21ExportArguments["9,3035"] = "47,3039,1"	-- Check Warning Lights PPS   374 2 >  "CDU", "I" 445 --
	MIG21ExportArguments["9,3036"] = "47,3040,1"	-- SORC   255 2 > "CDU", "J" 446   --
	-- Clock
	MIG21ExportArguments["43,3021"] = "26,3249,1"	-- Mech clock left lever 265 multi sw 3  1 0 -1  > "IFF", "Ident/Mic Switch" 207 --
	MIG21ExportArguments["58,3018"] = "26,3251,1"	-- Mech clock left lever 264 axis  0.04 > "Intercom", "Master Volume" 238
	MIG21ExportArguments["9,3037"] = "26,3252,1"	-- Mech clock right lever 268 btn  > "CDU", "K" 447 --
	MIG21ExportArguments["41,3003"] = "26,3253,1"	-- Mech clock right lever  267 axis  0.05 -015 0.15 > "Environmental Control", "Canopy Defog" 277 -- 












---------------------------------------------------------------------------------------- Export arguments for the MI-8 using the CapZeen Extended interface
MI8_ExportArguments = {}
-- Format: device,button number, multiplier
-- arguments with multiplier >100  are special conversion cases, and are computed in different way

--                      Extended       	MI8

	--toggle_switches:
	
	
	
	MI8_ExportArguments["2,3001"] ="1, 3001,1" -- Standby Generator Switch, ON/OFF 	         497
	MI8_ExportArguments["2,3002"] ="1, 3002,1" -- Battery 2 Switch, ON/OFF 			         496
	MI8_ExportArguments["2,3003"] ="1, 3003,1" -- Battery 1 Switch, ON/OFF 			         495
	MI8_ExportArguments["2,3004"] ="1, 3004,1" -- DC Ground Power Switch, ON/OFF 		     502
	MI8_ExportArguments["2,3005"] ="1, 3005,1" -- Rectifier 2 Switch, ON/OFF			     500
	MI8_ExportArguments["2,3006"] ="1, 3006,1" -- Rectifier 3 Switch, ON/OFF, 			     501
	MI8_ExportArguments["2,3007"] ="1, 3007,1" -- Rectifier 1 Switch, ON/OFF 			     499
	MI8_ExportArguments["2,3008"] ="1, 3009,1" -- Equipment Test Switch, ON/OFF 		     503
	MI8_ExportArguments["2,3009"] ="1, 3014,1" -- AC Ground Power Switch, ON/OFF		     540
	MI8_ExportArguments["2,3010"] ="1, 3015,1" -- Generator 1 Switch, ON/OFF 			     538
	MI8_ExportArguments["2,3011"] ="1, 3016,1" -- Generator 2 Switch, ON/OFF 			     539
	MI8_ExportArguments["2,3012"] ="1, 3019,1" -- Net on Rectifier Switch, ON/OFF 		     148
	MI8_ExportArguments["2,3013"] ="1, 3021,1" -- Net on Rectifier Switch Cover, OPEN/CLOSE  147
	MI8_ExportArguments["2,3031"] ="1, 3031,1" -- CB BW ESBR, ON/OFF			             		590
	MI8_ExportArguments["2,3032"] ="1, 3032,1" -- CB Explode, ON/OFF			             		591
	MI8_ExportArguments["2,3033"] ="1, 3033,1" -- CB Control, ON/OFF_mi8		             		592
	MI8_ExportArguments["2,3034"] ="1, 3034,1" -- CB Equipment, ON/OFF		                 		593
	MI8_ExportArguments["2,3035"] ="1, 3035,1" -- CB RS/GUV Fire, ON/OFF		             		594
	MI8_ExportArguments["2,3036"] ="1, 3036,1" -- CB RS/GUV Warning, ON/OFF	                 		595
	MI8_ExportArguments["2,3037"] ="1, 3037,1" -- CB ESBR Heating, ON/OFF		             		596
	MI8_ExportArguments["2,3038"] ="1, 3038,1" -- CB 311, ON/OFF						     		597
	MI8_ExportArguments["2,3039"] ="1, 3039,1" -- CB GUV: Outer 800 Left, ON/OFF		     		598
	MI8_ExportArguments["2,3040"] ="1, 3040,1" -- CB GUV: Outer 800 Right, ON/OFF		     		599
	MI8_ExportArguments["2,3041"] ="1, 3041,1" -- CB GUV: Inner Left 622 Left, ON/OFF	     		600
	MI8_ExportArguments["2,3042"] ="1, 3042,1" -- CB GUV: Inner Left 622 Right, ON/OFF       		601
	MI8_ExportArguments["2,3043"] ="1, 3043,1" -- CB GUV: Inner Right 622 Left, ON/OFF       		602
	MI8_ExportArguments["2,3044"] ="1, 3044,1" -- CB GUV: Inner Right 622 Right, ON/OFF      		603
	MI8_ExportArguments["2,3045"] ="1, 3045,1" -- CB Electric Launch 800 Left, ON/OFF	        	604
	MI8_ExportArguments["2,3046"] ="1, 3046,1" -- CB Electric Launch 800 Right, ON/OFF          	605
	MI8_ExportArguments["2,3047"] ="1, 3047,1" -- CB PKT, ON/OFF						        	606
	MI8_ExportArguments["2,3048"] ="1, 3048,1" -- CB Emergency Jettison: Bombs and GUV, ON/OFF  	607
	MI8_ExportArguments["2,3049"] ="1, 3049,1" -- CB Emergency Jettison: Power, ON/OFF		    	608
	MI8_ExportArguments["2,3050"] ="1, 3050,1" -- CB Emergency Jettison: Armed, ON/OFF		    	609
	MI8_ExportArguments["2,3051"] ="1, 3051,1" -- CB Signal Flare, ON/OFF							610
	MI8_ExportArguments["2,3052"] ="1, 3052,1" -- CB APU Start, ON/OFF						    	611
	MI8_ExportArguments["2,3053"] ="1, 3053,1" -- CB APU Ignition, ON/OFF					    	612
	MI8_ExportArguments["2,3054"] ="1, 3054,1" -- CB Engine Start, ON/OFF					    	613
	MI8_ExportArguments["2,3055"] ="1, 3055,1" -- CB Engine Ignition, ON/OFF				    	614
	MI8_ExportArguments["2,3056"] ="1, 3056,1" -- CB RPM CONTROL, ON/OFF					    	615
	MI8_ExportArguments["2,3057"] ="1, 3057,1" -- CB NONAME, ON/OFF						        	616
	MI8_ExportArguments["2,3058"] ="1, 3058,1" -- CB Lock Opening Control Main, ON/OFF	        	617
	MI8_ExportArguments["2,3059"] ="1, 3059,1" -- CB Lock Opening Control Reserve, ON/OFF	    	618
	MI8_ExportArguments["2,3060"] ="1, 3060,1" -- CB TURN INDICATOR, ON/OFF,				    	619
	MI8_ExportArguments["2,3061"] ="1, 3061,1" -- CB Autopilot: Main, ON/OFF				        620
	MI8_ExportArguments["2,3062"] ="1, 3062,1" -- CB Autopilot: Friction, ON/OFF			        621
	MI8_ExportArguments["2,3063"] ="1, 3063,1" -- CB Autopilot: Electric Clutches, ON/OFF		    622
	MI8_ExportArguments["2,3064"] ="1, 3064,1" -- CB Hydraulics: Main, ON/OFF					    623
	MI8_ExportArguments["2,3065"] ="1, 3065,1" -- CB Hydraulics: Auxiliary, ON/OFF			        624
	MI8_ExportArguments["2,3066"] ="1, 3066,1" -- CB Radio: SPU (Intercom), ON/OFF				    625
	MI8_ExportArguments["2,3067"] ="1, 3067,1" -- CB Radio: Altimeter, ON/OFF						626
	MI8_ExportArguments["2,3068"] ="1, 3068,1" -- CB Radio: Command Radio Station (R-863), ON/OFF	627
	MI8_ExportArguments["2,3069"] ="1, 3069,1" -- CB Radio: 6201, ON/OFF							628
	MI8_ExportArguments["2,3070"] ="1, 3070,1" -- CB Fuel System: Bypass Valve, ON/OFF	            629
	MI8_ExportArguments["2,3071"] ="1, 3071,1" -- CB Fuel System: Left Valve, ON/OFF		        630
	MI8_ExportArguments["2,3072"] ="1, 3072,1" -- CB Fuel System: Right Valve, ON/OFF		        631
	MI8_ExportArguments["2,3073"] ="1, 3073,1" -- CB Fuel System: Fuelmeter, ON/OFF		            632
	MI8_ExportArguments["2,3074"] ="1, 3074,1" -- CB Fuel System: Center Tank Pump, ON/OFF          633
	MI8_ExportArguments["2,3075"] ="1, 3075,1" -- CB Fuel System: Left Tank Pump, ON/OFF	        634
	MI8_ExportArguments["2,3076"] ="1, 3076,1" -- CB Fuel System: Right Tank Pump, ON/OFF	        635
	MI8_ExportArguments["2,3077"] ="1, 3077,1" -- CB T-819, ON/OFF,						            636
	MI8_ExportArguments["2,3078"] ="1, 3078,1" -- CB SPUU-52, ON/OFF						        637
	MI8_ExportArguments["2,3079"] ="1, 3079,1" -- CB Fire Protection System: Signalization, ON/OFF	638
	MI8_ExportArguments["2,3080"] ="1, 3080,1" -- CB Fire Protection System: 1 Queue Left, ON/OFF	639
	MI8_ExportArguments["2,3081"] ="1, 3081,1" -- CB Fire Protection System: 1 Queue Right, ON/OFF	640
	MI8_ExportArguments["2,3082"] ="1, 3082,1" -- CB Fire Protection System: 2 Queue Left, ON/OFF   641
	MI8_ExportArguments["2,3083"] ="1, 3083,1" -- CB Fire Protection System: 2 Queue Right, ON/OFF	642
	MI8_ExportArguments["2,3084"] ="1, 3084,1" -- CB Radio: Radio Compass MW(ARC-9), ON/OFF		    643
	MI8_ExportArguments["2,3085"] ="1, 3085,1" -- CB Radio: Radio Compass VHF(ARC-UD), ON/OFF		644
	MI8_ExportArguments["2,3086"] ="1, 3086,1" -- CB Radio: Doppler Navigator, ON/OFF				645
	MI8_ExportArguments["2,3087"] ="1, 3087,1" -- CB Radio: Radio Meter, ON/OFF					    646
	MI8_ExportArguments["2,3088"] ="1, 3088,1" -- CB Headlights: Left: Control, ON/OFF	            647
	MI8_ExportArguments["2,3089"] ="1, 3089,1" -- CB Headlights: Left: Light, ON/OFF	            648
	MI8_ExportArguments["2,3090"] ="1, 3090,1" -- CB Headlights: Right: Control, ON/OFF             649
	MI8_ExportArguments["2,3091"] ="1, 3091,1" -- CB Headlights: Right: Light, ON/OFF               650
	MI8_ExportArguments["2,3092"] ="1, 3092,1" -- CB ANO, ON/OFF						            651
	MI8_ExportArguments["2,3093"] ="1, 3093,1" -- CB Wing Lights, ON/OFF				            652
	MI8_ExportArguments["2,3094"] ="1, 3094,1" -- CB Check Lamps/Flasher, ON/OFF		            653
	MI8_ExportArguments["2,3095"] ="1, 3095,1" -- CB PRF-4 Light Left, ON/OFF		                918
	MI8_ExportArguments["2,3096"] ="1, 3096,1" -- CB PRF-4 Light Right, ON/OFF			            919
	MI8_ExportArguments["2,3097"] ="1, 3097,1" -- CB Defrost System: Control, ON/OFF	            656
	MI8_ExportArguments["2,3098"] ="1, 3098,1" -- CB Defrost System: Left Engine, ON/OFF            657
	MI8_ExportArguments["2,3099"] ="1, 3099,1" -- CB Defrost System: Right Engine, ON/OFF           658
	MI8_ExportArguments["2,3100"] ="1, 3100,1" -- CB Defrost System: RIO-3, ON/OFF		            659
	MI8_ExportArguments["2,3101"] ="1, 3101,1" -- CB Defrost System: Glass, ON/OFF		            660
	MI8_ExportArguments["2,3102"] ="1, 3102,1" -- CB Wiper Left, ON/OFF,				            661
	MI8_ExportArguments["2,3103"] ="1, 3103,1" -- CB Wiper Right, ON/OFF				            662
	MI8_ExportArguments["2,3104"] ="1, 3104,1" -- CB RIO-3, ON/OFF						            663
	MI8_ExportArguments["2,3105"] ="1, 3105,1" -- CB Heater KO-50, ON/OFF                           664
	MI8_ExportArguments["2,3106"] ="1, 3106,1" -- Battery Heating Switch, ON/OFF 		522
	MI8_ExportArguments["2,3107"] ="2, 3006,1" --  Feed Tank Pump Switch, ON/OFF				 438
	MI8_ExportArguments["2,3108"] ="2, 3003,1" --  Left Tank Pump Switch, ON/OFF				 439
	MI8_ExportArguments["2,3109"] ="2, 3005,1" --  Right Tank Pump Switch, ON/OFF				 440
	MI8_ExportArguments["2,3110"] ="2, 3001,1" --  Left Shutoff Valve Switch, ON/OFF			 427
	MI8_ExportArguments["2,3111"] ="2, 3002,1" --  Right Shutoff Valve Switch, ON/OFF			 429
	MI8_ExportArguments["2,3112"] ="2, 3009,1" --  Left Shutoff Valve Switch Cover, OPEN/CLOSE	 426
	MI8_ExportArguments["2,3113"] ="2, 3010,1" --  Right Shutoff Valve Switch Cover, OPEN/CLOSE	 428
	MI8_ExportArguments["2,3114"] ="2, 3004,1" --  Crossfeed Switch, ON/OFF						 431
	MI8_ExportArguments["2,3115"] ="2, 3011,1" --  Crossfeed Switch Cover, OPEN/CLOSE			 430
	MI8_ExportArguments["2,3116"] ="2, 3007,1" --  Bypass Switch, ON/OFF					     433
	MI8_ExportArguments["2,3117"] ="2, 3012,1" --  Bypass Switch Cover, OPEN/CLOSE				 432
	MI8_ExportArguments["2,3118"] ="3, 3009,1" --  Left Engine Stop Lever			 204
	MI8_ExportArguments["2,3119"] ="3, 3010,1" --  Right Engine Stop Lever 		     206
	MI8_ExportArguments["2,3120"] ="3, 3011,1" --  Rotor Brake Handle, UP/DOWN		 208
	MI8_ExportArguments["2,3121"] ="3, 3001,1" --  Left Engine EEC Switch, ON/OFF		 167
	MI8_ExportArguments["2,3122"] ="3, 3003,1" --  Right Engine EEC Switch, ON/OFF		 173
	MI8_ExportArguments["2,3123"] ="3, 3052,1" --  Left Engine ER Switch, ON/OFF	     168
	MI8_ExportArguments["2,3124"] ="3, 3053,1" --  Right Engine ER Switch, ON/OFF		 172
	MI8_ExportArguments["2,3125"] ="4, 3001,1" --  Main Hydraulic Switch, ON/OFF 				 406
	MI8_ExportArguments["2,3126"] ="4, 3002,1" --  Auxiliary Hydraulic Switch, ON/OFF 		     410
	MI8_ExportArguments["2,3127"] ="4, 3006,1" --  Auxiliary Hydraulic Switch Cover, OPEN/CLOSE	 409
	MI8_ExportArguments["2,3128"] ="18, 3003,1" --  Radar Altimeter Power Switch, ON/OFF	 35
	MI8_ExportArguments["2,3129"] ="34, 3003,1" --  HSI Radio Compass Selector Switch, ARC-9/ARC-UD	 858
	MI8_ExportArguments["2,3130"] ="12, 3027,1" --  Weapon Safe/Armed Switch, ON/OFF 				921
	MI8_ExportArguments["2,3131"] ="12, 3007,1" --  Emergency Explode Switch, ON/OFF 				707
	MI8_ExportArguments["2,3132"] ="12, 3049,1" --  Emergency Explode Switch Cover, OPEN/CLOSE 		706
	MI8_ExportArguments["2,3133"] ="12, 3050,1" --  Emergency Bomb Release Switch Cover, OPEN/CLOSE 708
	MI8_ExportArguments["2,3134"] ="12, 3002,1" --  Main Bombs Switch, ON/OFF 						717
	MI8_ExportArguments["2,3135"] ="12, 3012,1" --  ESBR Heating Switch, ON/OFF 					720
	MI8_ExportArguments["2,3136"] ="12, 3028,1" --  ESBR Switch, ON/OFF 							731
	MI8_ExportArguments["2,3137"] ="12, 3004,1" --  Emergency Explode Switch, ON/OFF 		main		570
	MI8_ExportArguments["2,3138"] ="12, 3051,1" --  Emergency Explode Switch Cover, OPEN/CLOSE 	main	569
	MI8_ExportArguments["2,3139"] ="12, 3052,1" --  Emergency Release Switch Cover, OPEN/CLOSE 	main	571
	MI8_ExportArguments["2,3140"] ="12, 3030,1" --  RS/GUV Selector Switch, ON/OFF 					575
	MI8_ExportArguments["2,3141"] ="12, 3041,1" --  800_or_624_622_800 Switch 						349
	MI8_ExportArguments["2,3142"] ="12, 3053,1" --  800 or 624_622_800 Switch Cover, OPEN/CLOSE 	348
	MI8_ExportArguments["2,3143"] ="12, 3076,1" --  Mine Arms Main Switch, ON/OFF 					573
	MI8_ExportArguments["2,3144"] ="12, 3077,1" --  PKT Selector Switch, FLIGHT ENGINEER/PILOT 		905
	--MI8_ExportArguments["2,3145"] ="12, 3084,1" --  Left Fire RS Button Cover, OPEN/CLOSE 			185
	--MI8_ExportArguments["2,3146"] ="12, 3085,1" --  Right Fire RS Button Cover, OPEN/CLOSE 			228
	MI8_ExportArguments["2,3147"] ="12, 3098,1" --  Gun Camera Switch, ON/OFF 						352
	MI8_ExportArguments["2,3148"] ="21, 3005,1" --  Flasher Switch, ON/OFF 			523
	MI8_ExportArguments["2,3149"] ="21, 3006,1" --  Transparent Switch, DAY/NIGHT 	525
	MI8_ExportArguments["2,3150"] ="8, 3005,1" 	--  SPUU-52 Power Switch, ON/OFF 	332
	--MI8_ExportArguments["2,3151"] ="8, 3001,1" 	--  DISPONIBLE
	MI8_ExportArguments["2,3152"] ="19, 3010,1" --  Fire Detector Test Switch 		399
	MI8_ExportArguments["2,3153"] ="19, 3011,1" --  Squib Test Switch 				400
	MI8_ExportArguments["2,3154"] ="3, 3030,1" --  Defrost Mode Switch, AUTO/MANUAL 		353
	MI8_ExportArguments["2,3155"] ="3, 3032,1" --  Left Engine Heater Switch, ON/OFF 		523
	MI8_ExportArguments["2,3156"] ="3, 3033,1" --  Right Engine Heater Switch, MANUAL/AUTO 	356
	MI8_ExportArguments["2,3157"] ="3, 3034,1" --  Glass Heater Switch, MANUAL/AUTO 		357
	MI8_ExportArguments["2,3158"] ="3, 3035,1" --  Ice Detector Heater Switch, MANUAL/AUTO	127
	MI8_ExportArguments["2,3159"] ="3, 3038,1" --  Left Pitot Heater Switch, ON/OFF 		519
	MI8_ExportArguments["2,3160"] ="3, 3039,1" --  Right Pitot Heater Switch, ON/OFF		520
	MI8_ExportArguments["2,3161"] ="15, 3001,1" --  Doppler Navigator Power Switch, ON/OFF	483
	MI8_ExportArguments["2,3162"] ="15, 3011,1" --  Test/Work Switch						797
	MI8_ExportArguments["2,3163"] ="15, 3012,1" --  Land/Sea Switch							798
	MI8_ExportArguments["2,3164"] ="7, 3004,1" --  Right Attitude Indicator Power Switch, ON/OFF	487
	MI8_ExportArguments["2,3165"] ="6, 3004,1" --  Left Attitude Indicator Power Switch, ON/OFF		335
	MI8_ExportArguments["2,3166"] ="32, 3001,1" --  VK-53 Power Switch, ON/OFF			336
	MI8_ExportArguments["2,3167"] ="14, 3001,1" --  GMC Power Switch, ON/OFF					 485
	MI8_ExportArguments["2,3168"] ="14, 3002,1" -- GMC Hemisphere Selection Switch, NORTH/SOUTH  470
	MI8_ExportArguments["2,3169"] ="3, 3028,1" -- Left Engine Dust Protection Switch, ON/OFF  517
	MI8_ExportArguments["2,3170"] ="3, 3029,1" -- Right Engine Dust Protection Switch, ON/OFF 518
	MI8_ExportArguments["2,3171"] ="9, 3014,1" -- Tip Lights Switch, ON/OFF     515
	MI8_ExportArguments["2,3172"] ="9, 3015,1" -- Strobe Light Switch, ON/OFF   516
	MI8_ExportArguments["2,3173"] ="9, 3017,1" -- Taxi Light Switch, ON/OFF     836
	MI8_ExportArguments["2,3174"] ="46, 3004,1" -- 5.5V Lights Switch, ON/OFF 			   		479
	MI8_ExportArguments["2,3175"] ="46, 3022,1" -- Cargo Cabin Duty Lights Switch, ON/OFF   	511
	MI8_ExportArguments["2,3176"] ="46, 3023,1" -- Cargo Cabin Common Lights Switch, ON/OFF   	512
	MI8_ExportArguments["2,3177"] ="36, 3004,1" -- Radio/ICS Switch 			553
	MI8_ExportArguments["2,3178"] ="36, 3007,1" -- Network 1/2 Switch (N/F)		551
	MI8_ExportArguments["2,3179"] ="36, 3012,1" -- Radio/ICS Switch 			845 copilot
	MI8_ExportArguments["2,3180"] ="36, 3013,1" -- Network 1/2 Switch (N/F)   	843 copilot
	MI8_ExportArguments["2,3181"] ="36, 3006,1" -- Laryngophone Switch, ON/OFF 					   480
	MI8_ExportArguments["2,3182"] ="38, 3001,1" -- R-863, Modulation Switch, FM/AM 				   369
	MI8_ExportArguments["2,3183"] ="38, 3002,1" -- R-863, Unit Switch, DIAL/MEMORY 				   132
	MI8_ExportArguments["2,3184"] ="38, 3004,1" -- R-863, Squelch Switch, ON/OFF 				   155
	MI8_ExportArguments["2,3185"] ="38, 3010,1" -- R-863, Emergency Receiver Switch, ON/OFF (N/F)  153
	MI8_ExportArguments["2,3186"] ="38, 3011,1" -- R-863, ARC Switch, ON/OFF (N/F) 				   154
	MI8_ExportArguments["2,3187"] ="39, 3004,1" -- R-828, Squelch Switch, ON/OFF				   739
	MI8_ExportArguments["2,3188"] ="39, 3005,1" -- R-828, Power Switch, ON/OFF 					   756
	MI8_ExportArguments["2,3189"] ="39, 3006,1" -- R-828, Compass Switch, COMM/NAV 				   757
	MI8_ExportArguments["2,3190"] ="37, 3013,1" -- Jadro 1A, Power Switch, ON/OFF 				   484
	MI8_ExportArguments["2,3191"] ="11, 3006,1" -- RI-65 Power Switch, ON/OFF 	 	338
	MI8_ExportArguments["2,3192"] ="36, 3021,1" -- RI-65 Amplifier Switch, ON/OFF"	295
	MI8_ExportArguments["2,3193"] ="41, 3002,1" -- ARC-UD, Sensitivity Switch, MORE/LESS 453
	MI8_ExportArguments["2,3194"] ="41, 3003,1" -- ARC-UD, Wave Switch, MW/D, 			 454
	MI8_ExportArguments["2,3195"] ="41, 3012,1" -- ARC-UD, Lock Switch, LOCK/UNLOCK 	 481
	MI8_ExportArguments["2,3196"] ="45, 3006,1" -- Clock Heating Switch, ON/OFF 	 521
	MI8_ExportArguments["2,3197"] ="48, 3010,1" -- CMD Power Switch, ON/OFF 					 910
	MI8_ExportArguments["2,3198"] ="48, 3003,1" -- CMD Flares Amount Switch, COUNTER/PROGRAMMING 913
	--MI8_ExportArguments["2,3199"] ="7, 3024,1" -- Parking Brake Handle 		930	
	MI8_ExportArguments["2,3200"] ="17, 3020,1" -- Left Fan Switch, ON/OFF  	334
	MI8_ExportArguments["2,3201"] ="17, 3021,1" -- Right Fan Switch, ON/OFF 	488
	MI8_ExportArguments["2,3202"] ="40, 3011,1" -- ARC-9, Dialer Switch, MAIN/BACKUP 469
	MI8_ExportArguments["2,3203"] ="40, 3002,1" -- ARC-9, TLF/TLG Switch 		 	444
	MI8_ExportArguments["2,3204"] ="51, 3002,1" -- Tactical Cargo Release Button Cover, OPEN/CLOSE	199
	MI8_ExportArguments["2,3205"] ="51, 3004,1" -- Emergency Cargo Release Button Cover, OPEN/CLOSE 197
	MI8_ExportArguments["2,3206"] ="51, 3005,1" -- External Cargo Automatic Dropping, ON/OFF 		324
	MI8_ExportArguments["2,3207"] ="52, 3001,1" -- Signal Flares Cassette 1 Power Switch, ON/OFF   282
	MI8_ExportArguments["2,3208"] ="52, 3006,1" -- Signal Flares Cassette 2 Power Switch, ON/OFF   283
	MI8_ExportArguments["2,3209"] ="53, 3002,1" -- KO-50 Fan Switch, ON/OFF   467
	MI8_ExportArguments["2,3210"] ="55, 3001,1" -- SARPP-12 Mode Switch, MANUAL/AUTO 315
	MI8_ExportArguments["2,3211"] ="56, 3001,1" -- Recorder P-503B Power Switch, ON/OFF  305
	MI8_ExportArguments["2,3212"] ="57, 3002,1" -- IFF Transponder Device Selector Switch, WORK/RESERVE	301
	MI8_ExportArguments["2,3213"] ="57, 3003,1" -- IFF Transponder Device Mode Switch, 1/2				300
	MI8_ExportArguments["2,3214"] ="57, 3004,1" -- IFF Transponder Erase Button Cover, OPEN/CLOSE		296
	MI8_ExportArguments["2,3215"] ="57, 3006,1" -- IFF Transponder Disaster Switch Cover, OPEN/CLOSE	    298
	MI8_ExportArguments["2,3216"] ="57, 3007,1" -- IFF Transponder Disaster Switch, ON/OFF				299
	MI8_ExportArguments["2,3014"] ="37, 3008,0.7" -- Jadro 1A, Squelch Switch			   741			
	--Push buttons
	MI8_ExportArguments["1,3001"] ="1, 3022,1" --  CB Group 1 ON    882
	MI8_ExportArguments["1,3002"] ="1, 3025,1" --  CB Group 4 ON    883
	MI8_ExportArguments["1,3003"] ="1, 3028,1" --  CB Group 7 ON    884
	MI8_ExportArguments["1,3004"] ="1, 3023,1" --  CB Group 2 ON    885
	MI8_ExportArguments["1,3005"] ="1, 3026,1" --  CB Group 5 ON    886
	MI8_ExportArguments["1,3006"] ="1, 3029,1" --  CB Group 8 ON    887
	MI8_ExportArguments["1,3007"] ="1, 3024,1" --  CB Group 3 ON    888
	MI8_ExportArguments["1,3008"] ="1, 3027,1" --  CB Group 6 ON    889
	MI8_ExportArguments["1,3009"] ="1, 3030,1" --  CB Group 9 ON    890
	MI8_ExportArguments["1,3010"] ="3, 3026,1" --  APU Start Button - Push to start APU 			413
	MI8_ExportArguments["1,3011"] ="3, 3007,1" --  APU Stop Button - Push to stop APU 			    415
	MI8_ExportArguments["1,3012"] ="3, 3005,1" --  Engine Start Button - Push to start engine 	    419
	MI8_ExportArguments["1,3013"] ="3, 3006,1" --  Abort Start Engine Button - Push to abort start  421
	MI8_ExportArguments["1,3014"] ="3, 3021,1" --  Vibration Sensor Test Button - Push to test 				    	310
	MI8_ExportArguments["1,3015"] ="3, 3023,1" --  Cold Temperature Sensor Test Button - Push to test 		    	311
	MI8_ExportArguments["1,3016"] ="3, 3022,1" --  Hot Temperature Sensor Test Button - Push to test 				312
	MI8_ExportArguments["1,3017"] ="3, 3019,1" --  Left Engine Temperature Regulator Test Button - Push to test  	313
	MI8_ExportArguments["1,3018"] ="3, 3020,1" --  Right Engine Temperature Regulator Test Button - Push to test    314
	MI8_ExportArguments["1,3019"] ="4, 3003,1" --  Auxiliary Hydraulic Shut Off Button - Push to shut off    		411
	MI8_ExportArguments["1,3020"] ="16, 3029,1" --  Autopilot Off Left Button 	183
	MI8_ExportArguments["1,3021"] ="16, 3030,1" --  Autopilot Off Right Button  226
	MI8_ExportArguments["1,3022"] ="16, 3031,1" --  Trimmer Left Button 		184
	MI8_ExportArguments["1,3023"] ="16, 3032,1" --  Trimmer Right Button 		227
	MI8_ExportArguments["1,3024"] ="12, 3032,1" --  Emergency Bomb Release Switch, ON/OFF 		709
	MI8_ExportArguments["1,3025"] ="12, 3014,1" --  Lamps Check Button - Push to check 		718
	MI8_ExportArguments["1,3026"] ="12, 3005,1" --  Emergency Release Switch main				572
	MI8_ExportArguments["1,3027"] ="12, 3026,1" --  Lamps Check Button - Push to check 	  	576
	MI8_ExportArguments["1,3028"] ="12, 3031,1" --  PUS Arming Button - Push to arm 		574
	--MI8_ExportArguments["1,3029"] ="12, 3082,1" --  Left Fire RS Button 						186
	--MI8_ExportArguments["1,3030"] ="12, 3083,1" --  Right Fire RS Button 						229
	MI8_ExportArguments["1,3031"] ="19, 3001,1" --  Main Discharge Left Engine Button 		389
	MI8_ExportArguments["1,3032"] ="19, 3002,1" --  Main Discharge Right Engine Button 	    390
	MI8_ExportArguments["1,3033"] ="19, 3003,1" --  Main Discharge KO-50 Button 			391
	MI8_ExportArguments["1,3034"] ="19, 3004,1" --  Main Discharge APU GEAR Button 		    392
	MI8_ExportArguments["1,3035"] ="19, 3005,1" --  Alternate Discharge Left Engine Button  393
	MI8_ExportArguments["1,3036"] ="19, 3006,1" --  Alternate Discharge Right Engine Button 394
	MI8_ExportArguments["1,3037"] ="19, 3007,1" --  Alternate Discharge KO-50 Button 		395
	MI8_ExportArguments["1,3038"] ="19, 3008,1" --  Alternate Discharge APU GEAR Button 	396
	MI8_ExportArguments["1,3039"] ="19, 3009,1" --  Turn Off Fire Signal Button 			397
	MI8_ExportArguments["1,3040"] ="3, 3031,1" --  Defrost OFF Button - Push to turn off 			354
	MI8_ExportArguments["1,3041"] ="3, 3036,1" --  Ice Detector Heater Test Button - Push to test  	359
	MI8_ExportArguments["1,3042"] ="3, 3040,1" --  Left Pitot Heater Test Button - Push to test    	339
	MI8_ExportArguments["1,3043"] ="3, 3041,1" --  Right Pitot Heater Test Button - Push to test   	482
	MI8_ExportArguments["1,3044"] ="15, 3002,1" --  Turn Off Coordinates Calculator Button 	818
	MI8_ExportArguments["1,3045"] ="15, 3003,1" --  Turn On Coordinates Calculator Button 	819
	MI8_ExportArguments["1,3046"] ="15, 3004,1" --  Decrease Map Angle Button 				815
	MI8_ExportArguments["1,3047"] ="15, 3005,1" --  Increase Map Angle Button 				816
	MI8_ExportArguments["1,3048"] ="15, 3006,1" --  Decrease Path KM Button 				809
	MI8_ExportArguments["1,3049"] ="15, 3007,1" --  Increase Path KM Button 				810
	MI8_ExportArguments["1,3050"] ="15, 3008,1" --  Decrease Deviation KM Button 			803
	MI8_ExportArguments["1,3051"] ="15, 3009,1" --  Increase Deviation KM Button 			804
	MI8_ExportArguments["1,3052"] ="7, 3002,1" --  Right Attitude Indicator Cage Knob - Push to cage 90
	MI8_ExportArguments["1,3053"] ="6, 3002,1" --  Left Attitude Indicator Cage Knob - Push to cage  11
	MI8_ExportArguments["1,3054"] ="9, 3016,1" --  ANO Code Button  322
	MI8_ExportArguments["1,3055"] ="36, 3008,1" -- Circular Call Button (N/F)  552
	MI8_ExportArguments["1,3056"] ="36, 3014,1" -- Circular Call Button (N/F)  846
	MI8_ExportArguments["1,3057"] ="39, 3003,1" -- R-828, Radio Tuner Button  738
	MI8_ExportArguments["1,3058"] ="37, 3009,1" -- Jadro 1A, Control Button  742
	MI8_ExportArguments["1,3059"] ="36, 3014,1" -- RI-65 OFF Button 	 292
	MI8_ExportArguments["1,3060"] ="39, 3003,1" -- RI-65 Repeat Button   293
	MI8_ExportArguments["1,3061"] ="37, 3009,1" -- RI-65 Check Button    294
	MI8_ExportArguments["1,3062"] ="41, 3006,1" -- ARC-UD, Control Button 		 672
	MI8_ExportArguments["1,3063"] ="41, 3007,1" -- ARC-UD, Left Antenna Button   673
	MI8_ExportArguments["1,3064"] ="41, 3008,1" -- ARC-UD, Right Antenna Button  674
	MI8_ExportArguments["1,3065"] ="48, 3004,1" -- CMD Num of Sequences Button 			914
	MI8_ExportArguments["1,3066"] ="48, 3006,1" -- CMD Dispense Interval Button 		862
	MI8_ExportArguments["1,3067"] ="48, 3005,1" -- CMD Num in Sequence Button 			863
	MI8_ExportArguments["1,3068"] ="48, 3007,1" -- CMD Start Dispense Button 			866
	MI8_ExportArguments["1,3069"] ="48, 3013,1" -- Start/Stop Dispense Button 			911
	MI8_ExportArguments["1,3070"] ="48, 3008,1" -- CMD Reset to Default Program Button 	864
	MI8_ExportArguments["1,3071"] ="48, 3009,1" -- CMD Stop Dispense Button 			865
	--MI8_ExportArguments["1,3072"] ="17, 3017,1" -- Wheel Brakes Handle 						  881
	MI8_ExportArguments["1,3073"] ="17, 3006,1" -- Accelerometer Reset Button - Push to reset 925
	MI8_ExportArguments["1,3074"] ="51, 3001,1" -- Tactical Cargo Release Button - Push to release   200
	MI8_ExportArguments["1,3075"] ="51, 3003,1" -- Emergency Cargo Release Button - Push to release  198
	MI8_ExportArguments["1,3076"] ="52, 3003,1" -- Signal Flares Cassette 1 Launch Red Button	   284
	MI8_ExportArguments["1,3077"] ="52, 3002,1" -- Signal Flares Cassette 1 Launch Green Button    285
	MI8_ExportArguments["1,3078"] ="52, 3005,1" -- Signal Flares Cassette 1 Launch Yellow Button   286
	MI8_ExportArguments["1,3079"] ="52, 3004,1" -- Signal Flares Cassette 1 Launch White Button    287
	MI8_ExportArguments["1,3080"] ="52, 3008,1" -- Signal Flares Cassette 2 Launch Red Button	   288
	MI8_ExportArguments["1,3081"] ="52, 3007,1" -- Signal Flares Cassette 2 Launch Green Button    289
	MI8_ExportArguments["1,3082"] ="52, 3010,1" -- Signal Flares Cassette 2 Launch Yellow Button   290
	MI8_ExportArguments["1,3083"] ="52, 3009,1" -- Signal Flares Cassette 2 Launch White Button    291
	MI8_ExportArguments["1,3084"] ="53, 3001,1" -- KO-50 Heater Start Button - Push to start    464
	MI8_ExportArguments["1,3085"] ="57, 3005,1" -- IFF Transponder Erase Button - Push to erase 297
	MI8_ExportArguments["1,3086"] ="20, 3001,1" -- Alarm Bell Button - Push to turn on          323
	MI8_ExportArguments["1,3087"] ="16,3003,1" -- Autopilot Heading ON Button >> PUSH_BUTTONS :: PB_87
	MI8_ExportArguments["1,3088"] ="16,3005,1" -- Autopilot Heading OFF Button >> PUSH_BUTTONS :: PB_88
	MI8_ExportArguments["1,3089"] ="16,3002,1" -- Autopilot Pitch/Roll ON Button >> PUSH_BUTTONS :: PB_89
	MI8_ExportArguments["1,3090"] ="16,3001,1" -- Autopilot Altitude ON Button >> PUSH_BUTTONS :: PB_90
	MI8_ExportArguments["1,3091"] ="16,3004,1" -- Autopilot Altitude OFF Button >> PUSH_BUTTONS :: PB_91
	MI8_ExportArguments["1,3092"] ="8, 3001,1" 	-- SPUU-52 Control Engage Button 	127  >> PUSH_BUTTONS :: PB_92
	MI8_ExportArguments["1,3093"] ="18,3002,1" -- Radio Altimeter Test Button - Push to test >> PUSH_BUTTONS :: PB_93 
	MI8_ExportArguments["1,3094"] ="45,3004,1" -- Mech clock right lever >> PUSH_BUTTONS :: PB_94 	
	--tree way switches
	MI8_ExportArguments["3,3001"] ="1,3012,1" -- 115V Inverter Switch, MANUAL/OFF/AUTO >> TREE_WAY_SWITCH :: 3WSwitch_A_1
	MI8_ExportArguments["3,3002"] ="1,3013,1" -- 36V Inverter Switch, MANUAL/OFF/AUTO >> TREE_WAY_SWITCH :: 3WSwitch_A_2
	MI8_ExportArguments["3,3003"] ="1,3020,1" -- 36V Transformer Switch, MAIN/OFF/AUXILIARY >> TREE_WAY_SWITCH :: 3WSwitch_A_3
	MI8_ExportArguments["3,3004"] ="3,3012,1" -- APU Start Mode Switch, START/COLD CRANKING/FALSE START >> TREE_WAY_SWITCH :: 3WSwitch_A_4
	MI8_ExportArguments["3,3005"] ="3,3008,1" -- Engine Selector Switch, LEFT/OFF/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_5
	MI8_ExportArguments["3,3006"] ="3,3027,1" -- Engine Start Mode Switch, START/OFF/COLD CRANKING >> TREE_WAY_SWITCH :: 3WSwitch_A_6
	MI8_ExportArguments["3,3203"] ="2,3014,1" -- Refueling Control Switch, REFUEL/OFF/CHECK >> TREE_WAY_SWITCH :: 3WSwitch_C_203
	MI8_ExportArguments["3,3008"] ="12,3020,1" -- 8/16/4 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_8
	MI8_ExportArguments["3,3009"] ="12,3021,1" -- 1-2-5-6/AUTO/3-4 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_9
	MI8_ExportArguments["3,3010"] ="12,3022,1" -- UPK/PKT/RS Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_10
	MI8_ExportArguments["3,3011"] ="12,3006,1" -- CUTOFF Switch, ON/OFF >> TREE_WAY_SWITCH :: 3WSwitch_A_11
	MI8_ExportArguments["3,3012"] ="21,3007,1" -- Check Switch, LAMPS/OFF/FLASHER >> TREE_WAY_SWITCH :: 3WSwitch_A_12
	MI8_ExportArguments["3,3013"] ="14,3004,1" -- GMC Mode Switch, MC/DG/AC(N/F) >> TREE_WAY_SWITCH :: 3WSwitch_A_13
	MI8_ExportArguments["3,3014"] ="9,3018,1" -- Left Landing Light Switch, LIGHT/OFF/RETRACT >> TREE_WAY_SWITCH :: 3WSwitch_A_14
	MI8_ExportArguments["3,3015"] ="9,3019,1" -- Right Landing Light Switch, LIGHT/OFF/RETRACT >> TREE_WAY_SWITCH :: 3WSwitch_A_15
	MI8_ExportArguments["3,3016"] ="9,3012,1" -- ANO Switch, BRIGHT/OFF/DIM >> TREE_WAY_SWITCH :: 3WSwitch_A_16
	MI8_ExportArguments["3,3017"] ="9,3013,1" -- Formation Lights Switch, BRIGHT/OFF/DIM >> TREE_WAY_SWITCH :: 3WSwitch_A_17
	MI8_ExportArguments["3,3018"] ="46,3002,1" -- Left Ceiling Light Switch, RED/OFF/WHITE >> TREE_WAY_SWITCH :: 3WSwitch_A_18
	MI8_ExportArguments["3,3019"] ="46,3003,1" -- Right Ceiling Light Switch, RED/OFF/WHITE >> TREE_WAY_SWITCH :: 3WSwitch_A_19
	MI8_ExportArguments["4,3116"] ="38,3003,1" -- R-863, Radio Channel Selector Knob >> axis b116
	MI8_ExportArguments["3,3202"] ="48,3002,1" -- CMD Board Flares Dispensers Switch, LEFT/BOTH/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_C_202
	MI8_ExportArguments["3,3023"] ="53,3003,1" -- KO-50 Heater Mode Switch, MANUAL/OFF/AUTO >> TREE_WAY_SWITCH :: 3WSwitch_A_23
	MI8_ExportArguments["3,3024"] ="53,3004,1" -- KO-50 Heater Regime Switch, FILLING/FULL/MEDIUM >> TREE_WAY_SWITCH :: 3WSwitch_A_24
	MI8_ExportArguments["3,3025"] ="3,3074,1" -- Engine Ignition Check Switch, LEFT/OFF/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_25
	--MI8_ExportArguments["3,3026"] ="3,3063,1" -- Readjust Free Turbine RPM Switch, MORE/OFF/LESS >> TREE_WAY_SWITCH :: 3WSwitch_A_26
	MI8_ExportArguments["3,3027"] ="3,3064,1" -- Readjust Free Turbine RPM Switch, MORE/OFF/LESS >> TREE_WAY_SWITCH :: 3WSwitch_A_27
	MI8_ExportArguments["3,3028"] ="3,3050,1" -- Left Engine FT Check Switch, ST1/WORK/ST2 >> TREE_WAY_SWITCH :: 3WSwitch_A_28
	MI8_ExportArguments["3,3029"] ="3,3051,1" -- Right Engine FT Check Switch, ST1/WORK/ST2 >> TREE_WAY_SWITCH :: 3WSwitch_A_29
	MI8_ExportArguments["3,3030"] ="3,3054,1" -- CT Check Switch, RIGHT/WORK/LEFT >> TREE_WAY_SWITCH :: 3WSwitch_A_30
	MI8_ExportArguments["3,3031"] ="14,3003,1" -- GMC Control Switch, 0/CONTROL/300 >> TREE_WAY_SWITCH :: 3WSwitch_A_31
	MI8_ExportArguments["3,3032"] ="14,3005,1" -- GMC Course Setting Switch, CCW/OFF/CW) >> TREE_WAY_SWITCH :: 3WSwitch_A_32
	MI8_ExportArguments["3,3033"] ="40,3010,1" -- ARC-9, Loop Control Switch, LEFT/OFF/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_33	
	-- axis
	MI8_ExportArguments["4,3010"] ="1,3010,1" -- Standby Generator Voltage Adjustment Rheostat >> AXIS :: Axis_A_10
	MI8_ExportArguments["4,3011"] ="1,3011,1" -- Generator 1 Voltage Adjustment Rheostat >> AXIS :: Axis_A_11
	MI8_ExportArguments["4,3012"] ="1,3018,1" -- Generator 2 Voltage Adjustment Rheostat >> AXIS :: Axis_A_12
	MI8_ExportArguments["4,3013"] ="3,3071,1" -- Left Engine Throttle >> AXIS :: Axis_A_13
	MI8_ExportArguments["4,3014"] ="3,3072,1" -- Right Engine Throttle >> AXIS :: Axis_A_14
	MI8_ExportArguments["4,3015"] ="12,3043,1" -- Burst Length Knob >> AXIS :: Axis_A_15
	MI8_ExportArguments["12,3010"] ="7,3003,0.01" -- Right Attitude Indicator Zero Pitch Knob >> TOGLEE_SWITCH :: TSwitch_B_10
	MI8_ExportArguments["12,3009"] ="6,3003,0.01" -- Left Attitude Indicator Zero Pitch Knob >>  TOGLEE_SWITCH :: TSwitch_B_9
	MI8_ExportArguments["4,3102"] ="14,3006,1" -- GMC Latitude Selection Knob >> AXIS :: Axis_B_102
	MI8_ExportArguments["4,3018"] ="46,3005,1" -- Left Red Lights Brightness Group 1 Rheostat >> AXIS :: Axis_A_18
	MI8_ExportArguments["4,3019"] ="46,3006,1" -- Left Red Lights Brightness Group 2 Rheostat >> AXIS :: Axis_A_19
	MI8_ExportArguments["4,3020"] ="46,3007,1" -- Right Red Lights Brightness Group 1 Rheostat >> AXIS :: Axis_A_20
	MI8_ExportArguments["4,3021"] ="46,3008,1" -- Right Red Lights Brightness Group 2 Rheostat >> AXIS :: Axis_A_21
	MI8_ExportArguments["4,3022"] ="46,3009,1" -- Central Red Lights Brightness Group 1 Rheostat >> AXIS :: Axis_A_22
	MI8_ExportArguments["4,3023"] ="46,3010,1" -- Central Red Lights Brightness Group 2 Rheostat >> AXIS :: Axis_A_23
	MI8_ExportArguments["4,3024"] ="46,3011,1" -- 5.5V Lights Brightness Rheostat >> AXIS :: Axis_A_24
	MI8_ExportArguments["4,3103"] ="36,3001,1" -- Common Volume Knob >> AXIS :: Axis_B_103
	MI8_ExportArguments["4,3104"] ="36,3002,1" -- Listening Volume Knob >> AXIS :: Axis_B_104
	MI8_ExportArguments["4,3105"] ="36,3009,1" -- Common Volume Knob >> AXIS :: Axis_B_105
	MI8_ExportArguments["4,3106"] ="36,3010,1" -- Listening Volume Knob >> AXIS :: Axis_B_106
	MI8_ExportArguments["4,3107"] ="38,3005,1" -- R-863, Volume Knob >> AXIS :: Axis_B_107
	MI8_ExportArguments["4,3108"] ="39,3002,1" -- R-828, Volume Knob >> AXIS :: Axis_B_108
	MI8_ExportArguments["4,3109"] ="37,3007,1" -- Jadro 1A, Volume Knob >> AXIS :: Axis_B_109
	MI8_ExportArguments["4,3110"] ="41,3005,1" -- ARC-UD, Volume Knob >> AXIS :: Axis_B_110
	MI8_ExportArguments["4,3025"] ="47,3001,1" -- Sight Brightness Knob >> AXIS :: Axis_A_25
	MI8_ExportArguments["4,3026"] ="47,3003,1" -- Sight Limb Knob >> AXIS :: Axis_A_26
	MI8_ExportArguments["4,3111"] ="40,3001,1" -- ARC-9, Volume Knob >> AXIS :: Axis_B_111
	MI8_ExportArguments["4,3112"] ="40,3004,1" -- ARC-9, Backup Frequency Tune Knob >> AXIS :: Axis_B_112
	MI8_ExportArguments["4,3113"] ="40,3007,1" -- ARC-9, Main Frequency Tune Knob >> AXIS :: Axis_B_113
	MI8_ExportArguments["4,3114"] ="53,3005,1" -- KO-50 Target Temperature Knob >> AXIS :: Axis_B_114
	MI8_ExportArguments["4,3027"] ="56,3002,1" -- Recorder P-503B Backlight Brightness Knob >> AXIS :: Axis_A_27
	MI8_ExportArguments["4,3028"] ="40,3005,1" -- ARC-9, Backup 100kHz Rotary Knob>>  AXIS  :: Axis_A_28
	MI8_ExportArguments["4,3029"] ="40,3006,1" -- ARC-9, Backup 10kHz Rotary Knob>>  AXIS  :: Axis_A_29
	MI8_ExportArguments["4,3030"] ="40,3008,1" -- ARC-9, Main 100kHz Rotary Knob >>  AXIS  :: Axis_A_30
	MI8_ExportArguments["4,3031"] ="40,3009,1" --ARC-9, Main 10kHz Rotary Knob >>  AXIS  :: Axis_A_31
	--switches
	MI8_ExportArguments["12,3011"] ="16,3009,0.1" -- Autopilot Heading Adjustment Knob >> TSwitch_B_11
	MI8_ExportArguments["12,3012"] ="16,3008,0.1" -- Autopilot Roll Adjustment Knob >> TSwitch_B_12
	MI8_ExportArguments["12,3013"] ="16,3010,0.1" -- Autopilot Pitch Adjustment Knob >> TSwitch_B_13
	MI8_ExportArguments["12,3014"] ="26,3001,0.1" -- Baro Pressure QFE Knob >> TSwitch_B_14
	MI8_ExportArguments["12,3015"] ="27,3001,0.1" -- Baro Pressure QFE Knob >> TSwitch_B_15
	MI8_ExportArguments["12,3016"] ="30,3001,0.1" -- Variometer Adjustment Knob >> TSwitch_B_16
	MI8_ExportArguments["12,3017"] ="31,3001,0.1" -- Variometer Adjustment Knob >> TSwitch_B_17
	MI8_ExportArguments["12,3018"] ="34,3001,0.1" -- HSI Course Set Knob >> TSwitch_B_18
	MI8_ExportArguments["12,3019"] ="35,3001,0.1" -- HSI Course Set Knob >> TSwitch_B_19
	MI8_ExportArguments["12,3020"] ="8,3002,0.1" -- SPUU-52 Adjustment Knob >>  TSwitch_B_20
	--multiswitch
	MI8_ExportArguments["5,3051"] ="1,3017,1" -- AC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_51
	MI8_ExportArguments["5,3052"] ="1,3008,1" -- DC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_52
	MI8_ExportArguments["5,3001"] ="2,3008,1" -- Fuel Meter Switch, OFF/SUM/LEFT/RIGHT/FEED/ADDITIONAL >> MULTI_POS_SWITCH :: Multi6PosSwitch_1
	MI8_ExportArguments["5,3002"] ="12,3013,1" -- Pod Variants Selector Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_2
	MI8_ExportArguments["4,3115"] ="12,3029,1" -- ESBR Position Selector Switch >>MULTI_POS_SWITCH :: Multi21PosSwitch_101
	MI8_ExportArguments["5,3053"] ="19,3012,1" -- Check Fire Circuits Switch, OFF/CONTROL/1/2/3/4/5/6 >> MULTI_POS_SWITCH :: Multi11PosSwitch_53
	MI8_ExportArguments["5,3054"] ="3,3037,1" -- Defrost System Amperemeter Selector Switch >> MULTI_POS_SWITCH :: Multi11PosSwitch_54
	MI8_ExportArguments["5,3055"] ="39,3001,1" -- R-828, Radio Channel Selector Knob >> MULTI_POS_SWITCH :: Multi11PosSwitch_55
	MI8_ExportArguments["5,3003"] ="15,3010,1" -- Doppler Navigator Mode Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_3
	MI8_ExportArguments["5,3004"] ="36,3003,1" -- Radio Source Selector Switch, R-863/JADRO-1A/R-828/NF/ARC-9/ARC-UD >> MULTI_POS_SWITCH :: Multi6PosSwitch_4
	MI8_ExportArguments["5,3005"] ="36,3011,1" -- Radio Source Selector Switch, R-863/JADRO-1A/R-828/NF/ARC-9/ARC-UD >> MULTI_POS_SWITCH :: Multi6PosSwitch_5
	MI8_ExportArguments["3,3201"] ="37,3001,1" -- Jadro 1A, Mode Switch, OFF/OM/AM") , >> TREE_WAY_SWITCH :: 3WSwitch_C_201
	MI8_ExportArguments["5,3006"] ="41,3001,1" -- ARC-UD, Mode Switch, OFF/NARROW/WIDE/PULSE/RC >> MULTI_POS_SWITCH :: Multi6PosSwitch_6
	MI8_ExportArguments["5,3007"] ="41,3004,1" -- ARC-UD, Channel Selector Switch, 1/2/3/4/5/6 >> MULTI_POS_SWITCH :: Multi6PosSwitch_7
	MI8_ExportArguments["5,3008"] ="40,3003,1" -- ARC-9, Mode Selector Switch, OFF/COMP/ANT/LOOP >> MULTI_POS_SWITCH :: Multi6PosSwitch_8
	MI8_ExportArguments["3,3101"] ="25,3001,1" -- Static Pressure System Mode Selector, LEFT/COMMON/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_B_101
	MI8_ExportArguments["5,3009"] ="57,3001,1" -- IFF Transponder Mode Selector Switch, AUTO/KD/+-15/KP >> MULTI_POS_SWITCH :: Multi6PosSwitch_9
	MI8_ExportArguments["5,3010"] ="12,3042,1" -- In800Out/800inOr624/622 Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_10
	MI8_ExportArguments["5,3011"] ="12,3044,1" -- Left PYROCARTRIDGE Switch, I/II/III >> MULTI_POS_SWITCH :: Multi6PosSwitch_11
	MI8_ExportArguments["5,3012"] ="12,3045,1" -- Right PYROCARTRIDGE Switch, I/II/III >> MULTI_POS_SWITCH :: Multi6PosSwitch_12	
	MI8_ExportArguments["5,3013"] ="17,3025,1" -- Left Windscreen Wiper Control Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_13
	MI8_ExportArguments["5,3014"] ="17,3026,1" -- Right Windscreen Wiper Control Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_14	
	MI8_ExportArguments["12,3001"] ="38,3006,0.1" -- R-863, 10MHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_1
	MI8_ExportArguments["12,3002"] ="38,3007,0.1" -- R-863, 1MHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_2
	MI8_ExportArguments["12,3003"] ="38,3008,0.1" -- R-863, 100kHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_3
	MI8_ExportArguments["12,3004"] ="38,3009,0.1" -- R-863, 1kHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_4
	MI8_ExportArguments["12,3005"] ="37,3002,0.1" -- Jadro 1A, Frequency Selector, 1MHz >> TOGLEE_SWITCH :: TSwitch_B_5
	MI8_ExportArguments["12,3006"] ="37,3003,0.1" -- Jadro 1A, Frequency Selector, 100kHz >> TOGLEE_SWITCH :: TSwitch_B_6
	MI8_ExportArguments["12,3007"] ="37,3004,0.1" -- Jadro 1A, Frequency Selector, 10kHz >> TOGLEE_SWITCH :: TSwitch_B_7
	MI8_ExportArguments["12,3008"] ="37,3005,0.1" -- Jadro 1A, Frequency Selector, Left mouse - 1kHz >> TOGLEE_SWITCH :: TSwitch_B_8
	MI8_ExportArguments["12,3021"] ="37,3006,0.1" -- Jadro 1A, Frequency Selector, Right mouse - 100Hz >> TOGLEE_SWITCH :: TSwitch_B_21
	MI8_ExportArguments["12,3022"] ="18,3001,0.05" -- Dangerous RALT Knob >> TOGLEE_SWITCH :: TSwitch_B_22
	
	--MI8_ExportArguments["4,3032"] ="3,3067,0.1" --Throttle (RMB press, hold and move)>>  AXIS  :: Axis_A_32
	MI8_ExportArguments["12,3023"] ="3,3067,0.05" -- Throttle (RMB press, hold and move) >> TOGLEE_SWITCH :: TSwitch_B_23
	MI8_ExportArguments["12,3024"] ="45,3003,0.05" -- Mech clock left lever LEVER>> TOGLEE_SWITCH :: TSwitch_B_24
	MI8_ExportArguments["12,3025"] ="45,3005,0.15" -- Mech clock right lever LEVER>> TOGLEE_SWITCH :: TSwitch_B_25
	-- rockers
	MI8_ExportArguments["10,3001"] ="8,3003,1" -- SPUU-52 Test Switch, P/OFF/t  P>> ROCKER_AABB :: Rocker_C_101
	MI8_ExportArguments["10,3002"] ="8,3004,1" -- SPUU-52 Test Switch, P/OFF/t  t>> ROCKER_AABB :: Rocker_C_101
	MI8_ExportArguments["10,3003"] ="16,3007,1" -- Autopilot Altitude Channel Control (Right Button - UP; Left Button - Down)>> ROCKER_AABB :: Rocker_C_102
	MI8_ExportArguments["10,3004"] ="16,3006,1" -- Autopilot Altitude Channel Control (Right Button - UP; Left Button - Down)>> ROCKER_AABB :: Rocker_C_102
	MI8_ExportArguments["8,3001"] ="45,3001,1" -- Mech clock left lever BUTON1>> ROCKER_ABAB :: Rocker_B_51
	MI8_ExportArguments["8,3002"] ="45,3002,1" -- Mech clock left lever BUTON2>> ROCKER_ABAB :: Rocker_B_51

 
 
 
 
 ---------------------------- end of MI8 export table
 
 
 
 
 
---------------------------------------------------------------------------------------- Export arguments for the UH-1H using the CapZeen Extended interface
UH1H_ExportArguments = {}
-- Format: device,button number, multiplier
-- arguments with multiplier >100 are special conversion cases, and are computed in different way

--                      Extended       	UH1H

	-- buttons
	UH1H_ExportArguments["1,3001"] ="2,3002,1" -- Test Fuel Gauge Button - Push to Test >> PUSH_BUTTONS :: PB_1
	UH1H_ExportArguments["1,3002"] ="30,3001,1" -- Winding/Adjustment Clock btn >> PUSH_BUTTONS :: PB_2
	UH1H_ExportArguments["1,3003"] ="3,3023,1" -- Fire Detector Test Button - Push to test >> PUSH_BUTTONS :: PB_3
	UH1H_ExportArguments["1,3004"] ="6,3001,1" -- Cage Copilot Attitude Indicator - Pull to cage >> PUSH_BUTTONS :: PB_4
	UH1H_ExportArguments["1,3005"] ="20,3002,1" -- Comm Test Button - Push to test >> PUSH_BUTTONS :: PB_5
	UH1H_ExportArguments["1,3006"] ="9,3012,1" -- Rocket Reset Button - Push to reset >> PUSH_BUTTONS :: PB_6
	UH1H_ExportArguments["1,3007"] ="9,3014,1" -- Jettison Switch >> PUSH_BUTTONS :: PB_7
	UH1H_ExportArguments["1,3008"] ="42,3001,1" -- Force Trim Button >> PUSH_BUTTONS :: PB_8
	UH1H_ExportArguments["1,3009"] ="42,3002,1" -- Force Trim Button >> PUSH_BUTTONS :: PB_9
	UH1H_ExportArguments["1,3010"] ="52,3001,1" -- Cargo Release Pilot >> PUSH_BUTTONS :: PB_10
	UH1H_ExportArguments["1,3011"] ="52,3002,1" -- Cargo Release CoPilot >> PUSH_BUTTONS :: PB_11
	UH1H_ExportArguments["1,3012"] ="50,3006,1" -- Flare Dispense Button - Push to dispense >> PUSH_BUTTONS :: PB_12
	UH1H_ExportArguments["1,3013"] ="50,3010,1" -- Armed Lamp Test Button - Push to test >> PUSH_BUTTONS :: PB_13
	UH1H_ExportArguments["1,3014"] ="50,3003,1" -- Flare counter Reset. press reset >> PUSH_BUTTONS :: PB_14
	UH1H_ExportArguments["1,3015"] ="50,3007,1" -- Chaff counter Reset. press reset >> PUSH_BUTTONS :: PB_15
	UH1H_ExportArguments["1,3016"] ="13,3001,1" -- Test / Hight Set. Left mouse click to Test >> PUSH_BUTTONS :: PB_16
	UH1H_ExportArguments["1,3017"] ="12,3005,1" -- Open Doors >> PUSH_BUTTONS :: PB_17
	UH1H_ExportArguments["1,3018"] ="12,3006,1" -- Open Doors >> PUSH_BUTTONS :: PB_18
	UH1H_ExportArguments["1,3019"] ="27,3005,1" -- Loop Left Low Speed >> PUSH_BUTTONS :: PB_19
	UH1H_ExportArguments["1,3020"] ="27,3005,1" -- Loop Right Low Speed >> PUSH_BUTTONS :: PB_20
	UH1H_ExportArguments["1,3021"] ="17,3017,1" -- Reply Button >> PUSH_BUTTONS :: PB_21
	UH1H_ExportArguments["1,3022"] ="17,3018,1" -- Test Button >> PUSH_BUTTONS :: PB_22
	UH1H_ExportArguments["1,3023"] ="0,511,108" -- Search light left >> PUSH_BUTTONS :: PB_23
	UH1H_ExportArguments["1,3024"] ="0,512,108" -- Search light right >> PUSH_BUTTONS :: PB_24
	UH1H_ExportArguments["1,3025"] ="0,513,108" -- Search light up >> PUSH_BUTTONS :: PB_25
	UH1H_ExportArguments["1,3026"] ="0,514,108" -- Search light down >> PUSH_BUTTONS :: PB_26
	UH1H_ExportArguments["1,3027"] ="0,515,108" -- Search light stop >> PUSH_BUTTONS :: PB_27
	--toggle_switches:
	UH1H_ExportArguments["2,3001"] ="1,3001,1" -- Battery Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_1
	UH1H_ExportArguments["2,3002"] ="1,3003,1" -- Starter/Stdby GEN Switch >> TOGLEE_SWITCH :: TSwitch_2
	UH1H_ExportArguments["2,3003"] ="1,3005,1" -- Non-Essential Bus Switch, NORMAL/MANUAL >> TOGLEE_SWITCH :: TSwitch_3
	UH1H_ExportArguments["2,3004"] ="1,3021,1" -- CB IFF APX 1 (N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_4
	UH1H_ExportArguments["2,3005"] ="1,3022,1" -- CB IFF APX 2 (N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_5
	UH1H_ExportArguments["2,3006"] ="1,3023,1" -- CB Prox. warn.(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_6
	UH1H_ExportArguments["2,3007"] ="1,3024,1" -- CB Marker beacon, ON/OFF >> TOGLEE_SWITCH :: TSwitch_7
	UH1H_ExportArguments["2,3008"] ="1,3025,1" -- CB VHF Nav. (ARN-82), ON/OFF >> TOGLEE_SWITCH :: TSwitch_8
	UH1H_ExportArguments["2,3009"] ="1,3026,1" -- CB LF Nav. (ARN-83), ON/OFF >> TOGLEE_SWITCH :: TSwitch_9
	UH1H_ExportArguments["2,3010"] ="1,3027,1" -- CB Intercom CPLT(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_10
	UH1H_ExportArguments["2,3011"] ="1,3028,1" -- CB Intercom PLT, ON/OFF >> TOGLEE_SWITCH :: TSwitch_11
	UH1H_ExportArguments["2,3012"] ="1,3029,1" -- CB ARC-102 HF Static INVTR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_12
	UH1H_ExportArguments["2,3013"] ="1,3030,1" -- CB HF ANT COUPLR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_13
	UH1H_ExportArguments["2,3014"] ="1,3031,1" -- CB HF ARC-102(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_14
	UH1H_ExportArguments["2,3015"] ="1,3032,1" -- CB FM Radio, ON/OFF >> TOGLEE_SWITCH :: TSwitch_15
	UH1H_ExportArguments["2,3016"] ="1,3033,1" -- CB UHF Radio, ON/OFF >> TOGLEE_SWITCH :: TSwitch_16
	UH1H_ExportArguments["2,3017"] ="1,3034,1" -- CB FM 2 Radio(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_17
	UH1H_ExportArguments["2,3018"] ="1,3035,1" -- CB VHF AM Radio, ON/OFF >> TOGLEE_SWITCH :: TSwitch_18
	UH1H_ExportArguments["2,3019"] ="1,3037,1" -- CB Pitot tube(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_19
	UH1H_ExportArguments["2,3020"] ="1,3039,1" -- CB Rescue hoist CTL(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_20
	UH1H_ExportArguments["2,3021"] ="1,3040,1" -- CB Rescue hoist cable cutter N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_21
	UH1H_ExportArguments["2,3022"] ="1,3041,1" -- CB Wind wiper CPLT, ON/OFF >> TOGLEE_SWITCH :: TSwitch_22
	UH1H_ExportArguments["2,3023"] ="1,3042,1" -- CB Wind wiper PLT, ON/OFF >> TOGLEE_SWITCH :: TSwitch_23
	UH1H_ExportArguments["2,3024"] ="1,3043,1" -- CB KY-28 voice security(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_24
	UH1H_ExportArguments["2,3025"] ="1,3044,1" -- CB Starter Relay(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_25
	UH1H_ExportArguments["2,3026"] ="1,3045,1" -- CB Search light power(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_26
	UH1H_ExportArguments["2,3027"] ="1,3046,1" -- CB Landing light power(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_27
	UH1H_ExportArguments["2,3028"] ="1,3047,1" -- CB Landing & Search light control(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_28
	UH1H_ExportArguments["2,3029"] ="1,3048,1" -- CB Anticollision light(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_29
	UH1H_ExportArguments["2,3030"] ="1,3049,1" -- CB Fuselage lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_30
	UH1H_ExportArguments["2,3031"] ="1,3050,1" -- CB Navigation lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_31
	UH1H_ExportArguments["2,3032"] ="1,3051,1" -- CB Dome lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_32
	UH1H_ExportArguments["2,3033"] ="1,3052,1" -- CB Cockpit lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_33
	UH1H_ExportArguments["2,3034"] ="1,3053,1" -- CB Caution lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_34
	UH1H_ExportArguments["2,3035"] ="1,3054,1" -- CB Console lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_35
	UH1H_ExportArguments["2,3036"] ="1,3055,1" -- CB INST Panel lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_36
	UH1H_ExportArguments["2,3037"] ="1,3056,1" -- CB INST SEC lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_37
	UH1H_ExportArguments["2,3038"] ="1,3057,1" -- CB Cabin heater (Outlet valve)(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_38
	UH1H_ExportArguments["2,3039"] ="1,3058,1" -- CB Cabin heater (Air valve)(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_39
	UH1H_ExportArguments["2,3040"] ="1,3059,1" -- CB Rescue hoist PWR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_40
	UH1H_ExportArguments["2,3041"] ="1,3060,1" -- CB RPM Warning system(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_41
	UH1H_ExportArguments["2,3042"] ="1,3061,1" -- CB Engine anti-ice(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_42
	UH1H_ExportArguments["2,3043"] ="1,3062,1" -- CB Fire detector(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_43
	UH1H_ExportArguments["2,3044"] ="1,3063,1" -- CB LH fuel boost pump(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_44
	UH1H_ExportArguments["2,3045"] ="1,3064,1" -- CB Turn & Slip indicator, ON/OFF >> TOGLEE_SWITCH :: TSwitch_45
	UH1H_ExportArguments["2,3046"] ="1,3065,1" -- CB TEMP indicator(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_46
	UH1H_ExportArguments["2,3047"] ="1,3066,1" -- CB HYD Control(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_47
	UH1H_ExportArguments["2,3048"] ="1,3068,1" -- CB FORCE Trim(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_48
	UH1H_ExportArguments["2,3049"] ="1,3069,1" -- CB Cargo hook release(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_49
	UH1H_ExportArguments["2,3050"] ="1,3070,1" -- CB EXT Stores jettison(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_50
	UH1H_ExportArguments["2,3051"] ="1,3071,1" -- CB Spare inverter PWR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_51
	UH1H_ExportArguments["2,3052"] ="1,3072,1" -- CB Inverter CTRL (N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_52
	UH1H_ExportArguments["2,3053"] ="1,3073,1" -- CB Main inverter PWR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_53
	UH1H_ExportArguments["2,3054"] ="1,3074,1" -- CB Generator & Bus Reset(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_54
	UH1H_ExportArguments["2,3055"] ="1,3075,1" -- CB STBY Generator Field(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_55
	UH1H_ExportArguments["2,3056"] ="1,3076,1" -- CB Governor Control(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_56
	UH1H_ExportArguments["2,3057"] ="1,3077,1" -- CB IDLE Stop release(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_57
	UH1H_ExportArguments["2,3058"] ="1,3078,1" -- CB RH fuel boost pump(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_58
	UH1H_ExportArguments["2,3059"] ="1,3079,1" -- CB Fuel TRANS(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_59
	UH1H_ExportArguments["2,3060"] ="1,3080,1" -- CB Fuel valves(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_60
	UH1H_ExportArguments["2,3061"] ="1,3081,1" -- CB Heated blanket 1(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_61
	UH1H_ExportArguments["2,3062"] ="1,3082,1" -- CB Heated blanket 2(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_62
	UH1H_ExportArguments["2,3063"] ="1,3083,1" -- CB Voltmeter Non Ess Bus(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_63
	UH1H_ExportArguments["2,3064"] ="1,3085,1" -- CB Ignition system(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_64
	UH1H_ExportArguments["2,3065"] ="1,3086,1" -- CB Pilot ATTD1(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_65
	UH1H_ExportArguments["2,3066"] ="1,3087,1" -- CB Pilot ATTD2(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_66
	UH1H_ExportArguments["2,3067"] ="1,3088,1" -- CB Copilot ATTD1(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_67
	UH1H_ExportArguments["2,3068"] ="1,3089,1" -- CB Copilot ATTD2(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_68
	UH1H_ExportArguments["2,3069"] ="1,3090,1" -- CB Gyro Cmps(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_69
	UH1H_ExportArguments["2,3070"] ="1,3091,1" -- CB Fuel Quantity(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_70
	UH1H_ExportArguments["2,3071"] ="1,3092,1" -- CB 28V Trans(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_71
	UH1H_ExportArguments["2,3072"] ="1,3093,1" -- CB Fail Relay(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_72
	UH1H_ExportArguments["2,3073"] ="1,3094,1" -- CB Pressure Fuel(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_73
	UH1H_ExportArguments["2,3074"] ="1,3095,1" -- CB Pressure Torque(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_74
	UH1H_ExportArguments["2,3075"] ="1,3096,1" -- CB Pressure XMSN(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_75
	UH1H_ExportArguments["2,3076"] ="1,3097,1" -- CB Pressure Eng(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_76
	UH1H_ExportArguments["2,3077"] ="1,3098,1" -- CB Course Ind(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_77
	UH1H_ExportArguments["2,3078"] ="1,3016,1" -- Pitot Heater Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_78
	UH1H_ExportArguments["2,3079"] ="1,3019,1" -- Main generator switch cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_79
	UH1H_ExportArguments["2,3080"] ="2,3001,1" -- Main Fuel Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_80
	UH1H_ExportArguments["2,3081"] ="17,3016,1" -- IFF On/Out Switch >> TOGLEE_SWITCH :: TSwitch_81
	UH1H_ExportArguments["2,3082"] ="3,3027,1" -- Throttle Stop Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_82
	UH1H_ExportArguments["2,3083"] ="3,3002,1" -- De-Ice Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_83
	UH1H_ExportArguments["2,3084"] ="3,3021,1" -- Low RPM Warning Switch, AUDIO/OFF >> TOGLEE_SWITCH :: TSwitch_84
	UH1H_ExportArguments["2,3085"] ="3,3014,1" -- Governor Switch, EMER/AUTO >> TOGLEE_SWITCH :: TSwitch_85
	UH1H_ExportArguments["2,3086"] ="4,3003,1" -- Hydraulic Control Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_86
	UH1H_ExportArguments["2,3087"] ="4,3004,1" -- Force Trim Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_87
	UH1H_ExportArguments["2,3088"] ="21,3001,1" -- VHF FM Radio Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_88
	UH1H_ExportArguments["2,3089"] ="21,3002,1" -- UHF Radio Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_89
	UH1H_ExportArguments["2,3090"] ="21,3003,1" -- VHF AM Radio Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_90
	UH1H_ExportArguments["2,3091"] ="21,3004,1" -- Receiver 4 N/F Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_91
	UH1H_ExportArguments["2,3092"] ="21,3005,1" -- INT Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_92
	UH1H_ExportArguments["2,3093"] ="21,3006,1" -- Receiver NAV Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_93
	UH1H_ExportArguments["2,3094"] ="22,3007,1" -- Squelch Disable Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_94
	UH1H_ExportArguments["2,3095"] ="26,3002,1" -- Marker Beacon Sensing Switch, HIGH/LOW >> TOGLEE_SWITCH :: TSwitch_95
	UH1H_ExportArguments["2,3096"] ="27,3006,1" -- BFO Switch (N/F), BFO/OFF >> TOGLEE_SWITCH :: TSwitch_96
	--UH1H_ExportArguments["2,3097"] ="27,3001,1" -- Gain control / Mode. Right mouse click to cycle mode >> TOGLEE_SWITCH :: TSwitch_97
	UH1H_ExportArguments["2,3099"] ="7,3003,1" -- Position Lights Switch, DIM/BRIGHT >> TOGLEE_SWITCH :: TSwitch_99
	UH1H_ExportArguments["2,3100"] ="7,3004,1" -- Anti-Collision Lights Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_100
	UH1H_ExportArguments["2,3101"] ="7,3005,1" -- Landing Light Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_101
	UH1H_ExportArguments["2,3102"] ="10,3004,1" -- ADF/VOR Control Switch >> TOGLEE_SWITCH :: TSwitch_102
	UH1H_ExportArguments["2,3103"] ="10,3002,1" -- Gyro Mode Switch, DG/Slave >> TOGLEE_SWITCH :: TSwitch_103
	UH1H_ExportArguments["2,3104"] ="49,3005,1" -- Pilot Sight, Armed/Safe >> TOGLEE_SWITCH :: TSwitch_104
	UH1H_ExportArguments["2,3105"] ="49,3006,1" -- Pilot Sight Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_105
	UH1H_ExportArguments["2,3106"] ="52,3003,1" -- Cargo Safety >> TOGLEE_SWITCH :: TSwitch_106
	UH1H_ExportArguments["2,3107"] ="50,3001,1" -- Ripple Fire Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_107
	UH1H_ExportArguments["2,3108"] ="50,3002,1" -- Ripple Fire Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_108
	UH1H_ExportArguments["2,3109"] ="50,3005,1" -- ARM Switch, SAFE/ARM >> TOGLEE_SWITCH :: TSwitch_109
	UH1H_ExportArguments["2,3110"] ="50,3009,1" -- Chaff Mode Switch, MAN/PGRM >> TOGLEE_SWITCH :: TSwitch_110
	UH1H_ExportArguments["2,3111"] ="13,3007,1" -- Radar Altimeter Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_111
	-- tree way switches
	UH1H_ExportArguments["3,3001"] ="1,3008,1" -- Inverter Switch, MAIN/OFF/SPARE >> TREE_WAY_SWITCH :: 3WSwitch_A_1
	UH1H_ExportArguments["3,3002"] ="17,3009,1" -- Audio/light Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_2
	UH1H_ExportArguments["3,3003"] ="7,3002,1" -- Position Lights Switch, STEADY/OFF/FLASH >> TREE_WAY_SWITCH :: 3WSwitch_A_3
	UH1H_ExportArguments["3,3004"] ="7,3006,1" -- Search Light Switch, ON/OFF/STOW >> TREE_WAY_SWITCH :: 3WSwitch_A_4
	UH1H_ExportArguments["3,3005"] ="7,3007,1" -- Landing Light Control Switch, EXT/OFF/RETR >> TREE_WAY_SWITCH :: 3WSwitch_A_5
	UH1H_ExportArguments["3,3006"] ="7,3021,1" -- Dome Light Switch, WHITE/OFF/GREEN >> TREE_WAY_SWITCH :: 3WSwitch_A_6
	UH1H_ExportArguments["3,3007"] ="9,3008,1" -- Armament Switch, ARMED/SAFE/OFF >> TREE_WAY_SWITCH :: 3WSwitch_A_7
	UH1H_ExportArguments["3,3008"] ="9,3009,1" -- Gun Selector Switch, LEFT/ALL/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_8
	UH1H_ExportArguments["3,3009"] ="9,3010,1" -- Armament Selector Switch, 7.62/2.75/40 >> TREE_WAY_SWITCH :: 3WSwitch_A_9
	UH1H_ExportArguments["3,3010"] ="9,3013,1" -- Jettison Switch Cover, OPEN/CLOSE >> TREE_WAY_SWITCH :: 3WSwitch_A_10
	UH1H_ExportArguments["3,3011"] ="32,3003,1" -- Sighting Station Lamp Switch, BACKUP/OFF/MAIN >> TREE_WAY_SWITCH :: 3WSwitch_A_11
	UH1H_ExportArguments["3,3012"] ="12,3002,1" -- Wiper Selector Switch, PILOT/BOTH/COPILOT >> TREE_WAY_SWITCH :: 3WSwitch_A_12
	UH1H_ExportArguments["3,3013"] ="15,3001,1" -- Reset/Test switch >> TREE_WAY_SWITCH :: 3WSwitch_A_13
	UH1H_ExportArguments["3,3014"] ="15,3002,1" -- Bright/Dim switch >> TREE_WAY_SWITCH :: 3WSwitch_A_14
	UH1H_ExportArguments["3,3015"] ="3,3013,1" -- Chip Detector Switch, LMB - Tail Rotor / RMB - XMSN >> TREE_WAY_SWITCH :: 3WSwitch_A_15
	UH1H_ExportArguments["3,3016"] ="3,3015,1" -- Governor RPM Switch, Decrease/Increase >> TREE_WAY_SWITCH :: 3WSwitch_A_16
	UH1H_ExportArguments["3,3017"] ="1,3002,1" -- Main generator Switch (Left button - ON/OFF. Right button RESET) >> TREE_WAY_SWITCH :: 3WSwitch_A_17
	UH1H_ExportArguments["3,3018"] ="17,3010,1" -- Test M-1 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_18
	UH1H_ExportArguments["3,3019"] ="17,3011,1" -- Test M-2 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_19
	UH1H_ExportArguments["3,3020"] ="17,3012,1" -- Test M-3A Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_20
	UH1H_ExportArguments["3,3021"] ="17,3013,1" -- Test M-C Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_21
	UH1H_ExportArguments["3,3022"] ="17,3014,1" -- RAD Switch, TEST/MON >> TREE_WAY_SWITCH :: 3WSwitch_A_22
	UH1H_ExportArguments["3,3023"] ="17,3015,1" -- Ident/Mic Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_23
	UH1H_ExportArguments["3,3024"] ="12,3001,1" -- Wipers Speed Switch, PARK/OFF/LOW/MED/HIGH  >> TREE_WAY_SWITCH :: 3WSwitch_A_24
	UH1H_ExportArguments["3,3025"] ="27,3002,1" -- Tune control / Band selection. Right mouse click to select a band >> TREE_WAY_SWITCH :: 3WSwitch_A_25 
	UH1H_ExportArguments["3,3201"] ="21,3009,1" -- Radio/ICS Switch >> TREE_WAY_SWITCH :: 3WSwitch_C_201
	-- axis:
	UH1H_ExportArguments["4,3001"] ="6,3002,1" -- Attitude Indicator Pitch Trim Knob copilot>> AXIS :: Axis_A_1
	UH1H_ExportArguments["4,3002"] ="5,3001,1" -- Attitude Indicator Pitch Trim Knob >> AXIS :: Axis_A_2
	UH1H_ExportArguments["4,3003"] ="5,3002,1" -- Attitude Indicator Roll Trim Knob >> AXIS :: Axis_A_3
	UH1H_ExportArguments["4,3004"] ="19,3001,1" -- Pressure Adjustment Knob >> AXIS :: Axis_A_4
	UH1H_ExportArguments["4,3005"] ="18,3001,1" -- Pressure Adjustment Knob >> AXIS :: Axis_A_5
	UH1H_ExportArguments["4,3006"] ="22,3008,1" -- UHF Volume Knob >> AXIS :: Axis_A_6
	UH1H_ExportArguments["4,3007"] ="10,3003,1" -- Heading Set Knob >> AXIS :: Axis_A_7
	UH1H_ExportArguments["4,3008"] ="29,3001,1" -- Course Select Knob >> AXIS :: Axis_A_8
	UH1H_ExportArguments["4,3009"] ="32,3001,1" -- Sighting Station Intensity Knob >> AXIS :: Axis_A_9
	UH1H_ExportArguments["4,3010"] ="49,3001,1" -- Pilot Sighting Station Intensity Knob >> AXIS :: Axis_A_10
	UH1H_ExportArguments["4,3011"] ="13,3002,1" -- Low Altitude Setting Knob >> AXIS :: Axis_A_11
	UH1H_ExportArguments["4,3012"] ="21,3007,1" -- Intercom Volume Knob >> AXIS :: Axis_A_12
	--UH1H_ExportArguments["4,3013"] ="22,3002,1" -- 10 MHz Selector >> AXIS :: Axis_A_13
	--UH1H_ExportArguments["4,3014"] ="22,3003,1" -- 1 MHz Selector >> AXIS :: Axis_A_14
	--UH1H_ExportArguments["4,3015"] ="22,3004,1" -- 50 kHz Selector >> AXIS :: Axis_A_15
	UH1H_ExportArguments["4,3016"] ="23,3006,1" -- Volume Knob VHF COM >> AXIS :: Axis_A_16
	UH1H_ExportArguments["4,3017"] ="26,3001,1" -- Marker Beacon Knob, ON/OFF/Volume >> AXIS :: Axis_A_17
	UH1H_ExportArguments["4,3018"] ="7,3015,1" -- Overhead Console Panel Lights Brightness Rheostat >> AXIS :: Axis_A_18
	UH1H_ExportArguments["4,3019"] ="7,3016,1" -- Pedestal Lights Brightness Rheostat >> AXIS :: Axis_A_19
	UH1H_ExportArguments["4,3020"] ="7,3017,1" -- Secondary Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_20
	UH1H_ExportArguments["4,3021"] ="7,3018,1" -- Engine Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_21
	UH1H_ExportArguments["4,3022"] ="7,3019,1" -- Copilot Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_22
	UH1H_ExportArguments["4,3023"] ="7,3020,1" -- Pilot Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_23
	UH1H_ExportArguments["4,3024"] ="27,3004,1" -- Gain control / Mode. Rotate mouse wheel to adjust gain >> AXIS :: Axis_A_24
	--UH1H_ExportArguments["4,3025"] ="50,3004,1" -- Flare counter Reset. Rotate mouse wheel to set Number >> AXIS :: Axis_A_25
	--UH1H_ExportArguments["4,3026"] ="50,3008,1" -- Chaff counter Reset. Rotate mouse wheel to set Number >> AXIS :: Axis_A_26
	UH1H_ExportArguments["4,3027"] ="13,3003,1" -- Test / Hight Set. Rotate mouse wheel to set Hight >> AXIS :: Axis_A_27
	UH1H_ExportArguments["4,3028"] ="20,3003,1" -- VHF_ARC_134 Volume >> AXIS :: Axis_A_28 
	UH1H_ExportArguments["4,3029"] ="25,3002,1" -- Frequency kHz / Volume VOLUME    --NAV CON Khz>> AXIS :: Axis_A_29   
	UH1H_ExportArguments["4,3101"] ="10,3005,1" -- Compass Synchronizing Knob >> AXIS :: Axis_B_101
	UH1H_ExportArguments["4,3102"] ="30,3002,1" -- Winding/Adjustment Clock lev >> AXIS :: Axis_B_102
	UH1H_ExportArguments["4,3103"] ="27,3003,1" -- Tune control / Band selection. Rotate mouse wheel to adjust tune >> AXIS :: Axis_B_103
	UH1H_ExportArguments["4,3104"] ="22,3001,1" -- Preset Channel Selector >> AXIS :: Axis_B_104
	UH1H_ExportArguments["4,3032"] ="20,3001,1" -- VHF_ARC_134 POWER >> AXIS :: Axis_A_32
	UH1H_ExportArguments["4,3033"] ="25,3004,1" -- NAV Frequency kHz / Volume VOLUME   - NAV CON VOLUME>> AXIS :: Axis_A_33 
	UH1H_ExportArguments["4,3034"] ="25,3003,1" -- NAV CON  POWER >> AXIS :: Axis_A_34	
	UH1H_ExportArguments["4,3036"] ="3,3024,107" -- THROTLE >> AXIS :: Axis_A_36
	-- multiposition:
	UH1H_ExportArguments["5,3001"] ="1,3004,1" -- DC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi6PosSwitch_1
	UH1H_ExportArguments["5,3002"] ="1,3007,1" -- AC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi6PosSwitch_2
	UH1H_ExportArguments["5,3003"] ="17,3008,1" -- Master Knob, OFF/STBY/LOW/NORM/EMER >> MULTI_POS_SWITCH :: Multi6PosSwitch_3
	UH1H_ExportArguments["5,3004"] ="17,3001,3.3" -- MODE1-WHEEL1 >> MULTI_POS_SWITCH :: Multi6PosSwitch_4
	UH1H_ExportArguments["5,3005"] ="21,3008,1" -- Intercom Mode (PVT,INT,VHF FM,UHF,VHF AM,Not used) >> MULTI_POS_SWITCH :: Multi6PosSwitch_5
	UH1H_ExportArguments["5,3006"] ="22,3005,1" -- Frequency Mode Dial >> MULTI_POS_SWITCH :: Multi6PosSwitch_6
	UH1H_ExportArguments["5,3007"] ="22,3006,1" -- Function Dial >> MULTI_POS_SWITCH :: Multi6PosSwitch_7
	UH1H_ExportArguments["5,3008"] ="7,3001,1" -- Navigation Lights Switch, OFF/1/2/3/4/BRT >> MULTI_POS_SWITCH :: Multi6PosSwitch_8
	UH1H_ExportArguments["5,3009"] ="47,3001,1" -- Bleed Air Switch, OFF/1/2/3/4 >> MULTI_POS_SWITCH :: Multi6PosSwitch_9
	--UH1H_ExportArguments["5,3010"] ="23,3001,1" -- Frequency Tens MHz Selector >> MULTI_POS_SWITCH :: Multi6PosSwitch_10
	UH1H_ExportArguments["5,3011"] ="23,3004,1" -- Frequency Hundredths MHz Selector >> MULTI_POS_SWITCH :: Multi6PosSwitch_11
	UH1H_ExportArguments["5,3012"] ="23,3007,1" -- Mode Switch, OFF/TR/RETRAN(N/F)/HOME(N/F) >> MULTI_POS_SWITCH :: Multi6PosSwitch_12
	UH1H_ExportArguments["5,3013"] ="23,3005,1" -- Squelch Mode Switch, DIS/CARR/TONE >> MULTI_POS_SWITCH :: Multi6PosSwitch_13
	UH1H_ExportArguments["5,3014"] ="12,3001,1" -- Wipers Speed Switch, PARK/OFF/LOW/MED/HIGH >> MULTI_POS_SWITCH :: Multi6PosSwitch_14 
	UH1H_ExportArguments["5,3015"] ="27,3001,1" -- Gain control / Mode. Right mouse click to cycle mode >> MULTI_POS_SWITCH :: Multi6PosSwitch_15
	UH1H_ExportArguments["5,3016"] ="27,3005,1" -- ADF loop >> MULTI_POS_SWITCH :: Multi6PosSwitch_16
	UH1H_ExportArguments["5,3017"] ="17,3007,1" -- Code Knob, ZERO/B/A/HOLD >> MULTI_POS_SWITCH :: Multi6PosSwitch_17
	UH1H_ExportArguments["5,3051"] ="17,3002,1.1" -- MODE1-WHEEL2 >> MULTI_POS_SWITCH :: Multi11PosSwitch_51
	UH1H_ExportArguments["5,3052"] ="17,3003,1.1" -- MODE3A-WHEEL1 >> MULTI_POS_SWITCH :: Multi11PosSwitch_52
	UH1H_ExportArguments["5,3053"] ="17,3004,1.1" -- MODE3A-WHEEL2 >> MULTI_POS_SWITCH :: Multi11PosSwitch_53
	UH1H_ExportArguments["5,3054"] ="17,3005,1.1" -- MODE3A-WHEEL3 >> MULTI_POS_SWITCH :: Multi11PosSwitch_54
	UH1H_ExportArguments["5,3055"] ="17,3006,1.1" -- MODE3A-WHEEL4 >> MULTI_POS_SWITCH :: Multi11PosSwitch_55
	UH1H_ExportArguments["5,3056"] ="9,3011,1" -- Rocket Pair Selector Switch >> MULTI_POS_SWITCH :: Multi11PosSwitch_56
	UH1H_ExportArguments["5,3057"] ="23,3002,1" -- Frequency Ones MHz Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_57
	UH1H_ExportArguments["5,3058"] ="23,3003,1" -- Frequency Decimals MHz Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_58
	UH1H_ExportArguments["5,3059"] ="23,3001,1" -- Frequency Tens MHz Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_59
	-- rockers
	UH1H_ExportArguments["10,3001"] ="27,3003,-0.01" -- Tune control / Band selection. Rotate mouse wheel to adjust tune >> Rocker_C_101
	UH1H_ExportArguments["10,3002"] ="27,3003,0.01" -- Tune control / Band selection. Rotate mouse wheel to adjust tune >>  Rocker_C_101
	UH1H_ExportArguments["10,3003"] ="20,3005,-0.01" -- VHF_ARC_134 Khz >> Rocker_C_102
	UH1H_ExportArguments["10,3004"] ="20,3005,0.01" -- VHF_ARC_134 Khz >>  Rocker_C_102
	UH1H_ExportArguments["10,3005"] ="20,3004,-0.01" -- VHF_ARC_134 Mhz >> Rocker_C_103
	UH1H_ExportArguments["10,3006"] ="20,3004,0.01" -- VHF_ARC_134 Mhz >>  Rocker_C_103
	UH1H_ExportArguments["10,3007"] ="25,3002,-0.01" -- NAV CON Khz >> Rocker_C_104
	UH1H_ExportArguments["10,3008"] ="25,3002,0.01" -- NAV CON Khz >>  Rocker_C_104
	UH1H_ExportArguments["10,3009"] ="25,3001,-0.01" -- NAV CON Mhz >> Rocker_C_105
	UH1H_ExportArguments["10,3010"] ="25,3001,0.01" -- NAV CON Mhz >>  Rocker_C_105
	UH1H_ExportArguments["10,3011"] ="13,3002,-0.02" -- Low Altitude Setting Knob >> Rocker_C_106
	UH1H_ExportArguments["10,3012"] ="13,3002,0.02" -- Low Altitude Setting Knob >>  Rocker_C_106
	UH1H_ExportArguments["10,3013"] ="13,3003,-0.02" -- Test / Hight Set >> Rocker_C_107
	UH1H_ExportArguments["10,3014"] ="13,3003,0.02" -- Test / Hight Set >>  Rocker_C_107
	UH1H_ExportArguments["10,3015"] ="29,3001,-0.02" -- Course Select Knobb >> Rocker_C_108
	UH1H_ExportArguments["10,3016"] ="29,3001,0.02" -- Course Select Knob >>  Rocker_C_108
	UH1H_ExportArguments["10,3017"] ="10,3003,-0.02" -- Heading Set Knob  >> Rocker_C_109
	UH1H_ExportArguments["10,3018"] ="10,3003,0.02" -- Heading Set Knob  >>  Rocker_C_109
	UH1H_ExportArguments["10,3019"] ="10,3005,-0.02" -- Compass Synchronizing Knob >> Rocker_C_110
	UH1H_ExportArguments["10,3020"] ="10,3005,0.02" -- Compass Synchronizing Knob >>  Rocker_C_110
	UH1H_ExportArguments["10,3021"] ="18,3001,-0.02" -- Pressure Adjustment Knob >> Rocker_C_111
	UH1H_ExportArguments["10,3022"] ="18,3001,0.02" -- Pressure Adjustment Knob >>  Rocker_C_111
	UH1H_ExportArguments["10,3023"] ="5,3001,-0.02" -- Attitude Indicator Pitch Trim Knob >> Rocker_C_112
	UH1H_ExportArguments["10,3024"] ="5,3001,0.02" -- Attitude Indicator Pitch Trim Knob >>  Rocker_C_112
	UH1H_ExportArguments["10,3025"] ="19,3001,-0.2" -- Pressure Adjustment Knob      copilot>> Rocker_C_113
	UH1H_ExportArguments["10,3026"] ="19,3001,0.2" -- Pressure Adjustment Knob       copilot>>  Rocker_C_113
	UH1H_ExportArguments["10,3027"] ="6,3002,-0.02" -- Attitude Indicator Pitch Trim Knob copilot >> Rocker_C_114
	UH1H_ExportArguments["10,3028"] ="6,3002,0.02" -- Attitude Indicator Pitch Trim Knob copilot >>  Rocker_C_114
	UH1H_ExportArguments["10,3029"] ="5,3002,-0.02" -- Attitude Indicator Roll Trim Knob >> Rocker_C_115
	UH1H_ExportArguments["10,3030"] ="5,3002,0.02" -- Attitude Indicator Roll Trim Knob >>  Rocker_C_115
	UH1H_ExportArguments["10,3031"] ="30,3002,-0.02" -- adjustement clock >> Rocker_C_116
	UH1H_ExportArguments["10,3032"] ="30,3002,0.02" -- adjustement clock >>  Rocker_C_116
	UH1H_ExportArguments["10,3033"] ="50,3004,-0.02" -- Flare counter Reset. Rotate mouse wheel to set Number >> Rocker_C_117
	UH1H_ExportArguments["10,3034"] ="50,3004,0.02" -- Flare counter Reset. Rotate mouse wheel to set Number >>  Rocker_C_117
	UH1H_ExportArguments["10,3035"] ="50,3008,-0.02" -- Chaff counter Reset. Rotate mouse wheel to set Number >> Rocker_C_118
	UH1H_ExportArguments["10,3036"] ="50,3008,0.02" -- Chaff counter Reset. Rotate mouse wheel to set Number >>  Rocker_C_118
	UH1H_ExportArguments["10,3037"] ="22,3002,-0.02" -- 10 MHz Selector >> Rocker_C_119
	UH1H_ExportArguments["10,3038"] ="22,3002,0.02" -- 10 MHz Selector >>  Rocker_C_119
	UH1H_ExportArguments["10,3039"] ="22,3003,-0.02" -- 1 MHz Selector >> Rocker_C_120
	UH1H_ExportArguments["10,3040"] ="22,3003,0.02" -- 1 MHz Selector >>  Rocker_C_120
	UH1H_ExportArguments["10,3041"] ="22,3004,-0.02" -- 50 kHz Selector >> Rocker_C_121
	UH1H_ExportArguments["10,3042"] ="22,3004,0.02" -- 50 kHz Selector >>  Rocker_C_121

	
	
	---------------------------- end of UH1H export table
    ----------------------------------------------------------
 
 
 
 
 
 
 
 
 
 
	
	-- Lookup tables for weapons store type display

gKa50StationTypes = 
{
	["9A4172"] = "NC", 
	["S-8KOM"] = "HP", 
	["S-13"] = "HP", 
	["UPK-23-250"] = "NN", 
	["AO-2.5RT"] = "A6", 
	["PTAB-2.5KO"] = "A6",
	["FAB-250"] = "A6", 
	["FAB-500"] = "A6" 
}

-- State data
gKa50Trigger = 0

gCurrentAircraft = "none"  -- not set yet.
gFlamingCliffsAircraft = false
gKnownAircraft = false


------------
-- SCRIPT --
------------

--os.setlocale("ISO-8559-1", "numeric")   -- this line makes the export.lua crash on 1.5.5

-- Simulation id
gSimID = string.format("%08x*",os.time())

-- State data for export
gPacketSize = 0
gSendStrings = {}
gLastData = {}

-- Frame counter for non important data
gTickCount = 0



----------------------------------------
-- AIRCRAFT-SPECIFIC EXPORT FUNCTIONS --
----------------------------------------

-----------------------------
-- HIGH IMPORTANCE EXPORTS --
-- done every export event --
-----------------------------

-- Exports.Lua from Helios AV-8B interface
function ProcessAV8BHighImportance(mainPanelDevice)
	-- Send Altimeter Values	
	SendData(2051, string.format("%0.4f;%0.4f;%0.4f", mainPanelDevice:get_argument_value(355), mainPanelDevice:get_argument_value(354), mainPanelDevice:get_argument_value(352)))
	SendData(2059, string.format("%0.2f;%0.2f;%0.2f;%0.3f", mainPanelDevice:get_argument_value(356), mainPanelDevice:get_argument_value(357), mainPanelDevice:get_argument_value(358), mainPanelDevice:get_argument_value(359)))		
end


-- Pointed to by ProcessHighImportance, if the player aircraft is an A-10
function ProcessA10HighImportance(mainPanelDevice)
	-- Send Altimeter Values	
	SendData(2051, string.format("%0.4f;%0.4f;%0.5f", mainPanelDevice:get_argument_value(52), 
													  mainPanelDevice:get_argument_value(53), 
													  mainPanelDevice:get_argument_value(51)))
	-- Barometric Pressure Setting
	SendData(2059, string.format("%0.2f;%0.2f;%0.2f;%0.3f", mainPanelDevice:get_argument_value(56), 
															mainPanelDevice:get_argument_value(57), 
															mainPanelDevice:get_argument_value(58), 
															mainPanelDevice:get_argument_value(59)))		
	-- Calcuate HSI Value
	SendData(2029, string.format("%0.2f;%0.2f;%0.4f", mainPanelDevice:get_argument_value(29), 
													  mainPanelDevice:get_argument_value(30), 
													  mainPanelDevice:get_argument_value(31)))
	-- Calculate Total Fuel
	SendData(2090, string.format("%0.2f;%0.2f;%0.5f", mainPanelDevice:get_argument_value(90), 
													  mainPanelDevice:get_argument_value(91), 
													  mainPanelDevice:get_argument_value(92)))
													  
	
			-- process AM freq digits
			
			
			
			
			if am_radio_freq_inicialized== 0 then  -- get the actual AM digits from the cockpit in case the sw is in manual mode, and inicialize values only one time
				local AM_mode_sw = math.floor((mainPanelDevice:get_argument_value(135)*10 + 0.4))/10
				if AM_mode_sw == 0.2  then  
					freq_digit_1, freq_digit_2, freq_digit_3 = get_radio_freq_in_manual_mode(55) 
					am_radio_freq_inicialized = 1
				end
			end
			
			if fm_radio_freq_inicialized== 0 then  -- get the actual FM digits from the cockpit in case the sw is in manual mode, and inicialize values only one time
				local FM_mode_sw = math.floor((mainPanelDevice:get_argument_value(135)*10 + 0.4))/10
				if FM_mode_sw == 0.2 then  
					freq_FM_digit_1, freq_FM_digit_2, freq_FM_digit_3 = get_radio_freq_in_manual_mode(56) 
					fm_radio_freq_inicialized = 1
				end
			end
	
			local actual_AM_digit_1 = math.floor((mainPanelDevice:get_argument_value(139)*10 + 0.4))/10
			local actual_AM_digit_2 = math.floor((mainPanelDevice:get_argument_value(140)*10 + 0.4))/10
			local actual_AM_digit_3 = math.floor((mainPanelDevice:get_argument_value(141)*10 + 0.4))/10
			
			if actual_AM_digit_1 > 0.9 then actual_AM_digit_1= 0.9 end
			if actual_AM_digit_2 > 0.9 then actual_AM_digit_2= 0.9 end
			if actual_AM_digit_3 > 0.9 then actual_AM_digit_3= 0.9 end
			
			
			if 	actual_AM_digit_1 ~= gAM_digit_1 then
				gAM_digit_1, freq_digit_1 = Convert_radio_first_digits(actual_AM_digit_1, gAM_digit_1, freq_digit_1)
			end
			
			if 	actual_AM_digit_2 ~= gAM_digit_2 then
				gAM_digit_2, freq_digit_2 = Convert_radio_other_digits(actual_AM_digit_2, gAM_digit_2, freq_digit_2)
			end
			
			if 	actual_AM_digit_3 ~= gAM_digit_3 then
				gAM_digit_3, freq_digit_3 = Convert_radio_other_digits(actual_AM_digit_3, gAM_digit_3, freq_digit_3)
			end
			
			-- process FM freq digits
			local actual_FM_digit_1 = math.floor((mainPanelDevice:get_argument_value(153)*10 + 0.4))/10
			local actual_FM_digit_2 = math.floor((mainPanelDevice:get_argument_value(154)*10 + 0.4))/10
			local actual_FM_digit_3 = math.floor((mainPanelDevice:get_argument_value(155)*10 + 0.4))/10
			
			if actual_FM_digit_1 > 0.9 then actual_FM_digit_1= 0.9 end
			if actual_FM_digit_2 > 0.9 then actual_FM_digit_2= 0.9 end
			if actual_FM_digit_3 > 0.9 then actual_FM_digit_3= 0.9 end
			
			
			if 	actual_FM_digit_1 ~= gFM_digit_1 then
				gFM_digit_1, freq_FM_digit_1 = Convert_radio_first_digits(actual_FM_digit_1, gFM_digit_1, freq_FM_digit_1)
			end
			
			if 	actual_FM_digit_2 ~= gFM_digit_2 then
				gFM_digit_2, freq_FM_digit_2 = Convert_radio_other_digits(actual_FM_digit_2, gFM_digit_2, freq_FM_digit_2)
			end
			
			if 	actual_FM_digit_3 ~= gFM_digit_3 then
				gFM_digit_3, freq_FM_digit_3 = Convert_radio_other_digits(actual_FM_digit_3, gFM_digit_3, freq_FM_digit_3)
			end
	
	SendData(139, string.format("%0.2f", freq_digit_1))
	SendData(140, string.format("%0.2f", freq_digit_2))
	SendData(141, string.format("%0.2f", freq_digit_3))
	SendData(153, string.format("%0.2f", freq_FM_digit_1))
	SendData(154, string.format("%0.2f", freq_FM_digit_2))
	SendData(155, string.format("%0.2f", freq_FM_digit_3))
																								  
													  
										
end


function Convert_radio_first_digits(actual, stored, freq_output)   -- this function convert the new radio system  to the old one and let caploz profile continue working

				if actual == 0.9 and  stored == 0 then  -- decrement from 0
					stored = 0.9
					freq_output = freq_output - 0.05
					if freq_output < 0.14 then freq_output = 0.75 end
								
				elseif actual == 0 and  stored == 0.9 then -- increment from 0.9
					stored = 0
					freq_output = freq_output + 0.05
					if freq_output > 0.76 then freq_output = 0.15 end	
					
				elseif  actual > stored and stored < 0.85 then  -- regular increment
					stored = actual
					freq_output = freq_output + 0.05
					if freq_output > 0.76 then freq_output = 0.15 end
				
				elseif actual < stored and stored > 0.05 then  -- regular decrement
					stored = actual
					freq_output = freq_output - 0.05
					if freq_output < 0.14 then freq_output = 0.75 end
				end

				return stored, freq_output
end


function get_radio_freq_in_manual_mode(device_number)
local digit1
local digit2
local digit3
local radio_freq

	local AM = GetDevice(device_number)
	radio_freq=AM:get_frequency()
	digit1= math.floor(radio_freq/10000000)
	digit2= math.floor(radio_freq/1000000) - (digit1 *10)
	digit3= math.floor(radio_freq/100000) - (((digit1 *10) + digit2)*10)
	
	
	return  digit1/20, digit2/10, digit3/10
	
end

function Convert_radio_other_digits(actual, stored, freq_output)  -- this function convert the new radio system  to the old one and let caploz profile continue working

				if actual == 0.9 and  stored == 0 then  -- decrement from 0
					stored = 0.9
					freq_output = freq_output - 0.1
					if freq_output < 0 then freq_output = 0.9 end
								
				elseif actual == 0 and  stored == 0.9 then -- increment from 0.9
					stored = 0
					freq_output = freq_output + 0.1
					if freq_output > 0.91 then freq_output = 0 end	
					
				elseif  actual > stored and stored < 0.9 then  -- regular increment
					stored = actual
					freq_output = freq_output + 0.1
					if freq_output > 0.91 then freq_output= 0 end
				
				elseif actual < stored and stored > 0 then  -- regular decrement
					stored = actual
					freq_output = freq_output - 0.1
					if freq_output < 0 then freq_output = 0.9 end
				end

				return stored, freq_output
end





-- Pointed to by ProcessHighImportance, if the player aircraft is an SA342M (Using KA50 interface)
function ProcessSA342HighImportance(mainPanelDevice)

	--- Altitude
	SendData("87", string.format("%.4f", mainPanelDevice:get_argument_value(87) ))		-- Baro_Altimeter_thousands (0-1) > Barometric Altimeter
	SendData("89", string.format("%.4f", mainPanelDevice:get_argument_value(573) ))		-- Baro_Altimeter_hundred (0-1) > Commanded Altitude
	SendData("471", string.format("%.4f", mainPanelDevice:get_argument_value(94) ))		-- Radar_Altimeter  > Common Pressure
	SendData("472", string.format("%.4f", mainPanelDevice:get_argument_value(93) ))		-- DangerRALT_index  > Main Pressure
	--- Velocity
	SendData("24", string.format("%.4f", mainPanelDevice:get_argument_value(24) ))		-- Variometre > vertical velocity
	SendData("51", string.format("%.4f", mainPanelDevice:get_argument_value(51) ))		-- IAS > Indicated Airspeed
	-- Engine Management
	SendData("53", string.format("%.4f", mainPanelDevice:get_argument_value(16) ))		-- Torque > Rotor Pitch
	SendData("133", string.format("%.4f", mainPanelDevice:get_argument_value(151) ))	-- TempThm > Left Engine EGT
	SendData("134", string.format("%.4f", mainPanelDevice:get_argument_value(15) ))		-- TQuatre > Right Engine EGT
	SendData("135", string.format("%.4f", mainPanelDevice:get_argument_value(135) ))	-- Turbine_RPM > Left Engine RPM
	SendData("136", string.format("%.4f", mainPanelDevice:get_argument_value(52) ))		-- Rotor_RPM > Right Engine RPM
	SendData("111", string.format("%.4f", mainPanelDevice:get_argument_value(55) ))		-- Torque_Bug > ADI air speed deviation
	-- HA
	local HA_rot_var= (mainPanelDevice:get_argument_value(115)*0.06)-0.03
	local Adjusted_HA = (-2 * mainPanelDevice:get_argument_value(27))- HA_rot_var
	SendData("101", string.format("%.4f", Adjusted_HA ))								-- HA_Pitch plus HA rot  > ADI pitch
	SendData("100", string.format("%.4f", mainPanelDevice:get_argument_value(28) ))		-- HA_Roll > ADI roll
	SendData("108", string.format("%.4f", mainPanelDevice:get_argument_value(20) ))		-- HA_bille > ADI side slip
	SendData("107", string.format("%.4f", mainPanelDevice:get_argument_value(118) ))	-- HA_barre_Verticale > ADI bank deviation
	SendData("106", string.format("%.4f", mainPanelDevice:get_argument_value(119) ))	-- HA_barre_Horizontale > ADI pitch deviation
	SendData("109", string.format("%.4f", mainPanelDevice:get_argument_value(19) ))		-- HA_flag_HS > ADI malfunction flag
	-- Stby HA
	local STB_HA_rot_var= (mainPanelDevice:get_argument_value(215)*0.06)-0.03
	local Adjusted_STB_HA = (-2 * mainPanelDevice:get_argument_value(213))- STB_HA_rot_var
	SendData("143", string.format("%.4f", Adjusted_STB_HA ))							-- Stdby_HA_Pitch plus Stb_HA rot > Backup ADI pitch
	SendData("142", string.format("%.4f", mainPanelDevice:get_argument_value(214) ))	-- Stdby_HA_Roll > Backup ADI roll
	SendData("145", string.format("%.4f", mainPanelDevice:get_argument_value(211) ))	-- Stdby_HA_flag > Backup ADI warning flag
	-- HSI
	local valFixed = 1 - mainPanelDevice:get_argument_value(113)
	SendData("112", string.format("%.4f", valFixed ))									-- ADF_Fond > HSI Heading
	SendData("118", string.format("%.4f", mainPanelDevice:get_argument_value(102) ))	-- ADF_AiguilleLarge > HSI Commaned Course
	SendData("124", string.format("%.4f", mainPanelDevice:get_argument_value(103) ))	-- ADF_Aiguille_fine > HSI Commanded Heading
	SendData("372", string.format("%.4f", mainPanelDevice:get_argument_value(110) ))	-- ADF_100 >  R-828 VHF-1 Radio Volume
	SendData("574", string.format("%.4f", mainPanelDevice:get_argument_value(111) ))	-- ADF_10 > R-800 VHF-2 Radio 2nd Rotary Window
	SendData("575", string.format("%.4f", mainPanelDevice:get_argument_value(112) ))	-- ADF_1 > R-800 VHF-2 Radio rd Rotary Window
	--Gyro
	SendData("144", string.format("%.4f", mainPanelDevice:get_argument_value(200) ))	-- Gyro needle > Backup ADI side slip
	--Clock
	SendData("70", string.format("%.4f", mainPanelDevice:get_argument_value(42) ))		-- CLOCK_SECOND > Current Time Seconds
	SendData("406", string.format("%.4f", mainPanelDevice:get_argument_value(210) ))	-- CLOCK_exterior corone > Shkval Brightness
	-- PA
	SendData("103", string.format("%.4f", mainPanelDevice:get_argument_value(37) ))		-- SA342 PA T > adi lateral dev
	SendData("526", string.format("%.4f", mainPanelDevice:get_argument_value(38) ))		-- SA342 PA R > adi alt dev
	SendData("127", string.format("%.4f", mainPanelDevice:get_argument_value(39) ))		-- SA342 PA L > hsi long dev
	-- main alarms lamps
	SendData("64", string.format("%.4f", mainPanelDevice:get_argument_value(303) ))		-- SA342 Voyant_ALARME > Mechanical Nose Gear Down Indicator
	SendData("61", string.format("%.4f", mainPanelDevice:get_argument_value(17) ))		-- SA342 Voyant_Torque > Mechanical Right Gear Up Indicator
	
end



------------------------------------------
-- L39ZA exported as a A10C aircraft    --
-- 	  by Capt Zeen				        --
------------------------------------------



-- Pointed to by ProcessHighImportance, if the player aircraft is an L39ZA (Using A10C interface)
function ProcessL39ZAHighImportance(mainPanelDevice)

		local _LAST_ONE = 0 -- used to mark the end of the tables	
		local MainPanel = GetDevice(0)
		
	
	local FrontCanopy = MainPanel:get_argument_value(38) 	-- 0 to 1
	local BackCanopy = MainPanel:get_argument_value(421) 	-- 0 to 1
	local FrontSeat = MainPanel:get_argument_value(50) 		-- 0 to 1 simplyfied
	local BackSeat = MainPanel:get_argument_value(472) 		-- 0 to 1 simplyfied
-- Mechanic clock
		local CLOCK_currtime_hours = MainPanel:get_argument_value(67) 				-- 0 to 1
		local CLOCK_currtime_minutes = MainPanel:get_argument_value(68) 			-- 0 to 1
		local CLOCK_seconds_meter_time_seconds = MainPanel:get_argument_value(70) 	-- 0 to 1
		local CLOCK_flight_time_meter_status = MainPanel:get_argument_value(73) 	-- 0 to 0.2
		local CLOCK_flight_hours = MainPanel:get_argument_value(71) 				-- 0 to 1
		local CLOCK_flight_minutes = MainPanel:get_argument_value(72) 				-- 0 to 1
		local CLOCK_seconds_meter_time_minutes = MainPanel:get_argument_value(69) 	-- 0 to 1
-- Mechanic clock
		local CLOCK_2_currtime_hours = MainPanel:get_argument_value(405) 			 -- 0 to 1
		local CLOCK_2_currtime_minutes = MainPanel:get_argument_value(406) 			 -- 0 to 1
		local CLOCK_2_seconds_meter_time_seconds = MainPanel:get_argument_value(408) -- 0 to 1
		local CLOCK_2_flight_time_meter_status = MainPanel:get_argument_value(411) 	 -- 0 to 0.2
		local CLOCK_2_flight_hours = MainPanel:get_argument_value(409) 				 -- 0 to 1
		local CLOCK_2_flight_minutes = MainPanel:get_argument_value(410) 			 -- 0 to 1
		local CLOCK_2_seconds_meter_time_minutes = MainPanel:get_argument_value(407) -- 0 to 1
-- Radar altimeter RV-5
		local RV_5_RALT = MainPanel:get_argument_value(58) -- 0 to 1
		local RV_5_DangerRALT_index = MainPanel:get_argument_value(59) -- 0 to 1
		local RV_5_DangerRALT_lamp = MainPanel:get_argument_value(63) -- 0 to 1
		local RV_5_warning_flag = MainPanel:get_argument_value(62) -- 0 to 1
-- Radar altimeter RV-5
		local RV_5_2_RALT = MainPanel:get_argument_value(396) -- 0 to 1
		local RV_5_2_DangerRALT_index = MainPanel:get_argument_value(397) -- 0 to 1
		local RV_5_2_DangerRALT_lamp = MainPanel:get_argument_value(401) -- 0 to 1
		local RV_5_2_warning_flag = MainPanel:get_argument_value(400) -- 0 to 1
-- variometer
		local Variometer = MainPanel:get_argument_value(74) -- -1 to 1
		local Variometer_sideslip = MainPanel:get_argument_value(76) -- -1 to 1
		local Variometer_turn = MainPanel:get_argument_value(75) -- -1 to 1
		local Variometer_2 = MainPanel:get_argument_value(416) -- -1 to 1
		local Variometer_2_sideslip = MainPanel:get_argument_value(418) -- -1 to 1
		local Variometer_2_turn = MainPanel:get_argument_value(417) -- -1 to 1
-- KPP
		local KPP_1273K_roll = MainPanel:get_argument_value(38) -- -1 to 1
		local KPP_1273K_pitch = MainPanel:get_argument_value(31) -- -0.5 to 0.5
		local KPP_1273K_sideslip = MainPanel:get_argument_value(40) -- -1 to 1
		local KPP_Course_Deviation_Bar = MainPanel:get_argument_value(35) -- -1 to 1
		local KPP_Alt_Deviation_Bar = MainPanel:get_argument_value(34) -- -1 to 1
		local KPP_Glide_Beacon = MainPanel:get_argument_value(36) -- 0 to 1
		local KPP_Localizer_Beacon = MainPanel:get_argument_value(37) -- 0 to 1
		local KPP_Arretir = MainPanel:get_argument_value(29) -- 0 to 1
		local KPP_SDU_Roll_Fwd = MainPanel:get_argument_value(32) -- -1 to 1
		local KPP_SDU_Pitch_Fwd = MainPanel:get_argument_value(33) -- -1 to 1
-- KPP_2
		local KPP_1273K_2_roll = MainPanel:get_argument_value(375) -- -1 to 1
		local KPP_1273K2__pitch = MainPanel:get_argument_value(368) -- -0.5 to 0.5
		local KPP_1273K2__sideslip = MainPanel:get_argument_value(377) -- -1 to 1
		local KPP_2_Course_Deviation_Bar = MainPanel:get_argument_value(372) -- -1 to 1
		local KPP_2_Alt_Deviation_Bar = MainPanel:get_argument_value(371) -- -1 to 1
		local KPP_2_Glide_Beacon = MainPanel:get_argument_value(373) -- 0 to 1
		local KPP_2_Localizer_Beacon = MainPanel:get_argument_value(374) -- 0 to 1
		local KPP_2_Arretir = MainPanel:get_argument_value(366) -- 0 to 1
		local KPP_SDU_Roll_Aft = MainPanel:get_argument_value(369) -- -1 to 1
		local KPP_SDU_Pitch_Aft = MainPanel:get_argument_value(370) -- -1 to 1
-- NPP (HSI)
		local HSI_heading = MainPanel:get_argument_value(41) -- 1 to 0
		local HSI_commanded_course_needle = MainPanel:get_argument_value(42) -- 1 to 0
		local HSI_bearing_needle = MainPanel:get_argument_value(43) -- 0 to 1
		local HSI_Course_Deviation_Bar = MainPanel:get_argument_value(47) -- -0.8 to 0.8
		local HSI_Alt_Deviation_Bar = MainPanel:get_argument_value(45) -- -0.8 to 0.8
		local HSI_Glide_Beacon = MainPanel:get_argument_value(46) -- 0 to 1
		local HSI_Localizer_Beacon = MainPanel:get_argument_value(44) -- 0 to 1
-- NPP 2 (HSI)
		local HSI2_heading = MainPanel:get_argument_value(378) -- 1 to 0
		local HSI2_commanded_course_needle = MainPanel:get_argument_value(379) -- 0 to 1  error ??
		local HSI2_bearing_needle = MainPanel:get_argument_value(380) -- 0 to 1
		local HSI2_Course_Deviation_Bar = MainPanel:get_argument_value(384) -- -0.8 to 0.8
		local HSI2_Alt_Deviation_Bar = MainPanel:get_argument_value(382) -- -0.8 to 0.8
		local HSI2_Glide_Beacon = MainPanel:get_argument_value(383) -- 0 to 1
		local HSI2_Localizer_Beacon = MainPanel:get_argument_value(381) -- 0 to 1
--RSBN
		local RSBN_NAV_Chan = MainPanel:get_argument_value(189) -- 0 to 1
		local RSBN_LAND_Chan = MainPanel:get_argument_value(190) -- 0 to 1
		local RSBN_Range_100 = MainPanel:get_argument_value(66) -- 0 to 1
		local RSBN_Range_10 = MainPanel:get_argument_value(65) -- 0 to 1
		local RSBN_Range_1 = MainPanel:get_argument_value(64) -- 0 to 1
		local RSBN_Range_2_100 = MainPanel:get_argument_value(404) -- 0 to 1
		local RSBN_Range_2_10 = MainPanel:get_argument_value(403) -- 0 to 1
		local RSBN_Range_2_1 = MainPanel:get_argument_value(402) -- 0 to 1
		local RSBN_PanelLightsLmp = MainPanel:get_argument_value(580) -- 0 to 1
-- Altimeter Feet imperial
		local Altimeter_100_footPtr = MainPanel:get_argument_value(637) -- 0 to 1
		local Altimeter_10000_footCount = MainPanel:get_argument_value(632) -- 0 to 1
		local Altimeter_1000_footCount = MainPanel:get_argument_value(631) -- 0 to 1
		local Altimeter_100_footCount = MainPanel:get_argument_value(630) -- 0 to 1
		local pressure_setting_0 = MainPanel:get_argument_value(636) -- 0 to 1
		local pressure_setting_1 = MainPanel:get_argument_value(635) -- 0 to 1
		local pressure_setting_2 = MainPanel:get_argument_value(634) -- 0 to 1
		local pressure_setting_3 = MainPanel:get_argument_value(633) -- 0 to 1
-- Altimeter Feet instructor imperial
		local Altimeter_100_footPtr_2 = MainPanel:get_argument_value(737) -- 0 to 1
		local Altimeter_10000_footCount_2 = MainPanel:get_argument_value(732) -- 0 to 1
		local Altimeter_1000_footCount_2 = MainPanel:get_argument_value(731) -- 0 to 1
		local Altimeter_100_footCount_2 = MainPanel:get_argument_value(730) -- 0 to 1
		local pressure_setting_0_2 = MainPanel:get_argument_value(736) -- 0 to 1
		local pressure_setting_1_2 = MainPanel:get_argument_value(735) -- 0 to 1
		local pressure_setting_2_2 = MainPanel:get_argument_value(734) -- 0 to 1
-- Barometric altimeter VD-20
		local VD_20_km = MainPanel:get_argument_value(52) -- 0 to 1
		local VD_20_m = MainPanel:get_argument_value(53) -- 0 to 1
		local VD_20_km_Ind = MainPanel:get_argument_value(54) -- 0 to 1
		local VD_20_m_Ind = MainPanel:get_argument_value(55) -- 0 to 1
		local VD_20_PRESS = MainPanel:get_argument_value(56) -- 0 to 1
-- Barometric altimeter VD-20 instructor
		local VD_20_km_2 = MainPanel:get_argument_value(389) -- 0 to 1
		local VD_20_m_2 = MainPanel:get_argument_value(390) -- 0 to 1
		local VD_20_km_Ind_2 = MainPanel:get_argument_value(391) -- 0 to 1
		local VD_20_m_Ind_2 = MainPanel:get_argument_value(392) -- 0 to 1
		local VD_20_PRESS_2 = MainPanel:get_argument_value(393) -- 0 to 1
--AIRSPEED AND MACH
		local IAS = MainPanel:get_argument_value(49) 
		local TAS = MainPanel:get_argument_value(50) 
		local MACH = MainPanel:get_argument_value(51) -- 0 to 1
		local IAS_2 = MainPanel:get_argument_value(386) 
		local TAS_2 = MainPanel:get_argument_value(387) 
		local MACH_2 = MainPanel:get_argument_value(388) -- 0 to 1
-- RKL-41
		local RKL_41_needle = MainPanel:get_argument_value(77) 		-- 0 to 1
		local RKL_41_2_needle = MainPanel:get_argument_value(420) 	-- 0 to 1
		local RKL_41_Signal = MainPanel:get_argument_value(156) 	-- 0 to 1
		local RKL_41_2_Signal = MainPanel:get_argument_value(513) 	-- 0 to 1
		local KM_8_heading = MainPanel:get_argument_value(531) 		-- 0 to 1
		local KM_8_variation = MainPanel:get_argument_value(530) 	-- 1 to -1
-- electric interface
		local Voltmeter = MainPanel:get_argument_value(92) 		-- 0 to 1
		local Ampermeter = MainPanel:get_argument_value(93) 	-- 0 to 1
-- oxygen interface
		local FwdOxygenPressure = ValueConvert(MainPanel:get_argument_value(301),{0.0,	10.0,	150.0,	160.0},{0.0,	0.025,	0.925,	1.0})
		local FwdFlowBlinker = MainPanel:get_argument_value(302) 		-- 0 to 1
		local AftOxygenPressure = ValueConvert(MainPanel:get_argument_value(477),{0.0,	10.0,	150.0,	160.0},{0.0,	0.025,	0.925,	1.0})
		local AftFlowBlinker = MainPanel:get_argument_value(478) 		-- 0 to 1
-- accelerometer
		local Acceleration = MainPanel:get_argument_value(86) 		-- 0 to 1
		local AccelerationMin = MainPanel:get_argument_value(88) 	-- 0.31 to 0.695
		local AccelerationMax = MainPanel:get_argument_value(87) 	-- 0 to 1
		local CockpitAltFwd = MainPanel:get_argument_value(95) 		-- 0 to 1
		local CockpitAltAft = MainPanel:get_argument_value(550) 	-- 0 to 1
		local PressDiffFwd = MainPanel:get_argument_value(96) 	-- 0 to 1
		local PressDiffAft = MainPanel:get_argument_value(551) 	-- 0 to 1
---Hydro Pressure
		local MainHydro_PRESS = MainPanel:get_argument_value(198) 		-- 0 to 1
		local AuxHydro_PRESS = MainPanel:get_argument_value(200) 		-- 0 to 1
		local BrakeLMainHydro_PRESS = MainPanel:get_argument_value(98) 	-- 0 to 1
		local BrakeRMainHydro_PRESS = MainPanel:get_argument_value(99) 	-- 0 to 1
		local BrakeAuxHydro_PRESS = MainPanel:get_argument_value(100) 	-- 0 to 1
-- fuel and engines
		local Fuel_Quantity = MainPanel:get_argument_value(91) 	-- 0 to 1 simplyfied
		local Fan_RPM = MainPanel:get_argument_value(85) 		-- 0 to 1 simplyfied
		local Compressor_RPM = MainPanel:get_argument_value(84) -- 0 to 1 simplyfied
		local Oil_Temp = MainPanel:get_argument_value(83) 		-- 0 to 1 simplyfied
		local Oil_Press = MainPanel:get_argument_value(82) 		-- 0 to 1 simplyfied
		local Fuel_Press = MainPanel:get_argument_value(81) 	-- 0 to 1 simplyfied
		local Engine_Temp = MainPanel:get_argument_value(90) 	-- 0 to 1 simplyfied
		local EngineVibration = MainPanel:get_argument_value(94) 	-- 0 to 1
		local PitchTrimInd = MainPanel:get_argument_value(247) 	-- 1 to -1
-- fuel and engines 2
		local Fuel_Quantity_2 = MainPanel:get_argument_value(427) 	-- 0 to 1 simplyfied
		local Fan_RPM_2 = MainPanel:get_argument_value(425) 		-- 0 to 1 simplyfied
		local Compressor_RPM_2 = MainPanel:get_argument_value(424) 	-- 0 to 1 simplyfied
		local Oil_Temp_2 = MainPanel:get_argument_value(423) 		-- 0 to 1 simplyfied
		local Oil_Press_2 = MainPanel:get_argument_value(422) 		-- 0 to 1 simplyfied
		local Fuel_Press_2 = MainPanel:get_argument_value(421) 		-- 0 to 1 simplyfied
		local Engine_Temp_2 = MainPanel:get_argument_value(426) 	-- 0 to 1 simplyfied
-- lights system
		local FwdCptInstrumentLightsIntensity = MainPanel:get_argument_value(553) 	-- 0 to 1
		local CompassLightIntensity = MainPanel:get_argument_value(558) 	-- 0 to 1
		local EmergencyLightIntensity = MainPanel:get_argument_value(555) 	-- 0 to 1
		local AftCptInstrumentLightsIntensity = MainPanel:get_argument_value(559) 	-- 0 to 1
-- RKL-41 Radio Compass
		local FarNDBSelectorLamp = MainPanel:get_argument_value(561) 		-- 0 to 1
		local NearNDBSelectorLamp = MainPanel:get_argument_value(570) 		-- 0 to 1
		local FarNDBSelectorLamp_CPT2 = MainPanel:get_argument_value(564) 	-- 0 to 1
		local NearNDBSelectorLamp_CPT2 = MainPanel:get_argument_value(571) 	-- 0 to 1
		local RKL_FwdPanelLights = MainPanel:get_argument_value(563) 		-- 0 to 1
		local RKL_AftPanelLights = MainPanel:get_argument_value(566) 		-- 0 to 1
-- brake
	local BrakeHandle = MainPanel:get_argument_value(127) 		-- 0 to 1
	local BrakeHandle_CPT2 = MainPanel:get_argument_value(542) 		-- 0 to 1

	
	
		-- engine and oxigene instruments  >>> "SAI", "Pitch Adjust"
		
		SendData("715", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.4f,%.2f,%.2f,%.2f,%.3f,%.3f,%.2f, %.2f",
				Fuel_Quantity, --1
				Fan_RPM, --2
				Compressor_RPM, --3
				Oil_Temp, --4
				Oil_Press, --5
				Fuel_Press, --6
				Engine_Temp, --7
				EngineVibration, --8
			PitchTrimInd, --9
				Voltmeter, --10
				Ampermeter, --11
				MainHydro_PRESS, --12
				AuxHydro_PRESS, --13
				BrakeLMainHydro_PRESS, --14
				BrakeRMainHydro_PRESS, --15
				BrakeAuxHydro_PRESS, --16
				FwdOxygenPressure, --17
				FwdFlowBlinker, --18
			AftOxygenPressure, --19
			AftFlowBlinker, --20
			Fuel_Quantity_2, --21
			Fan_RPM_2, --22
			Compressor_RPM_2, --23
			Oil_Temp_2, --24
			Oil_Press_2, --25
			Fuel_Press_2, --26
			Engine_Temp_2, --27
			_LAST_ONE  -- Last one, do not delete this
		) )
		
	
	-- clock and voltimeter  	>>> "ADI", "Glide Slope Indicator"
	SendData("27", string.format("%.3f,%.3f,%.3f,%.2f,%.3f,%3f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.3f, %.3f,%.2f",
			CLOCK_currtime_hours, --1
			CLOCK_currtime_minutes, --2
			CLOCK_seconds_meter_time_seconds, --3
			CLOCK_flight_time_meter_status, --4
			CLOCK_flight_hours, --5
			CLOCK_flight_minutes, --6
			CLOCK_seconds_meter_time_minutes, --7
		CLOCK_2_currtime_hours, --8
		CLOCK_2_currtime_minutes, --9
		CLOCK_2_seconds_meter_time_seconds, --10
		CLOCK_2_flight_time_meter_status, --11
		CLOCK_2_flight_hours, --12
		CLOCK_2_flight_minutes, --13
		CLOCK_2_seconds_meter_time_minutes, --14
		Voltmeter, --15
		_LAST_ONE  -- Last one, do not delete this
	) )
			

	-- RALT, variometer and RKL  	>>> "ADI", "Slip Ball"
	SendData("24", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.3f,%.2f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
			RV_5_RALT, --1
			RV_5_DangerRALT_index, --2
			RV_5_DangerRALT_lamp, --3
			RV_5_warning_flag, --4
		RV_5_2_RALT, --5
		RV_5_2_DangerRALT_index, --6
		RV_5_2_DangerRALT_lamp, --7
		RV_5_2_warning_flag, --8
			Variometer, --9 
			Variometer_sideslip, --10
			Variometer_turn, --11
		Variometer_2, --12
		Variometer_2_sideslip, --13
		Variometer_2_turn, --14
			RKL_41_needle, --15
		RKL_41_2_needle, --16
			RKL_41_Signal, --17
		RKL_41_2_Signal, --18
		RKL_FwdPanelLights, --19
		RKL_AftPanelLights, --20
		KM_8_heading, --21
		KM_8_variation, --22
		_LAST_ONE  -- Last one, do not delete this
	) )
		
		-- Kpp >>>	"ADI", "Pitch Steering Bar Offset"
	SendData("21", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.3f,%.2f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
			KPP_1273K_roll, --1
			KPP_1273K_pitch, --2
		KPP_1273K_sideslip, --3
			KPP_Course_Deviation_Bar, --4
			KPP_Alt_Deviation_Bar, --5
		KPP_Glide_Beacon, --6
		KPP_Localizer_Beacon, --7
			KPP_Arretir, --8
			KPP_SDU_Roll_Fwd, --9 
			KPP_SDU_Pitch_Fwd, --10
		KPP_1273K_2_roll, --11
		KPP_1273K2__pitch, --12
		KPP_1273K2__sideslip, --13
		KPP_2_Course_Deviation_Bar, --14
		KPP_2_Alt_Deviation_Bar, --15
		KPP_2_Glide_Beacon, --16
		KPP_2_Localizer_Beacon, --17
		KPP_2_Arretir, --18
		KPP_SDU_Roll_Aft, --19
		KPP_SDU_Pitch_Aft, --20
		_LAST_ONE  -- Last one, do not delete this
	) )
	

	
	-- HSI and RSBN >>>	"ADI", "Bank Steering Bar Offset"
	SendData("20", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.3f,%.2f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
			HSI_heading, --1
			HSI_commanded_course_needle, --2
			HSI_bearing_needle, --3
			HSI_Course_Deviation_Bar, --4
			HSI_Alt_Deviation_Bar, --5
			HSI_Glide_Beacon, --6
			HSI_Localizer_Beacon, --7
		HSI2_heading, --8
		HSI2_commanded_course_needle, --9 
		HSI2_bearing_needle, --10
		HSI2_Course_Deviation_Bar, --11
		HSI2_Alt_Deviation_Bar, --12
		HSI2_Glide_Beacon, --13
		HSI2_Localizer_Beacon, --14
			RSBN_NAV_Chan, --15
			RSBN_LAND_Chan, --16
			RSBN_Range_100, --17
			RSBN_Range_10, --18
			RSBN_Range_1, --19
		RSBN_Range_2_100, --20
		RSBN_Range_2_10, --21
		RSBN_Range_2_1, --22
		RSBN_PanelLightsLmp, --23
		_LAST_ONE  -- Last one, do not delete this
	) )
	

	
	-- altimeter and speed >>>	"UHF Radio", "Fequency"
	SendData("2000", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.3f,%.2f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
		Altimeter_100_footPtr, --1
		Altimeter_10000_footCount, --2
		Altimeter_1000_footCount, --3
		Altimeter_100_footCount, --4
		pressure_setting_0, --5
		pressure_setting_1, --6
		pressure_setting_2, --7
		pressure_setting_3, --8
		Altimeter_100_footPtr_2, --9 
		Altimeter_10000_footCount_2, --10
		Altimeter_1000_footCount_2, --11
		Altimeter_100_footCount_2, --12
		pressure_setting_0_2, --13
		pressure_setting_1_2, --14
		pressure_setting_2_2, --15
			IAS, --16
			TAS, --17
			MACH, --18
		IAS_2, --19
		TAS_2, --20
		MACH_2, --21
		_LAST_ONE  -- Last one, do not delete this
	) )
	
	
	
	-- Barometric altimeter, accelerometer >>>	"ADI", "Turn Needle"
	SendData("23", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.3f,%.2f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
			VD_20_km, --1
			VD_20_m, --2
			VD_20_km_Ind, --3
			VD_20_m_Ind, --4
			VD_20_PRESS, --5
		VD_20_km_2, --6
		VD_20_m_2, --7
		VD_20_km_Ind_2, --8
		VD_20_m_Ind_2, --9 
		VD_20_PRESS_2, --10
			Acceleration, --11
			AccelerationMin, --12
			CockpitAltFwd, --13
		CockpitAltAft, --14
			PressDiffFwd, --15
		PressDiffAft, --16
			AccelerationMax, --17
		FwdCptInstrumentLightsIntensity, --18
		CompassLightIntensity, --19
		EmergencyLightIntensity, --20
		AftCptInstrumentLightsIntensity, --21
		NearNDBSelectorLamp_CPT2, --22
		_LAST_ONE  -- Last one, do not delete this
	) )
	
		SendData("296", string.format("%.3f", mainPanelDevice:get_argument_value(209) )) 	-- GMK-1AE GMC Latitude Selector Knob 209 axis 0.02 > "Light System", "Flood Light"  296
		SendData("46", string.format("%.1d", mainPanelDevice:get_argument_value(15)) )    -- BreakdownFinishedLampFwd              >  "HSI", "Bearing Flag" 

		
		FlushData()
				
end

---------------------------------------------------------- END OF L39 HIGH IMPORTANCE VALUES
-------------------------------------------------------------------------------------------------







------------------------------------------
-- FA18C exported as a A10C aircraft    --
-- 	  by Capt Zeen				        --
------------------------------------------



-- Pointed to by ProcessHighImportance, if the player aircraft is an F/A-18C (Using A10C interface)



function Process_FA18C_HighImportance(mainPanelDevice)


	local _LAST_ONE = 0 -- used to mark the end of the tables	
	local MainPanel = GetDevice(0)
	

	-- Electric Interface
	local VoltmeterU = MainPanel:get_argument_value(400) 	-- 0 to 1
	local VoltmeterE = MainPanel:get_argument_value(401) 	-- 0 to 1
	-- Hydraulic Interface
	local HydIndLeft = MainPanel:get_argument_value(310) 	-- 0 to 1
	local HydIndRight = MainPanel:get_argument_value(311) 	-- 0 to 1
	local HydIndBrake = MainPanel:get_argument_value(242) 	-- 0 to 1
	-- Gear Interface
	local EmergGearDownHandle = MainPanel:get_argument_value(228) 	-- 0 to 1
	local EmergParkBrakeHandle = MainPanel:get_argument_value(240) 	-- 0 to 1
	-- Standby Pressure Altimeter AAU-52/A
	local Altimeter_100_footPtr = MainPanel:get_argument_value(218) 	-- 0 to 1
	local Altimeter_10000_footCount = MainPanel:get_argument_value(220) 	-- 0 to 1
	local Altimeter_1000_footCount = ValueConvert(MainPanel:get_argument_value(219),{-1.0, 0.0, 0.0, 10.0},{0.9, 1.0, 0.0, 1.0})
	local pressure_setting_0 = MainPanel:get_argument_value(221) 	-- 0 to 1
	local pressure_setting_1 = MainPanel:get_argument_value(222) 	-- 0 to 1
	local pressure_setting_2 = ValueConvert(MainPanel:get_argument_value(223),{26, 31},{0.0, 1.0})
	-- Indicated Airspeed Indicator AVU-35/A
	local Airspeed = MainPanel:get_argument_value(217) 	-- 0 to 1
	-- Vertical Speed Indicator AVU-53/A
	local Variometer = ValueConvert(MainPanel:get_argument_value(225),{-6000.0, -4000.0, -3000.0, -2000.0, -1000.0, -500.0, 0.0, 500.0, 1000.0, 2000.0, 3000.0, 4000.0, 6000.0},{   -1.0,   -0.83,   -0.73,  -0.605,   -0.40,  -0.22, 0.0,  0.22,   0.40,  0.605,   0.73,   0.83,    1.0})
	-- Clock
	local CLOCK_currtime_hours = MainPanel:get_argument_value(278) 	-- 0 to 1
	local CLOCK_currtime_minutes = MainPanel:get_argument_value(279) 	-- 0 to 1
	local CLOCK_elapsed_time_minutes = MainPanel:get_argument_value(281) 	-- 0 to 1
	local CLOCK_elapsed_time_seconds = MainPanel:get_argument_value(280) 	-- 0 to 1
	-- ID-2163/A
	local Min_Height_Indicator_ID2163A = MainPanel:get_argument_value(287) 	-- 0 to 1
	local Altitude_Pointer_ID2163A = MainPanel:get_argument_value(286) 	-- 0 to 1
	local OFF_Flag_ID2163A = MainPanel:get_argument_value(288) 	-- 0 to 1
	local Red_Lamp_ID2163A = MainPanel:get_argument_value(290) 	-- 0 to 1
	local Green_Lamp_ID2163A = MainPanel:get_argument_value(289) 	-- 0 to 1
	-- SAI
	local SAI_Pitch = MainPanel:get_argument_value(205) 	-- -1 to 1
	local SAI_Bank = MainPanel:get_argument_value(206) 	-- -1 to 1
	local SAI_attitude_warning_flag = MainPanel:get_argument_value(209) 	-- 0 to 1
	local SAI_manual_pitch_adjustment = MainPanel:get_argument_value(210) 	-- -1 to 1
	local SAI_SlipBall = MainPanel:get_argument_value(207) 	-- -1 to 1
	local SAI_RateOfTurn = MainPanel:get_argument_value(208) 	-- -1 to 1
	-- Cockpit Pressure Altimeter
	local CockpitPressureAltimeter = MainPanel:get_argument_value(285)
	local Windfold_pull = MainPanel:get_argument_value(296)
	-- additional axis values:
	local IFEI_Lights = MainPanel:get_argument_value(174) 
	local Cage_SAI = MainPanel:get_argument_value(214) 
	local AAU52_Pressure = MainPanel:get_argument_value(224) 
	local ALR67_AUDIO = MainPanel:get_argument_value(262) 
	local VOX_Volume = MainPanel:get_argument_value(357) 
	local ID2163A_Low_altitude= MainPanel:get_argument_value(291) 
	local KY58_FillSw= MainPanel:get_argument_value(446) 
	local RADAR_SW= MainPanel:get_argument_value(440)
	local EMERGENCY_BRAKE= MainPanel:get_argument_value(241)
	local FRICTION = MainPanel:get_argument_value(504)  
	-- RWR panel lights
	local FAIL_light = MainPanel:get_argument_value(264)   -- FAIL light
	local BIT_light = MainPanel:get_argument_value(265)   -- BIT light
	local ENABLE_light = MainPanel:get_argument_value(267)   -- ENABLE light
	local OFFSET_light = MainPanel:get_argument_value(268)   -- OFFSET light
	local SPECIAL_UP_light = MainPanel:get_argument_value(270)   -- SPECIAL UP light
	local SPECIAL_light = MainPanel:get_argument_value(271)   -- SPECIAL light
	local LIMIT_light = MainPanel:get_argument_value(273)   -- LIMIT light
	local DISPLAY_light = MainPanel:get_argument_value(274)   -- DISPLAY light
	local ON_light = MainPanel:get_argument_value(276)   -- ON light
	
	
	--    >>> "SAI", "Pitch Adjust"							F18 instruments
	SendData("715", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.1f",
		VoltmeterU, --1
		VoltmeterE, --2
		HydIndLeft, --3
		HydIndRight, --4
		HydIndBrake, --5
		EmergGearDownHandle, --6
		EmergParkBrakeHandle, --7
		Altimeter_100_footPtr, --8
		Altimeter_10000_footCount, --9
		Altimeter_1000_footCount, --10
		pressure_setting_0, --11
		pressure_setting_1, --12
		pressure_setting_2, --13
		Airspeed, --14
		Variometer, --15
		Windfold_pull, --16
		_LAST_ONE  -- Last one, do not delete this
	) )
		
	
	-- >>> "ADI", "Glide Slope Indicator"					F18 clock and SAI  
	SendData("27", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
		CLOCK_currtime_hours,--1
		CLOCK_currtime_minutes,--2
		CLOCK_elapsed_time_minutes,--3
		CLOCK_elapsed_time_seconds,--4
		Min_Height_Indicator_ID2163A,--5
		Altitude_Pointer_ID2163A,--6
		OFF_Flag_ID2163A,--7
		Red_Lamp_ID2163A,--8
		Green_Lamp_ID2163A,--9
		SAI_Pitch,--10
		SAI_Bank,--11
		SAI_attitude_warning_flag,--12
		SAI_manual_pitch_adjustment, --13
		SAI_SlipBall,--14
		SAI_RateOfTurn,--15
		CockpitPressureAltimeter,--16
		_LAST_ONE  -- Last one, do not delete this
	) )
			

	 -->>>	"ADI", "Turn Needle"                          F18 adittional axis values
	SendData("23", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
		IFEI_Lights,--1
		Cage_SAI,--2
		AAU52_Pressure,--3
		ALR67_AUDIO,--4
		VOX_Volume,--5
		ID2163A_Low_altitude,--6
		KY58_FillSw,--7
		RADAR_SW,--8
		EMERGENCY_BRAKE, --9
		FRICTION, --10
		_LAST_ONE  -- Last one, do not delete this
	) )
	
	
	-->>>	"ADI", "Slip Ball"                           F18 RWR lights
	SendData("24", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f",
		FAIL_light,--1
		BIT_light,--2
		ENABLE_light,--3
		OFFSET_light,--4
		SPECIAL_UP_light,--5
		SPECIAL_light,--6
		LIMIT_light,--7
		DISPLAY_light,--8
		ON_light, --9
		_LAST_ONE  -- Last one, do not delete this
	) )
	
	
	
	--SendData("21", string.format("%s", table.concat(IFEI_Textures_table,", ") ) )   	    >>> "ADI", "Pitch Steering Bar Offset"
	--SendData("20", string.format("%s", table.concat(UFC_table,", ") ) )        >>> "ADI", "Bank Steering Bar Offset"
	-- >>>	"UHF Radio", "Fequency"
	--	SendData("2000", string.format("%.3f,",

	--		_LAST_ONE  -- Last one, do not delete this
	--) )
	

		
	FlushData()
	
end

---------------------------------------------------------- END OF FA18C HIGH IMPORTANCE VALUES
-------------------------------------------------------------------------------------------------












------------------------------------------
-- MIG-21 exported as a A10C aircraft   --
-- 	  by Capt Zeen and slicker55        --
------------------------------------------

-- Pointed to by ProcessHighImportance, if the player aircraft is an MIG-21 (Using A10C interface)


function ProcessMIG21HighImportance ()


		local _LAST_ONE = 0 -- used to mark the end of the tables	
		local MainPanel = GetDevice(0)
		
		-- Pilot console instruments
		local ENGINE_TEMPERATURE = MainPanel:get_argument_value(51)
		local FUEL_METER = MainPanel:get_argument_value(52)
		local ENGINE_RPM = ValueConvert(MainPanel:get_argument_value(50),{ 0.0, 1, 110 },{ 0.0, 0.2, 1.0 })
		local ENGINE_RPM2 = MainPanel:get_argument_value(670)
		local IAS_indicator = ValueConvert(MainPanel:get_argument_value(100),{ 0.0, 83.33, 166.67, 250.0, 333.34, 416.67, 555.55 },{ 0.0, 0.15, 0.30, 0.45, 0.60, 0.75, 1.0 })
		local COMPRESSED_AIR_main = MainPanel:get_argument_value(413)
		local COMPRESSED_AIR_aux = MainPanel:get_argument_value(414)
		local OXYGENE_instrument_IK52 = MainPanel:get_argument_value(59)
		local OXYGENE_instrument_M2000 = MainPanel:get_argument_value(58)
		local OIL_PRESSURE = MainPanel:get_argument_value(627)
		local ACCELEROMETER = MainPanel:get_argument_value(110)
		local MAX_G = MainPanel:get_argument_value(113)
		local MIN_G = MainPanel:get_argument_value(114)
		local UUA_indicator = ValueConvert(MainPanel:get_argument_value(105),{ -0.1745, 0.0, 0.6108 },{ -0.2857, 0.0, 1.0 })
		local KONUS_efficiency = MainPanel:get_argument_value(625)
		local KONUS_UPES_3_instrument = MainPanel:get_argument_value(66)
		local ARU_3G_instrument = MainPanel:get_argument_value(64)
		local TAS_indicator = ValueConvert(MainPanel:get_argument_value(101),{ 0.0, 8, 63, 135, 206, 350 },{ 0.0, 0.20, 0.309, 0.49, 0.67, 1.00 })
		local M_indicator = ValueConvert(MainPanel:get_argument_value(102),{ 0.0,  13,  67,  180,  208, 350 },{ 0.0, 0.202, 0.312, 0.6, 0.66, 1.00 })
		local DC_BUS_V_needle = MainPanel:get_argument_value(124)
		local RADIO_ALTIMETER_indicator = ValueConvert(MainPanel:get_argument_value(103),{ 63, 81, 88, 115, 129, 154, 160, 173, 179, 186, 193, 212, 229, 246, 257, 277, 294, 300, 301, },{ 0.0, 0.041, 0.07, 0.103, 0.13, 0.181, 0.21, 0.245, 0.260, 0.298, 0.325, 0.472, 0.58, 0.680, 0.732, 0.807, 0.867, 0.909, 1.0 })
		local DA200_TurnNeedle = MainPanel:get_argument_value(107)
		local DA200_VerticalVelocity = ValueConvert(MainPanel:get_argument_value(106),{37, 55, 75, 100, 110, 145, 180, 215, 250, 260, 285, 305, 323},{ -1.0, -0.878, -0.754, -0.575, -0.504, -0.256, 0.0, 0.256, 0.505, 0.571, 0.751, 0.871, 1.0 })
		local variometer_set = MainPanel:get_argument_value(261)
			DA200_VerticalVelocity= DA200_VerticalVelocity + (variometer_set*20)  -- adjust VVI + variometer set value
		local DA200_SLIPBALL = MainPanel:get_argument_value(31)
		local H_indicator_needle_m = MainPanel:get_argument_value(104)
		local H_indicator_needle_km = MainPanel:get_argument_value(112)
		local GIDRO_PRESS_P_needle = ValueConvert(MainPanel:get_argument_value(126),{ 210, 60 },{ 0.0, 1.0 })
		local GIDRO_PRESS_S_needle = ValueConvert(MainPanel:get_argument_value(125),{ 60, 210 },{ 0.0, 1.0 })
		local DC_BUS_ISA_K = MainPanel:get_argument_value(55)
		local COCKPIT_PRESSURE_ALTIMETER = ValueConvert(MainPanel:get_argument_value(655),{ 0, 320 },{ 0.0, 1.0 })
		local COCKPIT_PRESSURE = ValueConvert(MainPanel:get_argument_value(656),{ 270, 290, 319, 251, 216, 180, 150, 120, 90, 55 },{ -1.0, -0.56, -0.27, 0.0, 0.17, 0.35, 0.50, 0.66, 0.82, 1.0 })
		local ARK_RSBN_needle = MainPanel:get_argument_value(36)
		local KSI_course_set_needle = MainPanel:get_argument_value(68)
		local KPP_Bank = MainPanel:get_argument_value(108)
		local KPP_Pitch = MainPanel:get_argument_value(109)
		local KPP_Set = MainPanel:get_argument_value(260)
			KPP_Pitch = KPP_Pitch + (KPP_Set/9) -- adjust KPP pitch + KPP_set value
		local Needle_ora_sec = MainPanel:get_argument_value(117)
		local Needle_ora = MainPanel:get_argument_value(115)
		local Needle_ora_perc = MainPanel:get_argument_value(116)
		local Needle_ora_min_kis = MainPanel:get_argument_value(121)
		local Needle_ora_sec_kis = MainPanel:get_argument_value(122)
		local RSBN_distance_meter_Hundreds = MainPanel:get_argument_value(355)
		local RSBN_distance_meter_Tens = MainPanel:get_argument_value(356)
		local RSBN_distance_meter_Singles = MainPanel:get_argument_value(357)
		local Gearbrake_needle1 = MainPanel:get_argument_value(56)
		local Gearbrake_needle2 = MainPanel:get_argument_value(57)
		local IAS_Nr = MainPanel:get_argument_value(100)
		local KSI_course_indicator = MainPanel:get_argument_value(111)
		local RSBN_NPP_kurs_needle = MainPanel:get_argument_value(590)
		local RSBN_NPP_glisada_needle = MainPanel:get_argument_value(589)
		local RSBN_KPP_kurs_director = MainPanel:get_argument_value(565)
		local RSBN_KPP_glisada_director = MainPanel:get_argument_value(566)
		local ENGINE_OXYGENE_manometer = MainPanel:get_argument_value(61)
		local AltimeterPressure = ValueConvert(MainPanel:get_argument_value(262),{ 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79 },{ -1.000, -0.889, -0.770, -0.668, -0.557, -0.450, -0.333, -0.222, -0.118, -0.007, 0.313, 0.639, 1.000 })
		local Clock_status_bar = MainPanel:get_argument_value(118)*10

	
		
		local sw_table =
		{			
			[1] = convert_sw (MainPanel:get_argument_value(165)),			-- Battery On/Off
			[2] = convert_sw (MainPanel:get_argument_value(155)),			-- Battery Heat On/Off
			[3] = convert_sw (MainPanel:get_argument_value(166)),			-- DC Generator On/Off
			[4] = convert_sw (MainPanel:get_argument_value(169)),			-- AC Generator On/Off
			[5] = convert_sw (MainPanel:get_argument_value(153)),			-- PO-750 Inverter #1 On/Off
			[6] = convert_sw (MainPanel:get_argument_value(154)),			-- PO-750 Inverter #2 On/Off
			[7] = convert_sw (MainPanel:get_argument_value(164)),			-- Emergency Inverter
			[8] = convert_sw (MainPanel:get_argument_value(162)),			-- Giro, NPP, SAU, RLS Signal, KPP Power On/Off
			[9] = convert_sw (MainPanel:get_argument_value(163)),			-- DA-200 Signal, Giro, NPP, RLS, SAU Power On/Off
			[10] = convert_sw (MainPanel:get_argument_value(159)),			-- Fuel Tanks 3rd Group, Fuel Pump
			[11] = convert_sw (MainPanel:get_argument_value(160)),			-- Fuel Tanks 1st Group, Fuel Pump
			[12] = convert_sw (MainPanel:get_argument_value(161)),			-- Drain Fuel Tank, Fuel Pump
			[13] = convert_sw (MainPanel:get_argument_value(302)),			-- APU On/Off
			[14] = convert_sw (MainPanel:get_argument_value(288)),			-- Engine Cold / Normal Start
			[15] = convert_sw (MainPanel:get_argument_value(301)),			-- Engine Emergency Air Start			
			[16] = convert_sw (MainPanel:get_argument_value(229)),			-- Pitot tube Selector Main/Emergency
			[17] = convert_sw (MainPanel:get_argument_value(279)),			-- Pitot tube/Periscope/Clock Heat
			[18] = convert_sw (MainPanel:get_argument_value(280)),			-- Secondary Pitot Tube Heat				
			[19] = convert_sw (MainPanel:get_argument_value(308)),			-- Anti surge doors - Auto/Manual
			[20] = convert_sw (MainPanel:get_argument_value(300)),			-- Afterburner/Maximum Off/On
			[21] = convert_sw (MainPanel:get_argument_value(320)),			-- Emergency Afterburner Off/On				
			[22] = convert_sw (MainPanel:get_argument_value(303)),			-- Fire Extinguisher Off/On
			[23] = convert_sw (MainPanel:get_argument_value(324)),			-- Fire Extinguisher Cover					
			[24] = convert_sw (MainPanel:get_argument_value(173)),			-- Radio System On/Off
			[25] = convert_sw (MainPanel:get_argument_value(208)),			-- Radio / Compass
			[26] = convert_sw (MainPanel:get_argument_value(209)),			-- Squelch On/Off
			[27] = convert_sw (MainPanel:get_argument_value(174)),			-- ARK On/Off
			[28] = convert_sw (MainPanel:get_argument_value(197)),			-- ARK Mode - Antenna / Compass
			[29] = convert_sw (MainPanel:get_argument_value(176)),			-- RSBN On/Off
			[30] = convert_sw (MainPanel:get_argument_value(340)),			-- RSBN / ARK	
			[31] = convert_sw (MainPanel:get_argument_value(367)),			-- RSBN Bearing
			[32] = convert_sw (MainPanel:get_argument_value(368)),			-- RSBN Distance
			[33] = convert_sw (MainPanel:get_argument_value(179)),			-- SAU On/Off
			[34] = convert_sw (MainPanel:get_argument_value(180)),			-- SAU Pitch On/Off	
			[35] = convert_sw (math.floor((MainPanel:get_argument_value(323)*2)-1)),  -- Landing Lights Off/Taxi/Land - 3 posiciones 0,5
			[36] = convert_sw (MainPanel:get_argument_value(202)),			-- SPO-10 RWR On/Off
			[37] = convert_sw (MainPanel:get_argument_value(188)),			-- SRZO IFF Coder/Decoder On/Off	
			[38] = convert_sw (MainPanel:get_argument_value(346)),			-- IFF System 'Type 81' On/Off
			[39] = convert_sw (MainPanel:get_argument_value(190)),			-- Emergency Transmitter Cover
			[40] = convert_sw (MainPanel:get_argument_value(191)),			-- Emergency Transmitter On/Off
			[41] = convert_sw (MainPanel:get_argument_value(427)),			-- SRZO Self Destruct Cover
			[42] = convert_sw (MainPanel:get_argument_value(200)),			-- SOD IFF On/Off	
			[43] = convert_sw (MainPanel:get_argument_value(207)),			-- Locked Beam On/Off
			[44] = convert_sw (MainPanel:get_argument_value(167)),			-- SPRD (RATO) System On/Off	
			[45] = convert_sw (MainPanel:get_argument_value(168)),			-- SPRD (RATO) Drop System On/Off	
			[46] = convert_sw (MainPanel:get_argument_value(252)),			-- SPRD (RATO) Start Cover
			[47] = convert_sw (MainPanel:get_argument_value(317)),       	-- SPRD (RATO)t Drop Cover
			[48] = string.format("%02.f", math.floor((MainPanel:get_argument_value(211)*20)+ 0.05)) -- Radio channel selector 20 channels from 0 to 19 - 0,0555
			-- warning 48 uses 2 characters
			
		}																
		
		local sw_table_2 =
		{			
			[1] = convert_sw (MainPanel:get_argument_value(299)),			-- ABS Off/On
			[2] = convert_sw (MainPanel:get_argument_value(238)),			-- Nosegear Brake Off/On
			[3] = convert_sw (MainPanel:get_argument_value(237)),			-- Emergency Brake
			[4] = convert_sw (MainPanel:get_argument_value(281)),			-- Nose Gear Emergency Release Handle
			[5] = convert_sw (MainPanel:get_argument_value(304)),			-- Drop Drag Chute Cover
			[6] = convert_sw (MainPanel:get_argument_value(172)),			-- Trimmer On/Off			
			[7] = convert_sw (MainPanel:get_argument_value(170)),			-- Nosecone On/Off
			[8] = convert_sw (MainPanel:get_argument_value(309)),			-- Nosecone Control - Manual/Auto
			[9] = convert_sw (MainPanel:get_argument_value(291)),			-- Engine Nozzle 2 Position Emergency Control				
			[10] = convert_sw (MainPanel:get_argument_value(171)),			-- Emergency Hydraulic Pump On/Off
			[11] = convert_sw (MainPanel:get_argument_value(319)),			-- Aileron Booster - Off/On
			[12] = convert_sw (MainPanel:get_argument_value(175)),			-- Radio Altimeter/Marker On/Off			
			[13] = convert_sw (MainPanel:get_argument_value(285)),			-- Helmet Air Condition Off/On
			[14] = convert_sw (MainPanel:get_argument_value(286)),			-- Emergency Oxygen Off/On					
			[15] = convert_sw (MainPanel:get_argument_value(287)),			-- Mixture/Oxygen
			[16] = convert_sw (MainPanel:get_argument_value(224)),			-- Canopy Emergency Release Handle
			[17] = convert_sw (MainPanel:get_argument_value(186)),			-- ASP Optical sight On/Off
			[18] = convert_sw (MainPanel:get_argument_value(241)),			-- ASP Main Mode - Manual/Auto
			[19] = convert_sw (MainPanel:get_argument_value(242)),			-- ASP Mode - Bombardment/Shooting
			[20] = convert_sw (MainPanel:get_argument_value(243)),			-- ASP Mode - Missiles-Rockets/Gun
			[21] = convert_sw (MainPanel:get_argument_value(244)),			-- ASP Mode - Giro/Missile	
			[22] = convert_sw (MainPanel:get_argument_value(249)),			-- Pipper On/Off
			[23] = convert_sw (MainPanel:get_argument_value(250)),			-- Fix net On/Off
			[24] = convert_sw (MainPanel:get_argument_value(181)),			-- Missiles - Rockets Heat On/Off
			[25] = convert_sw (MainPanel:get_argument_value(182)),			-- Missiles - Rockets Launch On/Off
			[26] = convert_sw (MainPanel:get_argument_value(183)),			-- Pylon 1-2 Power On/Off
			[27] = convert_sw (MainPanel:get_argument_value(184)),			-- Pylon 3-4 Power On/Off
			[28] = convert_sw (MainPanel:get_argument_value(185)),			-- GS-23 Gun On/Off
			[29] = convert_sw (MainPanel:get_argument_value(187)),			-- Guncam On/Off
			[30] = convert_sw (MainPanel:get_argument_value(277)),			-- Tactical Drop Cover
			[31] = convert_sw (MainPanel:get_argument_value(278)),			-- Tactical Drop
			[32] = convert_sw (MainPanel:get_argument_value(275)),			-- Emergency Missile/Rocket Launcher Cover
			[33] = convert_sw (MainPanel:get_argument_value(256)),			-- Drop Wing Fuel Tanks Cover
			[34] = convert_sw (MainPanel:get_argument_value(269)),			-- Drop Payload - Outer Pylons Cover
			[35] = convert_sw (MainPanel:get_argument_value(271)),			-- Drop Payload - Inner Pylons Cover
			[36] = convert_sw (MainPanel:get_argument_value(230)),			-- Weapon Mode - Air/Ground	
			[37] = convert_sw (MainPanel:get_argument_value(383)),			-- Release Weapon Cover
			[38] = convert_sw (MainPanel:get_argument_value(306)),			-- Helmet Heat - Manual/Auto
			[39] = convert_sw (MainPanel:get_argument_value(193)),			-- SARPP-12 Flight Data Recorder On/Off
			[40] = convert_sw (MainPanel:get_argument_value(632)),			-- Radar emission - Cover
			[41] = convert_sw (MainPanel:get_argument_value(633)),			-- Radar emission - Combat/Training
			[42] = convert_sw (MainPanel:get_argument_value(638)),			-- 1.7 Mach Test Cover (note: clickable.lua shows this as PNT_439 in error)
			[43] = convert_sw (MainPanel:get_argument_value(387)),			-- Emergency Jettison - RN24 Nuke Panel
			[44] = convert_sw (MainPanel:get_argument_value(388)),			-- Emergency Jettison Armed / Not Armed - RN24 Nuke Panel
			[45] = convert_sw (MainPanel:get_argument_value(389)),			-- Tactical Jettison - RN24 Nuke Panel
			[46] = convert_sw (MainPanel:get_argument_value(390)),			-- Special AB / Missile-Rocket-Bombs-Cannon - RN24 Nuke Panel
			[47] = convert_sw (MainPanel:get_argument_value(391)),			-- Brake Chute - RN24 Nuke Panel
			[48] = convert_sw (MainPanel:get_argument_value(392)),			-- Detonation Air / Ground - RN24 Nuke Panel
			[49] = convert_sw (MainPanel:get_argument_value(393)),			-- On / Off - SPS 141 CMS Panel
			[50] = convert_sw (MainPanel:get_argument_value(394)),			-- Transmit / Receive (Active/Passive) - SPS 141 CMS Panel
			[51] = string.format("%02.f", math.floor((MainPanel:get_argument_value(235)*10)+0.2))  -- Weapon Selector - 11 positions 0.1
			-- warning 51 uses 2 characters
			
		}

		
		
		local sw_table_3 =
		{	
			[1] = convert_sw (MainPanel:get_argument_value(395)),			-- Program I / II - SPS 141 CMS Panel
			[2] = convert_sw (MainPanel:get_argument_value(396)),			-- Continuous / Impulse - SPS 141 CMS Panel
			[3] = convert_sw (MainPanel:get_argument_value(398)),			-- Dispenser Auto / Manual - SPS 141 CMS Panel
			[4] = convert_sw (math.floor((MainPanel:get_argument_value(399)*2)-1)), -- Off / Parallel / Full - SPS 141 CMS Panel - 3 posiciones 0,5
			[5] = convert_sw (MainPanel:get_argument_value(400)),			-- Manual Activation button - Cover - SPS 141 CMS Panel
			[6] = convert_sw (MainPanel:get_argument_value(420)),			-- On / Off - UPK Panel
			[7] = convert_sw (MainPanel:get_argument_value(341)),			-- SAU - Landing - Command
			[8] = convert_sw (MainPanel:get_argument_value(342)),			-- SAU - Landing - Auto
			[9] = convert_sw (MainPanel:get_argument_value(343)),			-- SAU - Stabilize
			[10] = convert_sw (MainPanel:get_argument_value(348)),			-- SAU Reset/Off
			[11] = convert_sw (MainPanel:get_argument_value(344)),			-- SAU Preset - Limit Altitude
			[12] = convert_sw (MainPanel:get_argument_value(177)),			-- KPP Main/Emergency (Giro/Aux Giro switch)
			[13] = convert_sw (MainPanel:get_argument_value(254)),			-- Marker Far/Near
			[14] = convert_sw (MainPanel:get_argument_value(239)),			-- Canopy Anti Ice
			[15] = convert_sw (math.floor((MainPanel:get_argument_value(205)*2)-1)),       -- Radar Off/Prep/On - 3 posiciones 0,5
			[16] = (math.floor((MainPanel:get_argument_value(284)*7.142)+ 0.1))+1,         -- Dangerous Altitude Warning Set - 8 posiciones 0,14	
			[17] = convert_sw (math.floor((MainPanel:get_argument_value(231)*2)-1)),       -- Weapon Mode - IR Missile/Neutral/SAR Missile - 3 posiciones 0,5
			[18] = convert_sw (math.floor((MainPanel:get_argument_value(240)*2)-1)),       -- RSBN Mode Land/Navigation/Descend - 3 posiciones 0,5
			[19] = convert_sw (math.floor((MainPanel:get_argument_value(201)*2)-1)),       -- SOD Wave Selector 3/1/2 - 3 posiciones 0,5
			[20] = convert_sw (math.floor((MainPanel:get_argument_value(206)*2)-1)),       -- Low Altitude Off/Comp/On - 3 posiciones 0,5
			[21] = (math.floor((MainPanel:get_argument_value(204)*4)+ 0.1))+1,             -- SOD Modes - 5 posiciones 0,25
			[22] = (math.floor((MainPanel:get_argument_value(189)*7.142)+ 0.1))+1,         -- ARK Zone - 8 posiciones 0,14
			[23] = convert_sw (MainPanel:get_argument_value(296)),                         -- ARU System - Low Speed/Neutral/High Speed - 3 posiciones 1.00, 0.00, -1.00
			[24] = (math.floor((MainPanel:get_argument_value(213)*10)+0.1)),               -- ARK Change - 9 posiciones 0,1 (starting at 0,1)
			[25] = convert_sw (MainPanel:get_argument_value(295)),                         -- ARU System - Manual/Auto
			[26] = convert_sw (MainPanel:get_argument_value(293)),                         -- SPS System Off/On
			[27] = convert_sw (MainPanel:get_argument_value(178)),                         -- NPP (FDS)On/Off
			[28] = convert_sw (MainPanel:get_argument_value(421)),			               -- MAIN GUN / UPK Guns (ON UPK23-250 PANEL)
			[29] = (math.floor((MainPanel:get_argument_value(194)*3.030)+ 0.1))+1,          -- Navigation Lights Off/Min/Med/Max - 4 posiciones 0,33
										
		} 
		
		
		
		-- right rpm

		local sw_table_4 =
		{	
			[1] = convert_sw (MainPanel:get_argument_value(256)),	   -- Drop Wing Fuel Tanks Cover
			[2] = convert_sw (MainPanel:get_argument_value(265)),      -- Mech clock left lever
			[3] = convert_sw (MainPanel:get_argument_value(268)),      -- Mech clock right lever
			[4] = convert_sw (MainPanel:get_argument_value(326)),      -- Gear Handle Fixator
			[5] = convert_sw (MainPanel:get_argument_value(327)),      -- Gear Up/Neutral/Down - 3 posiciones 1.00, 0.00, -1.00
			[6] = convert_sw (MainPanel:get_argument_value(329)),      -- Secure Canopy Lever
			[7] = convert_sw (MainPanel:get_argument_value(328)),      -- Hermetize Canopy Lever
			[8] = convert_sw (math.floor(MainPanel:get_argument_value(1)+0.5)),        -- Canopy Open/Close
			[9] = string.format ( "%02.f", math.floor((MainPanel:get_argument_value(192)*13)+ 0.05))  -- SRZO Channel Selector - 13 Channels from 0 - 12
			-- warning 9 uses 2 characters
			
		} 
		
		
		
		local lamps_table =
		{	
			[1] = convert_lamp (MainPanel:get_argument_value(513)),    -- OIL_LIGHT
			[2] = convert_lamp (MainPanel:get_argument_value(542)),    -- SORC
			[3] = convert_lamp (MainPanel:get_argument_value(500)),    -- LOW_ALT_LIGHT
			[4] = convert_lamp (MainPanel:get_argument_value(546)),	   -- SAU_stabilization_LIGHT
			[5] = convert_lamp (MainPanel:get_argument_value(544)),	   -- SAU_landing_COMMAND_LIGHT
			[6] = convert_lamp (MainPanel:get_argument_value(545)),	   -- SAU_landing_AUTO_LIGHT
			[7] = convert_lamp (MainPanel:get_argument_value(547)),	   -- SAU_privedenie_LIGHT
			[8] = convert_lamp (MainPanel:get_argument_value(584)),	   -- MISSILE_55_1_LIGHT
			[9] = convert_lamp (MainPanel:get_argument_value(585)),	   -- MISSILE_55_2_LIGHT
			[10] = convert_lamp (MainPanel:get_argument_value(586)),   -- MISSILE_62_LIGHT
			[11] = convert_lamp (MainPanel:get_argument_value(538)),   -- ASP_LAUNCH_LIGHT
			[12] = convert_lamp (MainPanel:get_argument_value(540)),   -- ASP_DISENGAGE_LIGHT
			[13] = convert_lamp (MainPanel:get_argument_value(503)),   -- FUEL_450
			[14] = convert_lamp (MainPanel:get_argument_value(63)),	   -- TACTICAL_DROP_ARMED_LIGHT
			[15] = convert_lamp (MainPanel:get_argument_value(553)),   -- RADAR_ERROR_LIGHT
			[16] = convert_lamp (MainPanel:get_argument_value(554)),   -- RADAR_LOW_ALT_LIGHT
			[17] = convert_lamp (MainPanel:get_argument_value(555)),   -- RADAR_FIX_BEAM_LIGHT
			[18] = convert_lamp (MainPanel:get_argument_value(607)),   -- SRZO_ON (EOD)_LIGHT
			[19] = convert_lamp (MainPanel:get_argument_value(608)),   -- SRZO_CODE_LIGHT
			[20] = convert_lamp (MainPanel:get_argument_value(609)),   -- SRZO_CIPH (DEC)_LIGHT
			[21] = convert_lamp (MainPanel:get_argument_value(549)),   -- RSBN_dalnost_korekcija_LIGHT
			[22] = convert_lamp (MainPanel:get_argument_value(534)),   -- FIRE_LIGHT
			[23] = convert_lamp (MainPanel:get_argument_value(537)),   -- AOA_WARNING_LIGHT
			[24] = convert_lamp (MainPanel:get_argument_value(550)),   -- GUN_gotovn_LIGHT
			[25] = convert_lamp (MainPanel:get_argument_value(606)),   -- SOD_ANSWER
			[26] = convert_lamp (MainPanel:get_argument_value(516)),   -- MARKER_LIGHT
			[27] = convert_lamp (MainPanel:get_argument_value(601)),   -- SPO_L_F (SPO LEFT TOP) LIGHT
			[28] = convert_lamp (MainPanel:get_argument_value(602)),   -- SPO_R_F (SPO RIGHT TOP) LIGHT
			[29] = convert_lamp (MainPanel:get_argument_value(603)),   -- SPO_R_B (SPO RIGHT BOTTOM) LIGHT
			[30] = convert_lamp (MainPanel:get_argument_value(604)),   -- SPO_L_B (SPO LEFT BOTTOM) LIGHT
			[31] = convert_lamp (MainPanel:get_argument_value(605)),   -- SPO_MUTED(SPO TEST) LIGHT
			[32] = convert_lamp (MainPanel:get_argument_value(517)),   -- KONUS_LIGHT
			[33] = convert_lamp (MainPanel:get_argument_value(518)),   -- STABILISATOR_LIGHT
			[34] = convert_lamp (MainPanel:get_argument_value(519)),   -- TRIMMER_LIGHT
			[35] = convert_lamp (MainPanel:get_argument_value(509)),   -- START_DEVICE_ZAZIG_LIGHT
			[36] = convert_lamp (MainPanel:get_argument_value(510)),   -- DC_GEN_LIGHT
			[37] = convert_lamp (MainPanel:get_argument_value(511)),   -- AC_GEN_LIGHT
			[38] = convert_lamp (MainPanel:get_argument_value(512)),   -- NOZZLE_LIGHT
			[39] = convert_lamp (MainPanel:get_argument_value(514)),   -- CHECK_BUSTER_PRESSURE
			[40] = convert_lamp (MainPanel:get_argument_value(515)),   -- CHECK_HYDRAULIC_PRESSURE
			[41] = convert_lamp (MainPanel:get_argument_value(505)),   -- FUEL_PODW
			[42] = convert_lamp (MainPanel:get_argument_value(502)),   -- FUEL_1GR
			[43] = convert_lamp (MainPanel:get_argument_value(504)),   -- FUEL_3GR
			[44] = convert_lamp (MainPanel:get_argument_value(568)),   -- RSBN_KPP_tangaz_blinker (RED T LIGHT)
			[45] = convert_lamp (MainPanel:get_argument_value(526)),   -- PYLON_1_ON_LIGHT
			[46] = convert_lamp (MainPanel:get_argument_value(527)),   -- PYLON_2_ON_LIGHT
			[47] = convert_lamp (MainPanel:get_argument_value(528)),   -- PYLON_3_ON_LIGHT
			[48] = convert_lamp (MainPanel:get_argument_value(529)),   -- PYLON_4_ON_LIGHT
			[49] = convert_lamp (MainPanel:get_argument_value(524)),   -- RATO_L_LIGHT
			[50] = convert_lamp (MainPanel:get_argument_value(501)),   -- FUEL_PODC
			[51] = convert_lamp (MainPanel:get_argument_value(525)),   -- RATO_R_LIGHT
			[52] = convert_lamp (MainPanel:get_argument_value(506)),   -- FUEL_RASHOD (DISP TK EMPTY)
			[53] = convert_lamp (MainPanel:get_argument_value(507)),   -- FORSAZ_1_LIGHT (AFTERBURNER)
			[54] = convert_lamp (MainPanel:get_argument_value(508)),   -- FORSAZ_2_LIGHT (SECOND AFTERBURNER)
			[55] = convert_lamp (MainPanel:get_argument_value(523)),   -- CENTRAL_PYLON_LIGHT
			[56] = convert_lamp (MainPanel:get_argument_value(530)),   -- PYLON_1_OFF_LIGHT(UB POD 1 EMPTY)
			[57] = convert_lamp (MainPanel:get_argument_value(531)),   -- PYLON_2_OFF_LIGHT(UB POD 2 EMPTY)
			[58] = convert_lamp (MainPanel:get_argument_value(532)),   -- PYLON_3_OFF_LIGHT(UB POD 3 EMPTY)
			[59] = convert_lamp (MainPanel:get_argument_value(533)),   -- PYLON_4_OFF_LIGHT(UB POD 4 EMPTY)
			[60] = convert_lamp (MainPanel:get_argument_value(536)),   -- GIRO_ARRETIR (CAGE VERT RED LIGHT)
			[61] = convert_lamp (MainPanel:get_argument_value(535)),   -- KPP_ARRETIR_light (RED LIGHT MARKED APPETNP)
			[62] = convert_lamp (MainPanel:get_argument_value(541)),   -- CANOPY_WARNG_LIGHT
			[63] = convert_lamp (MainPanel:get_argument_value(9)),     -- GEAR_NOSE_UP_LIGHT
			[64] = convert_lamp (MainPanel:get_argument_value(12)),    -- GEAR_NOSE_DOWN_LIGHT
			[65] = convert_lamp (MainPanel:get_argument_value(10)),    -- GEAR_LEFT_UP_LIGHT
			[66] = convert_lamp (MainPanel:get_argument_value(13)),    -- GEAR_LEFT_DOWN_LIGHT
			[67] = convert_lamp (MainPanel:get_argument_value(11)),    -- GEAR_RIGHT_UP_LIGHT
			[68] = convert_lamp (MainPanel:get_argument_value(14)),    -- GEAR_RIGHT_DOWN_LIGHT
			[69] = convert_lamp (MainPanel:get_argument_value(522)),   -- AIRBRAKE_LIGHT
			[70] = convert_lamp (MainPanel:get_argument_value(521)),   -- FLAPS_LIGHT
			[71] = convert_lamp (MainPanel:get_argument_value(520)),   -- CHECK_GEAR_LIGHT
			[72] = convert_lamp (MainPanel:get_argument_value(581)),   -- IAB_LIGHT_1 (RN24 PANEL 'LOADED' LIGHT)
			[73] = convert_lamp (MainPanel:get_argument_value(582)),   -- IAB_LIGHT_2 (RN24 PANEL 'ARMED' LIGHT)
			[74] = convert_lamp (MainPanel:get_argument_value(583)),   -- IAB_LIGHT_3 (RN24 PANEL 'FUSE ON' LIGHT)
			[75] = convert_lamp (MainPanel:get_argument_value(594)),   -- SPS_LAUNCH(SPS 141 PANEL 'LAUNCH' LIGHT)
			[76] = convert_lamp (MainPanel:get_argument_value(592)),   -- SPS_WORKS (SPS 141 PANEL 'READY' LIGHT)
			[77] = convert_lamp (MainPanel:get_argument_value(593)),   -- SPS_ILLUMINATION (SPS 141 PANEL 'SIGNAL' LIGHT)
			[78] = convert_lamp (MainPanel:get_argument_value(701)),   -- GUV_LAUNCH (UPK23-250 PANEL 'STATUS' LIGHT)
			[79] = convert_lamp (MainPanel:get_argument_value(560)),   -- RADAR_JAMMED (HORIZ LEFT 'JAMMING' - RED LIGHT)
			[80] = convert_lamp (MainPanel:get_argument_value(571)),   -- RADAR_19A_1 (CMS 'C' LIGHT) 
			[81] = convert_lamp (MainPanel:get_argument_value(572)),   -- ADAR_19A_2(CMS 'O N' LIGHT) 
			[82] = convert_lamp (MainPanel:get_argument_value(573)),   -- RADAR_19A_3 (CMS 'T E' LIGHT) 
			[83] = convert_lamp (MainPanel:get_argument_value(574)),   -- RADAR_19A_4 (CMS 'WEATH' LIGHT)
			[84] = convert_lamp (MainPanel:get_argument_value(575)),   -- RADAR_19A_5(CMS 'IFF' LIGHT) 
			[85] = convert_lamp (MainPanel:get_argument_value(576)),   -- RADAR_19A_6 (CMS 'LOW' LIGHT) 
			[86] = convert_lamp (MainPanel:get_argument_value(577)),   -- RADAR_19A_7 (CMS 'SELF TEST' LIGHT)
			[87] = convert_lamp (MainPanel:get_argument_value(578)),   -- RADAR_19A_8 (CMS 'RESET' LIGHT) 
			[88] = convert_lamp (MainPanel:get_argument_value(558)),   -- RADAR_LAUNCH (VERTICAL TOP - RED LIGHT)
			[89] = convert_lamp (MainPanel:get_argument_value(559)),   -- RADAR_MISSILE_HEAD_RDY (VERTICAL BOTTOM - RED LIGHT)
			[90] = convert_lamp (MainPanel:get_argument_value(561)),   -- RADAR_BROKEN (HORIZ RIGHT - RED LIGHT)
			[91] = convert_lamp (MainPanel:get_argument_value(562)),   -- RADAR_DISENGAGE(ROUND RED LIGHT)
			[92] = convert_lamp (MainPanel:get_argument_value(539)),   -- ASP_TGT_ACQUIRED_LIGHT(ROUND GREEN LIGHT)
			[93] = convert_lamp (MainPanel:get_argument_value(60)),    -- OXYGENE_instrument_IK52_blinking_lungs
			[94] = convert_lamp (MainPanel:get_argument_value(587)),   -- RSBN_NPP_kurs_blinker (WHITE COURSE LIGHT)
			[95] = convert_lamp (MainPanel:get_argument_value(588)),   -- RSBN_NPP_glisada_blinker (WHITE GLIDESLOPE LIGHT)
			[96] = convert_lamp (MainPanel:get_argument_value(567))    -- RSBN_KPP_kren_blinker (RED K LIGHT)
			
			} 
		
		



	----------------------------------------------------------
	---- ok, now lets send all this MIG-21 data across A10C interface to Helios
	----------------------------------------------------------			
	
	
	-- gauges and instruments  >>> "SAI", "Pitch Adjust"
	SendData("715", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f, %.2f,%.2f,%.2f,%.4f,%.2f,%.2f,%.2f,%.3f,%.3f,%.2f, %.2f",
		ENGINE_TEMPERATURE, --1
		FUEL_METER, --2
		ENGINE_RPM, --3
		ENGINE_RPM2, --4
		IAS_indicator, --5
		COMPRESSED_AIR_main, --6
		COMPRESSED_AIR_aux, --7
		OXYGENE_instrument_IK52, --8
		OXYGENE_instrument_M2000, --9
		OIL_PRESSURE, --10
		ACCELEROMETER, --11
		MAX_G, --12
		MIN_G, --13
		UUA_indicator, --14
		KONUS_efficiency, --15
		KONUS_UPES_3_instrument, --16
		ARU_3G_instrument, --17
		TAS_indicator, --18
		M_indicator, --19
		DC_BUS_V_needle, --20
		_LAST_ONE  -- Last one, do not delete this
	) )
					
			
		
	-- gauges and instruments  	>>> "ADI", "Glide Slope Indicator"
	SendData("27", string.format("%.2f,%.1f,%.2f,%.2f,%.2f,%.f,%.3f,%.3f,%.3f,%.3f, %.3f,%.3f,%.3f,%.3f, %.3f,%.2f",
		RSBN_distance_meter_Hundreds, --1
		RSBN_distance_meter_Tens, --2
		RSBN_distance_meter_Singles, --3
		Gearbrake_needle1, --4
		Gearbrake_needle2, --5
		IAS_Nr, --6
		KSI_course_indicator, --7
		RSBN_NPP_kurs_needle, --8
		RSBN_NPP_glisada_needle, --9
		RSBN_KPP_kurs_director, --10
		RSBN_KPP_glisada_director, --11
		KPP_Pitch, --12
		ENGINE_OXYGENE_manometer, --13
		AltimeterPressure, --14
		Clock_status_bar, --15
		_LAST_ONE  -- Last one, do not delete this
	) )
			
			
	-- gauges and instruments  	>>> "ADI", "Slip Ball"
	SendData("24", string.format("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.2f,%.3f, %.3f,%.3f,%.3f,%.3f,%.2f,%.2f,%.2f,%.2f,%.2f,%.2f",
		RADIO_ALTIMETER_indicator, --1
		DA200_TurnNeedle, --2
		DA200_VerticalVelocity, --3
		DA200_SLIPBALL, --4
		H_indicator_needle_m, --5
		H_indicator_needle_km, --6
		GIDRO_PRESS_P_needle, --7
		GIDRO_PRESS_S_needle, --8
		DC_BUS_ISA_K, --9 
		COCKPIT_PRESSURE_ALTIMETER, --10
		COCKPIT_PRESSURE, --11
		ARK_RSBN_needle, --12
		KSI_course_set_needle, --13
		KPP_Bank, --14
		Needle_ora_sec, --15
		Needle_ora, --16
		Needle_ora_perc, --17
		Needle_ora_min_kis, --18
		Needle_ora_sec_kis, --19
		_LAST_ONE  -- Last one, do not delete this
	) )
		
			
	-- switches and lamps tables exported on pure networvalues from A10C				
	SendData("269", string.format("%s", table.concat(lamps_table,"") ) )    -- lamps table	    >>> "HARS", "SYN-IND Sync Needle"
	SendData("23", string.format("%s", table.concat(sw_table,"") ) )		-- switches table 1 >>>	"ADI", "Turn Needle"
	SendData("2000", string.format("%s", table.concat(sw_table_2,"") ) )	-- switches table 2 >>>	"UHF Radio", "Fequency"
	SendData("20", string.format("%s", table.concat(sw_table_3,"") ) )		-- switches table 3 >>>	"ADI", "Bank Steering Bar Offset"
	SendData("21", string.format("%s", table.concat(sw_table_4,"") ) )		-- switches table 4 >>>	"ADI", "Pitch Steering Bar Offset"
	--flaps			
	SendData("628", string.format("%.1f", MainPanel:get_argument_value(311) ) )		-- Flaps Neutral 311 2 > "TISL", "Enter" 628 --
	SendData("630", string.format("%.1f", MainPanel:get_argument_value(312) ) )		-- Flaps Take-Off 312 2 > "TISL", "OverTemp" 630 --
	SendData("632", string.format("%.1f", MainPanel:get_argument_value(313) ) )		-- Flaps Landing 313 2 > "TISL", "Bite" 632 --
	SendData("634", string.format("%.1f", MainPanel:get_argument_value(314) ) )		-- Flaps Reset buttons 314 btn > "TISL", "Track" 634 --
	--axis	
	SendData("171", string.format("%.3f", MainPanel:get_argument_value(210) ) )		-- Radio Volume  210 axis 0.1 >  "UHF Radio", "Volume" 171
	SendData("221", string.format("%.3f", MainPanel:get_argument_value(198) ) )		-- ARK Sound  198 axis 0.1 > "Intercom", "INT Volume" 221
	SendData("223", string.format("%.3f", MainPanel:get_argument_value(345) ) )		-- RSBN Sound  345 axis 0.1 > "Intercom", "FM Volume" 223 
	SendData("225", string.format("%.3f", MainPanel:get_argument_value(612) ) )		-- Cockpit Texts Back-light  612 axis 0.1 +300 dwn> "Intercom", "VHF Volume"  225
	SendData("227", string.format("%.3f", MainPanel:get_argument_value(156) ) )		-- Instruments Back-light  156 axis 0.1 +300 dwn>   "Intercom", "UHF Volume"  227
	SendData("229", string.format("%.3f", MainPanel:get_argument_value(157) ) )		-- Main Red Lights  157 axis 0.1 +300 dwn>          "Intercom", "AIM Volume"  229
	SendData("231", string.format("%.3f", MainPanel:get_argument_value(222) ) )		-- Main White Lights  222 axis 0.1 +300 dwn>        "Intercom", "IFF Volume"  231
	SendData("233", string.format("%.3f", MainPanel:get_argument_value(225) ) )		-- SPO-10 Volume  	225 axis 0.1 > "Intercom", "ILS Volume" 233 
	SendData("235", string.format("%.3f", MainPanel:get_argument_value(623) ) )		-- Radar Polar Filter 623 axis 0.1 > "Intercom", "TCN Volume" 235 
	SendData("636", string.format("%.3f", MainPanel:get_argument_value(236) ) )		-- Nosecone manual position controller 236 axis 0.05 > "TISL", "TISL Code Wheel 1" 636 
	SendData("238", string.format("%.3f", MainPanel:get_argument_value(263) ) )		-- NPP Course set 263 axis 0.1 > "Intercom", "Master Volume" 238
	SendData("288", string.format("%.3f", MainPanel:get_argument_value(245) ) )		-- Target Size 245 axis 0.1 >                      "Light System", "Formation Lights"            288 
	SendData("290", string.format("%.3f", MainPanel:get_argument_value(246) ) )		-- Intercept Angle 246 axis 0.1 >                  "Light System", "Engine Instrument Lights"    290 
	SendData("292", string.format("%.3f", MainPanel:get_argument_value(247) ) )		-- Scale Backlights control 247 axis 0.1 >         "Light System", "Flight Instruments Lights"   292 
	SendData("293", string.format("%.3f", MainPanel:get_argument_value(248) ) )		-- Pipper light control 248 axis 0.1 >             "Light System", "Auxillary instrument Lights" 293 
	SendData("296", string.format("%.3f", MainPanel:get_argument_value(251) ) )		-- Fix Net light control 251 axis 0.1 >            "Light System", "Flood Light"                 296 
	SendData("297", string.format("%.3f", MainPanel:get_argument_value(348) ) )		-- TDC Range / Pipper Span control 384 axis 0.1 >  "Light System", "Console Lights"              297 
	SendData("193", string.format("%.3f", MainPanel:get_argument_value(297) ) )		-- Missile Seeker Sound  297 axis 0.1 > "Light System", "Refuel Status Indexer Brightness" 193 	
	SendData("642", string.format("%.3f", MainPanel:get_argument_value(223) ) )		-- Main Gears Emergency Release Handle 223 axis 0.2 > "TISL Code Wheel 4" 642 aaaaaaaaaa
	SendData("277", string.format("%.3f", MainPanel:get_argument_value(267) ) )		-- Mech clock right lever  267 axis  0.05 -015 0.15 > "Environmental Control", "Canopy Defog" 277 --
	SendData("192", string.format("%.3f", MainPanel:get_argument_value(261) ) )		-- variometer Set  261 axis lim 0.0001   (-1,1) > "Autopilot", "Yaw Trim" 192  --
	--others
	SendData("624", string.format("%.3f", MainPanel:get_argument_value(351) ) )		-- RSBN Channel Selector - 99 positions 0 - 99 > "TISL", "Altitude above target tens of thousands of feet" 624 
	SendData("626", string.format("%.3f", MainPanel:get_argument_value(352) ) )		-- PRMG Channel Selector - 99 positions 0 - 99 >"TISL", "Altitude above target thousands of feet" 626 
	SendData("780", string.format("%.1d", MainPanel:get_argument_value(202) ) )		-- SPO-10 RWR On/Off 202 2 > "KY-58 Secure Voice", "Delay" 780 --	
	SendData("784", string.format("%.1d", MainPanel:get_argument_value(227) ) )		-- SPO-10 Night / Day  	227 2 > "KY-58 Secure Voice", "Power Switch" 784 --		
	SendData("170", string.format("%.1d", MainPanel:get_argument_value(326) ) )		-- Gear Handle Fixator 326 2 > "UHF Radio", "Squelch" 170 --
	SendData("105", string.format("%.1d", MainPanel:get_argument_value(327) ) )		-- Gear Up/Neutral/Down 327 multi sw 3 1.0 > "Fire System", "Discharge Switch" 105 ----------- -1 0 1
	SendData("540", string.format("%.1d", MainPanel:get_argument_value(611) ) )		-- SRZO_ERROR lamp > "AOA Indexer", "High Indicator" 540
	

	FlushData()
end


--------------------------------------------------------------------- End of MIG-21 exports   -----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------










-- Pointed to by ProcessHighImportance, if the player aircraft is something else
function ProcessNoHighImportance(mainPanelDevice)
end


-----------------------------------------------------
-- LOW IMPORTANCE EXPORTS                          --
-- done every gExportLowTickInterval export events --
-----------------------------------------------------

-- Pointed to by ProcessLowImportance, if the player aircraft is an AV-8B

function ProcessAV8BLowImportance(mainPanelDevice)
 
    SendData(2001, string.format("%.0f",mainPanelDevice:get_argument_value(253) * 1000+mainPanelDevice:get_argument_value(254) * 100+mainPanelDevice:get_argument_value(255) * 10))     -- Engine Duct
    SendData(2002, string.format("%.0f",mainPanelDevice:get_argument_value(256) * 10000+mainPanelDevice:get_argument_value(257) * 1000+mainPanelDevice:get_argument_value(258) * 100+mainPanelDevice:get_argument_value(259) * 10))     -- Engine RPM
    SendData(2003, string.format("%.0f",mainPanelDevice:get_argument_value(260) * 1000+mainPanelDevice:get_argument_value(261) * 100+mainPanelDevice:get_argument_value(262) * 10))    -- Engine FF
    SendData(2004, string.format("%.0f",mainPanelDevice:get_argument_value(263) * 1000+mainPanelDevice:get_argument_value(264) * 100+mainPanelDevice:get_argument_value(265) * 10)) -- Engine JPT
    SendData(2005, string.format("%.0f",mainPanelDevice:get_argument_value(267) * 100+mainPanelDevice:get_argument_value(268) * 10)) -- Engine Stab
    SendData(2006, string.format("%.0f",mainPanelDevice:get_argument_value(269) * 100+mainPanelDevice:get_argument_value(270) * 10)) -- Engine H2O
    SendData(2019, string.format("%.4f",mainPanelDevice:get_argument_value(386) * 100+mainPanelDevice:get_argument_value(387) * 10)) -- SMC Fuze
    SendData(2020, string.format("%.0f",mainPanelDevice:get_argument_value(392) * 1000+mainPanelDevice:get_argument_value(393) * 100+mainPanelDevice:get_argument_value(394) * 10))    -- SMC Interval
    SendData(2022, string.format("%.0f",mainPanelDevice:get_argument_value(389) * 100+mainPanelDevice:get_argument_value(390) * 10))    -- SMC Quantity
    SendData(2021, string.format("%.0f",mainPanelDevice:get_argument_value(391) * 10))    -- SMC Mult
    SendData(2010, string.format("%.0f",mainPanelDevice:get_argument_value(367) * 10000+mainPanelDevice:get_argument_value(368) * 1000+mainPanelDevice:get_argument_value(369) * 100+mainPanelDevice:get_argument_value(370) * 10))    -- Fuel Total
    SendData(2011, string.format("%.0f",mainPanelDevice:get_argument_value(371) * 10000+mainPanelDevice:get_argument_value(372) * 1000+mainPanelDevice:get_argument_value(373) * 100+mainPanelDevice:get_argument_value(374) * 10))    -- Fuel Left Tank
    SendData(2012, string.format("%.0f",mainPanelDevice:get_argument_value(375) * 10000+mainPanelDevice:get_argument_value(376) * 1000+mainPanelDevice:get_argument_value(377) * 100+mainPanelDevice:get_argument_value(378) * 10))    -- Fuel Right Tank
    SendData(2013, string.format("%.0f",mainPanelDevice:get_argument_value(381) * 10000+mainPanelDevice:get_argument_value(382) * 1000+mainPanelDevice:get_argument_value(383) * 100+mainPanelDevice:get_argument_value(384) * 10))    -- Fuel Bingo
    SendData(2014, string.format("%.0f",mainPanelDevice:get_argument_value(455) * 100+mainPanelDevice:get_argument_value(456) * 10))    -- Flap Position
    SendData(2015, string.format("%.0f",mainPanelDevice:get_argument_value(550) * 1000+mainPanelDevice:get_argument_value(551) * 100+mainPanelDevice:get_argument_value(552) * 10))    -- Pressure Brake
    SendData(2016, string.format("%.0f",mainPanelDevice:get_argument_value(553) * 1000+mainPanelDevice:get_argument_value(554) * 100+mainPanelDevice:get_argument_value(555) * 10))    -- Pressure Hyd 1
    SendData(2017, string.format("%.0f",mainPanelDevice:get_argument_value(556) * 1000+mainPanelDevice:get_argument_value(557) * 100+mainPanelDevice:get_argument_value(558) * 10))    -- Pressure Hyd 2
end

-- Pointed to by ProcessLowImportance, if the player aircraft is an A-10
function ProcessA10LowImportance(mainPanelDevice)
	-- Get Radio Frequencies
	local lUHFRadio = GetDevice(54)
	SendData(2000, string.format("%7.3f", lUHFRadio:get_frequency()/1000000))

	  -- TACAN Channel
	SendData(2263, string.format("%0.2f;%0.2f;%0.2f", mainPanelDevice:get_argument_value(263), -- corrected for new TACAN dcs 1.5.6
													  mainPanelDevice:get_argument_value(264), 
													  mainPanelDevice:get_argument_value(265)))
end


-- Pointed to by ProcessLowImportance, if the player aircraft is a Ka-50
function ProcessKa50LowImportance(mainPanelDevice)

	local lWeaponSystem = GetDevice(12)
	local lEKRAN = GetDevice(10)
	local l828Radio = GetDevice(49)
	local lCannonAmmoCount = " "
	local lStationNumbers = lWeaponSystem:get_selected_weapon_stations()
	local lStationCount = " "
	local lStationType = " "	
	local lTargetingPower = mainPanelDevice:get_argument_value(433)
	local lTrigger = mainPanelDevice:get_argument_value(615)

	if lTrigger == 0 then
		gKa50Trigger = 1
	end
	if lTrigger == -1 then
		gKa50Trigger = 0
	end

	if lTargetingPower == 1 then
		lCannonAmmoCount = string.format("%02d",string.match(lWeaponSystem:get_selected_gun_ammo_count() / 10,"(%d+)"))
	
		if #lStationNumbers ~= 0 and gKa50Trigger == 0 then
			lStationCount = 0
			for i=1,#lStationNumbers do
				lStationCount = lStationCount + lWeaponSystem:get_weapon_count_on_station(lStationNumbers[i])
			end
			
			lStationCount = string.format("%02d", lStationCount);
			
			lStationType = gKa50StationTypes[lWeaponSystem:get_weapon_type_on_station(lStationNumbers[1])]
			if lStationType == nil then
				lStationType = " "
			end
		end
	end

	local lEkranText = lEKRAN:get_actual_text_frame()
	local lEkranSendString = string.sub(lEkranText,1,8).."\n"..string.sub(lEkranText,12,19).."\n"..string.sub(lEkranText,23,30).."\n"..string.sub(lEkranText,34,41) 
	
	SendData("2001",lStationType)
	SendData("2002",lStationCount)
	SendData("2003",lCannonAmmoCount)
	SendData("2004",lEkranSendString)
	SendData("2017", string.format("%7.3f", l828Radio:get_frequency()/1000000))
	
	-- getting the UV26 data
    local li = parse_indication(7)  -- 7 for UV26
	if li then
		SendData("2005", string.format("%s",check(li.txt_digits)))
		else
		SendData("2005", string.format("%s","   "))
	end

   -- getting the EKRAN data
    local li = parse_indication(4)  -- 4 for EKRAN
	if li then
        SendData("2006", string.format("%s",check(li.txt_queue)))
        SendData("2007", string.format("%s",check(li.txt_failure)))
		SendData("2008", string.format("%s",check(li.txt_memory)))
		else
		SendData("2006", string.format("%s"," "))
        SendData("2007", string.format("%s"," "))
		SendData("2008", string.format("%s"," "))
	end

	-- getting the PVI display data
    local li = parse_indication(5)  -- 75 for PVI
	if li then
		SendData("2009", string.format("%s",check(li.txt_VIT)))
		SendData("2010", string.format("%s",check(li.txt_VIT_apostrophe1)))
        SendData("2011", string.format("%s",check(li.txt_VIT_apostrophe2)))
		SendData("2012", string.format("%s",check(li.txt_OIT_PPM)))
		SendData("2013", string.format("%s",check(li.txt_NIT)))
		SendData("2014", string.format("%s",check(li.txt_NIT_apostrophe1)))
		SendData("2015", string.format("%s",check(li.txt_NIT_apostrophe2)))
		SendData("2016", string.format("%s",check(li.txt_OIT_NOT)))
		else
		SendData("2009", string.format("%s"," "))
		SendData("2010", string.format("%s"," "))
        SendData("2011", string.format("%s"," "))
		SendData("2012", string.format("%s"," "))
		SendData("2013", string.format("%s"," "))
		SendData("2014", string.format("%s"," "))
		SendData("2015", string.format("%s"," "))
		SendData("2016", string.format("%s"," "))
	end
end






-- Pointed to by ProcessLowImportance, if the player aircraft is a SA342 (using ka50 interface)
function ProcessSA342LowImportance(mainPanelDevice)
																						-- SA342  >  KA50
	--Instruments Flags
	SendData("190", string.format("%.4f", mainPanelDevice:get_argument_value(29) ))		-- SA342 HA loc >
	SendData("207", string.format("%.4f", mainPanelDevice:get_argument_value(18) ))		-- SA342 HA GS >
	SendData("183", string.format("%.4f", mainPanelDevice:get_argument_value(108) ))	-- SA342 HSI px >
	SendData("182", string.format("%.4f", mainPanelDevice:get_argument_value(109) ))	-- SA342 HSI but >
	SendData("191", string.format("%.4f", mainPanelDevice:get_argument_value(107) ))	-- SA342 HSI cap >
	SendData("208", string.format("%.4f", mainPanelDevice:get_argument_value(208) ))	-- SA342 Gyro flags >
	--- Clock
	SendData("68", string.format("%.4f", mainPanelDevice:get_argument_value(41) ))		-- SA342 CLOCK_HOUR > Current Time Hours
	SendData("69", string.format("%.4f", mainPanelDevice:get_argument_value(43) ))		-- SA342 CLOCK_MINUTE > Current Time Minutes
	SendData("73", string.format("%.4f", mainPanelDevice:get_argument_value(44) ))		-- SA342 CLOCK_MINI > Stop Watch Minutes
	-- Qcomb
	SendData("137", string.format("%.4f", mainPanelDevice:get_argument_value(137) ))	-- SA342 QComb > Rear Tank Fuel Quantity
	-- voltmetre
	SendData("52", string.format("%.4f", mainPanelDevice:get_argument_value(14) ))		-- SA342 Voltmetre > Rotor RPM
	-- torque
	SendData("55", string.format("%1d", mainPanelDevice:get_argument_value(58) ))		-- SA342 torque test button >  laser ranger reset
	-- alarms panel
	SendData("59", string.format("%.4f", mainPanelDevice:get_argument_value(1) ))		-- SA342 TA_PITOT > Mechanical Left Gear Up Indicator
	SendData("47", string.format("%.4f", mainPanelDevice:get_argument_value(2) ))		-- SA342 TA_HMOT > Caution Under Fire Indicator
	SendData("48", string.format("%.4f", mainPanelDevice:get_argument_value(3) ))		-- SA342 TA_HBTP > Caution Lower Gear Indicator
	SendData("78", string.format("%.4f", mainPanelDevice:get_argument_value(4) ))		-- SA342 TA_HRAL > Caution Left Engine Max RPM Indicator
	SendData("79", string.format("%.4f", mainPanelDevice:get_argument_value(5) ))		-- SA342 TA_GENE > Caution Right Engine Max RPM Indicator
	SendData("80", string.format("%.4f", mainPanelDevice:get_argument_value(6) ))		-- SA342 TA_ALTER > Caution Ny Max	
	SendData("81", string.format("%.4f", mainPanelDevice:get_argument_value(7) ))		-- SA342 TA_BAT > Caution Left Engine Vibration Indicator	
	SendData("82", string.format("%.4f", mainPanelDevice:get_argument_value(8) ))		-- SA342 TA_PA > Caution Right Engine Vibration Indicator	
	SendData("83", string.format("%.4f", mainPanelDevice:get_argument_value(9) ))		-- SA342 TA_NAV > Caution IAS Max Indicator	
	SendData("84", string.format("%.4f", mainPanelDevice:get_argument_value(10) ))		-- SA342 TA_COMB > Caution Main Transmission Warning Indicator	
	SendData("85", string.format("%.4f", mainPanelDevice:get_argument_value(11) ))		-- SA342 TA_BPHY > Caution Fire Indicator	
	SendData("86", string.format("%.4f", mainPanelDevice:get_argument_value(12) ))		-- SA342 TA_LIM > Caution IFF Failure Indicator
	SendData("63", string.format("%.4f", mainPanelDevice:get_argument_value(13) ))		-- SA342 TA_FILT > Mechanical Nose Gear Up Indicator		
	-- other alarms
	SendData("62", string.format("%.4f", mainPanelDevice:get_argument_value(97) ))		-- SA342 RAlt_Alarm > Mechanical Right Gear Down Indicator
	SendData("170", string.format("%.4f", mainPanelDevice:get_argument_value(300) ))	-- SA342 Voyant_DEM > Left Warning Panel R-Alt Hold Indicator
	SendData("175", string.format("%.4f", mainPanelDevice:get_argument_value(301) ))	-- SA342 Voyant_RLT > Left Warning Panel Auto Hover
	SendData("172", string.format("%.4f", mainPanelDevice:get_argument_value(302) ))	-- SA342 Voyant_BLOC > Left Warning Panel Auto Descent
	SendData("165", string.format("%.4f", mainPanelDevice:get_argument_value(320) ))	-- SA342 Voyant_SUPP > Left Warning Panel ENR Nav On
	SendData("171", string.format("%.4f", mainPanelDevice:get_argument_value(321) ))	-- SA342 Voyant_CONV > Left Warning Panel ENR Course
	SendData("176", string.format("%.4f", mainPanelDevice:get_argument_value(322) ))	-- SA342 Voyant_FILTAS > Left Warning Panel Next WP"
	SendData("166", string.format("%.4f", mainPanelDevice:get_argument_value(201) ))	-- SA342 Voyant_TEST > Left Warning Panel ENR End
	SendData("164", string.format("%.4f", mainPanelDevice:get_argument_value(202) ))	-- SA342 Voyant_TRIM > Left Warning Panel AC-POS Cal. Data
	SendData("178", string.format("%.4f", mainPanelDevice:get_argument_value(203) ))	-- SA342 Voyant_BPP > Left Warning Panel Weap. Arm
	SendData("173", string.format("%.4f", mainPanelDevice:get_argument_value(127) ))	-- SA342 Voyant_BPP > Left Warning Panel cannon"
	-- PH panel
	SendData("392", string.format("%.4f", mainPanelDevice:get_argument_value(183) ))	-- SA342 PH_Bon_Light > "PUI-800", "Station 1 Present Lamp"
	SendData("393", string.format("%.4f", mainPanelDevice:get_argument_value(184) ))	-- SA342 PH_Mauvais_Light > "PUI-800", "Station 2 Present Lamp"
	SendData("394", string.format("%.4f", mainPanelDevice:get_argument_value(185) ))	-- SA342 PH_Alim_Light > "PUI-800", "Station 3 Present Lamp"
	SendData("177", string.format("%.4f", mainPanelDevice:get_argument_value(189) ))	-- SA342 PH_TestI_Light > canon <> lamp
	SendData("395", string.format("%.4f", mainPanelDevice:get_argument_value(190) ))	-- SA342 PH_Jour_Light > "PUI-800", "Station 4 Present Lamp"
	SendData("211", string.format("%.4f", mainPanelDevice:get_argument_value(192) ))	-- SA342 PH_TestII_Light > Xfeed valve open lamp
	SendData("388", string.format("%.4f", mainPanelDevice:get_argument_value(193) ))	-- SA342 PH_Nuit_Light > "PUI-800", "Station 1 Ready Lamp"
	SendData("389", string.format("%.4f", mainPanelDevice:get_argument_value(186) ))	-- SA342 PH_Pret_Light > "PUI-800", "Station 2 Ready Lamp
	SendData("390", string.format("%.4f", mainPanelDevice:get_argument_value(187) ))	-- SA342 PH_Autor_Light > "PUI-800", "Station 3 Ready Lamp"
	SendData("391", string.format("%.4f", mainPanelDevice:get_argument_value(188) ))	-- SA342 PH_Defaut_Light > "PUI-800", "Station 4 Ready Lamp"
	SendData("187", string.format("%.4f", mainPanelDevice:get_argument_value(191) ))	-- SA342 PH_ilum light > turbo gear lamp
	SendData("517", string.format("%.4f", mainPanelDevice:get_argument_value(178) ))	-- SA342 PH_Gisement into "ABRIS", "Brightness"
	-- Nadir
	SendData("312", string.format("%.1f", mainPanelDevice:get_argument_value(351)/5 ))		-- SA342 NADIR 0 > PVI 0
	SendData("303", string.format("%.1f", mainPanelDevice:get_argument_value(338)/5 ))		-- SA342 NADIR 1
	SendData("304", string.format("%.1f", mainPanelDevice:get_argument_value(339)/5 ))		-- SA342 NADIR 2
	SendData("305", string.format("%.1f", mainPanelDevice:get_argument_value(340)/5 ))		-- SA342 NADIR 3
	SendData("306", string.format("%.1f", mainPanelDevice:get_argument_value(342)/5 ))		-- SA342 NADIR 4
	SendData("307", string.format("%.1f", mainPanelDevice:get_argument_value(343)/5 ))		-- SA342 NADIR 5
	SendData("308", string.format("%.1f", mainPanelDevice:get_argument_value(344)/5 ))		-- SA342 NADIR 6
	SendData("309", string.format("%.1f", mainPanelDevice:get_argument_value(346)/5 ))		-- SA342 NADIR 7
	SendData("310", string.format("%.1f", mainPanelDevice:get_argument_value(347)/5 ))		-- SA342 NADIR 8
	SendData("311", string.format("%.1f", mainPanelDevice:get_argument_value(348)/5 ))		-- SA342 NADIR 9
	SendData("315", string.format("%.1f", mainPanelDevice:get_argument_value(333)/5 ))		-- SA342 NADIR_ENT
	SendData("519", string.format("%.1f", mainPanelDevice:get_argument_value(334)/5 ))		-- SA342 NADIR_DES
	SendData("316", string.format("%.1f", mainPanelDevice:get_argument_value(335)/5 ))		-- SA342 NADIR_AUX
	SendData("520", string.format("%.1f", mainPanelDevice:get_argument_value(336)/5 ))		-- SA342 NADIR_IC
	SendData("317", string.format("%.1f", mainPanelDevice:get_argument_value(337)/5 ))		-- SA342 NADIR_DOWN
	SendData("521", string.format("%.1f", mainPanelDevice:get_argument_value(341)/5 ))		-- SA342 NADIR_POL
	SendData("318", string.format("%.1f", mainPanelDevice:get_argument_value(345)/5 ))		-- SA342 NADIR_GEO
	SendData("313", string.format("%.1f", mainPanelDevice:get_argument_value(349)/5 ))		-- SA342 NADIR_POS
	SendData("314", string.format("%.1f", mainPanelDevice:get_argument_value(350)/5 ))		-- SA342 NADIR_GEL
	SendData("522", string.format("%.1f", mainPanelDevice:get_argument_value(352)/5 ))		-- SA342 NADIR_EFF
	SendData("324", string.format("%.1f", mainPanelDevice:get_argument_value(331)/2 ))		-- SA342 NADIR Mode
	SendData("357", string.format("%.1f", mainPanelDevice:get_argument_value(332)/2 ))		-- SA342 NADIR Parameter
	SendData("531", string.format("%.4f", mainPanelDevice:get_argument_value(330) ))		-- SA342 NADIR Light Intensity >  flight time seconds
	--RWR
	SendData("319", string.format("%.1f", mainPanelDevice:get_argument_value(149)/5 ))		-- SA342 RWR marquer
	SendData("320", string.format("%.1f", mainPanelDevice:get_argument_value(150)/5 ))		-- SA342 RWR page
	SendData("9", string.format("%1d", mainPanelDevice:get_argument_value(148) ))			-- SA342 RWR ON-OFF-PTR
	SendData("98", string.format("%.4f", mainPanelDevice:get_argument_value(122) ))	    	-- SA342 rwr brt rot  >  Accelerometer max g
	SendData("99", string.format("%.4f", mainPanelDevice:get_argument_value(121) ))			-- SA342 rwr audio rot  >  Accelerometer min g
	--Main panel
	SendData("329", string.format("%.1f", mainPanelDevice:get_argument_value(218)/3.3 ))	-- SA342 Source ArtVisVhfDop
	SendData("262", string.format("%1d", mainPanelDevice:get_argument_value(264) ))			-- SA342 Battery	2 > guarda del dc power
	SendData("263", string.format("%1d", mainPanelDevice:get_argument_value(265) ))			-- SA342 Alternator	2
	SendData("543", string.format("%1d", mainPanelDevice:get_argument_value(268) ))			-- SA342 Generator	2
	SendData("544", string.format("%1d", mainPanelDevice:get_argument_value(170) ))			-- SA342 Pitot	2
	SendData("264", string.format("%1d", mainPanelDevice:get_argument_value(271) ))			-- SA342 Fuel Pump	2
	SendData("265", string.format("%1d", mainPanelDevice:get_argument_value(267) ))			-- SA342 Additionnal Fuel Tank	2
	SendData("408", string.format("%.1f", (mainPanelDevice:get_argument_value(56) +1)/10 ))	-- SA342 Starter Start/Stop/Air	3  >  laser convert -1 0 1 to 0 0.1 0.2
	SendData("267", string.format("%1d", mainPanelDevice:get_argument_value(57) ))			-- SA342 Test
	SendData("400", string.format("%.1f", (mainPanelDevice:get_argument_value(48) +1)/10 ))	-- SA342 Copilot Wiper	3
	SendData("36", string.format("%.1f", (mainPanelDevice:get_argument_value(49) +1)/10 ))	-- SA342 Pilot Wiper	3  
	SendData("268", string.format("%1d", mainPanelDevice:get_argument_value(61) ))			-- SA342 space				2
	SendData("321", string.format("%.1f", mainPanelDevice:get_argument_value(62)/5 ))		-- SA342 Voltmeter Test
	SendData("271", string.format("%1d", mainPanelDevice:get_argument_value(59) ))			-- SA342 HYD Test
	SendData("272", string.format("%1d", mainPanelDevice:get_argument_value(66) ))			-- SA342 Alter Rearm
	SendData("273", string.format("%1d", mainPanelDevice:get_argument_value(67) ))			-- SA342 Gene Rearm
	SendData("274", string.format("%1d", mainPanelDevice:get_argument_value(63) ))			-- SA342 Convoy Tank On/Off	2
	SendData("275", string.format("%1d", mainPanelDevice:get_argument_value(64) ))			-- SA342 Sand Filter On/Off	2
	SendData("354", string.format("%.1d", mainPanelDevice:get_argument_value(269) ))		-- SA342 armt 2
	SendData("269", string.format("%1d", mainPanelDevice:get_argument_value(382) ))			-- SA342 Panels Lighting On/Off		2
	SendData("276", string.format("%1d", mainPanelDevice:get_argument_value(60) ))			-- SA342 Trim On/Off		2
	SendData("277", string.format("%1d", mainPanelDevice:get_argument_value(65) ))			-- SA342 Magnetic Brake On/Off		2
	--Lights
	SendData("415", string.format("%.1f", (mainPanelDevice:get_argument_value(146) +1)/10 ))-- SA342 Navigation Lights CLI / OFF / FIX	3
	SendData("270", string.format("%.1f", (mainPanelDevice:get_argument_value(228) +1)/10 ))-- SA342 Anticollision Light NOR / OFF / ATT	3 
	SendData("592", string.format("%.4f", mainPanelDevice:get_argument_value(22) ))			-- SA342 Main Dashboard Lighting >  Engine Power Indicator Power Indicator Mode
	SendData("2003", string.format("%.4f", mainPanelDevice:get_argument_value(21) ))		-- SA342 Console Lighting >  PUI-800 Cannon Rounds
	SendData("2001", string.format("%.4f", mainPanelDevice:get_argument_value(145) ))		-- SA342 UV Lighting >  PUI-800Selected Station Type	
	SendData("72", string.format("%.4f", mainPanelDevice:get_argument_value(30) ))			-- SA342 AntiCollision Light Intensity >  flight time hours
	SendData("138", string.format("%.4f", mainPanelDevice:get_argument_value(230) ))		-- SA342 formation lights brt >  Fuel System Forward Tank Fuel Quantity
	SendData("356", string.format("%1d", mainPanelDevice:get_argument_value(229) ))			-- SA342  inter_Feux_Formation >
	--TV
	SendData("278", string.format("%1d", mainPanelDevice:get_argument_value(124) ))			-- SA342 TV On/Off		2
	SendData("8", string.format("%.4f", mainPanelDevice:get_argument_value(123)/2 ))		-- SA342 TV Brightness		2
	SendData("407", string.format("%.4f", mainPanelDevice:get_argument_value(125)/2 ))		-- SA342 TV Contrast		2
	--Gyro
	SendData("280", string.format("%1d", mainPanelDevice:get_argument_value(198) ))			-- SA342 Gyro Test Switch On/Off    2
	SendData("281", string.format("%1d", mainPanelDevice:get_argument_value(197) ))			-- SA342 Gyro Test Cover On/Off		2
	SendData("154", string.format("%.1f", (mainPanelDevice:get_argument_value(199) +1)/2 ))	-- SA342 Left/Center/Right	3 
	SendData("147", string.format("%.1f", mainPanelDevice:get_argument_value(153)/2.5 ))	-- SA342 CM/A/GM/D/GD   multipos	
	--PE
	SendData("396", string.format("%1d", mainPanelDevice:get_argument_value(367) ))			-- SA342 PE system M/A		2
	SendData("403", string.format("%1d", mainPanelDevice:get_argument_value(362) ))			-- SA342 PE centering		2
	SendData("399", string.format("%1d", mainPanelDevice:get_argument_value(364) ))			-- SA342 PE VDO VTH		2
	SendData("462", string.format("%.1f", mainPanelDevice:get_argument_value(370)/2.5  ))	-- SA342 PE mode		2 ( convert steps 0.25 to steps 0.1
	SendData("335", string.format("%.1f", mainPanelDevice:get_argument_value(366) ))		-- SA342 PE CTH		3 pos 
	SendData("336", string.format("%0.1f", (mainPanelDevice:get_argument_value(365) +1)/2 ))-- SA342 PE CTH		3 pos 
	--PH
	SendData("431", string.format("%.1f", mainPanelDevice:get_argument_value(180)/2.5 ))	-- SA342 PH cle
	SendData("371", string.format("%.1f", mainPanelDevice:get_argument_value(181)/1.25 ))	-- SA342 PH station selection
	--Weapons
	SendData("548", string.format("%1d", mainPanelDevice:get_argument_value(373) ))			-- SA342 weapon cover left		2
	SendData("547", string.format("%1d", mainPanelDevice:get_argument_value(372) ))			-- SA342 weapon left		2
	SendData("283", string.format("%1d", mainPanelDevice:get_argument_value(375) ))			-- SA342 weapon cover right		2
	SendData("282", string.format("%1d", mainPanelDevice:get_argument_value(374) ))			-- SA342 weapon right		2
	SendData("398", string.format("%1d", mainPanelDevice:get_argument_value(376) ))			-- SA342 weapon riple single		2
	SendData("204", string.format("%.4f", mainPanelDevice:get_argument_value(377) ))		-- SA342 weapon left lamp > AGB Oil Press
	SendData("213", string.format("%.4f", mainPanelDevice:get_argument_value(378) ))		-- SA342 weapon right lamp >	SL Hook Open	
	SendData("229", string.format("%.1f", (mainPanelDevice:get_argument_value(354)+1)/10))  -- SA342 weapons power	3
	SendData("532", string.format("%.4f", mainPanelDevice:get_argument_value(357) ))		-- SA342 wp1 display brt >  Clock Stop Watch Seconds
	--FD flare dispenser
	SendData("167", string.format("%.4f", mainPanelDevice:get_argument_value(223) ))		-- SA342 FD g1 lamp > right alarm panel
	SendData("180", string.format("%.4f", mainPanelDevice:get_argument_value(224) ))		-- SA342 FD g2 lamp > right alarm panel
	SendData("179", string.format("%.4f", mainPanelDevice:get_argument_value(225) ))		-- SA342 FD d1 lamp > right alarm panel
	SendData("188", string.format("%.4f", mainPanelDevice:get_argument_value(226) ))		-- SA342 FD d2 lamp > right alarm panel
	SendData("189", string.format("%.4f", mainPanelDevice:get_argument_value(227) ))		-- SA342 FD leu lamp > right alarm panel
	SendData("206", string.format("%.4f", mainPanelDevice:get_argument_value(231) ))		-- SA342 FD left lamp > right alarm panel
	SendData("212", string.format("%.4f", mainPanelDevice:get_argument_value(232) ))		-- SA342 FD right lamp > right alarm panel
	SendData("205", string.format("%.4f", mainPanelDevice:get_argument_value(233) ))		-- SA342 FD power lamp > right alarm panel
	SendData("230", string.format("%.1d", mainPanelDevice:get_argument_value(221) ))		-- SA342 FD seq switch 2 > AGB Oil Press
	SendData("248", string.format("%.1f", (mainPanelDevice:get_argument_value(220)+1)/10))  -- SA342 FD G+D	3 >
	SendData("295", string.format("%.1f", (mainPanelDevice:get_argument_value(222)+1)/10))  -- SA342 FD LE VE AR 3 >
	--PA Autopilot
	SendData("65", string.format("%.1d", mainPanelDevice:get_argument_value(31) ))		-- SA342 PA on off > CPT MECH gear
	SendData("539", string.format("%.1d", mainPanelDevice:get_argument_value(32) ))		-- SA342 PA pitch on 2 > CPT MECH pitot static
	SendData("151", string.format("%.1d", mainPanelDevice:get_argument_value(33) ))		-- SA342 PA roll on 2 > CPT MECH pitot ram
	SendData("153", string.format("%.1d", mainPanelDevice:get_argument_value(34) ))		-- SA342 PA yaw on 2 > engine rotor de icing
	SendData("328", string.format("%.1f", (mainPanelDevice:get_argument_value(35)+1)/10)) -- SA342 PA mode 3 > datalink self id
	--UHF 
	SendData("301", string.format("%.1f", mainPanelDevice:get_argument_value(383)/1.67 ))	-- SA342 UHF left rot
	SendData("512", string.format("%.1d", mainPanelDevice:get_argument_value(384) ))	-- SA342 UHF drw
	SendData("513", string.format("%.1d", mainPanelDevice:get_argument_value(385) ))	-- SA342 UHF vld
	SendData("514", string.format("%.1d", mainPanelDevice:get_argument_value(387) ))	-- SA342 UHF conf
	SendData("515", string.format("%.1d", mainPanelDevice:get_argument_value(388) ))	-- SA342 UHF 1
	SendData("516", string.format("%.1d", mainPanelDevice:get_argument_value(389) ))	-- SA342 UHF 2
	SendData("523", string.format("%.1d", mainPanelDevice:get_argument_value(390) ))	-- SA342 UHF 3
	SendData("156", string.format("%.1d", mainPanelDevice:get_argument_value(391) ))	-- SA342 UHF 4
	SendData("38", string.format("%.1d", mainPanelDevice:get_argument_value(392) ))		-- SA342 UHF 5
	SendData("39", string.format("%.1d", mainPanelDevice:get_argument_value(393) ))		-- SA342 UHF 6
	SendData("41", string.format("%.1d", mainPanelDevice:get_argument_value(394) ))		-- SA342 UHF 7
	SendData("43", string.format("%.1d", mainPanelDevice:get_argument_value(395) ))		-- SA342 UHF 8
	SendData("42", string.format("%.1d", mainPanelDevice:get_argument_value(396) ))		-- SA342 UHF 9
	SendData("40", string.format("%.1d", mainPanelDevice:get_argument_value(397) ))		-- SA342 UHF 0
	--FM radio
	SendData("484", string.format("%.1f", mainPanelDevice:get_argument_value(272)/2.5 ))	-- SA342 FM mode selector
	SendData("483", string.format("%.1f", mainPanelDevice:get_argument_value(273)/1.43 ))	-- SA342 FM channels selector
	--AM radio
	SendData("252", string.format("%.4f", mainPanelDevice:get_argument_value(133) ))	-- SA342 AM 1 digit > 
	SendData("253", string.format("%.4f", mainPanelDevice:get_argument_value(134) ))	-- SA342 AM 2 digit > 
	SendData("254", string.format("%.4f", mainPanelDevice:get_argument_value(136) ))	-- SA342 AM 3 digit > 
	SendData("255", string.format("%.4f", mainPanelDevice:get_argument_value(138) ))	-- SA342 AM 1 dec digit > 
	SendData("256", string.format("%.4f", mainPanelDevice:get_argument_value(139) ))	-- SA342 AM 2 dec digit >
	SendData("181", string.format("%.4f", mainPanelDevice:get_argument_value(141) ))	-- SA342 AM on lamp > 
	SendData("583", string.format("%.1d", mainPanelDevice:get_argument_value(130) ))	-- SA342 AM 25/50 > 	
	SendData("428", string.format("%0.2f", mainPanelDevice:get_argument_value(128)/3 ))	-- SA342 selector A M SQ TEST
	--ADF
	SendData("56", string.format("%1d", mainPanelDevice:get_argument_value(166) ))		-- SA342 ADF select		2
	SendData("57", string.format("%1d", mainPanelDevice:get_argument_value(167) ))		-- SA342 ADF tune	2
	SendData("473", string.format("%.4f", mainPanelDevice:get_argument_value(158) ))	-- SA342 ADF1 1 digit > 
	SendData("474", string.format("%.4f", mainPanelDevice:get_argument_value(159) ))	-- SA342 ADF1 2 digit > 
	SendData("475", string.format("%.4f", mainPanelDevice:get_argument_value(160) ))	-- SA342 ADF1 3 digit > 
	SendData("476", string.format("%.4f", mainPanelDevice:get_argument_value(161) ))	-- SA342 ADF1 dec digit > 	
	SendData("257", string.format("%.4f", mainPanelDevice:get_argument_value(162) ))	-- SA342 ADF2 1 digit > 
	SendData("235", string.format("%.2f", mainPanelDevice:get_argument_value(163) ))	-- SA342 ADF2 2 digit > 
	SendData("234", string.format("%.2f", mainPanelDevice:get_argument_value(164) ))	-- SA342 ADF2 3 digit > 
	SendData("6", string.format("%.4f", mainPanelDevice:get_argument_value(165) ))		-- SA342 ADF2 dec digit > 
	SendData("405", string.format("%.4f", mainPanelDevice:get_argument_value(179) ))	-- SA342 ADF gain rot >  hms bright
	--Radio alt
	SendData("386", string.format("%1d", mainPanelDevice:get_argument_value(91) ))		-- Ralt on /off
	SendData("119", string.format("%.4f", mainPanelDevice:get_argument_value(99) ))		-- Ralt on off flag > HSI Heading Warning Flag
	SendData("114", string.format("%.4f", mainPanelDevice:get_argument_value(98) ))		-- Ralt test flag > HSI Course Warning Flag
	SendData("113", string.format("%1d", mainPanelDevice:get_argument_value(100) ))		-- Ralt test > HSI button test
	--QFE
	local qfe_mil= math.floor((mainPanelDevice:get_argument_value(95)+0.05)*10)*1000
	local qfe_cent= math.floor((mainPanelDevice:get_argument_value(92)+0.05)*10)*100
	local qfe_dec= math.floor((mainPanelDevice:get_argument_value(90)+0.05)*10)*10
	local qfe_unit= math.floor((mainPanelDevice:get_argument_value(88)+0.05)*10)
	local qfe= qfe_mil+qfe_cent+qfe_dec+qfe_unit
	SendData("2002", string.format("%.4f", qfe ))										-- SA342 QFE > PUI-800 Selected Station Count
	--Intercom Pilot
	SendData("338", string.format("%.4f", mainPanelDevice:get_argument_value(68) ))		-- SA342 IC1 VHF >  ZMS-3 Magnetic Variation
	SendData("340", string.format("%.4f", mainPanelDevice:get_argument_value(69) ))		-- SA342 IC1 UHF >  PShK-7 Latitude Entry
	SendData("327", string.format("%.4f", mainPanelDevice:get_argument_value(70) ))		-- SA342 IC1 FM1 >  PVI-800 Control Panel Brightness
	-- HA nad Stby HA
	SendData("128", string.format("%.4f", mainPanelDevice:get_argument_value(115) ))	-- SA342 HA rot >  HSI Lateral deviation
	SendData("97", string.format("%.4f", mainPanelDevice:get_argument_value(215) ))		-- SA342 Stby HA rot  >  Accelerometer Current gs
	--Collective
	SendData("382", string.format("%.1f", (mainPanelDevice:get_argument_value(105)+1)/2))  -- SA342 Landing Light Off/Vario/On > Landing Light On/Off/Retract
	SendData("383", string.format("%1d", mainPanelDevice:get_argument_value(194) ))    -- SA342 flare dispenser guard > Landing Light Primary/Backup Select
	SendData("402", string.format("%1d", mainPanelDevice:get_argument_value(116) ))    -- SA342 flare dispenser guard > Landing Light Primary/Backup Select
	SendData("397", string.format("%1d", mainPanelDevice:get_argument_value(216) ))    -- SA342 flare dispenser guard > Landing Light Primary/Backup Select
end






-- Pointed to by ProcessLowImportance, if the player aircraft is a L39ZA (using A10C interface)
function ProcessL39ZALowImportance(mainPanelDevice)
																						-- L39ZA  >  A10C
	--lamps
		SendData("540", string.format("%.1d", mainPanelDevice:get_argument_value(18)) )    -- Marker_lamp                           >  "AOA Indexer", "High Indicator", "High AOA indicator light."
		SendData("542", string.format("%.1d", mainPanelDevice:get_argument_value(6)) )     -- MainGen_lamp                          >  "AOA Indexer", "Low Indicator", "Low AOA indicator light."
		SendData("730", string.format("%.1d", mainPanelDevice:get_argument_value(9)) )     -- ReserveGen_lamp                       >  "Refuel Indexer", "Ready Indicator", "Refuel ready indicator light."
		SendData("731", string.format("%.1d", mainPanelDevice:get_argument_value(12)) )    -- Inverter115_lamp                      >  "Refuel Indexer", "Latched Indicator", "Refuel latched indicator light."
		SendData("732", string.format("%.1d", mainPanelDevice:get_argument_value(16)) )    -- Inverter363_lamp                      >  "Refuel Indexer", "Disconnect Indicator", "Refuel disconnect indicator light."
		SendData("662", string.format("%.1d", mainPanelDevice:get_argument_value(316)) )   -- GroundPower_lamp                      >  "Misc", "Gun Ready Indicator", "Indicator is lit when the GAU-8 cannon is armed and ready to fire."
		SendData("216", string.format("%.1d", mainPanelDevice:get_argument_value(278)) )   -- FlapsUpLamp                           >  "Fire System", "APU Fire Indicator", "Indicator lights when a fire is detedted in the APU."
		SendData("217", string.format("%.1d", mainPanelDevice:get_argument_value(279)) )   -- FlapsTOLamp                           >  "Fire System", "Right Engine Fire Indicator", "Indicator lights when a fire is detected in the right engine."
		SendData("404", string.format("%.1d", mainPanelDevice:get_argument_value(280)) )   -- FlapsDnLamp                           >  "UFC", "Master Caution Indicator", "Indicator lamp on master caution button." 
		SendData("659", string.format("%.1d", mainPanelDevice:get_argument_value(117)) )   -- AirBrakesLampFwd                      >  "Mechanical", "Gear Nose Safe Indicator", "Lit when the nose gear is down and locked."
		SendData("661", string.format("%.1d", mainPanelDevice:get_argument_value(113)) )   -- GearDown_front                        >  "Mechanical", "Gear Right Safe Indicator", "Lit when the right gear is down and locked."
		SendData("737", string.format("%.1d", mainPanelDevice:get_argument_value(112)) )   -- GearDown_left                         >  "Mechanical", "Gear Handle Indicator", "Lit when the landing gear are moving between down and stowed position."
		SendData("606", string.format("%.1d", mainPanelDevice:get_argument_value(114)) )   -- GearDown_right                        >  "Navigation Mode Select Panel", "HARS Indicator", "HARS button indicator lamp."
		SendData("608", string.format("%.1d", mainPanelDevice:get_argument_value(110)) )   -- GearUp_front                          >  "Navigation Mode Select Panel", "EGI Indicator", "EGI button indicator lamp."
		SendData("610", string.format("%.1d", mainPanelDevice:get_argument_value(109)) )   -- GearUp_left                           >  "Navigation Mode Select Panel", "TISL Indicator", "TISL button indicator lamp."
		SendData("612", string.format("%.1d", mainPanelDevice:get_argument_value(111)) )   -- GearUp_right                          >  "Navigation Mode Select Panel", "STEERPT Indicator", "STEERPT button indicator lamp."
		SendData("614", string.format("%.1d", mainPanelDevice:get_argument_value(115)) )   -- ExtendGears                           >  "Navigation Mode Select Panel", "ANCHR Indicator", "ANCHR button indicator lamp."
		SendData("616", string.format("%.1d", mainPanelDevice:get_argument_value(116)) )   -- DoorsOut                              >  "Navigation Mode Select Panel", "TCN Indicator", "TCN button indicator lamp."
		SendData("484", string.format("%.1d", mainPanelDevice:get_argument_value(185)) )   -- RSBN_Azimuth_Correction               >  "Caution Panel", "ANTI SKID", "Lit if landing gear is down but anti-skid is disengaged."
		SendData("485", string.format("%.1d", mainPanelDevice:get_argument_value(186)) )   -- RSBN_Range_Correction                 >  "Caution Panel", "L-HYD RES", "Lit if left hyudraulic fluid reservoir is low."
		--SendData("46", string.format("%.1d", mainPanelDevice:get_argument_value(15)) )    -- BreakdownFinishedLampFwd     SENDED in HIGH priority             >  "HSI", "Bearing Flag" 
		SendData("488", string.format("%.1d", mainPanelDevice:get_argument_value(123)) )   -- GMK_GA_Tilt_Lamp                      >  "Caution Panel", "ELEV DISENG", "Lit if at least one elevator is disengaged from the Emergency Flight Control panel."
		SendData("489", string.format("%.1d", mainPanelDevice:get_argument_value(206)) )   -- GMK_GA_Tilt_Lamp PU26                     >  "Caution Panel", "VOID1", ""
		SendData("491", string.format("%.1d", mainPanelDevice:get_argument_value(2)) )     -- DangerAltitude_lamp                   >  "Caution Panel", "BLEED AIR LEAK", "Lit if bleed air is 400 degrees or higher."
		SendData("493", string.format("%.1d", mainPanelDevice:get_argument_value(27)) )    -- EmergFuelFwd_lamp                     >  "Caution Panel", "L-AIL TAB", "Lit if left aileron is not at normal positoin due to MRFCS."
		SendData("495", string.format("%.1d", mainPanelDevice:get_argument_value(23)) )    -- TurboStarter_lamp                     >  "Caution Panel", "SERVICE AIR HOT", "Lit if air temperature exceeds allowable ECS range."
		SendData("496", string.format("%.1d", mainPanelDevice:get_argument_value(4)) )     -- FwdRemain150_lamp                     >  "Caution Panel", "PITCH SAS", "Lit if at least one pitch SAS channel has been disabled."
		SendData("497", string.format("%.1d", mainPanelDevice:get_argument_value(7)) )     -- FwdDoNotStart_lamp                    >  "Caution Panel", "L-ENG HOT", "Lit if left engine ITT exceeds 880 degrees C."
		SendData("498", string.format("%.1d", mainPanelDevice:get_argument_value(26)) )    -- FwdFuelFilter_lamp                    >  "Caution Panel", "R-ENG HOT", "Lit if right engine ITT exceeds 880 degrees C."
		SendData("499", string.format("%.1d", mainPanelDevice:get_argument_value(14)) )    -- FwdWingTanks_lamp                     >  "Caution Panel", "WINDSHIELD HOT", "Lit if windshield temperature exceeds 150 degrees F."
	SendData("504", string.format("%.1d", mainPanelDevice:get_argument_value(246)) )   -- TrimmerRollNeutralFwd_lamp            >  "Caution Panel", "GCAS", "Lit if LASTE failure is detected that affects GCAS."
		SendData("507", string.format("%.1d", mainPanelDevice:get_argument_value(3)) )     -- MachMeterLampFwd                      >  "Caution Panel", "VOID2", ""
		SendData("509", string.format("%.1d", mainPanelDevice:get_argument_value(10)) )    -- FwdCanopyNotClosed                    >  "Caution Panel", "L-WING PUMP", "Lit if boost pump pressure is low."
		SendData("511", string.format("%.1d", mainPanelDevice:get_argument_value(556)) )   -- LeftPitot_lamp                        >  "Caution Panel", "HARS", "Lit if44,  HARS heading or attitude is invalid."
		SendData("512", string.format("%.1d", mainPanelDevice:get_argument_value(557)) )   -- RightPitot_lamp                       >  "Caution Panel", "IFF MODE-4", "Lit if inoperative mode 4 capability is detected."
		SendData("513", string.format("%.1d", mainPanelDevice:get_argument_value(8)) )     -- FwdVibration_lamp                     >  "Caution Panel", "L-MAIN FUEL LOW", "Lit if left main fuel tank has 500 pounds or less."
		SendData("515", string.format("%.1d", mainPanelDevice:get_argument_value(1)) )     -- FwdFire_lamp                          >  "Caution Panel", "L-R TKS UNEQUAL", "Lit if thers is a 750 or more pund difference between the two main fuel tanks."
		SendData("517", string.format("%.1d", mainPanelDevice:get_argument_value(28)) )    -- FwdEngineTemperature700_lamp          >  "Caution Panel", "L-FUEL PRESS", "Lit if low fuel pressure is detected in fuel feed lines."
		SendData("518", string.format("%.1d", mainPanelDevice:get_argument_value(24)) )    -- FwdEngineTemperature730_lamp          >  "Caution Panel", "R-FUEL PRESS", "Lit if low fuel pressure is detected in fuel feed lines."
		SendData("519", string.format("%.1d", mainPanelDevice:get_argument_value(20)) )    -- FwdEngineMinOilPressure_lamp          >  "Caution Panel", "NAV", "Lit if there is a CDU failure while in alignment mode."
	SendData("520", string.format("%.1d", mainPanelDevice:get_argument_value(359)) )   -- RSBN_Azimuth_Correction               >  "Caution Panel", "STALL SYS", "Lit if there is a power failure to the AoA and Mach meters."
	SendData("521", string.format("%.1d", mainPanelDevice:get_argument_value(362)) )   -- RSBN_Range_Correction                 >  "Caution Panel", "L-CONV", "Lit if left electrical converter fails."
		SendData("522", string.format("%.1d", mainPanelDevice:get_argument_value(19)) )    -- HSI_manual_accordance                 >  "Caution Panel", "R-CONV", "Lit if right electrical converter fails."
		SendData("523", string.format("%.1d", mainPanelDevice:get_argument_value(11)) )    -- FwdCockpitPressure_lamp               >  "Caution Panel", "CADC", "Lit if CADC has failed."
		SendData("525", string.format("%.1d", mainPanelDevice:get_argument_value(22)) )    -- FwdConditioningClosed_lamp            >  "Caution Panel", "L-GEN", "Lit if left generator has shut down or AC power is out of limits."
		SendData("527", string.format("%.1d", mainPanelDevice:get_argument_value(25)) )    -- FwdDefrost_lamp                       >  "Caution Panel", "INST INV", "Lit if AC powered systems are not receiving power from inverter."
		SendData("191", string.format("%.1d", mainPanelDevice:get_argument_value(21)) )    -- FwdIce_lamp                           >  "Autopilot", "Take Off Trim Indicator", "Lit when reseting autopilot for take off trim"
		SendData("799", string.format("%.1d", mainPanelDevice:get_argument_value(182)) )   -- RIO_HeatingOk_lamp                    >  "IFF", "Test Lamp", ""
		SendData("178", string.format("%.1d", mainPanelDevice:get_argument_value(5)) )     -- FwdHydraulicPressureDrop_lamp         >  "Autopilot", "Left Aileron Disengage Indicator", "Lit when the left aileron is disengaged."
		SendData("181", string.format("%.1d", mainPanelDevice:get_argument_value(253)) )   -- FwdMasterDanger_lamp                  >  "Autopilot", "Left Elevator Disengage Indicator", "Lit when the left elevator is disengaged."
		SendData("55", string.format("%.1d", mainPanelDevice:get_argument_value(17)) )     -- EmergConditioning_lamp                >  "AOA", "Off Flag", ""
	--SendData("25", string.format("%.1d", mainPanelDevice:get_argument_value(562)) )    -- FwdRadioUnderControl_lamp             > 
		SendData("25", string.format("%.1d", mainPanelDevice:get_argument_value(299)) )    -- FLT_recoder_lamp             >  "ADI", "Attitude Warning Flag", "Indicates that the ADI has lost electrical power or otherwise been disabled."
		
		SendData("26", string.format("%.1d", mainPanelDevice:get_argument_value(13)) )     -- FwdEmptyWingFuelTanks_lamp only L39za >  "ADI", "Glide Slope Warning Flag", "Indicates that the ADI is not recieving a ILS glide slope signal."
		SendData("40", string.format("%.1d", mainPanelDevice:get_argument_value(561)) )    -- FarNDBSelectorLamp                    > "HSI", "Power Off Flag"
		SendData("32", string.format("%.1d", mainPanelDevice:get_argument_value(570)) )    -- NearNDBSelectorLamp                   > "HSI", "Range Flag"

	SendData("541", string.format("%.1d", mainPanelDevice:get_argument_value(358)) )   -- MarkerInstructor_lamp                 >  "AOA Indexer", "Normal Indicator", "Norm AOA indidcator light."
	SendData("663", string.format("%.1d", mainPanelDevice:get_argument_value(347)) )   -- MainGen_Instructor_lamp               >  "Misc", "Nose Wheel Steering Indicator", "Indicator is lit when nose wheel steering is engaged."
	SendData("665", string.format("%.1d", mainPanelDevice:get_argument_value(350)) )   -- ReserveGen_Instructor_lamp            >  "Misc", "Canopy Unlocked Indicator", "Indicator is lit when canopy is open."
	SendData("664", string.format("%.1d", mainPanelDevice:get_argument_value(353)) )   -- Inverter115_Instructor_lamp           >  "Misc", "Marker Beacon Indicator", "Indicator is lit when in ILS mode and a beacon is overflown."
	SendData("215", string.format("%.1d", mainPanelDevice:get_argument_value(357)) )   -- Inverter363_Instructor_lamp           >  "Fire System", "Left Engine Fire Indicator", "Indicator lights when a fire is detected in the left engine."
	SendData("372", string.format("%.1d", mainPanelDevice:get_argument_value(462)) )   -- FlapsUpLamp2                          >  "CMSC", "Missle Launch Indicator", "Flashes when missile has been launched near your aircraft."
	SendData("373", string.format("%.1d", mainPanelDevice:get_argument_value(463)) )   -- FlapsTOLamp2                          >  "CMSC", "Priority Status Indicator", "Lit when priority display mode is active."
	SendData("374", string.format("%.1d", mainPanelDevice:get_argument_value(464)) )   -- FlapsDnLamp2                          >  "CMSC", "Unknown Status Indicator", "Lit when unknown threat display is active."
	SendData("660", string.format("%.1d", mainPanelDevice:get_argument_value(436)) )   -- AirBrakesLampAft                      >  "Mechanical", "Gear Left Safe Indicator", "Lit when the left gear is down and locked."
	SendData("618", string.format("%.1d", mainPanelDevice:get_argument_value(432)) )   -- GearDown_front2                       >  "Navigation Mode Select Panel", "ILS Indicator", "ILS button indicator lamp."
	SendData("619", string.format("%.1d", mainPanelDevice:get_argument_value(431)) )   -- GearDown_left2                        >  "Navigation Mode Select Panel", "UHF Homing Indicator", "Lit when the UHF control panel is ste to ADF."
	SendData("620", string.format("%.1d", mainPanelDevice:get_argument_value(433)) )   -- GearDown_right2                       >  "Navigation Mode Select Panel", "VHF/FM Homing Indicator", "Lit when the VHF/FM control panel is set to homing mode."
	SendData("600", string.format("%.1d", mainPanelDevice:get_argument_value(429)) )   -- GearUp_front2                         >  "Oxygen System", "Breathflow", "Flashs with each breath."
	SendData("480", string.format("%.1d", mainPanelDevice:get_argument_value(428)) )   -- GearUp_left2                          >  "Caution Panel", "ENG START CYCLE", "Lit if either engine is in engine start process."
	SendData("481", string.format("%.1d", mainPanelDevice:get_argument_value(430)) )   -- GearUp_right2                         >  "Caution Panel", "L-HYD PRESS", "Lit if left hydraulic system pressure falls below 1,000 psi."
	SendData("482", string.format("%.1d", mainPanelDevice:get_argument_value(434)) )   -- ExtendGears2                          >  "Caution Panel", "R-HYD PRESS", "Lit if right hydraulic system pressure falls below 1,000 psi."
	SendData("483", string.format("%.1d", mainPanelDevice:get_argument_value(435)) )   -- DoorsOut2                             >  "Caution Panel", "GUN UNSAFE", "Lit if gun is capable of being fired."
	SendData("487", string.format("%.1d", mainPanelDevice:get_argument_value(356)) )   -- BreakdownFinishedLampAft              >  "Caution Panel", "OXY LOW", "Lit if oxygen gauge indices 0.5 liters or less."
	SendData("490", string.format("%.1d", mainPanelDevice:get_argument_value(443)) )   -- GMK_GA_Tilt_Lamp 2                     >  "Caution Panel", "SEAT NOT ARMED", "Lit if ground safety lever is in the safe position."
	SendData("492", string.format("%.1d", mainPanelDevice:get_argument_value(343)) )   -- DangerAltitudeInstructor_lamp         >  "Caution Panel", "AIL DISENG", "Lit if at least one aileron is disngaged from the Emergency FLight Control panel."
	SendData("494", string.format("%.1d", mainPanelDevice:get_argument_value(365)) )   -- EmergFuelAft_lamp                     >  "Caution Panel", "R-AIL TAB", "Lit if right aileron is not at normal positoin due to MRFCS."
	SendData("500", string.format("%.1d", mainPanelDevice:get_argument_value(345)) )   -- AftRemain150_lamp                     >  "Caution Panel", "YAW SAS", "Lit if at least one yaw SAS channel has been disabled."
	SendData("501", string.format("%.1d", mainPanelDevice:get_argument_value(348)) )   -- AftDoNotStart_lamp                    >  "Caution Panel", "L-ENG OIL PRESS", "Lit if left engine oil pressure is less than 27.5 psi."
	SendData("502", string.format("%.1d", mainPanelDevice:get_argument_value(364)) )   -- AftFuelFilter_lamp                    >  "Caution Panel", "R-ENG OIL PRESS", "Lit if right engine oil pressure is less than 27.5 psi."
	SendData("503", string.format("%.1d", mainPanelDevice:get_argument_value(355)) )   -- AftWingTanks_lamp                     >  "Caution Panel", "CICU", "Lit if ?."
	SendData("505", string.format("%.1d", mainPanelDevice:get_argument_value(441)) )   -- TrimmerRollNeutralAft_lamp            >  "Caution Panel", "L-MAIN PUMP", "Lit if boost pump pressure is low."
	SendData("506", string.format("%.1d", mainPanelDevice:get_argument_value(442)) )   -- TrimmerPitchNeutralAft_lamp           >  "Caution Panel", "R-MAIN PUMP", "Lit if boost pump pressure is low."
	SendData("508", string.format("%.1d", mainPanelDevice:get_argument_value(344)) )   -- MachMeterLampAft                      >  "Caution Panel", "LASTE", "Lit if fault is detected in LASTE computer."
	SendData("510", string.format("%.1d", mainPanelDevice:get_argument_value(351)) )   -- AftCanopyNotClosed                    >  "Caution Panel", "R-WING PUMP", "Lit if boost pump pressure is low."
	SendData("514", string.format("%.1d", mainPanelDevice:get_argument_value(349)) )   -- AftVibration_lamp                     >  "Caution Panel", "R-MAIN FUEL LOW", "Lit if right main fuel tank has 500 pounds or less."
	SendData("516", string.format("%.1d", mainPanelDevice:get_argument_value(342)) )   -- AftFire_lamp                          >  "Caution Panel", "EAC", "Lit if EAC is turned off."
	SendData("524", string.format("%.1d", mainPanelDevice:get_argument_value(352)) )   -- AftCockpitPressure_lamp               >  "Caution Panel", "APU GEN", "Lit if APU is on but APU generator is not set to PWR."
	SendData("526", string.format("%.1d", mainPanelDevice:get_argument_value(361)) )   -- AftConditioningClosed_lamp            >  "Caution Panel", "R-GEN", "Lit if right generator has shut down or AC power is out of limits."
	SendData("260", string.format("%.1d", mainPanelDevice:get_argument_value(363)) )   -- AftDefrost_lamp                       >  "TACAN", "Test Light", ""
	SendData("798", string.format("%.1d", mainPanelDevice:get_argument_value(360)) )   -- AftIce_lamp                           >  "IFF", "Reply Lamp", ""
	SendData("179", string.format("%.1d", mainPanelDevice:get_argument_value(346)) )   -- AftHydraulicPressureDrop_lamp         >  "Autopilot", "Right Aileron Disengage Indicator", "Lit when the right aileron is disengaged."
	SendData("182", string.format("%.1d", mainPanelDevice:get_argument_value(455)) )   -- AftMasterDanger_lamp                  >  "Autopilot", "Right Elevator Disengage Indicator", "Lit when the right elevator is disengaged."
	SendData("19", string.format("%.1d", mainPanelDevice:get_argument_value(565)) )    -- AftRadioUnderControl_lamp             >  "ADI", "Course Warning Flag", "Indicates thatn an operative ILS or TACAN signal is received."
	SendData("65", string.format("%.1d", mainPanelDevice:get_argument_value(354)) )    -- AftEmptyWingFuelTanks_lamp only L39za >  "SAI", "Warning Flag", "Displayed when SAI is caged or non-functional."
	SendData("486", string.format("%.1d", mainPanelDevice:get_argument_value(564)) )    -- FarNDBSelectorLamp_CPT2               > "Caution Panel", "R-HYD RES", "Lit if right hyudraulic fluid reservoir is low."

	
	-- weapons status lamps L39C
	SendData("432", string.format("%.1f", mainPanelDevice:get_argument_value(261)) )   -- store_left 	>     "CDU", "8"
	SendData("433", string.format("%.1f", mainPanelDevice:get_argument_value(262)) )   -- store_right	>     "CDU", "9"
	SendData("434", string.format("%.1f", mainPanelDevice:get_argument_value(263)) )   -- explosive  	>     "CDU", "0"
	SendData("435", string.format("%.1f", mainPanelDevice:get_argument_value(264)) )   -- cc_left 		>     "CDU", "Point"
	SendData("436", string.format("%.1f", mainPanelDevice:get_argument_value(265)) )   -- cc_right 	>         "CDU", "Slash"
	SendData("437", string.format("%.1f", mainPanelDevice:get_argument_value(266)) )   -- pus_0	   	>         "CDU", "A"
		SendData("438", string.format("%.1f", mainPanelDevice:get_argument_value(251)) )   -- no_launch   	>     "CDU", "B"
		SendData("439", string.format("%.1f", mainPanelDevice:get_argument_value(250)) )   -- stand_alert 	>     "CDU", "C"
	SendData("440", string.format("%.1f", mainPanelDevice:get_argument_value(445)) )   -- store_left_aft	> "CDU", "D"
	SendData("441", string.format("%.1f", mainPanelDevice:get_argument_value(446)) )   -- store_right_aft	> "CDU", "E"
	SendData("442", string.format("%.1f", mainPanelDevice:get_argument_value(447)) )   -- cc_left_aft		> "CDU", "F"
	SendData("443", string.format("%.1f", mainPanelDevice:get_argument_value(448)) )   -- cc_right_aft		> "CDU", "G"
	SendData("444", string.format("%.1f", mainPanelDevice:get_argument_value(449)) )   -- stand_alert_aft	> "CDU", "H"
	SendData("445", string.format("%.1f", mainPanelDevice:get_argument_value(450)) )   -- no_launch_aft	>     "CDU", "I"
	SendData("446", string.format("%.1f", mainPanelDevice:get_argument_value(451)) )   -- explosive_aft	>     "CDU", "J"
	SendData("447", string.format("%.1f", mainPanelDevice:get_argument_value(453)) )   -- glowing_cc		> "CDU", "K"
	SendData("448", string.format("%.1f", mainPanelDevice:get_argument_value(454)) )   -- heating_cc		> "CDU", "L"
	SendData("449", string.format("%.1f", mainPanelDevice:get_argument_value(452)) )   -- armament_fire	>     "CDU", "M"
	
	
	-- weapons status lamps only L39ZA
	SendData("410", string.format("%.1f", mainPanelDevice:get_argument_value(626)) )   -- status_lamps.gsh23_block			>     "CDU", "LSK 3L"
		SendData("411", string.format("%.1f", mainPanelDevice:get_argument_value(252)) )   -- status_lamps.explosive			>     "CDU", "LSK 5L"
	SendData("412", string.format("%.1f", mainPanelDevice:get_argument_value(608)) )   -- status_lamps.pus_0	      		>     "CDU", "LSK 7L"
	SendData("413", string.format("%.1f", mainPanelDevice:get_argument_value(609)) )   -- status_lamps.pus_0_inner			>     "CDU", "LSK 9L"
	SendData("414", string.format("%.1f", mainPanelDevice:get_argument_value(266)) )   -- status_lamps.pus_0_bombs			>     "CDU", "LSK 3R"
	SendData("415", string.format("%.1f", mainPanelDevice:get_argument_value(622)) )   -- status_lamps.store_left    		>     "CDU", "LSK 5R"
	SendData("416", string.format("%.1f", mainPanelDevice:get_argument_value(623)) )   -- status_lamps.store_left_inboard  >      "CDU", "LSK 7R"
	SendData("417", string.format("%.1f", mainPanelDevice:get_argument_value(624)) )   -- status_lamps.store_right_inboard >      "CDU", "LSK 9R"
	SendData("418", string.format("%.1f", mainPanelDevice:get_argument_value(625)) )   -- status_lamps.store_right   		>     "CDU", "SYS"
	SendData("419", string.format("%.1f", mainPanelDevice:get_argument_value(618)) )   -- payload_indicator 1         		>     "CDU", "NAV"
	SendData("420", string.format("%.1f", mainPanelDevice:get_argument_value(619)) )   -- payload_indicator 2          	>         "CDU", "WP MENU"
	SendData("421", string.format("%.1f", mainPanelDevice:get_argument_value(620)) )   -- payload_indicator 3              >      "CDU", "OFFSET"
	SendData("422", string.format("%.1f", mainPanelDevice:get_argument_value(621)) )   -- payload_indicator 4              >      "CDU", "FPMENU"
	SendData("423", string.format("%.1f", mainPanelDevice:get_argument_value(722)) )   -- aft_status_lamps.store_left    		> "CDU", "PREV"
	SendData("425", string.format("%.1f", mainPanelDevice:get_argument_value(723)) )   -- aft_status_lamps.store_left_inboard  >  "CDU", "1"
	SendData("426", string.format("%.1f", mainPanelDevice:get_argument_value(724)) )   -- aft_status_lamps.store_right_inboard >  "CDU", "2"
	SendData("427", string.format("%.1f", mainPanelDevice:get_argument_value(725)) )   -- aft_status_lamps.store_right   		> "CDU", "3"
	SendData("428", string.format("%.1f", mainPanelDevice:get_argument_value(718)) )   -- aft_payload_indicator 1         		> "CDU", "4"
	SendData("429", string.format("%.1f", mainPanelDevice:get_argument_value(719)) )   -- aft_payload_indicator 2          	>     "CDU", "5"
	SendData("430", string.format("%.1f", mainPanelDevice:get_argument_value(720)) )   -- aft_payload_indicator 3              >  "CDU", "6"
	SendData("431", string.format("%.1f", mainPanelDevice:get_argument_value(721)) )   -- aft_payload_indicator 4              >  "CDU", "7"
	

	-- switches
	
	SendData("327", string.format("%.1f", mainPanelDevice:get_argument_value(211) ) ) -- CB Air Conditioning, ON/OFF 211 sw 2 pos > "Right MFCD", "OSB2"  327
	SendData("328", string.format("%.1f", mainPanelDevice:get_argument_value(212) ) ) -- CB Anti-Ice, ON/OFF 212 sw 2 pos >         "Right MFCD", "OSB3"  328
	SendData("329", string.format("%.1f", mainPanelDevice:get_argument_value(213) ) ) -- CB Pitot Left, ON/OFF 213 sw 2 pos >       "Right MFCD", "OSB4"  329
	SendData("330", string.format("%.1f", mainPanelDevice:get_argument_value(214) ) ) -- CB Pitot Right, ON/OFF 214 sw 2 pos >      "Right MFCD", "OSB5"  330
	SendData("331", string.format("%.1f", mainPanelDevice:get_argument_value(215) ) ) -- CB PT-500C, ON/OFF 215 sw 2 pos >          "Right MFCD", "OSB6"  331
	SendData("332", string.format("%.1f", mainPanelDevice:get_argument_value(216) ) ) -- CB ARC, ON/OFF 216 sw 2 pos >              "Right MFCD", "OSB7"  332
	SendData("333", string.format("%.1f", mainPanelDevice:get_argument_value(217) ) ) -- CB SRO, ON/OFF 217 sw 2 pos >              "Right MFCD", "OSB8"  333
	SendData("334", string.format("%.1f", mainPanelDevice:get_argument_value(218) ) ) -- CB Seat-Helmet, ON/OFF 218 sw 2 pos >      "Right MFCD", "OSB9"  334
	SendData("335", string.format("%.1f", mainPanelDevice:get_argument_value(219) ) ) -- CB Gears, ON/OFF 219 sw 2 pos >            "Right MFCD", "OSB10" 335
	SendData("336", string.format("%.1f", mainPanelDevice:get_argument_value(220) ) ) -- CB Control, ON/OFF 220 sw 2 pos >          "Right MFCD", "OSB11" 336
	SendData("337", string.format("%.1f", mainPanelDevice:get_argument_value(221) ) ) -- CB Signaling, ON/OFF 221 sw 2 pos >        "Right MFCD", "OSB12" 337
	SendData("338", string.format("%.1f", mainPanelDevice:get_argument_value(222) ) ) -- CB Nav. Lights, ON/OFF 222 sw 2 pos >      "Right MFCD", "OSB13" 338
	SendData("339", string.format("%.1f", mainPanelDevice:get_argument_value(223) ) ) -- CB Spotlight Left, ON/OFF 223 sw 2 pos >   "Right MFCD", "OSB14" 339
	SendData("340", string.format("%.1f", mainPanelDevice:get_argument_value(224) ) ) -- CB Spotlight Right, ON/OFF 224 sw 2 pos >  "Right MFCD", "OSB15" 340
	SendData("341", string.format("%.1f", mainPanelDevice:get_argument_value(225) ) ) -- CB Red Lights, ON/OFF 225 sw 2 pos >       "Right MFCD", "OSB16" 341
	SendData("342", string.format("%.1f", mainPanelDevice:get_argument_value(226) ) ) -- CB White Lights, ON/OFF 226 sw 2 pos >     "Right MFCD", "OSB17" 342
	SendData("454", string.format("%.1f", mainPanelDevice:get_argument_value(227) ) ) -- CB Start Panel, ON/OFF 227 sw 2 pos >         "CDU", "R"   454
	SendData("455", string.format("%.1f", mainPanelDevice:get_argument_value(228) ) ) -- CB Booster Pump, ON/OFF 228 sw 2 pos >        "CDU", "S"   455
	SendData("456", string.format("%.1f", mainPanelDevice:get_argument_value(229) ) ) -- CB Ignition 1, ON/OFF 229 sw 2 pos >          "CDU", "T"   456
	SendData("457", string.format("%.1f", mainPanelDevice:get_argument_value(230) ) ) -- CB Ignition 2, ON/OFF 230 sw 2 pos >          "CDU", "U"   457
	SendData("458", string.format("%.1f", mainPanelDevice:get_argument_value(231) ) ) -- CB Engine Instruments, ON/OFF 231 sw 2 pos >  "CDU", "V"   458
	SendData("459", string.format("%.1f", mainPanelDevice:get_argument_value(232) ) ) -- CB Fire, ON/OFF 232 sw 2 pos >                "CDU", "W"   459
	SendData("460", string.format("%.1f", mainPanelDevice:get_argument_value(233) ) ) -- CB Emergency Jettison, ON/OFF 233 sw 2 pos >  "CDU", "X"   460
	SendData("461", string.format("%.1f", mainPanelDevice:get_argument_value(234) ) ) -- CB SARPP, ON/OFF 234 sw 2 pos >               "CDU", "Y"   461
	SendData("343", string.format("%.1f", mainPanelDevice:get_argument_value(243) ) ) -- RT-12 JPT Regulator Power Switch, ON/OFF 243 sw 2 pos > "Right MFCD", "OSB18" 343
	
	SendData("122", string.format("%.1d", mainPanelDevice:get_argument_value(141) ) )     -- Battery Switch, ON/OFF 141 sw 2 pos > "Engine System", "Left Engine Fuel Flow Control" 122
	SendData("123", string.format("%.1d", mainPanelDevice:get_argument_value(142) ) )     -- Main Generator Switch, ON/OFF 142 sw 2 pos > "Engine System", "Right Engine Fuel Flow Control" 123
	SendData("126", string.format("%.1d", mainPanelDevice:get_argument_value(143) ) )     -- Emergency Generator Switch, ON/OFF 143 sw 2 pos > "Engine System", "APU" 126
	SendData("106", string.format("%.1d", mainPanelDevice:get_argument_value(144) ) )     -- CB Engine Switch, ON/OFF 144 sw 2 pos > "Fuel System", "External Wing Tank Boost Pump" 106
	SendData("107", string.format("%.1d", mainPanelDevice:get_argument_value(145) ) )     -- CB AGD-GMK Switch, ON/OFF 145 sw 2 pos > "Fuel System", "External Fuselage Tank Boost Pump" 107
	SendData("108", string.format("%.1d", mainPanelDevice:get_argument_value(146) ) )     -- CB Inverter 1 (AC 115V) Switch, ON/OFF 146 sw 2 pos > "Fuel System", "Tank Gate" 108
	SendData("109", string.format("%.1d", mainPanelDevice:get_argument_value(147) ) )     -- CB Inverter 2 (AC 115V) Switch, ON/OFF 147 sw 2 pos > "Fuel System", "Cross Feed" 109
	SendData("110", string.format("%.1d", mainPanelDevice:get_argument_value(148) ) )     -- CB RDO (ICS and Radio) Switch, ON/OFF 148 sw 2 pos > "Fuel System", "Boost Pump Left Wing" 110
	SendData("111", string.format("%.1d", mainPanelDevice:get_argument_value(149) ) )     -- CB MRP-RV (Marker Beacon Receiver and Radio Altimeter) Switch, ON/OFF 149 sw 2 pos > "Fuel System", "Boost Pump Right Wing" 111
	SendData("112", string.format("%.1d", mainPanelDevice:get_argument_value(150) ) )     -- CB RSBN (ISKRA) Switch, ON/OFF 150 sw 2 pos > "Fuel System", "Boost Pump Main Fuseloge Left" 112
	SendData("113", string.format("%.1d", mainPanelDevice:get_argument_value(151) ) )     -- CB IFF (SRO) Emergency Connection Switch, ON/OFF 151 sw 2 pos > "Fuel System", "Boost Pump Main Fuseloge Right" 113
	SendData("114", string.format("%.1d", mainPanelDevice:get_argument_value(152) ) )     -- CB RSBN (ISKRA) Emergency Connection Switch, ON/OFF 152 sw 2 pos > "Fuel System", "Signal Amplifier" 114
	SendData("120", string.format("%.1d", mainPanelDevice:get_argument_value(153) ) )     -- CB Wing Tanks Switch, ON/OFF" 153 sw 2 pos > "Fuel System", "Fill Disable Main Right" 120
	SendData("121", string.format("%.1d", mainPanelDevice:get_argument_value(154) ) )     -- CB RIO-3 De-Icing Signal Switch, ON/OFF 154 sw 2 pos > "Fuel System", "Refuel Control Lever" 121
	SendData("117", string.format("%.1d", mainPanelDevice:get_argument_value(155) ) )     -- CB SDU Switch, ON/OFF 155 sw 2 pos > "Fuel System", "Fill Disable Wing Left" 117
	SendData("118", string.format("%.1d", mainPanelDevice:get_argument_value(628) ) )     -- CB Heating AOA Sensor Switch, ON/OFF 628 sw 2 pos --------SOLO L39ZA> "Fuel System", "Fill Disable Wing Right" 118
	SendData("119", string.format("%.1d", mainPanelDevice:get_argument_value(629) ) )     -- CB Weapon Switch, ON/OFF 629 sw 2 pos > "Fuel System", "Fill Disable Main Left" 119
	SendData("784", string.format("%.1d", mainPanelDevice:get_argument_value(177) ) )   	-- SDU Switch, ON/OFF 177 sw 2 pos > "KY-58 Secure Voice", "Power Switch" 784
	SendData("780", string.format("%.1d", mainPanelDevice:get_argument_value(169) ) )   	-- Emergency Engine Instruments Power Switch, ON/OFF 169 sw 2 pos > "KY-58 Secure Voice", "Delay" 780
	
	SendData("101", string.format("%.1f", mainPanelDevice:get_argument_value(124) ))	-- MC Synchronization Button - Push to synchronize (level flight only) 124 btn > "IFFCC", "Ext Stores Jettison" 101
	SendData("130", string.format("%.1d", mainPanelDevice:get_argument_value(119) ) )   -- RKL-41 ADF Outer-Inner Beacon (Far-Near NDB) Switch 119 sw 2 pos > "Radar Altimeter", "Normal/Disabled" 130
	SendData("170", string.format("%.1d", (mainPanelDevice:get_argument_value(204)/2)+0.5 )) -- GMK-1AE GMC Hemisphere Selection Switch, N(orth)/S(outh) 204 sw 2 pos >  "UHF Radio", "Squelch" 170
	SendData("734", string.format("%.1d", (mainPanelDevice:get_argument_value(207)/2)+0.5 )) -- GMK-1AE GMC Mode Switch, MC(Magnetic Compass Mode)/GC(Directional Gyro Mode) 207 sw 2 pos >  "UHF Radio", "Cover" 734
	SendData("204", string.format("%.1d", mainPanelDevice:get_argument_value(205) )) 	-- GMK-1AE GMC Test Switch, 0(degrees)/OFF/300(degrees) - Use to check heading indication accuracy 205 sw 3 pos -1 0 1> "IFF", "M-3/A Switch" 204
	SendData("205", string.format("%.1d", mainPanelDevice:get_argument_value(208) )) 	-- GMK-1AE GMC Course Selector Switch, CCW/OFF/CW 208 sw 3 pos -1 0 1 >  "IFF", "M-C Switch" 205

	SendData("351", string.format("%.1f", mainPanelDevice:get_argument_value(178) )) 	-- RSBN Mode Switch, LANDING/NAVIGATION/GLIDE PATH {0.0,0.1,0.2} 178 sw 3 pos > "Right MFCD", "Day/Night/Off" 351
	SendData("300", string.format("%.1f", mainPanelDevice:get_argument_value(179) )) 	-- RSBN Identification Button 179 btn >       "Left MFCD", "OSB1" 300
	SendData("301", string.format("%.1f", mainPanelDevice:get_argument_value(180) )) 	-- RSBN Test Button - Push to test 180 btn >  "Left MFCD", "OSB2" 301
	SendData("288", string.format("%.1f", mainPanelDevice:get_argument_value(181) )) 	-- RSBN Control Box Lighting Intensity Knob 181 axis 0.04 0.0, 0.8 > "Light System", "Formation Lights" 288
	SendData("292", string.format("%.3f", mainPanelDevice:get_argument_value(184) )) 	-- RSBN Volume Knob 184 axis 0.04 0.0, 0.8 > "Light System", "Flight Instruments Lights" 292
	SendData("202", string.format("%.1d", mainPanelDevice:get_argument_value(187) )) 	-- Initial Azimuth 187 spr sw 3 pos -1.0,0.0,1.0> "IFF", "M-1 Switch" 202
	SendData("203", string.format("%.1d", mainPanelDevice:get_argument_value(188) )) 	-- Initial Range 188 spr sw 3 pos -1.0,0.0,1.0>   "IFF", "M-2 Switch" 203
	SendData("624", string.format("%.3f", mainPanelDevice:get_argument_value(191) )) 	-- RSBN Navigation Channel Selector Knob 191 multi sw 40 0.025 > "TISL", "Altitude above target tens of thousands of feet" 624
	SendData("626", string.format("%.3f", mainPanelDevice:get_argument_value(192) )) 	-- RSBN Landing Channel Selector Knob 192 multi sw 40 0.025  >   "TISL", "Altitude above target thousands of feet" 626
	SendData("303", string.format("%.1f", mainPanelDevice:get_argument_value(193) )) 	-- Set 0 Azimuth 193 btn > "Left MFCD", "OSB4" 303
	SendData("308", string.format("%.1f", mainPanelDevice:get_argument_value(297) )) 	-- RSBN Listen Callsign Button - Push to listen 297 btn > "Left MFCD", "OSB9" 308
	SendData("636", string.format("%.1f", mainPanelDevice:get_argument_value(157) )) 	-- RKL-41 ADF Volume Knob 157 axis 0.05 >     "TISL", "TISL Code Wheel 1" 636
	SendData("638", string.format("%.1f", mainPanelDevice:get_argument_value(161) )) 	-- RKL-41 ADF Brightness Knob 161 axis 0.05 > "TISL", "TISL Code Wheel 2" 638
	SendData("103", string.format("%.1d", mainPanelDevice:get_argument_value(159) )) 	-- RKL-41 ADF Mode Switch, TLF(A3)/TLG(A1,A2) 159 sw 2 pos > "Fire System", "APU Fire Pull" 103
	SendData("364", string.format("%.1f", mainPanelDevice:get_argument_value(160) )) 	-- RKL-41 ADF Function Selector Switch, OFF/COMP(AUTO)/COMP(MAN)/ANT/LOOP 160 multi sw 5 pos 0.1 > "CMSP", "Mode Select Dial" 364 - 5 pos
	SendData("105", string.format("%.1d", mainPanelDevice:get_argument_value(162) )) 	-- RKL-41 ADF Loop Switch, LEFT/OFF/RIGHT {-1.0,0.0,1.0} 162 spr sw 3 pos > "Fire System", "Discharge Switch" 105
	SendData("104", string.format("%.1d", mainPanelDevice:get_argument_value(158) )) 	-- RKL-41 ADF Control Switch, TAKE CONTROL/HAND OVER CONTROL 158 sw 2 pos > "Fire System", "Right Engine Fire Pull" 104
	SendData("640", string.format("%.3f", mainPanelDevice:get_argument_value(165) )) 	-- RKL-41 ADF Far NDB Frequency Tune 165 axis 0.05  > "TISL", "TISL Code Wheel 3" 640
	SendData("642", string.format("%.3f", mainPanelDevice:get_argument_value(168) )) 	-- RKL-41 ADF Near NDB Frequency Tune 168 axis 0.05 > "TISL", "TISL Code Wheel 4" 642
	SendData("277", string.format("%.3f", mainPanelDevice:get_argument_value(166) ))	-- RKL-41 ADF Near NDB 100kHz rotary 166  weel arc 0.0588 0.0,0.938  > "Environmental Control", "Canopy Defog" 277
	SendData("284", string.format("%.3f", mainPanelDevice:get_argument_value(167) ))	-- RKL-41 ADF Near ND  10kHz rotary 167 weel arc 0.1 0.0,0.9 >         "Environmental Control", "Flow Level" 284
	SendData("221", string.format("%.3f", mainPanelDevice:get_argument_value(163) ))	-- RKL-41 ADF Far NDB 100kHz rotary 163  weel arc 0.0588 0.0,0.938 > "Intercom", "INT Volume" 221
	SendData("223", string.format("%.3f", mainPanelDevice:get_argument_value(164) ))	-- RKL-41 ADF Far NDB 10kHz rotary 164 weel arc 0.1 0.0,0.9 >        "Intercom", "FM Volume" 223
	SendData("228", string.format("%.1d", mainPanelDevice:get_argument_value(314) )) 	-- Turbo Button Cover, Open/Close 314 sw 2 pos > "Intercom", "UHF Switch"228
	SendData("313", string.format("%.1f", mainPanelDevice:get_argument_value(315) )) 	-- Turbo Button 315 btn > "Left MFCD", "OSB14" 313
	SendData("230", string.format("%.1d", mainPanelDevice:get_argument_value(312) )) 	-- Stop Turbo Switch Cover, Open/Close 312 sw 2 pos > "Intercom", "AIM Switch" 230
	SendData("222", string.format("%.1d", mainPanelDevice:get_argument_value(313) )) 	-- Stop Turbo Switch, ON/OFF 313 sw 2 pos > "Intercom", "INT Switch" 222
	SendData("232", string.format("%.1d", mainPanelDevice:get_argument_value(325) )) 	-- Engine Button Cover, Open/Close 325 sw 2 pos > "Intercom", "IFF Switch" 232
	SendData("314", string.format("%.1f", mainPanelDevice:get_argument_value(326) )) 	-- Engine Button 326 btn >  "Left MFCD", "OSB15" 314
	SendData("234", string.format("%.1d", mainPanelDevice:get_argument_value(317) )) 	-- Stop Engine Switch Cover, Open/Close 317 sw 2 pos > "Intercom", "ILS Switch" 234
	SendData("224", string.format("%.1d", mainPanelDevice:get_argument_value(318) )) 	-- Stop Engine Switch 318 sw 2 pos > Intercom", "FM Switch" 224
	SendData("236", string.format("%.1d", mainPanelDevice:get_argument_value(321) )) 	-- Engine Start Mode Switch Cover, Open/Close 321 sw 2 pos > "Intercom", "TCN Switch" 236
	SendData("169", string.format("%.1d", mainPanelDevice:get_argument_value(322) )) 	-- Engine Start Mode Switch, START/FALSE START/COLD CRANKING  322 sw 3 pos (-1.0,0.0,1.0 L39ZA) (0.0,0.1,0.2 L39C)> "UHF Radio", "T/Tone Switch" 169
	SendData("237", string.format("%.1d", mainPanelDevice:get_argument_value(319) )) 	-- Emergency Fuel Switch Cover, Open/Close 319 sw 2 pos > "Intercom", "Hot Mic Switch" 237
	SendData("226", string.format("%.1d", mainPanelDevice:get_argument_value(320) )) 	-- Emergency Fuel Switch 320 sw 2 pos > "Intercom", "VHF Switch" 226
	SendData("309", string.format("%.1f", mainPanelDevice:get_argument_value(294) )) 	-- Standby (Left) Pitot Tube Heating Button - Push to turn heating on 294 btn >      "Left MFCD", "OSB10"  309
	SendData("310", string.format("%.1f", mainPanelDevice:get_argument_value(295) )) 	-- Main (Right) Pitot Tube Heating Button - Push to turn heating on 295 btn >        "Left MFCD", "OSB11"  310
	SendData("311", string.format("%.1f", mainPanelDevice:get_argument_value(292) )) 	-- Standby (Left) Pitot Tube Heating Off Button - Push to turn heating off 292 btn > "Left MFCD", "OSB12"  311
	SendData("312", string.format("%.1f", mainPanelDevice:get_argument_value(293) )) 	-- Main (Right) Pitot Tube Heating Off Button - Push to turn heating off 293 btn >   "Left MFCD", "OSB13"  312
	SendData("177", string.format("%.1d", (mainPanelDevice:get_argument_value(176)*2)-1 ))	-- Navigation Lights Mode Control Switch, FLICKER/OFF/FIXED  176 sw 3 pos 0.0,0.5,1.0 > "Autopilot", "Alieron Emergency Disengage" 177
	SendData("201", string.format("%.1d", (mainPanelDevice:get_argument_value(175)*2)-1 )) 	-- Navigation Lights Intensity Control Switch, DIM(30%)/BRT(60%)/MAX(100%)  175 sw 3 pos 0.0,0.5,1.0> IFF", "Audio Light Switch" 201
	SendData("206", string.format("%.1d", mainPanelDevice:get_argument_value(330) )) 	-- Instrument Lighting Switch, Red/OFF/White 330 sw 3 pos -1.0 0.0 1.0 > "IFF", "RAD Test/Monitor Switch" 206
	SendData("102", string.format("%.1d", mainPanelDevice:get_argument_value(249) )) 	-- Emergency Instrument Light Switch, ON/OFF 249 sw 2 pos > "Fire System", "Left Engine Fire Pull" 102
	SendData("293", string.format("%.1f", mainPanelDevice:get_argument_value(202) )) 	-- Warning-Light Intensity Knob 202 axis 0.1 > "Light System", "Auxillary instrument Lights" 293
	SendData("304", string.format("%.1f", mainPanelDevice:get_argument_value(203) )) 	-- Warning-Light Check Button - Push to check 203 btn > "Left MFCD", "OSB5" 304
	rockets_firing_mode=mainPanelDevice:get_argument_value(271)
	if rockets_firing_mode >0.25 then rockets_firing_mode= 0.0 end
	SendData("325", string.format("%.1f", rockets_firing_mode )) 	-- Rockets Firing Mode Selector Switch, AUT./2RS/4RS 271 multi sw 3 pos 0.3 0.1 0.2 > "Left MFCD", "Day/Night/Off" 325
	SendData("381", string.format("%.1d", (mainPanelDevice:get_argument_value(260)/2) +0.5 )) 	-- Missile/Bomb Release Selector Switch, PORT(Left)/STARB-BOTH(Right for Missiles/Both) 260 sw 2 pos (1,-1)> "AHCP", "HUD Norm/Standbyh" 381
	SendData("623", string.format("%.1d", (mainPanelDevice:get_argument_value(607)*2)-1 )) 	-- Pyro Charge Select 607 sw 3 pos 0.0,0.5,1.0 >  "TISL", "Slant Range" 623
	SendData("621", string.format("%.1d", mainPanelDevice:get_argument_value(577) )) 	-- Charge Outer Guns 577 sw 2 pos > "Navigation Mode Select Panel", "Able - Stow" 621
	SendData("380", string.format("%.1d", mainPanelDevice:get_argument_value(578) )) 	-- Charge Inner Guns 578 sw 2 pos > "AHCP", "HUD Day/Night" 380
	SendData("644", string.format("%.1d", mainPanelDevice:get_argument_value(584) )) 	-- Bombs Series 584 sw 3 pos -1.0,0.0,1.0 > "TISL", "Code Select" 644
	SendData("175", string.format("%.1d", mainPanelDevice:get_argument_value(303) )) 	-- Emergency Oxygen Switch, ON/OFF 303 sw 2 pos >   "Autopilot", "Pitch/Roll Emergency Override"  175
	SendData("183", string.format("%.1d", mainPanelDevice:get_argument_value(304) )) 	-- Diluter Demand Switch, 100% / MIX 304 sw 2 pos > "Autopilot", "Flaps Emergency Retract"   183
	SendData("184", string.format("%.1d", mainPanelDevice:get_argument_value(307) ))	-- Helmet Ventilation Switch, ON/OFF 307 sw 2 pos > "Autopilot", "Manual Reversion Flight Control System Switch" 184
	SendData("174", string.format("%.1d", mainPanelDevice:get_argument_value(298) )) 	-- SARPP Flight Recorder, ON/OFF 298 sw 2 pos > "Autopilot", "Speed Brake Emergency Retract" 174
	SendData("290", string.format("%.1f", mainPanelDevice:get_argument_value(173) )) 	-- Cabin Air Temperature Controller Rheostat 173 axis 0.1 > "Light System", "Engine Instrument Lights" 290
	SendData("655", string.format("%.1f", mainPanelDevice:get_argument_value(174) ))	-- De-Icing Mode Switch, MANUAL/AUTOMATIC/OFF  174 sw 3 pos 0.0 0.1 0.2 > "Light System", "Land/Taxi Lights" 655
	SendData("302", string.format("%.1f", mainPanelDevice:get_argument_value(183) )) 	-- RIO-3 De-Icing Sensor Heating Circuit Check Button - Push to test 183 btn > "Left MFCD", "OSB3" 302
	SendData("316", string.format("%.1f", mainPanelDevice:get_argument_value(309) ))	-- Helmet Visor Quick Heating Button - Push to heat 309 btn > "Left MFCD", "OSB17" 316
	SendData("207", string.format("%.1f", mainPanelDevice:get_argument_value(308) )) 	-- Helmet Heating Mode Switch, AUTO/OFF/ON 308 sw 3 pos  0.0 0.5 1.0 > "IFF", "Ident/Mic Switch" 207
	SendData("476", string.format("%.1d", mainPanelDevice:get_argument_value(290) ))	-- Reserve Intercom Switch, ON/OFF 290 sw 2 pos > "AAP", "CDU Power"   476
	SendData("477", string.format("%.1d", mainPanelDevice:get_argument_value(291) )) 	-- ADF Audio Switch, ADF/OFF 291 sw 2 pos >       "AAP", "EGI Power"   477
	SendData("318", string.format("%.1f", mainPanelDevice:get_argument_value(134) ))	-- Radio Button 134 btn > "Left MFCD", "OSB19" 318
	SendData("319", string.format("%.1f", mainPanelDevice:get_argument_value(133) )) 	-- Intercom Button 133 btn > "Left MFCD", "OSB20" 319
	SendData("772", string.format("%.1d", mainPanelDevice:get_argument_value(287) )) 	-- Radio Control Switch, ON/OFF 287 sw 2 pos > "Autopilot", "Emergency Brake" 772
	SendData("196", string.format("%.1d", mainPanelDevice:get_argument_value(286) )) 	-- Squelch Switch, ON/OFF 286 sw 2 pos > "Autopilot", "HARS-SAS Override/Norm" 196
	SendData("317", string.format("%.1f", mainPanelDevice:get_argument_value(329) ))	-- IV-300 Engine Vibration Test Button - Push to test 329 btn > "Left MFCD", "OSB18" 317		
	SendData("718", string.format("%.1d", mainPanelDevice:get_argument_value(327) )) 	-- Fire Extinguish Button Cover OPEN/CLOSE 327 sw 2 pos > "Mechanical", "Auxiliary Landing Gear Handle" 718	
	SendData("315", string.format("%.1f", mainPanelDevice:get_argument_value(328) ))	-- Fire Extinguish Button - Push to extinguish 328 btn > "Left MFCD", "OSB16" 315	
	SendData("180", string.format("%.1d", mainPanelDevice:get_argument_value(242) ))	-- RT-12 JPT Regulator Test Switch, I/OFF/II  242 sw 3 pos -1.0 0.0 1.0 > "Autopilot", "Elevator Emergency Disengage" 180
	SendData("305", string.format("%.1f", mainPanelDevice:get_argument_value(281)) ) 	-- Flaps Flight Position (0 degrees) Button 281 btn >     "Left MFCD", "OSB6" 305
	SendData("306", string.format("%.1f", mainPanelDevice:get_argument_value(282)) ) 	-- Flaps Takeoff Position (25 degrees) Button 282 btn >   "Left MFCD", "OSB7" 306
	SendData("307", string.format("%.1f", mainPanelDevice:get_argument_value(283)) ) 	-- Flaps Landing Position (44 degrees) Button 283 btn >   "Left MFCD", "OSB8" 307
			
	SendData("294", string.format("%.1d", mainPanelDevice:get_argument_value(254) ))	-- CB Armament System Power Switch, ON/OFF 254 sw 2 pos > "Light System", "Signal Lights" 294
	SendData("358", string.format("%.1d", mainPanelDevice:get_argument_value(255) ))	-- CB Missile Firing Control Circuit Power Switch, ON/OFF 255 sw 2 pos > "CMSP", "ECM Pod Jettison" 358	
	SendData("295", string.format("%.1d", mainPanelDevice:get_argument_value(256) ))	-- CB ASP-FKP (Gunsight and Gun Camera) Power Switch, ON/OFF 256 sw 2 pos > "Light System", "Accelerometer & Compass Lights" 295	
	SendData("276", string.format("%.1d", mainPanelDevice:get_argument_value(273) ))	-- EKSR-46 Signal Flare Dispenser Power Switch, ON/OFF 273 sw 2 pos > "Environmental Control", "Windshield Defog/Deice", 276	
	SendData("279", string.format("%.1d", mainPanelDevice:get_argument_value(274) ))	-- EKSR-46 Yellow Signal Flare Launch Button 274 sw 2 pos >           "Environmental Control", "Pitot heat"              279	
	SendData("280", string.format("%.1d", mainPanelDevice:get_argument_value(275) ))	-- EKSR-46 Green Signal Flare Launch Button 275 sw 2 pos >            "Environmental Control", "Bleed Air"               280	
	SendData("283", string.format("%.1d", mainPanelDevice:get_argument_value(276) ))	-- EKSR-46 Red Signal Flare Launch Button 276 sw 2 pos >              "Environmental Control", "Main Air Supply"         283	
	SendData("291", string.format("%.1d", mainPanelDevice:get_argument_value(277) ))	-- EKSR-46 White Signal Flare Launch Button 277 sw 2 pos >            "Light System", "Nose Illumination"                291	
	SendData("244", string.format("%.1d", mainPanelDevice:get_argument_value(597) ))	-- Arm Outer Guns 597 sw 2 pos > "Electrical", "AC Generator - Left" 244	
	SendData("245", string.format("%.1d", mainPanelDevice:get_argument_value(598) ))	-- Arm Inner Guns 598 sw 2 pos > "Electrical", "AC Generator - Right" 245	
	SendData("246", string.format("%.1d", mainPanelDevice:get_argument_value(596) ))	-- Arm Bombs 596 sw 2 pos >      "Electrical", "Battery" 246	
	SendData("326", string.format("%.1f", mainPanelDevice:get_argument_value(599)) )	-- Deblock Guns 599 btn > "Right MFCD", "OSB1" 326 	
	SendData("601", string.format("%.1d", mainPanelDevice:get_argument_value(272)) )	-- Fire Warning Signal Test Switch, I/OFF/II  272 spr sw 3 pos -1.0 0.0 1.0> "Oxygen System", "Emergency Lever" 601
		
	SendData("243", string.format("%.1d", mainPanelDevice:get_argument_value(267)))	-- Arm/Safe Bombs Emergency Jettison Switch Cover, 267 OPEN/CLOSE sw 2 pos > "Electrical", "Emergency Flood" 243		
	SendData("247", string.format("%.1d", mainPanelDevice:get_argument_value(268)))	-- Arm/Safe Bombs Emergency Jettison Switch, LIVE/BLANK 268 sw 2 pos >   "ILS", "Power"               247			
	SendData("378", string.format("%.1d", mainPanelDevice:get_argument_value(269)))	-- Emergency Jettison Outboard Stations Switch, Cover OPEN/CLOSE 269 sw 2 pos >  "AHCP", "TGP Power"  378			
	SendData("383", string.format("%.1d", mainPanelDevice:get_argument_value(270)))	-- Emergency Jettison Outboard Stations Switch, ON/OFF 270 sw 2 pos >       "AHCP", "Datalink Power"  383			
	SendData("602", string.format("%.1d", mainPanelDevice:get_argument_value(582)))	-- Gun+PK3 Switch 582 Cover sw 2 pos > "Oxygen System", "Dilution Lever" 602			
	SendData("603", string.format("%.1d", mainPanelDevice:get_argument_value(583)))	-- Gun+PK3 Switch 583 sw 2 pos >       "Oxygen System", "Supply Lever"   603			
	SendData("270", string.format("%.1d", mainPanelDevice:get_argument_value(589)))	-- Emergency Jettison Inboard Stations Switch, Cover OPEN/CLOSE 589 sw 2 pos > "HARS", "Mode"         270			
	SendData("273", string.format("%.1d", mainPanelDevice:get_argument_value(590)))	-- Emergency Jettison Inboard Stations Switch, ON/OFF 590 sw 2 pos >           "HARS", "Hemisphere Selector"  273			
	SendData("388", string.format("%.1f", mainPanelDevice:get_argument_value(579)))	-- Pyro Charge Apply 579 btn > "UFC", "4" 388	
	SendData("716", string.format("%.1d", mainPanelDevice:get_argument_value(585)))	-- Outboard Stations Select 585 sw 2 pos > "Mechanical", "Landing Gear Lever" 716			
	SendData("385", string.format("%.1f", mainPanelDevice:get_argument_value(586)))	-- Outboard Stations Deselect 586 btn > "UFC", "1" 385			
	SendData("382", string.format("%.1d", mainPanelDevice:get_argument_value(587)))	-- Inboard Stations Select 587 sw 2 pos >   "AHCP", "CICU Power"               382			
	SendData("386", string.format("%.1f", mainPanelDevice:get_argument_value(588)))	-- Inboard Stations Deselect 588 btn > "UFC", "2" 386			
	SendData("241", string.format("%.1d", mainPanelDevice:get_argument_value(591)))	-- Emergency Launch Missiles Cover OPEN/CLOSE 591 sw 2 pos > "Electrical", "APU Generator" 241			
	SendData("387", string.format("%.1f", mainPanelDevice:get_argument_value(592)))	-- Emergency Launch Missiles 592 btn > "UFC", "3" 387			

	SendData("389", string.format("%.1f", mainPanelDevice:get_argument_value(197)))	-- Main and Emergency Hydraulic Systems Interconnection Lever, FORWARD(OFF)/BACKWARD(ON) 197 sw 2 pos > "UFC", "5"  389
    SendData("390", string.format("%.1f", mainPanelDevice:get_argument_value(194)))	-- Emergency Landing Gear Extension Lever, FORWARD(OFF)/BACKWARD(ON) 194 sw 2 pos >                     "UFC", "6"  390
    SendData("391", string.format("%.1f", mainPanelDevice:get_argument_value(195)))	-- Emergency Flaps Extension Lever, FORWARD(OFF)/BACKWARD(ON) 195 sw 2 pos >                            "UFC", "7"  391
    SendData("392", string.format("%.1f", mainPanelDevice:get_argument_value(196)))	-- RAT (Emergency Generator) Emergency Lever, FORWARD(OFF)/BACKWARD(ON) 196 sw 2 pos >                  "UFC", "8"  392
	SendData("297", string.format("%.3f", mainPanelDevice:get_argument_value(201)))	-- RSBN Field Elevation Knob 201 axis 0.02 > "Light System", "Console Lights" 297
	
	SendData("393", string.format("%.1f", mainPanelDevice:get_argument_value(333)))	-- Pitot Tube Selector Lever, STBY(Left)/MAIN(Right) 333 sw 2 pos > "UFC", "9" 393
	SendData("531", string.format("%.1f", mainPanelDevice:get_argument_value(257)))	-- CB Missile Seeker Heating Circuit Power Switch, ON/OF 257  sw 2 pos > "UFC", "FWD" 531
	SendData("532", string.format("%.1f", mainPanelDevice:get_argument_value(258)))	-- CB Missile Seeker Glowing Circuit Power Switch, ON/OFF 258 sw 2 pos > "UFC", "MID" 532
	SendData("533", string.format("%.1f", mainPanelDevice:get_argument_value(576)))	-- Gsh-23 Arm/Safe 576 sw 2 pos > "UFC", "AFT" 533
	SendData("272", string.format("%.1d", mainPanelDevice:get_argument_value(311)))	-- Taxi and Landing Lights (Searchlights) Control Switch, TAXI/OFF/LANDING  311 sw 3 pos -1.0 0.0 1.0 > "HARS", "Magnetic Variation" 272
	SendData("395", string.format("%.1f", mainPanelDevice:get_argument_value(136)))	-- Air Brake Switch 136 sw 2 pos > "UFC", "0" 395
	SendData("225", string.format("%.3f", mainPanelDevice:get_argument_value(288)))	-- Intercom Volume Knob 288 axis lim 0.05 0.0 0.8 >	"Intercom", "VHF Volume" 225
	SendData("227", string.format("%.3f", mainPanelDevice:get_argument_value(289)))	-- Radio Volume Knob 289 axis lim 0.05 0.0 0.8 >   	"Intercom", "UHF Volume" 227
	SendData("229", string.format("%.3f", mainPanelDevice:get_argument_value(120)))	-- Diffuser and Flight Suit Temperature Rheostat 120 axis 0.1 > "Intercom", "AIM Volume" 229
	SendData("231", string.format("%.3f", mainPanelDevice:get_argument_value(259)))	-- Missile Seeker Tone Volume Knob 259 axis 0.1 > "Intercom", "IFF Volume" 231
	SendData("233", string.format("%.3f", mainPanelDevice:get_argument_value(331)))	-- Instrument Lights Intensity Knob 331 axis 0.1 > "Intercom", "ILS Volume" 233
	SendData("235", string.format("%.3f", mainPanelDevice:get_argument_value(306)))	-- Oxygen Supply Valve (CLOSE - CW, OPEN - CCW) 306 axis 0.05 >           "Intercom", "TCN Volume"    235
	SendData("238", string.format("%.3f", mainPanelDevice:get_argument_value(484)))	-- Oxygen Interconnaction Valve (CLOSE - CW, OPEN - CCW) 484 axis 0.05  > "Intercom", "Master Volume" 238
	SendData("704", string.format("%.3f", mainPanelDevice:get_argument_value(245)))	-- ECS and Pressurization Handle, OFF/CANOPIES SEALED/ECS ON 245 axis 0.1 > "Stall Warning", "Stall Volume" 704
	SendData("22", string.format("%.3f", mainPanelDevice:get_argument_value(334)/2))-- Emergency/Parking Wheel Brake Lever 334 axis lim 0.1 -1.0 1.0 > "ADI", "Pitch Trim Knob" 22 -0.5 a 0.5
	SendData("705", string.format("%.3f", mainPanelDevice:get_argument_value(296)))	-- Fuel Shut-Off Lever 296 lever 0.0 1.0 > "Stall Warning", "Peak Volume" 705 
	SendData("261", string.format("%.3f", mainPanelDevice:get_argument_value(284)))	-- R-832M Preset Channel Selector Knob 284 multi sw 20 pos 0.05 > "TACAN", "Volumne" 261
	multi_sw_172=mainPanelDevice:get_argument_value(172)
	if multi_sw_172 >0.04 and multi_sw_172 < 0.06 then multi_sw_172= 0.3 end
	if multi_sw_172 >0.12 and multi_sw_172 < 0.16 then multi_sw_172= 0.3 end
	if multi_sw_172 >0.22 then multi_sw_172= 0.3 end
	SendData("135", string.format("%.1f", multi_sw_172)) -- Cabin Air Conditioning Control Switch, OFF/HEAT/COOL/AUTOMATIC 172 multi sw 4 pos 0.05 > "VHF AM Radio", "Frequency Selection Dial" 135
	multi_sw_121=mainPanelDevice:get_argument_value(121)
	if multi_sw_121 >0.04 and multi_sw_121 < 0.06 then multi_sw_121= 0.3 end
	if multi_sw_121 >0.12 and multi_sw_121 < 0.16 then multi_sw_121= 0.3 end
	if multi_sw_121 >0.22 then multi_sw_121= 0.3 end
	SendData("149", string.format("%.1f", multi_sw_121))-- Diffuser and Flight Suit Air Conditioning Control Switch, HEAT/AUTO/COOL 121 sw 3 pos 0.05 > "VHF FM Radio", "Frequency Selection Dial" 149
	SendData("268", string.format("%.3f", mainPanelDevice:get_argument_value(532)))	-- Magnetic Declination set knob {0.0, 1.0} in 0.05 Steps 532 axis 0.05 > "HARS", "Sync Button Rotate" 268 
	SendData("195", string.format("%.3f", mainPanelDevice:get_argument_value(57)))	-- Baro pressure QFE knob 57 axis 0.6 > "Light System", "Weapon Station Lights Brightness" 195
	SendData("193", string.format("%.3f", mainPanelDevice:get_argument_value(61)))	-- RV-5M Radio Altimeter Decision Height Knob 61 axis 0.2 > "Light System", "Refuel Status Indexer Brightness" 193
	SendData("451", string.format("%.1f", mainPanelDevice:get_argument_value(60)))	-- RV-5M Radio Altimeter Test Button 60 sw 2 pos > "CDU", "O" 451
	SendData("450", string.format("%.1f", mainPanelDevice:get_argument_value(30)))	-- KPP-1273K Attitude Director Indicator (ADI) Cage Button 30 btn > "CDU", "N" 450
	SendData("192", string.format("%.3f", mainPanelDevice:get_argument_value(39)))	-- KPP-1273K Attitude Director Indicator (ADI) Pitch Trim Knob 39 axis 0.05 -1 1 > "Autopilot", "Yaw Trim" 192
	SendData("271", string.format("%.3f", mainPanelDevice:get_argument_value(48)))	-- HSI Course set knob 48 axis 0.15 > "HARS", "Latitude Correction" 271
	SendData("249", string.format("%.3f", mainPanelDevice:get_argument_value(569)))	-- Variometer adjustment knob 569 axis 0.1 > "ILS", "Volume" 249 
	SendData("452", string.format("%.1f", mainPanelDevice:get_argument_value(89)))	-- Reset Limits 89 btn > "CDU", "P" 452
	SendData("132", string.format("%.1d", mainPanelDevice:get_argument_value(335)))	-- Mech clock left lever (right click) 335 btn -1.0 > "Autopilot", "Mode Selection" 132
	SendData("116", string.format("%.3f", mainPanelDevice:get_argument_value(336)))	-- Mech clock left lever  336 lever 0.04 > "Light System", "Refueling Lighting Dial" 116
	SendData("453", string.format("%.3f", mainPanelDevice:get_argument_value(337)))	-- Mech clock right lever 337 btn > "CDU", "Q" 453
	SendData("368", string.format("%.3f", mainPanelDevice:get_argument_value(338)))	-- Mech clock right lever 338 lever 0.1> "CMSC", "RWR Volume" 368
	SendData("189", string.format("%.1d", mainPanelDevice:get_argument_value(118)))	-- Landing Gear Control Lever 118 sw 3 pos  -1.0 0.0 1.0 > "Autopilot", "Monitor Test Left/Right" 189
	
	
	
	
	
	----------------------------------------------------------------------------  L39ZA  -------------------------------------------------------------
	FlushData()
end












--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Pointed to by ProcessLowImportance, if the player aircraft is a FA18C (using A10C interface)


function Process_FA18C_LowImportance(mainPanelDevice)


																							-- FA18C  						>  A10C
	--lamps
		SendData("540", string.format("%.1d", mainPanelDevice:get_argument_value(298)) )   -- CPT_LTS_CK_SEAT				>  "AOA Indexer", "High Indicator", "High AOA indicator light."
		SendData("542", string.format("%.1d", mainPanelDevice:get_argument_value(299)) )   -- CPT_LTS_APU_ACC				>  "AOA Indexer", "Low Indicator", "Low AOA indicator light."
		SendData("730", string.format("%.1d", mainPanelDevice:get_argument_value(300)) )   -- CPT_LTS_BATT_SW				>  "Refuel Indexer", "Ready Indicator", "Refuel ready indicator light."
		SendData("731", string.format("%.1d", mainPanelDevice:get_argument_value(301)) )   -- CPT_LTS_FCS_HOT				>  "Refuel Indexer", "Latched Indicator", "Refuel latched indicator light."
		SendData("732", string.format("%.1d", mainPanelDevice:get_argument_value(302)) )   -- CPT_LTS_GEN_TIE				>  "Refuel Indexer", "Disconnect Indicator", "Refuel disconnect indicator light."
		SendData("662", string.format("%.1d", mainPanelDevice:get_argument_value(303)) )   -- CPT_LTS_SPARE_CTN1			>  "Misc", "Gun Ready Indicator", "Indicator is lit when the GAU-8 cannon is armed and ready to fire."
		SendData("216", string.format("%.1d", mainPanelDevice:get_argument_value(304)) )   -- CPT_LTS_FUEL_LO				>  "Fire System", "APU Fire Indicator", "Indicator lights when a fire is detedted in the APU."
		SendData("217", string.format("%.1d", mainPanelDevice:get_argument_value(305)) )   -- CPT_LTS_FCES					>  "Fire System", "Right Engine Fire Indicator", "Indicator lights when a fire is detected in the right engine."
		SendData("404", string.format("%.1d", mainPanelDevice:get_argument_value(306)) )   -- CPT_LTS_SPARE_CTN2			>  "UFC", "Master Caution Indicator", "Indicator lamp on master caution button." 
		SendData("659", string.format("%.1d", mainPanelDevice:get_argument_value(307)) )   -- CPT_LTS_L_GEN					>  "Mechanical", "Gear Nose Safe Indicator", "Lit when the nose gear is down and locked."
		SendData("661", string.format("%.1d", mainPanelDevice:get_argument_value(308)) )   -- CPT_LTS_R_GEN					>  "Mechanical", "Gear Right Safe Indicator", "Lit when the right gear is down and locked."
		SendData("737", string.format("%.1d", mainPanelDevice:get_argument_value(309)) )   -- CPT_LTS_SPARE_CTN3			>  "Mechanical", "Gear Handle Indicator", "Lit when the landing gear are moving between down and stowed position."
		SendData("606", string.format("%.1d", mainPanelDevice:get_argument_value( 13)) )   -- CPT_LTS_MASTER_CAUTION		>  "Navigation Mode Select Panel", "HARS Indicator", "HARS button indicator lamp."
		SendData("608", string.format("%.1d", mainPanelDevice:get_argument_value( 10)) )   -- CPT_LTS_FIRE_LEFT				>  "Navigation Mode Select Panel", "EGI Indicator", "EGI button indicator lamp."
		SendData("610", string.format("%.1d", mainPanelDevice:get_argument_value( 15)) )   -- CPT_LTS_GO					>  "Navigation Mode Select Panel", "TISL Indicator", "TISL button indicator lamp."
		SendData("612", string.format("%.1d", mainPanelDevice:get_argument_value( 16)) )   -- CPT_LTS_NO_GO					>  "Navigation Mode Select Panel", "STEERPT Indicator", "STEERPT button indicator lamp."
		SendData("614", string.format("%.1d", mainPanelDevice:get_argument_value( 17)) )   -- CPT_LTS_L_BLEED				>  "Navigation Mode Select Panel", "ANCHR Indicator", "ANCHR button indicator lamp."
		SendData("616", string.format("%.1d", mainPanelDevice:get_argument_value( 18)) )   -- CPT_LTS_R_BLEED				>  "Navigation Mode Select Panel", "TCN Indicator", "TCN button indicator lamp."
		SendData("484", string.format("%.1d", mainPanelDevice:get_argument_value( 19)) )   -- CPT_LTS_SPD_BRK				>  "Caution Panel", "ANTI SKID", "Lit if landing gear is down but anti-skid is disengaged."
		SendData("485", string.format("%.1d", mainPanelDevice:get_argument_value( 20)) )   -- CPT_LTS_STBY					>  "Caution Panel", "L-HYD RES", "Lit if left hyudraulic fluid reservoir is low."
		SendData("46",  string.format("%.1d", mainPanelDevice:get_argument_value( 21)) )   -- CPT_LTS_L_BAR_RED				>  "HSI", "Bearing Flag" 
		SendData("488", string.format("%.1d", mainPanelDevice:get_argument_value( 22)) )   -- CPT_LTS_REC					>  "Caution Panel", "ELEV DISENG", "Lit if at least one elevator is disengaged from the Emergency Flight Control panel."
		SendData("489", string.format("%.1d", mainPanelDevice:get_argument_value( 23)) )   -- CPT_LTS_L_BAR_GREEN			>  "Caution Panel", "VOID1", ""
		SendData("491", string.format("%.1d", mainPanelDevice:get_argument_value( 24)) )   -- CPT_LTS_XMIT					>  "Caution Panel", "BLEED AIR LEAK", "Lit if bleed air is 400 degrees or higher."
		SendData("493", string.format("%.1d", mainPanelDevice:get_argument_value( 25)) )   -- CPT_LTS_ASPJ_OH				>  "Caution Panel", "L-AIL TAB", "Lit if left aileron is not at normal positoin due to MRFCS."
		SendData("495", string.format("%.1d", mainPanelDevice:get_argument_value( 29)) )   -- CPT_LTS_FIRE_APU				>  "Caution Panel", "SERVICE AIR HOT", "Lit if air temperature exceeds allowable ECS range."
		SendData("496", string.format("%.1d", mainPanelDevice:get_argument_value( 26)) )   -- CPT_LTS_FIRE_RIGHT			>  "Caution Panel", "PITCH SAS", "Lit if at least one pitch SAS channel has been disabled."
		SendData("497", string.format("%.1d", mainPanelDevice:get_argument_value( 31)) )   -- CPT_LTS_RCDR_ON				>  "Caution Panel", "L-ENG HOT", "Lit if left engine ITT exceeds 880 degrees C."
		SendData("498", string.format("%.1d", mainPanelDevice:get_argument_value( 32)) )   -- CPT_LTS_DISP					>  "Caution Panel", "R-ENG HOT", "Lit if right engine ITT exceeds 880 degrees C."
		SendData("499", string.format("%.1d", mainPanelDevice:get_argument_value( 38)) )   -- CPT_LTS_SAM					>  "Caution Panel", "WINDSHIELD HOT", "Lit if windshield temperature exceeds 150 degrees F."
		SendData("504", string.format("%.1d", mainPanelDevice:get_argument_value( 39)) )   -- CPT_LTS_AI					>  "Caution Panel", "GCAS", "Lit if LASTE failure is detected that affects GCAS."
		SendData("507", string.format("%.1d", mainPanelDevice:get_argument_value( 40)) )   -- CPT_LTS_AAA					>  "Caution Panel", "VOID2", ""
		SendData("509", string.format("%.1d", mainPanelDevice:get_argument_value( 41)) )   -- CPT_LTS_CW					>  "Caution Panel", "L-WING PUMP", "Lit if boost pump pressure is low."
		SendData("511", string.format("%.1d", mainPanelDevice:get_argument_value( 33)) )   -- CPT_LTS_SPARE_RH1				>  "Caution Panel", "HARS", "Lit if44,  HARS heading or attitude is invalid."
		SendData("512", string.format("%.1d", mainPanelDevice:get_argument_value( 34)) )   -- CPT_LTS_SPARE_RH2				>  "Caution Panel", "IFF MODE-4", "Lit if inoperative mode 4 capability is detected."
		SendData("513", string.format("%.1d", mainPanelDevice:get_argument_value( 35)) )   -- CPT_LTS_SPARE_RH3				>  "Caution Panel", "L-MAIN FUEL LOW", "Lit if left main fuel tank has 500 pounds or less."
		SendData("515", string.format("%.1d", mainPanelDevice:get_argument_value( 36)) )   -- CPT_LTS_SPARE_RH4				>  "Caution Panel", "L-R TKS UNEQUAL", "Lit if thers is a 750 or more pund difference between the two main fuel tanks."
		SendData("517", string.format("%.1d", mainPanelDevice:get_argument_value( 37)) )   -- CPT_LTS_SPARE_RH5				>  "Caution Panel", "L-FUEL PRESS", "Lit if low fuel pressure is detected in fuel feed lines."
		SendData("518", string.format("%.1d", mainPanelDevice:get_argument_value(152)) )   -- CPT_LTS_CTR					>  "Caution Panel", "R-FUEL PRESS", "Lit if low fuel pressure is detected in fuel feed lines."
		SendData("519", string.format("%.1d", mainPanelDevice:get_argument_value(154)) )   -- CPT_LTS_LI					>  "Caution Panel", "NAV", "Lit if there is a CDU failure while in alignment mode."
		SendData("520", string.format("%.1d", mainPanelDevice:get_argument_value(156)) )   -- CPT_LTS_LO					>  "Caution Panel", "STALL SYS", "Lit if there is a power failure to the AoA and Mach meters."
		SendData("521", string.format("%.1d", mainPanelDevice:get_argument_value(158)) )   -- CPT_LTS_RI					>  "Caution Panel", "L-CONV", "Lit if left electrical converter fails."
		SendData("522", string.format("%.1d", mainPanelDevice:get_argument_value(160)) )   -- CPT_LTS_RO					>  "Caution Panel", "R-CONV", "Lit if right electrical converter fails."
		SendData("523", string.format("%.1d", mainPanelDevice:get_argument_value(166)) )   -- CPT_LTS_NOSE_GEAR				>  "Caution Panel", "CADC", "Lit if CADC has failed."
		SendData("525", string.format("%.1d", mainPanelDevice:get_argument_value(165)) )   -- CPT_LTS_LEFT_GEAR				>  "Caution Panel", "L-GEN", "Lit if left generator has shut down or AC power is out of limits."
		SendData("527", string.format("%.1d", mainPanelDevice:get_argument_value(167)) )   -- CPT_LTS_RIGHT_GEAR			>  "Caution Panel", "INST INV", "Lit if AC powered systems are not receiving power from inverter."
		SendData("191", string.format("%.1d", mainPanelDevice:get_argument_value(163)) )   -- CPT_LTS_HALF_FLAPS			>  "Autopilot", "Take Off Trim Indicator", "Lit when reseting autopilot for take off trim"
		SendData("799", string.format("%.1d", mainPanelDevice:get_argument_value(164)) )   -- CPT_LTS_FULL_FLAPS			>  "IFF", "Test Lamp", ""
		SendData("178", string.format("%.1d", mainPanelDevice:get_argument_value(162)) )   -- CPT_LTS_FLAPS					>  "Autopilot", "Left Aileron Disengage Indicator", "Lit when the left aileron is disengaged."
		SendData("181", string.format("%.1d", mainPanelDevice:get_argument_value(  1)) )   -- CPT_LTS_LOCK					>  "Autopilot", "Left Elevator Disengage Indicator", "Lit when the left elevator is disengaged."
		SendData("55",  string.format("%.1d", mainPanelDevice:get_argument_value(  2)) )   -- CPT_LTS_SHOOT					>  "AOA", "Off Flag", ""
		SendData("25",  string.format("%.1d", mainPanelDevice:get_argument_value(  3)) )   -- CPT_LTS_SHOOT_STROBE			>  "ADI", "Attitude Warning Flag", "Indicates that the ADI has lost electrical power or otherwise been disabled."
		SendData("26",  string.format("%.1d", mainPanelDevice:get_argument_value( 47)) )   -- CPT_LTS_AA					>  "ADI", "Glide Slope Warning Flag", "Indicates that the ADI is not recieving a ILS glide slope signal."
		SendData("40",  string.format("%.1d", mainPanelDevice:get_argument_value( 48)) )   -- CPT_LTS_AG					>  "HSI", "Power Off Flag"
		SendData("32",  string.format("%.1d", mainPanelDevice:get_argument_value( 45)) )   -- CPT_LTS_DISCH					>  "HSI", "Range Flag"
		SendData("541", string.format("%.1d", mainPanelDevice:get_argument_value( 44)) )   -- CPT_LTS_READY					>  "AOA Indexer", "Normal Indicator", "Norm AOA indidcator light."
		SendData("663", string.format("%.1d", mainPanelDevice:get_argument_value(294)) )   -- CPT_LTS_HOOK					>  "Misc", "Nose Wheel Steering Indicator", "Indicator is lit when nose wheel steering is engaged."
		--SendData("665", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_LDG_GEAR_HANDLE *		>  "Misc", "Canopy Unlocked Indicator", "Indicator is lit when canopy is open."
		SendData("664", string.format("%.1d", mainPanelDevice:get_argument_value(376)) )   -- CPT_LTS_APU_READY	 			>  "Misc", "Marker Beacon Indicator", "Indicator is lit when in ILS mode and a beacon is overflown."
		--SendData("215", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_SEL *	 				>  "Fire System", "Left Engine Fire Indicator", "Indicator lights when a fire is detected in the left engine."
		SendData("372", string.format("%.1d", mainPanelDevice:get_argument_value(137)) )   -- CPT_LTS_SPN	 				>  "CMSC", "Missle Launch Indicator", "Flashes when missile has been launched near your aircraft."
		SendData("373", string.format("%.1d", mainPanelDevice:get_argument_value(290)) )   -- CPT_LTS_LOW_ALT_WARN	 		>  "CMSC", "Priority Status Indicator", "Lit when priority display mode is active."
		--SendData("374", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_ARM_LEFT *			>  "CMSC", "Unknown Status Indicator", "Lit when unknown threat display is active."
		--SendData("660", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_ARM_RIGHT *			>  "Mechanical", "Gear Left Safe Indicator", "Lit when the left gear is down and locked."
		--SendData("618", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_SAFE_LEFT *			>  "Navigation Mode Select Panel", "ILS Indicator", "ILS button indicator lamp."
		--SendData("619", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_SAFE_RIGHT *			>  "Navigation Mode Select Panel", "UHF Homing Indicator", "Lit when the UHF control panel is ste to ADF."
		--SendData("620", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_CONTR_LEFT *			>  "Navigation Mode Select Panel", "VHF/FM Homing Indicator", "Lit when the VHF/FM control panel is set to homing mode."
		--SendData("600", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_CONTR_RIGHT *			>  "Oxygen System", "Breathflow", "Flashs with each breath."
		--SendData("480", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_DCDR_LEFT*			>  "Caution Panel", "ENG START CYCLE", "Lit if either engine is in engine start process."
		--SendData("481", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_DCDR_RIGHT *			>  "Caution Panel", "L-HYD PRESS", "Lit if left hydraulic system pressure falls below 1,000 psi."
		--SendData("482", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- CPT_LTS_USG_XMT*	 			>  "Caution Panel", "R-HYD PRESS", "Lit if right hydraulic system pressure falls below 1,000 psi."
		SendData("483", string.format("%.1d", mainPanelDevice:get_argument_value(  4)) )   -- CPT_LTS_AOA_HIGH 				>  "Caution Panel", "GUN UNSAFE", "Lit if gun is capable of being fired."
		SendData("487", string.format("%.1d", mainPanelDevice:get_argument_value(  5)) )   -- CPT_LTS_AOA_CENTER			>  "Caution Panel", "OXY LOW", "Lit if oxygen gauge indices 0.5 liters or less."
		SendData("490", string.format("%.1d", mainPanelDevice:get_argument_value(  6)) )   -- CPT_LTS_AOA_LOW      			>  "Caution Panel", "SEAT NOT ARMED", "Lit if ground safety lever is in the safe position."
		SendData("492", string.format("%.1d", mainPanelDevice:get_argument_value(460)) )   -- Console_lt					>  "Caution Panel", "AIL DISENG", "Lit if at least one aileron is disngaged from the Emergency FLight Control panel."
		SendData("494", string.format("%.1d", mainPanelDevice:get_argument_value(461)) )   -- Flood_lt						>  "Caution Panel", "R-AIL TAB", "Lit if right aileron is not at normal positoin due to MRFCS."
		SendData("500", string.format("%.1d", mainPanelDevice:get_argument_value(462)) )   -- NvgFlood_lt					>  "Caution Panel", "YAW SAS", "Lit if at least one yaw SAS channel has been disabled."
		SendData("501", string.format("%.1d", mainPanelDevice:get_argument_value(464)) )   -- EmerInstr_lt					>  "Caution Panel", "L-ENG OIL PRESS", "Lit if left engine oil pressure is less than 27.5 psi."
		SendData("502", string.format("%.1d", mainPanelDevice:get_argument_value(465)) )   -- EngInstFlood_lt				>  "Caution Panel", "R-ENG OIL PRESS", "Lit if right engine oil pressure is less than 27.5 psi."
		SendData("503", string.format("%.1d", mainPanelDevice:get_argument_value(466)) )   -- Instrument_lt					>  "Caution Panel", "CICU", "Lit if ?."
		SendData("505", string.format("%.1d", mainPanelDevice:get_argument_value(467)) )   -- StbyCompass_lt				>  "Caution Panel", "L-MAIN PUMP", "Lit if boost pump pressure is low."
		--SendData("506", string.format("%.1d", mainPanelDevice:get_argument_value(000)) )   -- Utility_lt *					>  "Caution Panel", "R-MAIN PUMP", "Lit if boost pump pressure is low."
		SendData("508", string.format("%.1d", mainPanelDevice:get_argument_value(463)) )   -- Chart_lt						>  "Caution Panel", "LASTE", "Lit if fault is detected in LASTE computer."
			 
							
	-- rockers:
		SendData("356", string.format("%1d", mainPanelDevice:get_argument_value(331) ) ) -- fire test >> CMSP :: Page Cycle
        SendData("424", string.format("%1d", mainPanelDevice:get_argument_value(332) ) ) -- Ground Power Switch 1, A ON/AUTO/B ON >> CDU :: Brightness
        SendData("463", string.format("%1d", mainPanelDevice:get_argument_value(333) ) ) -- Ground Power Switch 2, A ON/AUTO/B ON >> CDU :: Page
        SendData("469", string.format("%1d", mainPanelDevice:get_argument_value(334) ) ) -- Ground Power Switch 3, A ON/AUTO/B ON >> CDU :: Blank
        SendData("472", string.format("%1d", mainPanelDevice:get_argument_value(335) ) ) -- Ground Power Switch 4, A ON/AUTO/B ON >> CDU :: +/- 
		SendData("405", string.format("%1d", mainPanelDevice:get_argument_value(177) ) ) -- AMPCD Night/Day brightness selector >> UFC :: Steer
		SendData("406", string.format("%1d", mainPanelDevice:get_argument_value(179) ) ) -- AMPCD symbology control >> UFC :: Data
		SendData("407", string.format("%1d", mainPanelDevice:get_argument_value(182) ) ) -- AMPCD contrast control >> UFC :: Select
		SendData("408", string.format("%1d", mainPanelDevice:get_argument_value(180) ) ) -- AMPCD gain control >> UFC :: Adjust Depressible Pipper
		SendData("409", string.format("%1d", mainPanelDevice:get_argument_value(312) ) ) -- Left MDI HDG switch >> UFCHUD :: Brightness
		SendData("474", string.format("%1d", mainPanelDevice:get_argument_value(313) ) ) -- Left MDI CRS switch >> AAPSteer :: Toggle Switch
		SendData("718", string.format("%1d", mainPanelDevice:get_argument_value(226) ) ) -- gears >> Mechanical :: Auxiliary Landing Gear Handle
		SendData("622", string.format("%0.1f", mainPanelDevice:get_argument_value(236)+ 0.1 ) ) -- CHART Light Dimmer Control >> TISL :: Mode Select
		SendData("124", string.format("%1d", mainPanelDevice:get_argument_value(377) ) ) -- Engine Crank Switch, LEFT/OFF/RIGHT >> ENGINE_SYSTEM :: Engine Operate Left*
		SendData("134", string.format("%1d", mainPanelDevice:get_argument_value(368) ) ) -- MC Switch, 1 OFF/NORM/2 OFF >> VHF AM Radio :: Squelch / Tone*
		SendData("245", string.format("%1d", mainPanelDevice:get_argument_value(27) ) ) -- Right Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress >> ELEC_INTERFACE :: AC Generator - Right 245
		SendData("244", string.format("%1d", mainPanelDevice:get_argument_value(28) ) ) -- Right Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress/(RMB) cover control >> ELEC_INTERFACE :: AC Generator - Left 244
		SendData("232", string.format("%1d", mainPanelDevice:get_argument_value(11) ) ) -- Left Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress >> Intercom :: IFF Switch 232
		SendData("230", string.format("%1d", mainPanelDevice:get_argument_value(12) ) ) -- Left Engine/AMAD Fire Warning/Extinguisher Light - (LMB) depress/(RMB) cover control >> Intercom :: AIM Switch 230
		SendData("350", string.format("%1d", mainPanelDevice:get_argument_value(354) ) ) -- IFF Crypto Switch, HOLD/NORM/ZERO* >> Right MFCD :: Entity Level
		SendData("323", string.format("%1d", mainPanelDevice:get_argument_value(453) ) ) -- Canopy Control Switch, OPEN/HOLD/CLOSE >> Left MFCD :: Contrast
		SendData("250", string.format("%0.1f", mainPanelDevice:get_argument_value(443) ) ) -- INS Switch, OFF/CV/GND/NAV/IFA/GYRO/GB/TEST >> ILS :: ILS Frequencey Khz    encoder
		SendData("532", string.format("%1d", mainPanelDevice:get_argument_value(292) ) ) -- ID2163A Push to Test Switch >> UFC:: MID
		SendData("346", string.format("%1d", mainPanelDevice:get_argument_value(514) ) ) -- Seat Height Adjustment Switch, UP/HOLD/DOWN >> Right MFCD :: Moving Map Scale

	-- switches	
		SendData("148", string.format("%1d", mainPanelDevice:get_argument_value(336) ) ) -- External Power Switch, RESET/NORM/OFF >> VHF FM Radio :: Squelch / Tone* 
		SendData("241", string.format("%1d",( mainPanelDevice:get_argument_value(30)/2)+0.5)) -- APU Fire Warning/Extinguisher Light >> ELEC_INTERFACE :: APU Generator
		SendData("642", string.format("%0.2f", mainPanelDevice:get_argument_value(352) ) ) -- ILS Channel Selector Switch >> TISL :: TISL Code Wheel 4
		SendData("351", string.format("%0.1f",( mainPanelDevice:get_argument_value(175)+1)/10 )) -- Selector Switch, HMD/LDDI/RDDI >> Right MFCD :: Day/Night/Off 
		SendData("118", string.format("%1d",( mainPanelDevice:get_argument_value(42)/2)+0.5)) -- Canopy Jettison Lever, Pull to jettison >> Fuel System :: Fill Disable Wing Right 
		SendData("401", string.format("%.1f", mainPanelDevice:get_argument_value(43) ) ) -- Canopy Jettison Handle Unlock Button - Press to unlock >> UFC :: Create Overhead Mark Point 
		SendData("273", string.format("%1d",( mainPanelDevice:get_argument_value(511)/2)+0.5)) -- Ejection Seat SAFE/ARMED Handle, SAFE/ARMED >> HARS :: Hemisphere Selecto
		SendData("270", string.format("%1d",( mainPanelDevice:get_argument_value(512)/2)+0.5)) -- Ejection Seat Manual Override Handle, PULL/PUSH >> HARS :: Mode 
		SendData("366", string.format("%.1f", mainPanelDevice:get_argument_value(260) ) ) -- Rudder Pedal Adjust Lever >> CMSC :: Cycle MWS Program Button 
		SendData("365", string.format("%.1f", mainPanelDevice:get_argument_value(380) ) ) -- Dispense Button - Push to dispense flares and chaff >> CMSC :: Cycle JMR Program Button
		SendData("180", string.format("%1d", mainPanelDevice:get_argument_value(295) ) ) -- Wing Fold Control Handle, (RMB)Pull/(LMB)Stow/(MW)Rotate >> Autopilot :: Elevator Emergency Disengage 
		SendData("277", string.format("%0.2f", mainPanelDevice:get_argument_value(418) ) ) -- CHART Light Dimmer Control >> Environmental Control :: Canopy Defog
        SendData("296", string.format("%0.2f", mainPanelDevice:get_argument_value(417) ) ) -- WARN/CAUTION Dimmer Control >> Light System :: Flood Light
        SendData("109", string.format("%1d",( mainPanelDevice:get_argument_value(416)/2)+0.5)) -- LT TEST Switch, TEST/OFF >> Fuel System :: Cross Feed
        SendData("259", string.format("%.1f", mainPanelDevice:get_argument_value(14) ) ) -- MASTER CAUTION Reset Switch, Press to reset >> TACAN :: Test
        SendData("222", string.format("%1d",( mainPanelDevice:get_argument_value(239)/2)+0.5)) -- HOOK BYPASS Switch, FIELD/CARRIER >> Intercom :: INT Switch
        SendData("121", string.format("%1d",( mainPanelDevice:get_argument_value(365)/2)+0.5)) -- OBOGS Control Switch, ON/OFF >> Fuel System :: Refuel Control Lever
        SendData("249", string.format("%0.2f", mainPanelDevice:get_argument_value(366) ) ) -- OXY FLOW Knob >> ILS :: Volume
		SendData("168", string.format("%0.1f", mainPanelDevice:get_argument_value(411) ) ) -- Bleed Air Switch, R OFF/NORM/L OFF/OFF >> UHF Radio :: Frequency Dial
        SendData("267", string.format("%.1f", mainPanelDevice:get_argument_value(412) ) ) -- Bleed Air Switch, AUG PULL >> HARS :: Sync Button Push
        SendData("282", string.format("%1d", mainPanelDevice:get_argument_value(405) ) ) -- ECS Mode Switch, AUTO/MAN/OFF(RAM) >> Environmental Control :: Temp/Press
        SendData("287", string.format("%1d", mainPanelDevice:get_argument_value(408) ) ) -- Cabin Pressure Switch, NORM/DUMP/RAM(DUMP) >> Light System :: Position Flash
	SendData("192", string.format("%0.2f", mainPanelDevice:get_argument_value(451) ) ) -- Defog Handle >> Autopilot :: Yaw Trim
        SendData("261", string.format("%0.2f", mainPanelDevice:get_argument_value(407) ) ) -- Cabin Temperature Knob >> TACAN :: Volumne
        SendData("147", string.format("%0.2f", mainPanelDevice:get_argument_value(406) ) ) -- Suit Temperature Knob >> VHF FM Radio :: Volume
        SendData("470", string.format("%.1f", mainPanelDevice:get_argument_value(46) ) ) -- Fire Extinguisher Switch >> CDU :: CLR
        SendData("468", string.format("%.1f", mainPanelDevice:get_argument_value(458) ) ) -- A/A Master Mode Switch >> CDU :: SPC
        SendData("467", string.format("%.1f", mainPanelDevice:get_argument_value(459) ) ) -- A/G Master Mode Switch >> CDU :: BCK
        SendData("120", string.format("%1d",( mainPanelDevice:get_argument_value(49)/2)+0.5)) -- Master Arm Switch >> Fuel System :: Fill Disable Main Right
        SendData("436", string.format("%.1f", mainPanelDevice:get_argument_value(50) ) ) -- Emergency Jettison Button >> CDU :: Slash
        SendData("283", string.format("%1d",( mainPanelDevice:get_argument_value(258)/2)+0.5)) -- Auxiliary Release Switch, ENABLE/NORM >> Environmental Control :: Main Air Supply
        SendData("280", string.format("%1d",( mainPanelDevice:get_argument_value(153)/2)+0.5)) -- Jett Station Center >> Environmental Control :: Bleed Air
        SendData("279", string.format("%1d",( mainPanelDevice:get_argument_value(155)/2)+0.5)) -- Jett Station Left In >> Environmental Control :: Pitot heat
        SendData("358", string.format("%1d",( mainPanelDevice:get_argument_value(157)/2)+0.5)) -- Jett Station Left Out >> CMSP :: ECM Pod Jettison
        SendData("291", string.format("%1d",( mainPanelDevice:get_argument_value(159)/2)+0.5)) -- Jett Station Right In >> Light System :: Nose Illumination
        SendData("107", string.format("%1d",( mainPanelDevice:get_argument_value(161)/2)+0.5)) -- Jett Station Righr Out >> Fuel System :: External Fuselage Tank Boost Pump
        SendData("435", string.format("%.1f", mainPanelDevice:get_argument_value(235) ) ) -- Selective Jettison >> CDU :: Point
		SendData("654", string.format("%0.1f", mainPanelDevice:get_argument_value(236) ) ) -- Selective Jettison Knob, L FUS MSL/SAFE/R FUS MSL/ RACK/LCHR /STORES >> Fuel System :: Fuel Display Selector
        SendData("138", string.format("%0.1f", mainPanelDevice:get_argument_value(135) ) ) -- IR COOLING, ORIDE/NORM/OFF >> VHF AM Radio :: Frequency Mode Dial
        SendData("162", string.format("%0.1f", mainPanelDevice:get_argument_value(140) ) ) -- HUD Symbology Reject Switch >> UHF Radio :: 100Mhz Selector
        SendData("704", string.format("%0.2f", mainPanelDevice:get_argument_value(141) ) ) -- HUD Symbology Brightness Control >> Stall Warning :: Stall Volume
        SendData("381", string.format("%1d",( mainPanelDevice:get_argument_value(142)/2)+0.5)) -- HUD Symbology Brightness Selector Knob >> AHCP :: HUD Norm/Standbyh
        SendData("238", string.format("%0.2f", mainPanelDevice:get_argument_value(143) ) ) -- Black Level Control >> Intercom :: Master Volume
        SendData("655", string.format("%0.1f", mainPanelDevice:get_argument_value(144) ) ) -- HUD Video Control Switch >> Light System :: Land/Taxi Lights
        SendData("233", string.format("%0.2f", mainPanelDevice:get_argument_value(145) ) ) -- Balance Control >> Intercom :: ILS Volume
        SendData("223", string.format("%0.2f", mainPanelDevice:get_argument_value(146) ) ) -- AOA Indexer Control >> Intercom :: FM Volume
        SendData("382", string.format("%1d",( mainPanelDevice:get_argument_value(147)/2)+0.5)) -- Altitude Switch >> AHCP :: CICU Power
        SendData("272", string.format("%1d", mainPanelDevice:get_argument_value(148) ) ) -- Attitude Selector Switch >> HARS :: Magnetic Variation
        SendData("379", string.format("%0.1f", mainPanelDevice:get_argument_value(51) ) ) -- Left MDI Off/Night/Day switch >> AHCP :: Altimeter Source
        SendData("284", string.format("%0.2f", mainPanelDevice:get_argument_value(52) ) ) -- Left MDI brightness control >> Environmental Control :: Flow Level
        SendData("229", string.format("%0.2f", mainPanelDevice:get_argument_value(53) ) ) -- Left MDI contrast control >> Intercom :: AIM Volume
        SendData("300", string.format("%.1f", mainPanelDevice:get_argument_value(54) ) ) -- Left MDI PB 1 >> Left MFCD :: OSB1
        SendData("301", string.format("%.1f", mainPanelDevice:get_argument_value(55) ) ) -- Left MDI PB 2 >> Left MFCD :: OSB2
        SendData("302", string.format("%.1f", mainPanelDevice:get_argument_value(56) ) ) -- Left MDI PB 3 >> Left MFCD :: OSB3
        SendData("303", string.format("%.1f", mainPanelDevice:get_argument_value(57) ) ) -- Left MDI PB 4 >> Left MFCD :: OSB4
        SendData("304", string.format("%.1f", mainPanelDevice:get_argument_value(58) ) ) -- Left MDI PB 5 >> Left MFCD :: OSB5
        SendData("305", string.format("%.1f", mainPanelDevice:get_argument_value(59) ) ) -- Left MDI PB 6 >> Left MFCD :: OSB6
        SendData("306", string.format("%.1f", mainPanelDevice:get_argument_value(60) ) ) -- Left MDI PB 7 >> Left MFCD :: OSB7
        SendData("307", string.format("%.1f", mainPanelDevice:get_argument_value(61) ) ) -- Left MDI PB 8 >> Left MFCD :: OSB8
        SendData("308", string.format("%.1f", mainPanelDevice:get_argument_value(62) ) ) -- Left MDI PB 9 >> Left MFCD :: OSB9
        SendData("309", string.format("%.1f", mainPanelDevice:get_argument_value(63) ) ) -- Left MDI PB 10 >> Left MFCD :: OSB10
        SendData("310", string.format("%.1f", mainPanelDevice:get_argument_value(64) ) ) -- Left MDI PB 11 >> Left MFCD :: OSB11
        SendData("311", string.format("%.1f", mainPanelDevice:get_argument_value(65) ) ) -- Left MDI PB 12 >> Left MFCD :: OSB12
        SendData("312", string.format("%.1f", mainPanelDevice:get_argument_value(66) ) ) -- Left MDI PB 13 >> Left MFCD :: OSB13
        SendData("114", string.format("%1d",( mainPanelDevice:get_argument_value(353)/2)+0.5)) -- ILS UFC/MAN Switch, UFC/MAN >> Fuel System :: Signal Amplifier
		SendData("135", string.format("%0.1f", mainPanelDevice:get_argument_value(444) ) ) -- KY-58 Mode Select Knob, P/C/LD/RV >> VHF AM Radio :: Frequency Selection Dial
        SendData("235", string.format("%0.2f", mainPanelDevice:get_argument_value(445) ) ) -- KY-58 Volume Control Knob >> Intercom :: TCN Volume
		SendData("473", string.format("%0.1f", mainPanelDevice:get_argument_value(447) ) ) -- KY-58 Power Select Knob, OFF/ON/TD >> AAP :: Steer Point Dial
        SendData("420", string.format("%.1f", mainPanelDevice:get_argument_value(230) ) ) -- Warning Tone Silence Button - Push to silence >> CDU :: WP MENU
        SendData("607", string.format("%.1f", mainPanelDevice:get_argument_value(277) ) ) -- ALR-67 POWER Pushbutton >> Navigation Mode Select Panel :: EGI
        SendData("605", string.format("%.1f", mainPanelDevice:get_argument_value(275) ) ) -- ALR-67 DISPLAY Pushbutton >> Navigation Mode Select Panel :: HARS
        SendData("613", string.format("%.1f", mainPanelDevice:get_argument_value(272) ) ) -- ALR-67 SPECIAL Pushbutton >> Navigation Mode Select Panel :: ANCHR
        SendData("609", string.format("%.1f", mainPanelDevice:get_argument_value(269) ) ) -- ALR-67 OFFSET Pushbutton >> Navigation Mode Select Panel :: TISL
        SendData("611", string.format("%.1f", mainPanelDevice:get_argument_value(266) ) ) -- ALR-67 BIT Pushbutton >> Navigation Mode Select Panel :: STEERPT
        SendData("705", string.format("%0.2f", mainPanelDevice:get_argument_value(263) ) ) -- ALR-67 DMR Control Knob >> Stall Warning :: Peak Volume
		SendData("262", string.format("%0.1f", mainPanelDevice:get_argument_value(261) ) ) -- ALR-67 DIS TYPE Switch, N/I/A/U/F >> TACAN :: Mode
        SendData("116", string.format("%0.2f", mainPanelDevice:get_argument_value(216) ) ) -- RWR Intensity Knob >> Light System :: Refueling Lighting Dial"
		SendData("419", string.format("%.1f", mainPanelDevice:get_argument_value(380) ) ) -- Dispense Button - Push to dispense flares and chaff >> CDU :: NAV
		SendData("376", string.format("%0.1f", mainPanelDevice:get_argument_value(517) ) ) -- DISPENSER Switch, BYPASS/ON/OFF >> AHCP :: Gun Arm 
        SendData("170", string.format("%1d", mainPanelDevice:get_argument_value(515) ) ) -- ECM JETT JETT SEL Button - Push to jettison >> UHF Radio :: Squelch
		SendData("364", string.format("%0.1f", mainPanelDevice:get_argument_value(248) ) ) -- ECM Mode Switch, XMIT/REC/BIT/STBY/OFF >> CMSP :: Mode Select Dial
		SendData("112", string.format("%1d",( mainPanelDevice:get_argument_value(507)/2)+0.5)) -- NUC WPN Switch, ENABLE/DISABLE (no function) >> Fuel System :: Boost Pump Main Fuseloge Left
        SendData("384", string.format("%0.1f",( mainPanelDevice:get_argument_value(176)+1)/10 )) -- Selector Switch, HUD/LDIR/RDDI >> AHCP :: IFFCC Power
        SendData("375", string.format("%0.1f",( mainPanelDevice:get_argument_value(314)+1)/10 )) -- Mode Selector Switch, MAN/OFF/AUTO >> AHCP :: Master Arm
	SendData("423", string.format("%.1f", mainPanelDevice:get_argument_value(7) ) ) -- HUD Video BIT Initiate Pushbutton - Push to initiate BIT >> CDU :: PREV
        SendData("288", string.format("%0.2f", mainPanelDevice:get_argument_value(136) ) ) -- HMD OFF/BRT Knob >> Light System :: Formation Lights
        SendData("194", string.format("%0.1f",( mainPanelDevice:get_argument_value(439)/5))) -- FLIR Switch, ON/STBY/OFF >> Light System :: Nightvision Lights
        SendData("325", string.format("%0.1f",( mainPanelDevice:get_argument_value(441)/5))) -- LTD/R Switch, ARM/SAFE/AFT >> Left MFCD :: Day/Night/Off 
        SendData("477", string.format("%1d",( mainPanelDevice:get_argument_value(442)/2)+0.5)) -- LST/NFLR Switch, ON/OFF >> AAP :: EGI Power
	SendData("370", string.format("%.1f", mainPanelDevice:get_argument_value(315) ) ) -- Left Video Sensor BIT Initiate Pushbutton - Push to initiate BIT >> CMSC :: Separate Button
	SendData("422", string.format("%.1f", mainPanelDevice:get_argument_value(318) ) ) -- Right Video Sensor BIT Initiate Pushbutton - Push to initiate BIT >> CDU :: FPMENU
        SendData("169", string.format("%1d", mainPanelDevice:get_argument_value(410) ) ) -- Engine Anti-Ice Switch, ON/OFF/TEST >> UHF Radio :: T/Tone Switch
        SendData("108", string.format("%1d",( mainPanelDevice:get_argument_value(297)/2)+0.5)) -- AV COOL Switch, NORM/EMERG >> Fuel System :: Tank Gate
        SendData("206", string.format("%1d", mainPanelDevice:get_argument_value(452) ) ) -- Windshield Anti-Ice/Rain Switch, ANTI ICE/OFF/RAIN >> IFF :: RAD Test/Monitor Switch
		SendData("126", string.format("%1d",( mainPanelDevice:get_argument_value(348)/2)+0.5)) -- GAIN Switch Cover >> Engine System :: APU
        SendData("110", string.format("%1d",( mainPanelDevice:get_argument_value(347)/2)+0.5)) -- GAIN Switch, NORM/ORIDE >> Fuel System :: Boost Pump Left Wing
        SendData("205", string.format("%1d", mainPanelDevice:get_argument_value(234) ) ) -- FLAP Switch, AUTO/HALF/FULL >> IFF :: M-C Switch
		SendData("123", string.format("%1d",( mainPanelDevice:get_argument_value(139)/2)+0.5)) -- SPIN Recovery Switch Cover >> Engine System :: Right Engine Fuel Flow Control
		SendData("111", string.format("%1d",( mainPanelDevice:get_argument_value(138)/2)+0.5)) -- SPIN Recovery Switch, RCVY/NORM >> Fuel System :: Boost Pump Right Wing
		SendData("471", string.format("%.1f", mainPanelDevice:get_argument_value(470) ) ) -- CS BIT switch >> CDU :: FA
        SendData("105", string.format("%1d", mainPanelDevice:get_argument_value(404) ) ) -- Battery Switch, ON/OFF/ORIDE >> Fire System :: Discharge Switch
        SendData("380", string.format("%1d", mainPanelDevice:get_argument_value(403) ) ) -- Right Generator Switch, NORM/OFF >> AHCP :: HUD Day/Night
        SendData("780", string.format("%1d",( mainPanelDevice:get_argument_value(379)/2)+0.5)) -- Generator TIE Control Switch Cover, OPEN/CLOSE >> KY-58 Secure Voice :: Delay
        SendData("104", string.format("%1d", mainPanelDevice:get_argument_value(378) ) ) -- Generator TIE Control Switch, NORM/RESET >> FIRE_SYSTEM :: Right Engine Fire Pull
        SendData("716", string.format("%1d", mainPanelDevice:get_argument_value(336) ) ) -- External Power Switch, RESET/NORM/OFF >> CPT_MECH :: Landing Gear Lever
        SendData("226", string.format("%1d",( mainPanelDevice:get_argument_value(409)/2)+0.5)) -- Anti Ice Pitot Switch, ON/AUTO >> Intercom :: VHF Switch
		SendData("234", string.format("%1d", mainPanelDevice:get_argument_value(381) ) ) -- CB FCS CHAN 1, ON/OFF >> Intercom :: ILS Switch
		SendData("175", string.format("%1d", mainPanelDevice:get_argument_value(382) ) ) -- CB FCS CHAN 2, ON/OFF >> Autopilot :: Pitch/Roll Emergency Override
		SendData("184", string.format("%1d", mainPanelDevice:get_argument_value(383) ) ) -- CB SPD BRK, ON/OFF >> Autopilot :: Manual Reversion Flight Control System Switch
		SendData("224", string.format("%1d", mainPanelDevice:get_argument_value(384) ) ) -- CB LAUNCH BAR, ON/OFF >> Intercom :: FM Switch
		SendData("237", string.format("%1d", mainPanelDevice:get_argument_value(454) ) ) -- CB FCS CHAN 3, ON/OFF >> Intercom :: Hot Mic Switch
		SendData("236", string.format("%1d", mainPanelDevice:get_argument_value(455) ) ) -- CB FCS CHAN 4, ON/OFF >> Intercom :: TCN Switch
		SendData("174", string.format("%1d", mainPanelDevice:get_argument_value(456) ) ) -- CB HOOK, ON/OFF >> Autopilot :: Speed Brake Emergency Retract
		SendData("183", string.format("%1d", mainPanelDevice:get_argument_value(457) ) ) -- CB LG, ON/OFF >> Autopilot :: Flaps Emergency Retract
        SendData("378", string.format("%1d", mainPanelDevice:get_argument_value(402) ) ) -- Left Generator Switch, NORM/OFF >> AHCP :: TGP Power
        SendData("102", string.format("%1d", mainPanelDevice:get_argument_value(375) ) ) -- APU Control Switch - ON/OFF >> FIRE_SYSTEM :: Left Engine Fire Pull
        SendData("784", string.format("%1d",( mainPanelDevice:get_argument_value(369)/2)+0.5)) -- Hydraulic Isolate Override Switch, NORM/ORIDE >> KY-58 Secure Voice :: Power Switch
        SendData("354", string.format("%.1f", mainPanelDevice:get_argument_value(229) ) ) -- Down Lock Override Button - Push to unlock >> CMSP :: OSB 3
        SendData("117", string.format("%1d",( mainPanelDevice:get_argument_value(238)/2)+0.5)) -- Anti Skid Switch, ON/OFF >> Fuel System :: Fill Disable Wing Left
        SendData("734", string.format("%1d", mainPanelDevice:get_argument_value(233) ) ) -- Launch Bar Control Switch, EXTEND/RETRACT >> UHF Radio :: Cover
        SendData("196", string.format("%1d",( mainPanelDevice:get_argument_value(293)/2)+0.5)) -- Arresting Hook Handle, UP/DOWN >> Autopilot :: HARS-SAS Override/Norm
        SendData("113", string.format("%1d",( mainPanelDevice:get_argument_value(340)/2)+0.5)) -- Internal Wing Tank Fuel Control Switch, INHIBIT/NORM >> Fuel System :: Boost Pump Main Fuseloge Right
        SendData("201", string.format("%1d", mainPanelDevice:get_argument_value(341) ) ) -- Probe Control Switch, EXTEND/RETRACT/EMERG EXTD >> IFF :: Audio Light Switch
        SendData("621", string.format("%1d", mainPanelDevice:get_argument_value(344) ) ) -- Fuel Dump Switch, ON/OFF >> NMSP :: Able - Stow
        SendData("204", string.format("%1d", mainPanelDevice:get_argument_value(343) ) ) -- External Tanks CTR Switch, STOP/NORM/ORIDE >> IFF :: M-3/A Switch
        SendData("207", string.format("%1d", mainPanelDevice:get_argument_value(342) ) ) -- External Tanks WING Switch, STOP/NORM/ORIDE >> IFF :: Ident/Mic Switch
		SendData("275", string.format("%.1f", mainPanelDevice:get_argument_value(43) ) ) -- Canopy Jettison Lever Safety Button, Press to unlock >> Environmental Control :: Oxygen Indicator Test
		SendData("118", string.format("%1d",( mainPanelDevice:get_argument_value(42)/2)+0.5)) -- Canopy Jettison Lever, Pull to jettison >> Fuel System :: Fill Disable Wing Right
        SendData("171", string.format("%0.2f", mainPanelDevice:get_argument_value(338) ) ) -- POSITION Lights Dimmer Control >> UHF Radio :: Volume
        SendData("227", string.format("%0.2f", mainPanelDevice:get_argument_value(337) ) ) -- FORMATION Lights Dimmer Control >> Intercom :: UHF Volume
        SendData("177", string.format("%1d", mainPanelDevice:get_argument_value(339) ) ) -- STROBE Lights Switch, BRT/OFF/DIM >> Autopilot :: Alieron Emergency Disengage
        SendData("294", string.format("%1d",( mainPanelDevice:get_argument_value(237)/2)+0.5)) -- LDG/TAXI LIGHT Switch, ON/OFF >> Light System :: Signal Lights
        SendData("290", string.format("%0.2f", mainPanelDevice:get_argument_value(413) ) ) -- CONSOLES Lights Dimmer Control >> Light System :: Engine Instrument Lights
        SendData("225", string.format("%0.2f", mainPanelDevice:get_argument_value(414) ) ) -- INST PNL Dimmer Control >> Intercom :: VHF Volume
        SendData("297", string.format("%0.2f", mainPanelDevice:get_argument_value(415) ) ) -- FLOOD Light Dimmer Control >> Light System :: Console Lights
        SendData("132", string.format("%1d", mainPanelDevice:get_argument_value(419) ) ) -- MODE Switch, NVG/NITE/DAY >> Autopilot :: Mode Selection
        SendData("313", string.format("%.1f", mainPanelDevice:get_argument_value(67) ) ) -- Left MDI PB 14 >> Left MFCD :: OSB14
        SendData("314", string.format("%.1f", mainPanelDevice:get_argument_value(68) ) ) -- Left MDI PB 15 >> Left MFCD :: OSB15
        SendData("133", string.format("%0.2f",( mainPanelDevice:get_argument_value(345)/2)+0.5)) -- RUD TRIM Control >> VHF AM Radio :: Volume
        SendData("352", string.format("%.1f", mainPanelDevice:get_argument_value(346) ) ) -- T/O TRIM PUSH Switch >> CMSP :: OSB 1
        SendData("353", string.format("%.1f", mainPanelDevice:get_argument_value(349) ) ) -- FCS RESET Switch >> CMSP :: OSB 2
        SendData("315", string.format("%.1f", mainPanelDevice:get_argument_value(69) ) ) -- Left MDI PB 16 >> Left MFCD :: OSB16
        SendData("316", string.format("%.1f", mainPanelDevice:get_argument_value(70) ) ) -- Left MDI PB 17 >> Left MFCD :: OSB17
        SendData("317", string.format("%.1f", mainPanelDevice:get_argument_value(72) ) ) -- Left MDI PB 18 >> Left MFCD :: OSB18
        SendData("318", string.format("%.1f", mainPanelDevice:get_argument_value(73) ) ) -- Left MDI PB 19 >> Left MFCD :: OSB19
        SendData("319", string.format("%.1f", mainPanelDevice:get_argument_value(75) ) ) -- Left MDI PB 20 >> Left MFCD :: OSB20
        SendData("377", string.format("%0.1f", mainPanelDevice:get_argument_value(76) ) ) -- Right MDI Off/Night/Day switch >> AHCP :: Laser Arm
        SendData("326", string.format("%.1f", mainPanelDevice:get_argument_value(79) ) ) -- Right MDI PB 1 >> Right MFCD :: OSB1
        SendData("327", string.format("%.1f", mainPanelDevice:get_argument_value(80) ) ) -- Right MDI PB 2 >> Right MFCD :: OSB2
        SendData("328", string.format("%.1f", mainPanelDevice:get_argument_value(81) ) ) -- Right MDI PB 3 >> Right MFCD :: OSB3
        SendData("329", string.format("%.1f", mainPanelDevice:get_argument_value(82) ) ) -- Right MDI PB 4 >> Right MFCD :: OSB4
        SendData("330", string.format("%.1f", mainPanelDevice:get_argument_value(83) ) ) -- Right MDI PB 5 >> Right MFCD :: OSB5
        SendData("331", string.format("%.1f", mainPanelDevice:get_argument_value(84) ) ) -- Right MDI PB 6 >> Right MFCD :: OSB6
        SendData("332", string.format("%.1f", mainPanelDevice:get_argument_value(85) ) ) -- Right MDI PB 7 >> Right MFCD :: OSB7
        SendData("333", string.format("%.1f", mainPanelDevice:get_argument_value(86) ) ) -- Right MDI PB 8 >> Right MFCD :: OSB8
        SendData("334", string.format("%.1f", mainPanelDevice:get_argument_value(87) ) ) -- Right MDI PB 9 >> Right MFCD :: OSB9
        SendData("335", string.format("%.1f", mainPanelDevice:get_argument_value(88) ) ) -- Right MDI PB 10 >> Right MFCD :: OSB10
        SendData("336", string.format("%.1f", mainPanelDevice:get_argument_value(89) ) ) -- Right MDI PB 11 >> Right MFCD :: OSB11
        SendData("337", string.format("%.1f", mainPanelDevice:get_argument_value(90) ) ) -- Right MDI PB 12 >> Right MFCD :: OSB12
        SendData("338", string.format("%.1f", mainPanelDevice:get_argument_value(91) ) ) -- Right MDI PB 13 >> Right MFCD :: OSB13
        SendData("339", string.format("%.1f", mainPanelDevice:get_argument_value(92) ) ) -- Right MDI PB 14 >> Right MFCD :: OSB14
        SendData("340", string.format("%.1f", mainPanelDevice:get_argument_value(93) ) ) -- Right MDI PB 15 >> Right MFCD :: OSB15
        SendData("341", string.format("%.1f", mainPanelDevice:get_argument_value(94) ) ) -- Right MDI PB 16 >> Right MFCD :: OSB16
        SendData("342", string.format("%.1f", mainPanelDevice:get_argument_value(95) ) ) -- Right MDI PB 17 >> Right MFCD :: OSB17
        SendData("271", string.format("%0.2f", mainPanelDevice:get_argument_value(77) ) ) -- Right MDI brightness control >> HARS :: Latitude Correction
        SendData("293", string.format("%0.2f", mainPanelDevice:get_argument_value(78) ) ) -- Right MDI contrast control >> Light System :: Auxillary instrument Lights
        SendData("343", string.format("%.1f", mainPanelDevice:get_argument_value(96) ) ) -- Right MDI PB 18 >> Right MFCD :: OSB18
        SendData("344", string.format("%.1f", mainPanelDevice:get_argument_value(97) ) ) -- Right MDI PB 19 >> Right MFCD :: OSB19
        SendData("345", string.format("%.1f", mainPanelDevice:get_argument_value(98) ) ) -- Right MDI PB 20 >> Right MFCD :: OSB20
        SendData("231", string.format("%0.2f", mainPanelDevice:get_argument_value(203) ) ) -- AMPCD Off/brightness control >> Intercom :: IFF Volume
        SendData("437", string.format("%.1f", mainPanelDevice:get_argument_value(183) ) ) -- AMPCD PB 1 >> CDU :: A
        SendData("438", string.format("%.1f", mainPanelDevice:get_argument_value(184) ) ) -- AMPCD PB 2 >> CDU :: B
        SendData("439", string.format("%.1f", mainPanelDevice:get_argument_value(185) ) ) -- AMPCD PB 3 >> CDU :: C
        SendData("440", string.format("%.1f", mainPanelDevice:get_argument_value(186) ) ) -- AMPCD PB 4 >> CDU :: D
        SendData("441", string.format("%.1f", mainPanelDevice:get_argument_value(187) ) ) -- AMPCD PB 5 >> CDU :: E
        SendData("442", string.format("%.1f", mainPanelDevice:get_argument_value(188) ) ) -- AMPCD PB 6 >> CDU :: F
        SendData("443", string.format("%.1f", mainPanelDevice:get_argument_value(189) ) ) -- AMPCD PB 7 >> CDU :: G
        SendData("444", string.format("%.1f", mainPanelDevice:get_argument_value(190) ) ) -- AMPCD PB 8 >> CDU :: H
        SendData("445", string.format("%.1f", mainPanelDevice:get_argument_value(191) ) ) -- AMPCD PB 9 >> CDU :: I
        SendData("446", string.format("%.1f", mainPanelDevice:get_argument_value(192) ) ) -- AMPCD PB 10 >> CDU :: J
        SendData("447", string.format("%.1f", mainPanelDevice:get_argument_value(193) ) ) -- AMPCD PB 11 >> CDU :: K
        SendData("448", string.format("%.1f", mainPanelDevice:get_argument_value(194) ) ) -- AMPCD PB 12 >> CDU :: L
        SendData("449", string.format("%.1f", mainPanelDevice:get_argument_value(195) ) ) -- AMPCD PB 13 >> CDU :: M
        SendData("450", string.format("%.1f", mainPanelDevice:get_argument_value(196) ) ) -- AMPCD PB 14 >> CDU :: N
        SendData("451", string.format("%.1f", mainPanelDevice:get_argument_value(197) ) ) -- AMPCD PB 15 >> CDU :: O
        SendData("452", string.format("%.1f", mainPanelDevice:get_argument_value(198) ) ) -- AMPCD PB 16 >> CDU :: P
        SendData("453", string.format("%.1f", mainPanelDevice:get_argument_value(199) ) ) -- AMPCD PB 17 >> CDU :: Q
        SendData("454", string.format("%.1f", mainPanelDevice:get_argument_value(200) ) ) -- AMPCD PB 18 >> CDU :: R
        SendData("455", string.format("%.1f", mainPanelDevice:get_argument_value(201) ) ) -- AMPCD PB 19 >> CDU :: S
        SendData("456", string.format("%.1f", mainPanelDevice:get_argument_value(202) ) ) -- AMPCD PB 20 >> CDU :: T
		SendData("632", string.format("%.1f", mainPanelDevice:get_argument_value(213) ) ) -- Cage Standby Attitude Indicator >> TISL :: Bite
        SendData("466", string.format("%.1f", mainPanelDevice:get_argument_value(215) ) ) -- SAI test >> CDU :: MK
        SendData("457", string.format("%.1f", mainPanelDevice:get_argument_value(168) ) ) -- IFEI Mode button >> CDU :: U
        SendData("458", string.format("%.1f", mainPanelDevice:get_argument_value(169) ) ) -- IFEI QTY button >> CDU :: V
        SendData("459", string.format("%.1f", mainPanelDevice:get_argument_value(170) ) ) -- IFEI up arrow button >> CDU :: W
        SendData("460", string.format("%.1f", mainPanelDevice:get_argument_value(171) ) ) -- IFEI down arrow button >> CDU :: X
        SendData("461", string.format("%.1f", mainPanelDevice:get_argument_value(172) ) ) -- IFEI ZONE button >> CDU :: Y
        SendData("462", string.format("%.1f", mainPanelDevice:get_argument_value(173) ) ) -- IFEI ET button >> CDU :: Z
	SendData("630", string.format("%.1f", mainPanelDevice:get_argument_value(283) ) ) -- ABU-43 Clock Wind/Set Control >> TISL :: OverTemp
	SendData("115", string.format("%.1f", mainPanelDevice:get_argument_value(284) ) ) -- ABU-43 Clock Stop/Reset Control >> Fuel System :: Line Check
        SendData("390", string.format("%.1f", mainPanelDevice:get_argument_value(128) ) ) -- UFC Function Pushbutton, A/P >> UFC :: 6
        SendData("391", string.format("%.1f", mainPanelDevice:get_argument_value(129) ) ) -- UFC Function Pushbutton, IFF >> UFC :: 7
        SendData("392", string.format("%.1f", mainPanelDevice:get_argument_value(130) ) ) -- UFC Function Pushbutton, TCN >> UFC :: 8
        SendData("393", string.format("%.1f", mainPanelDevice:get_argument_value(131) ) ) -- UFC Function Pushbutton, ILS >> UFC :: 9
        SendData("395", string.format("%.1f", mainPanelDevice:get_argument_value(132) ) ) -- UFC Function Pushbutton, D/L >> UFC :: 0
        SendData("396", string.format("%.1f", mainPanelDevice:get_argument_value(133) ) ) -- UFC Function Pushbutton, BCN >> UFC :: Space
        SendData("394", string.format("%.1f", mainPanelDevice:get_argument_value(134) ) ) -- UFC Function Pushbutton, ON(OFF) >> UFC :: Display Hack Time
        SendData("385", string.format("%.1f", mainPanelDevice:get_argument_value(100) ) ) -- UFC Option Select Pushbutton 1 >> UFC :: 1
        SendData("386", string.format("%.1f", mainPanelDevice:get_argument_value(101) ) ) -- UFC Option Select Pushbutton 2 >> UFC :: 2
        SendData("387", string.format("%.1f", mainPanelDevice:get_argument_value(102) ) ) -- UFC Option Select Pushbutton 3 >> UFC :: 3
        SendData("388", string.format("%.1f", mainPanelDevice:get_argument_value(103) ) ) -- UFC Option Select Pushbutton 4 >> UFC :: 4
        SendData("389", string.format("%.1f", mainPanelDevice:get_argument_value(106) ) ) -- UFC Option Select Pushbutton 5 >> UFC :: 5
        SendData("425", string.format("%.1f", mainPanelDevice:get_argument_value(111) ) ) -- UFC Keyboard Pushbutton, 1 >> CDU :: 1
        SendData("426", string.format("%.1f", mainPanelDevice:get_argument_value(112) ) ) -- UFC Keyboard Pushbutton, 2 >> CDU :: 2
        SendData("427", string.format("%.1f", mainPanelDevice:get_argument_value(113) ) ) -- UFC Keyboard Pushbutton, 3 >> CDU :: 3
        SendData("428", string.format("%.1f", mainPanelDevice:get_argument_value(114) ) ) -- UFC Keyboard Pushbutton, 4 >> CDU :: 4
        SendData("429", string.format("%.1f", mainPanelDevice:get_argument_value(115) ) ) -- UFC Keyboard Pushbutton, 5 >> CDU :: 5
        SendData("430", string.format("%.1f", mainPanelDevice:get_argument_value(116) ) ) -- UFC Keyboard Pushbutton, 6 >> CDU :: 6
        SendData("431", string.format("%.1f", mainPanelDevice:get_argument_value(117) ) ) -- UFC Keyboard Pushbutton, 7 >> CDU :: 7
        SendData("432", string.format("%.1f", mainPanelDevice:get_argument_value(118) ) ) -- UFC Keyboard Pushbutton, 8 >> CDU :: 8
        SendData("433", string.format("%.1f", mainPanelDevice:get_argument_value(119) ) ) -- UFC Keyboard Pushbutton, 9 >> CDU :: 9
        SendData("434", string.format("%.1f", mainPanelDevice:get_argument_value(120) ) ) -- UFC Keyboard Pushbutton, 0 >> CDU :: 0
        SendData("399", string.format("%.1f", mainPanelDevice:get_argument_value(121) ) ) -- UFC Keyboard Pushbutton, CLR >> UFC :: Clear
        SendData("400", string.format("%.1f", mainPanelDevice:get_argument_value(122) ) ) -- UFC Keyboard Pushbutton, ENT >> UFC :: Enter
        SendData("397", string.format("%.1f", mainPanelDevice:get_argument_value(99) ) ) -- UFC I/P Pushbutton >> UFC :: Select Funciton Mode
        SendData("398", string.format("%.1f", mainPanelDevice:get_argument_value(110) ) ) -- UFC EMCON Select Pushbutton >> UFC :: Select Letter Mode
        SendData("623", string.format("%1d", mainPanelDevice:get_argument_value(107) ) ) -- UFC ADF Function Select Switch, 1/OFF/2 >> TISL :: Slant Range
        SendData("195", string.format("%0.2f", mainPanelDevice:get_argument_value(108) ) ) -- UFC COMM 1 Volume Control Knob >> Light System :: Weapon Station Lights Brightness
        SendData("193", string.format("%0.2f", mainPanelDevice:get_argument_value(123) ) ) -- UFC COMM 2 Volume Control Knob >> Light System :: Refuel Status Indexer Brightness
        SendData("292", string.format("%0.2f", mainPanelDevice:get_argument_value(109) ) ) -- UFC Brightness Control Knob >> Light System :: Flight Instruments Lights
        SendData("640", string.format("%0.2f", mainPanelDevice:get_argument_value(358) ) ) -- ICS Volume Control Knob >> TISL :: TISL Code Wheel 3
        SendData("221", string.format("%0.2f", mainPanelDevice:get_argument_value(359) ) ) -- RWR Volume Control Knob >> Intercom :: INT Volume;
        SendData("626", string.format("%0.2f", mainPanelDevice:get_argument_value(360) ) ) -- WPN Volume Control Knob >> TISL :: Altitude above target thousands of feet
        SendData("624", string.format("%0.2f", mainPanelDevice:get_argument_value(361) ) ) -- MIDS B Volume Control Knob >> TISL :: Altitude above target tens of thousands of feet
        SendData("636", string.format("%0.2f", mainPanelDevice:get_argument_value(362) ) ) -- MIDS A Volume Control Knob >> TISL :: TISL Code Wheel 1
        SendData("638", string.format("%0.2f", mainPanelDevice:get_argument_value(363) ) ) -- TACAN Volume Control Knob >> TISL :: TISL Code Wheel 2
        SendData("368", string.format("%0.2f", mainPanelDevice:get_argument_value(364) ) ) -- AUX Volume Control Knob >> CMSC :: RWR Volume
        SendData("601", string.format("%1d", mainPanelDevice:get_argument_value(350) ) ) -- COMM RLY Select Switch, CIPHER/OFF/PLAIN >> Oxygen System :: Emergency Lever
        SendData("202", string.format("%1d", mainPanelDevice:get_argument_value(351) ) ) -- COMM G XMT Switch, COMM 1/OFF/COMM 2 >> IFF :: M-1 Switch
        SendData("476", string.format("%1d",( mainPanelDevice:get_argument_value(356)/2)+0.5)) -- IFF Master Switch, EMER/NORM >> AAP :: CDU Power
        SendData("644", string.format("%1d", mainPanelDevice:get_argument_value(355) ) ) -- IFF Mode 4 Switch, DIS-AUD/DIS/OFF >> TISL :: Code Select
        SendData("278", string.format("%1d", mainPanelDevice:get_argument_value(373) ) ) -- COMM 1 ANT SEL Switch, UPPER/AUTO/LOWER >> Environmental Control :: Windshield Remove/Wash
        SendData("203", string.format("%1d", mainPanelDevice:get_argument_value(374) ) ) -- IFF ANT SEL Switch, UPPER/BOTH/LOWER >> IFF :: M-2 Switch



		
		
	----------------------------------------------------------------------------  FA18C -------------------------------------------------------------
	FlushData()
end















-- Pointed to by ProcessLowImportance, if the player aircraft is something else
function ProcessNoLowImportance(mainPanelDevice)
end


-----------------------------------------
-- FLAMING CLIFFS AIRCRAFT             --
-- FC aircraft don't support GetDevice --
-----------------------------------------

function ProcessFCExports ()

	local myData = LoGetSelfData()

	if (myData) then
	
		local altBar = LoGetAltitudeAboveSeaLevel()
		local altRad = LoGetAltitudeAboveGroundLevel()
		local pitch, bank, yaw = LoGetADIPitchBankYaw()
		local engine = LoGetEngineInfo()
		local hsi    = LoGetControlPanel_HSI()
		local vvi = LoGetVerticalVelocity()
		local ias = LoGetIndicatedAirSpeed()
		local route = LoGetRoute()
		local aoa = LoGetAngleOfAttack()
		local accelerometer = LoGetAccelerationUnits()
		local glide = LoGetGlideDeviation()
		local side = LoGetSideDeviation()

		local distanceToWay = 999
		local navInfo = LoGetNavigationInfo()
	
	
		if engine then
					local fuelLeftKG = engine.fuel_internal  + engine.fuel_external
					local fuelConsumptionKGsec = engine.FuelConsumption.left + engine.FuelConsumption.right
		end
				
		if (myData and route) then -- if neither are nil
			local myLoc = LoGeoCoordinatesToLoCoordinates(myData.LatLongAlt.Long, myData.LatLongAlt.Lat)
			-- DCS coordinates are X & Z, with Y as altitude.
			distanceToWay = math.sqrt((myLoc.x - route.goto_point.world_point.x)^2 + (myLoc.z -  route.goto_point.world_point.z)^2)
		end


		if myData.Name=="F-15C" then   --- F-15C  prepared for Capt Zeen helios profile

			SendData("1", string.format("%.2f", Degrees(pitch) ) )
			SendData("2", string.format("%.2f", Degrees(bank) ) )
			SendData("3", string.format("%.2f", Degrees(yaw) ) )
			SendData("4", string.format("%.2f", altBar) )
			SendData("7", string.format("%.2f", 360 - Degrees(hsi.RMI_raw) ))
			SendData("8", string.format("%.2f", Degrees(myData.Heading) ) )
			SendData("13", string.format("%.2f", vvi) )
			SendData("16", string.format("%.2f", Degrees(aoa) ) )
			SendData("17", string.format("%.2f", glide) )
			SendData("18", string.format("%.2f", side) )


			-- prepare pairs of data to send more info to helios........

			SendData("9", string.format("%.4f", (math.floor(engine.fuel_internal) + (engine.RPM.left /1000))  ) ) --fuel int + rpm left in rpm.left import data
			SendData("10", string.format("%.4f", (math.floor(engine.fuel_external) + (engine.RPM.right /1000))  ) ) --fuel ext + rpm right in rpm.right import data
			SendData("11", string.format("%.4f", (math.floor(engine.fuel_internal+engine.fuel_external) + (engine.Temperature.left/1000)) ) ) --fuel TOTAL +  eng temp left in eng temp left import data
			if math.floor(route.goto_point.world_point.x)<0 then
				SendData("12", string.format("%.4f", (math.floor(route.goto_point.world_point.x) - (engine.Temperature.right/1000)) ) ) --x coord +  eng temp left in eng temp rifgt import data
				else
				SendData("12", string.format("%.4f", (math.floor(route.goto_point.world_point.x) + (engine.Temperature.right/1000)) ) ) --x coord +  eng temp left in eng temp rifgt import data
			end

			SendData("14", string.format("%.5f", (math.floor(distanceToWay) + (ias /10000))  ) ) --distance to way + ias in IAS import data

			-- end of pairs

			SendData("5", string.format("%.2f", accelerometer.y ))   -- acelerometer in Radar altidud import data
			SendData("15", string.format("%s", navInfo.SystemMode.master .." / ".. navInfo.SystemMode.submode))  -- HUD MODE and SUBMODE in distancetoway import data
			SendData("6", string.format("%.2f", 360 - (hsi.ADF_raw * 57.3)) )  --HSI in f15 format

		else

			--------------------------------------------------------------------------------------------------------------
			------------------------------------------------------------------------------------------     Other airplanes
			--------------------------------------------------------------------------------------------------------------

			SendData("1", string.format("%.2f", Degrees(pitch) ) )
			SendData("2", string.format("%.2f", Degrees(bank) ) )
			SendData("3", string.format("%.2f", Degrees(yaw) ) )
			SendData("4", string.format("%.2f", altBar) )
			SendData("5", string.format("%.2f", altRad) )
			if (hsi) then
				SendData("6", string.format("%.2f", (360 - Degrees(hsi.ADF_raw))+(360 - Degrees(myData.Heading)) ) )
				SendData("7", string.format("%.2f", 360 - Degrees(hsi.RMI_raw)) )
				SendData("8", string.format("%.2f", Degrees(myData.Heading)) ) 
			end
			if (engine) then
				SendData("9", string.format("%.2f", engine.RPM.left) )
				SendData("10", string.format("%.2f", engine.RPM.right) )
				SendData("11", string.format("%.2f", engine.Temperature.left) )
				SendData("12", string.format("%.2f", engine.Temperature.right) )
			end
			SendData("13", string.format("%.2f", vvi) )
			SendData("14", string.format("%.2f", ias) )
			SendData("15", string.format("%.2f", distanceToWay) )
			SendData("16", string.format("%.2f", Degrees(aoa) ) )
			SendData("17", string.format("%.2f", glide) )
			SendData("18", string.format("%.2f", side) )


		end

		FlushData()

	else
		--if debug_output_file then
		--	debug_output_file:write("ProcessFCExports(4.2) called but myData is nil\r\n")
		--end
	end

end


------------------------------------------------
-- P-51D and TF-51D exported as a FC aircraft --
-- 				by Capt Zeen				  --
------------------------------------------------

function ProcessP51Exports ()

	-- read from main panel
	local MainPanel = GetDevice(0)
	local AirspeedNeedle = MainPanel:get_argument_value(11)*1000
	local Altimeter_10000_footPtr = MainPanel:get_argument_value(96)*100000
	local Variometer = MainPanel:get_argument_value(29)   
	local TurnNeedle = MainPanel:get_argument_value(27)   
	local Slipball = MainPanel:get_argument_value(28)
	local CompassHeading = MainPanel:get_argument_value(1) 
	local CommandedCourse = MainPanel:get_argument_value(2) 							
	local Manifold_Pressure = MainPanel:get_argument_value(10) 
	local Engine_RPM = MainPanel:get_argument_value(23)
	local AHorizon_Pitch = MainPanel:get_argument_value(15) 
	local AHorizon_Bank = MainPanel:get_argument_value(14) 
	local AHorizon_PitchShift = MainPanel:get_argument_value(16) * 10.0 * math.pi/180.0
	local AHorizon_Caged = MainPanel:get_argument_value(20) 
	local GyroHeading = MainPanel:get_argument_value(12) 
	local vaccum_suction = MainPanel:get_argument_value(9)
	local carburator_temp = MainPanel:get_argument_value(21)
	local coolant_temp = MainPanel:get_argument_value(22)
	local Acelerometer = MainPanel:get_argument_value(175)
	local OilTemperature = MainPanel:get_argument_value(30)
	local OilPressure = MainPanel:get_argument_value(31)
	local FuelPressure = MainPanel:get_argument_value(32)
	local Clock_hours = MainPanel:get_argument_value(4)
	local Clock_minutes = MainPanel:get_argument_value(5)
	local Clock_seconds = MainPanel:get_argument_value(6)
	local LandingGearGreenLight = MainPanel:get_argument_value(80) 
	local LandingGearRedLight = MainPanel:get_argument_value(82)
	local Hight_Blower_Lamp = MainPanel:get_argument_value(59) 						
	local Acelerometer_Min = MainPanel:get_argument_value(177)
	local Acelerometer_Max = MainPanel:get_argument_value(178)
	local Ammeter = MainPanel:get_argument_value(101)	
	local hydraulic_Pressure = MainPanel:get_argument_value(78)  
	local Oxygen_Flow_Blinker = MainPanel:get_argument_value(33)
	local Oxygen_Pressure = MainPanel:get_argument_value(34)
	local Fuel_Tank_Left = MainPanel:get_argument_value(155)
	local Fuel_Tank_Right = MainPanel:get_argument_value(156)
	local Fuel_Tank_Fuselage = MainPanel:get_argument_value(160)
	local Tail_radar_warning = MainPanel:get_argument_value(161)
	local Channel_A = MainPanel:get_argument_value(122)
	local Channel_B = MainPanel:get_argument_value(123)
	local Channel_C = MainPanel:get_argument_value(124)
	local Channel_D = MainPanel:get_argument_value(125)
	local transmit_light = MainPanel:get_argument_value(126)
	local RocketCounter = MainPanel:get_argument_value(77)

	--- preparing landing gear and High Blower lights, all together, in only one value	
	local gear_lights = 0
	if LandingGearGreenLight > 0 then gear_lights = gear_lights +100 end
	if LandingGearRedLight > 0 then gear_lights = gear_lights +10 end
	if Hight_Blower_Lamp > 0 then gear_lights = gear_lights +1 end
	------------------------------------------------------------	

	--- preparing radio lights, all together, in only one value	
	local radio_active = 0
	if Channel_A > 0 then radio_active = 1 end
	if Channel_B > 0 then radio_active= 2 end
	if Channel_C > 0 then radio_active= 3 end
	if Channel_D > 0 then radio_active= 4 end
	if transmit_light > 0 then radio_active = radio_active + 10 end
	------------------------------------------------------------


	---- sending P51 and tf51 data across fc2 interface

	SendData("1", string.format("%.5f", math.floor((AHorizon_Pitch+1)*1000) + ((AHorizon_Bank+1)/100) ) ) 	-- pitch
	SendData("2", string.format("%.3f", math.floor(Oxygen_Flow_Blinker*100) + (Oxygen_Pressure/100) ) )		-- bank
	SendData("3", string.format("%.4f", math.floor(OilTemperature*100) + (vaccum_suction/100) ) )			-- yaw
	SendData("4", string.format("%.3f", math.floor(Altimeter_10000_footPtr) + (AHorizon_Caged/100) ) )		-- barometric altitude 
	SendData("5", string.format("%.5f", math.floor(Clock_hours*1000000) + (Tail_radar_warning/100) ) )		-- radar altitude 
	SendData("6", string.format("%.5f", math.floor(CompassHeading*1000) + (CommandedCourse/100) ) )			-- adf
	SendData("7", string.format("%.4f", math.floor(Clock_seconds*100) + (hydraulic_Pressure/100) ) )		-- rmi
	SendData("8", string.format("%.2f", math.floor(GyroHeading*1000) + (radio_active/100) ) )				-- heading
	SendData("9", string.format("%.4f", math.floor(Engine_RPM*100) + (Manifold_Pressure/100) ) )			-- left rpm
	SendData("10", string.format("%.4f", math.floor(Fuel_Tank_Left*100) + (Fuel_Tank_Right/100) ) )			-- right rpm
	SendData("11", string.format("%.4f", math.floor(carburator_temp*100) + (coolant_temp/100) ) )			-- left temp
	SendData("12", string.format("%.4f", math.floor(gear_lights) + (Acelerometer_Min/100 ) ) )				-- right temp
	SendData("13", string.format("%.2f", Variometer) )														-- vvi
	SendData("14", string.format("%.5f", math.floor(AirspeedNeedle)+ (RocketCounter/100) ) )				-- ias
	SendData("15", string.format("%.4f", math.floor(OilPressure*100) + (FuelPressure/100) ) )				-- distance to way
	SendData("16", string.format("%.3f", math.floor(Acelerometer*1000) + (Acelerometer_Max/100 ) ) )		-- aoa
	SendData("17", string.format("%.4f", math.floor((TurnNeedle+1)*100) + ((Slipball+1)/100) ) )			-- glide
	SendData("18", string.format("%.4f", math.floor(Fuel_Tank_Fuselage*100) + (Ammeter/100) ) )				-- side

	FlushData()
end











------------------------------------------------------------
-- MI-8 v2.0 exported as new General interface helios 1.4 --
-- 				by Capt Zeen				              --
------------------------------------------------------------

function convert_sw (valor)
	return math.abs(valor-1)+1
end

function convert_lamp (valor_lamp)
	return (valor_lamp  > 0.1) and 1 or 0
end

function parse_indication(indicator_id)  -- Thanks to [FSF]Ian code
	local ret = {}
	local li = list_indication(indicator_id)
	if li == "" then return nil end
	local m = li:gmatch("-----------------------------------------\n([^\n]+)\n([^\n]*)\n")
	while true do
	local name, value = m()
	if not name then break end
		ret[name] = value
	end
	return ret
end

function get_uv26_display()

local li = parse_indication(4)  -- use 5 in DCS1.5     use 4 DCSin 1.5.4
if not li then return "   " end
if not li.txt_digits then return "   " end
return li.txt_digits

end


function ProcessMI8Exports ()


					local _LAST_ONE = 0 -- used to mark the end of the tables	
					local MainPanel = GetDevice(0)
					
					-- radios information
					local R863_ = GetDevice(38)
					local R828_ = GetDevice(39)
					local R863__ON = 0
					local R863__freq= 0
					local R828__ON = 0
					local R828__freq= 0
					
					R863__freq = R863_:get_frequency()
					if (R863_:is_on()) then
					  R863__ON = 1
					end
					R828__freq = R828_:get_frequency()
					if (R828_:is_on()) then
					  R828__ON = 1
					end
					
							-- Pilot console instruments

	local uv26 = get_uv26_display()							
	local CompassHeading = MainPanel:get_argument_value(25)
	local CompassHeading_copilot = MainPanel:get_argument_value(101)	
	local bearing_needle = MainPanel:get_argument_value(28)	* 360	
		if bearing_needle > 180 then bearing_needle = bearing_needle-360 end   -- convert Bearing Needle from 0,360 to -180,180 for helios russian HSI
	local bearing_needle_copilot = MainPanel:get_argument_value(104)* 360	
		if bearing_needle_copilot > 180 then bearing_needle_copilot = bearing_needle_copilot-360 end   -- convert Bearing Needle from 0,360 to -180,180 for helios russian HSI copilot
	local CommandedCourse = MainPanel:get_argument_value(27) + MainPanel:get_argument_value(25) -- convert Commanded Course for helios russian HSI pilot
	local CommandedCourse_copilot = MainPanel:get_argument_value(103) + MainPanel:get_argument_value(101) -- convert Commanded Course for helios russian HSI pilot
	
	
		
		SendData("190", string.format("%s",   uv26  ) )				
		SendData("192", string.format("%.3f", math.floor(bearing_needle*1000) + (bearing_needle/100) ) )
		SendData("193", string.format("%.5f", math.floor(CompassHeading*1000) + (CommandedCourse/100) ) )
		SendData("194", string.format("%.3f", math.floor(bearing_needle_copilot*1000) + (bearing_needle_copilot/100) ) )
		SendData("195", string.format("%.5f", math.floor(CompassHeading_copilot*1000) + (CommandedCourse_copilot/100) ) )
	
	
	----[[	
local instruments_table =
{	
		[1] =	MainPanel:get_argument_value(24), 			--IAS pilot
		[2] =	ValueConvert(MainPanel:get_argument_value(904),{-50.0, 0, 70.0},{-1.0, 0.0, 1.0}),   -- RAM_Temp
		[3] =	ValueConvert(MainPanel:get_argument_value(16),{-30, -20, -10, -5, -2, -1, 0, 1, 2, 5, 10, 20, 30},{-1.0, -0.71, -0.43, -0.23, -0.09, -0.05, 0, 0.05, 0.09, 0.23, 0.43, 0.71, 1.0}),	--Variometer 
		[4] =	MainPanel:get_argument_value(22),           -- TurnNeedle 	pilot
		[5] =	MainPanel:get_argument_value(23),           -- Slipball		pilot
		[6] =	MainPanel:get_argument_value(25),           -- CompassHeading pilot
		[7] =	MainPanel:get_argument_value(27) + MainPanel:get_argument_value(25), -- convert Commanded Course for helios russian HSI  CommandedCourse pilot
		[8] =	bearing_needle,						        -- bearing needle	pilot								
		[9] =	MainPanel:get_argument_value(41),           -- Engine_RPM_R								
		[10] = 	MainPanel:get_argument_value(40),           -- Engine_RPM_L								
		[11] = 	MainPanel:get_argument_value(42)*110 ,      -- RotorRPM										
		[12] = 	MainPanel:get_argument_value(36)*15 ,       -- RotorPitch								
		[13] = 	MainPanel:get_argument_value(43)*1200,      -- LeftEngineTemperature						
		[14] = 	MainPanel:get_argument_value(45)*1200,      -- RightEngineTemperature 						
		[15] = 	MainPanel:get_argument_value(19),     -- Altimeter								
		[16] = 	MainPanel:get_argument_value(13)*180,       -- AGB_3K_Left_roll								
		[17] = 	(MainPanel:get_argument_value(12)*-180)/2,  -- AGB_3K_Left_pitch						
		[18] = 	MainPanel:get_argument_value(34),  			-- RALT											
		[19] = 	MainPanel:get_argument_value(31),  			-- RALT_danger_alt							
		[20] = 	MainPanel:get_argument_value(830),          -- diss15_hover_x							
		[21] = 	MainPanel:get_argument_value(828),          -- diss15_hover_y							
		[22] = 	MainPanel:get_argument_value(829),          -- diss15_hover_z 							
		[23] = 	MainPanel:get_argument_value(404),          -- hydro_pressure_main						
		[24] = 	MainPanel:get_argument_value(405),          -- hydro_pressure_aux						
		[25] = 	MainPanel:get_argument_value(402), 	   		-- APU_temperature								
		[26] = 	MainPanel:get_argument_value(403),          -- APU_pressure								
		[27] = 	MainPanel:get_argument_value(526),          -- DC_voltage								
		[28] = 	MainPanel:get_argument_value(527),          -- DC_battery_I_current						
		[29] = 	MainPanel:get_argument_value(528),          -- DC_battery_II_current					
		[30] = 	MainPanel:get_argument_value(529),          -- DC_VU_I_current								
		[31] = 	MainPanel:get_argument_value(530),	        -- DC_VU_II_current
		[32] = 	MainPanel:get_argument_value(531),          -- DC_VU_III_current								
		[33] = 	MainPanel:get_argument_value(532),          -- AC_voltage  									
		[34] = 	MainPanel:get_argument_value(533),          -- AC_generator_I_current						
		[35] = 	MainPanel:get_argument_value(534),          -- AC_generator_II_current					
		[36] = 	MainPanel:get_argument_value(493),	        -- DC_APU_current								
		[37] = 	MainPanel:get_argument_value(371),          -- AntiIce_ampermeter 							
		[38] = 	MainPanel:get_argument_value(126),  		-- SPUU_pointer									
		[39] = 	MainPanel:get_argument_value(122),  		-- autopilot_yaw_indicator					
		[40] = 	MainPanel:get_argument_value(124),  		-- autopilot_pitch_indicator	 					
		[41] = 	MainPanel:get_argument_value(123)* 3.03,    -- autopilot_roll_indicator  						
		[42] = 	MainPanel:get_argument_value(125),          -- autopilot_altitude_indicator  					
		[43] = 	MainPanel:get_argument_value(119),			-- autopilot_yaw_scale  							
		[44] = 	MainPanel:get_argument_value(120),			-- autopilot_roll_scale  							
		[45] = 	MainPanel:get_argument_value(121),			-- autopilot_pitch_scale	 						
		[46] = 	MainPanel:get_argument_value(111), 			-- oils_p_main_reductor  							
		[47] = 	MainPanel:get_argument_value(114)+ 0.25,  	-- oils_t_main_reductor  							
		[48] = 	MainPanel:get_argument_value(113)+ 0.25,  	-- oils_temp_tail_reductor  						
		[49] = 	MainPanel:get_argument_value(112)+ 0.25,  	-- oils_temp_intermediate_reductor  				
		[50] = 	MainPanel:get_argument_value(115), 			-- oils_p_left_engine  							
		[51] = 	MainPanel:get_argument_value(116)+ 0.25,	-- oils_t_left_engine  							
		[52] = 	MainPanel:get_argument_value(117),			-- oils_p_right_engine  							
		[53] = 	MainPanel:get_argument_value(118) + 0.25,	-- oils_t_right_engine  							
		[54] = 	ValueConvert(MainPanel:get_argument_value(736),{0, 1, 2, 3, 4, 5, 6, 7, 8, 9},{0.0, 0.101, 0.199, 0.302, 0.400, 0.502, 0.601, 0.697, 0.801, 0.898}), -- R828_channel								
		[55] = 	MainPanel:get_argument_value(62), 			-- FuelScaleUpper  								
		[56] = 	MainPanel:get_argument_value(791),			-- diss15_drift_angle  							
		[57] = 	MainPanel:get_argument_value(795),			-- diss15_W_shutter  								
		[58] = 	MainPanel:get_argument_value(832),			-- VD_10K_L_10_Ind 						
		[59] = 	MainPanel:get_argument_value(792), -- 0 to 1                -- diss15_W_hundreds  							
		[60] = 	MainPanel:get_argument_value(793), -- 0 to 1                -- diss15_W_tens	 								
		[61] = 	MainPanel:get_argument_value(794), -- 0 to 1                -- diss15_W_ones  								
		[62] = 	MainPanel:get_argument_value(833),			-- VD_10K_L_100_Ind							
		[63] = 	MainPanel:get_argument_value(805), -- 0 to 1 inversed       -- diss15_coord_forward  							
		[64] = 	MainPanel:get_argument_value(806),         -- diss15_coord_X_hundreds  						
		[65] = 	MainPanel:get_argument_value(807),         -- diss15_coord_X_tens  			
		[66] = 	MainPanel:get_argument_value(808),         -- diss15_coord_X_ones  							
		[67] = 	MainPanel:get_argument_value(802),         -- diss15_coord_right  							
		[68] = 	MainPanel:get_argument_value(799),         -- diss15_coord_Z_hundreds  						
		[69] = 	MainPanel:get_argument_value(800),         -- diss15_coord_Z_tens  							
		[70] = 	MainPanel:get_argument_value(801),         -- diss15_coord_Z_ones  							
		[71] = 	MainPanel:get_argument_value(811),         -- diss15_coord_angle_hundreds  					
		[72] = 	MainPanel:get_argument_value(812),         -- diss15_coord_angle_tens  						
		[73] = 	MainPanel:get_argument_value(813),         -- diss15_coord_angle_ones  						
		[74] = 	MainPanel:get_argument_value(814),         -- diss15_coord_angle_minutes  					
		[75] = 	MainPanel:get_argument_value(39), 	       -- EnginesMode  									
		[76] = 	MainPanel:get_argument_value(37), 	       -- LeftEngineMode  								
		[77] = 	MainPanel:get_argument_value(38), 	       -- RightEngineMode  								
		[78] = 	MainPanel:get_argument_value(577),         -- AMMO_CNT1_1  									
		[79] = 	MainPanel:get_argument_value(578),         -- AMMO_CNT1_2  									
		[80] = 	MainPanel:get_argument_value(580),         -- AMMO_CNT2_1  									
		[81] = 	MainPanel:get_argument_value(581),         -- AMMO_CNT2_2  									
		[82] = 	MainPanel:get_argument_value(583),         -- AMMO_CNT3_1  									
		[83] = 	MainPanel:get_argument_value(584),         -- AMMO_CNT3_2  									
		[84] = 	MainPanel:get_argument_value(49)*12 ,      -- CLOCK_currtime_hours  							
		[85] = 	MainPanel:get_argument_value(50)*60 ,      -- CLOCK_currtime_minutes  						
		[86] = 	MainPanel:get_argument_value(51)*60 ,      -- CLOCK_currtime_seconds  						
		[87] = 	MainPanel:get_argument_value(52)*12 ,      -- CLOCK_flight_hours  							
		[88] = 	MainPanel:get_argument_value(53)*60 ,      -- CLOCK_flight_minutes  							
		[89] = 	MainPanel:get_argument_value(56),       -- CLOCK_flight_time_meter_status  				
		[90] = 	MainPanel:get_argument_value(54)*60 ,      -- CLOCK_seconds_meter_time_minutes  				
		[91] = 	MainPanel:get_argument_value(55)*60,       -- CLOCK_seconds_meter_time_seconds  				
		[92] = 	MainPanel:get_argument_value(320),         -- air_system_pressure  							
		[93] = 	MainPanel:get_argument_value(321),         -- air_system_brake_pressure  					
		[94] = 	MainPanel:get_argument_value(681),         -- ARC_9_Signal  														
		[95] = 	MainPanel:get_argument_value(675),         -- ARC_9_Backup_100_rotary  						
		[96] = 	MainPanel:get_argument_value(450),        -- ARC_9_Backup_10_rotary  
		[97] =	MainPanel:get_argument_value(678),         -- ARC_9_Main_100_rotary  						
		[98] =	MainPanel:get_argument_value(452),         -- ARC_9_Main_10_rotary  												
		[99] =	MainPanel:get_argument_value(192),         -- engines_throttle	  							
		[100] =	MainPanel:get_argument_value(745),	       -- Jadro_1A_Frequency_Selector_1MHz  				
		[101] =	MainPanel:get_argument_value(746),	       -- Jadro_1A_Frequency_Selector_100kHz  			
		[102] =	MainPanel:get_argument_value(747),         -- Jadro_1A_Frequency_Selector_10kHz	  			
		[103] =	MainPanel:get_argument_value(748),	       -- Jadro_1A_Frequency_Selector_Left_mouse_1kHz   	
		[104] =	MainPanel:get_argument_value(750),	       -- Jadro_1A_Frequency_Selector_1MHz_SLAVE  		
		[105] =	MainPanel:get_argument_value(749),         -- Jadro_1A_Frequency_Selector_Right_mouse_100Hz 	
		[106] =	MainPanel:get_argument_value(28),	       -- rmi_needle  									
		[107] =	MainPanel:get_argument_value(21),          -- Baro_press  			
		[108] =	MainPanel:get_argument_value(14),   							--AGB_3K_Left_failure_flag                                                                      				
		[109] =	ValueConvert(MainPanel:get_argument_value(907),{-1.0, 0, 1.0},{-1.0, 0.343, 1.0}),                 -- G_Meter  				
		[110] =	ValueConvert(MainPanel:get_argument_value(908),{1.0, 3.0},{0.343, 1.0}),                           -- G_Meter_Max  			
		[111] =	ValueConvert(MainPanel:get_argument_value(909),{-1.0, 0.0 ,0.5, 1.0},{-1.0, 0.0, 0.174, 0.343}),   -- G_Meter_Min  			
		[112] =	MainPanel:get_argument_value(834),			-- VD_10K_R_10_Ind					
		[113] =	ValueConvert(MainPanel:get_argument_value(63),{-70.0, -30.0, -20.0, -10.0, 0.0, 10.0, 20.0, 30.0, 70.0},{-0.7, -0.296, -0.227, -0.125, 0.003, 0.132, 0.233, 0.302, 0.693}),  --SalonTemperature	
		[114] =	MainPanel:get_argument_value(790), 			--IAS copilot
		[115] =	ValueConvert(MainPanel:get_argument_value(95),{-30, -20, -10, -5, -2, -1, 0, 1, 2, 5, 10, 20, 30},{-1.0, -0.71, -0.43, -0.23, -0.09, -0.05, 0, 0.05, 0.09, 0.23, 0.43, 0.71, 1.0}),	--Variometer copilot
		[116] =	MainPanel:get_argument_value(101),           -- CompassHeading copilot
		[117] =	MainPanel:get_argument_value(103) + MainPanel:get_argument_value(101), -- convert Commanded Course for helios russian HSI  CommandedCourse copilot
		[118] =	bearing_needle_copilot,						        -- bearing needle	copilot	
		[119] =	MainPanel:get_argument_value(789),           -- Engine_RPM_R	copilot							
		[120] =	MainPanel:get_argument_value(788),           -- Engine_RPM_L		copilot								
		[121] =	MainPanel:get_argument_value(787)*110 ,      -- RotorRPM	copilot	MainPanel:get_argument_value(789),  				
		[122] = MainPanel:get_argument_value(98),     -- Altimeter	big needle copilot
		[123] = MainPanel:get_argument_value(92)*180,       -- AGB_3K_roll		copilot	
		[124] = (MainPanel:get_argument_value(91)*-180)/2,  -- AGB_3K_pitch	copilot					
		[125] = ValueConvert(MainPanel:get_argument_value(100),{661.0, 790.0},{-0.051, 0.668}), -- Baro_press  	copilot
		[126] = R863__freq,
		[127] = R828__freq,
		[128] = R863__ON,
		[129] = R828__ON,
		[130] = MainPanel:get_argument_value(104),   --rmi needle right
		[131] =	MainPanel:get_argument_value(93),   							--AGB_3K_Right_failure_flag  
		[132] =	MainPanel:get_argument_value(835),			-- VD_10K_R_100_Ind
		[133] =	MainPanel:get_argument_value(20),			-- Altimeter	small needle pilot
		[134] =	MainPanel:get_argument_value(99),			-- Altimeter	small needle copilot
		[135] =	MainPanel:get_argument_value(100)			-- QFE copilot		
			
	}	


		-- exporting instruments data
		for a=1, 135 do
			SendData(tostring(a), string.format("%0.3f",  instruments_table[a] ) )
		end
--[[		
]]--					
					
					



 
				-- lamps table >>>> YAW

				
				
				
			local lamps_table =
			{	
				[1] = convert_lamp (MainPanel:get_argument_value(33)),      -- RALT_warning_flag
				[2] = convert_lamp (MainPanel:get_argument_value(30)),      -- RALT_lamp
				[3] = convert_lamp (MainPanel:get_argument_value(831)),		-- hover_lamp_off
				[4] = convert_lamp (MainPanel:get_argument_value(783)),     -- lamp_AP_pitch_roll_on
				[5] = convert_lamp (MainPanel:get_argument_value(72)),      -- lamp_VIBRATION_LEFT_HIGH
				[6] = convert_lamp (MainPanel:get_argument_value(73)),      -- lamp_VIBRATION_RIGHT_HIGH
				[7] = convert_lamp (MainPanel:get_argument_value(74)),      -- lamp_FIRE
				[8] = convert_lamp (MainPanel:get_argument_value(76)),      -- lamp_LEFT_ENG_TURN_OFF
				[9] = convert_lamp (MainPanel:get_argument_value(77)),      -- lamp_RIGHT_ENG_TURN_OFF
				[10] = convert_lamp (MainPanel:get_argument_value(68)),     -- lamp_CLOG_TF_LEFT
				[11] = convert_lamp (MainPanel:get_argument_value(69)),     -- lamp_CLOG_TF_RIGHT
				[12] = convert_lamp (MainPanel:get_argument_value(70)),     -- lamp_CHIP_LEFT_ENG
				[13] = convert_lamp (MainPanel:get_argument_value(71)),     -- lamp_CHIP_RIGHT_ENG
				[14] = convert_lamp (MainPanel:get_argument_value(78)),     -- lamp_FT_LEFT_HIGH
				[15] = convert_lamp (MainPanel:get_argument_value(79)),     -- lamp_FT_RIGHT_HIGH
				[16] = convert_lamp (MainPanel:get_argument_value(80)),     -- lamp_OIL_PRESSURE_LEFT
				[17] = convert_lamp (MainPanel:get_argument_value(81)),     -- lamp_OIL_PRESSURE_RIGHT
				[18] = convert_lamp (MainPanel:get_argument_value(82)),     -- lamp_ER_LEFT
				[19] = convert_lamp (MainPanel:get_argument_value(83)),     -- lamp_ER_RIGHT
				[20] = convert_lamp (MainPanel:get_argument_value(84)),     -- lamp_EEC_LEFT_OFF
				[21] = convert_lamp (MainPanel:get_argument_value(85)),     -- lamp_EEC_RIGHT_OFF
				[22] = convert_lamp (MainPanel:get_argument_value(86)),     -- lamp_CIRCUIT_FROM_BATTERY
				[23] = convert_lamp (MainPanel:get_argument_value(873)),    -- lamp_CHIP_MAIN_REDUCTOR
				[24] = convert_lamp (MainPanel:get_argument_value(874)),    -- lamp_CHIP_INTER_REDUCTOR
				[25] = convert_lamp (MainPanel:get_argument_value(875)),    -- lamp_CHIP_TAIL_REDUCTOR
				[26] = convert_lamp (MainPanel:get_argument_value(377)),    -- lamp_LEFT_ENG_FIRE
				[27] = convert_lamp (MainPanel:get_argument_value(378)),    -- lamp_RIGHT_ENG_FIRE
				[28] = convert_lamp (MainPanel:get_argument_value(379)),    -- lamp_KO50_FIRE
				[29] = convert_lamp (MainPanel:get_argument_value(380)),    -- lamp_REDUC_AI9_FIRE
				[30] = convert_lamp (MainPanel:get_argument_value(381)),    -- lamp_FIRE_LENG_1_QUEUE
				[31] = convert_lamp (MainPanel:get_argument_value(382)),    -- lamp_FIRE_RENG_1_QUEUE
				[32] = convert_lamp (MainPanel:get_argument_value(383)),    -- lamp_FIRE_KO50_1_QUEUE
				[33] = convert_lamp (MainPanel:get_argument_value(384)),    -- lamp_FIRE_REDUCT_1_QUEUE
				[34] = convert_lamp (MainPanel:get_argument_value(385)),    -- lamp_FIRE_LENG_2_QUEUE
				[35] = convert_lamp (MainPanel:get_argument_value(386)),    -- lamp_FIRE_RENG_2_QUEUE
				[36] = convert_lamp (MainPanel:get_argument_value(387)),    -- lamp_FIRE_KO50_2_QUEUE
				[37] = convert_lamp (MainPanel:get_argument_value(388)),    -- lamp_FIRE_REDUCT_2_QUEUE
				[38] = convert_lamp (MainPanel:get_argument_value(407)),    -- lamp_HYDRO_main_on
				[39] = convert_lamp (MainPanel:get_argument_value(408)),    -- lamp_HYDRO_aux_on
				[40] = convert_lamp (MainPanel:get_argument_value(414)),    -- lamp_APD9_on
				[41] = convert_lamp (MainPanel:get_argument_value(416)),    -- lamp_APD9_oil_pressure
				[42] = convert_lamp (MainPanel:get_argument_value(417)),    -- lamp_APD9_rpm
				[43] = convert_lamp (MainPanel:get_argument_value(418)),    -- lamp_APD9_rpm_high
				[44] = convert_lamp (MainPanel:get_argument_value(420)),    -- lamp_APD_on
				[45] = convert_lamp (MainPanel:get_argument_value(424)),    -- lamp_APD_starter_on
				[46] = convert_lamp (MainPanel:get_argument_value(434)),    -- lamp_FUEL_left_closed
				[47] = convert_lamp (MainPanel:get_argument_value(435)),    -- lamp_FUEL_right_closed
				[48] = convert_lamp (MainPanel:get_argument_value(436)),    -- lamp_FUEL_ring_closed
				[49] = convert_lamp (MainPanel:get_argument_value(441)),    -- lamp_FUEL_center_on
				[50] = convert_lamp (MainPanel:get_argument_value(442)),    -- lamp_FUEL_left_on
				[51] = convert_lamp (MainPanel:get_argument_value(443)),    -- lamp_FUEL_right_on
				[52] = convert_lamp (MainPanel:get_argument_value(398)),    -- lamp_CHECK_SENSORS
				[53] = convert_lamp (MainPanel:get_argument_value(504)),    -- lamp_ELEC_turn_VU1
				[54] = convert_lamp (MainPanel:get_argument_value(505)),    -- lamp_ELEC_turn_VU2
				[55] = convert_lamp (MainPanel:get_argument_value(506)),    -- lamp_ELEC_turn_VU3
				[56] = convert_lamp (MainPanel:get_argument_value(507)),    -- lamp_ELEC_DC_ground
				[57] = convert_lamp (MainPanel:get_argument_value(508)),    -- lamp_ELEC_test_equipment
				[58] = convert_lamp (MainPanel:get_argument_value(543)),    -- lamp_ELEC_gen1_fail	
				[59] = convert_lamp (MainPanel:get_argument_value(544)),    -- lamp_ELEC_gen2_fail
				[60] = convert_lamp (MainPanel:get_argument_value(545)),    -- lamp_ELEC_AC_ground	
				[61] = convert_lamp (MainPanel:get_argument_value(546)),    -- lamp_ELEC_PO_500
				[62] = convert_lamp (MainPanel:get_argument_value(509)),	-- lamp_LEFT_PZU_ON
				[63] = convert_lamp (MainPanel:get_argument_value(510)),	-- lamp_RIGHT_PZU_ON 
				[64] = convert_lamp (MainPanel:get_argument_value(781)),    -- lamp_AP_heading_on
				[65] = convert_lamp (MainPanel:get_argument_value(782)),    -- lamp_AP_heading_off	
				[66] = convert_lamp (MainPanel:get_argument_value(783)),    -- lamp_AP_pitch_roll_on
				[67] = convert_lamp (MainPanel:get_argument_value(784)),	-- lamp_AP_height_on
				[68] = convert_lamp (MainPanel:get_argument_value(785)),	-- lamp_AP_height_off 
				[69] = convert_lamp (MainPanel:get_argument_value(316)),	-- lamp_ENGINE_RT_LEFT_ON 
				[70] = convert_lamp (MainPanel:get_argument_value(317)),    -- lamp_ENGINE_RT_RIGHT_ON
				[71] = convert_lamp (MainPanel:get_argument_value(318)),    -- lamp_SARPP_ON	
				[72] = convert_lamp (MainPanel:get_argument_value(326)),    -- lamp_LOCK_OPEN
				[73] = convert_lamp (MainPanel:get_argument_value(327)),	-- lamp_DOORS_OPEN
				[74] = convert_lamp (MainPanel:get_argument_value(340)),	-- lamp_TURN_ON_RI_65
				[75] = convert_lamp (MainPanel:get_argument_value(360)),	-- lamp_FROST
				[76] = convert_lamp (MainPanel:get_argument_value(362)),	-- lamp_LEFT_ENG_HEATING
				[77] = convert_lamp (MainPanel:get_argument_value(363)),    -- lamp_RIGHT_ENG_HEATING
				[78] = convert_lamp (MainPanel:get_argument_value(361)),    -- lamp_ANTI_ICE_ON
				[79] = convert_lamp (MainPanel:get_argument_value(364)),    -- lamp_LEFT_PZU_FRONT
				[80] = convert_lamp (MainPanel:get_argument_value(365)),	-- lamp_RIGHT_PZU_FRONT
				[81] = convert_lamp (MainPanel:get_argument_value(366)),	-- lamp_LEFT_PZU_BACK
				[82] = convert_lamp (MainPanel:get_argument_value(367)),	-- lamp_RIGHT_PZU_BACK
				[83] = convert_lamp (MainPanel:get_argument_value(373)),    -- lamp_SECTION_1
				[84] = convert_lamp (MainPanel:get_argument_value(375)),    -- lamp_SECTION_2
				[85] = convert_lamp (MainPanel:get_argument_value(374)),    -- lamp_SECTION_3
				[86] = convert_lamp (MainPanel:get_argument_value(376)),	-- lamp_SECTION_4
				[87] = convert_lamp (MainPanel:get_argument_value(368)),	-- lamp_RIO_heating_ok
				[88] = convert_lamp (MainPanel:get_argument_value(461)),	-- lamp_HEATER
				[89] = convert_lamp (MainPanel:get_argument_value(462)),	-- lamp_IGNITION
				[90] = convert_lamp (MainPanel:get_argument_value(463)),    -- lamp_KO50_ON
				[91] = convert_lamp (MainPanel:get_argument_value(341)),    -- lamp_LEFT_PITOT_HEATER_OK
				[92] = convert_lamp (MainPanel:get_argument_value(490)),    -- lamp_RIGHT_PITOT_HEATER_OK
				[93] = convert_lamp (MainPanel:get_argument_value(509)),	-- lamp_LEFT_PZU_ON
				[94] = convert_lamp (MainPanel:get_argument_value(510)),	-- lamp_RIGHT_PZU_ON
				[95] = convert_lamp (MainPanel:get_argument_value(873)),    -- lamp_CHIP_MAIN_REDUCTOR
				[96] = convert_lamp (MainPanel:get_argument_value(874)),    -- lamp_CHIP_INTER_REDUCTOR
				[97] = convert_lamp (MainPanel:get_argument_value(875)),    -- lamp_CHIP_TAIL_REDUCTOR
				[98] = convert_lamp (MainPanel:get_argument_value(64)),		-- lamp_300_Left   (low fuel?)
				[99] = convert_lamp (MainPanel:get_argument_value(65)),		-- lamp_DISS_OFF   (doppler Off?)
				[100] = convert_lamp (MainPanel:get_argument_value(555)),     -- lamp_BD1
				[101] = convert_lamp (MainPanel:get_argument_value(556)),     -- lamp_BD2
				[102] = convert_lamp (MainPanel:get_argument_value(557)),     -- lamp_BD3
				[103] = convert_lamp (MainPanel:get_argument_value(558)),     -- lamp_BD4
				[104] = convert_lamp (MainPanel:get_argument_value(559)),     -- lamp_BD5
				[105] = convert_lamp (MainPanel:get_argument_value(560)),     -- lamp_BD6
				[106] = convert_lamp (MainPanel:get_argument_value(711)),     -- lamp_BD1Bomb
				[107] = convert_lamp (MainPanel:get_argument_value(712)),     -- lamp_BD2Bomb
				[108] = convert_lamp (MainPanel:get_argument_value(713)),     -- lamp_BD3Bomb
				[109] = convert_lamp (MainPanel:get_argument_value(714)),     -- lamp_BD4Bomb
				[110] = convert_lamp (MainPanel:get_argument_value(715)),     -- lamp_BD5Bomb
				[111] = convert_lamp (MainPanel:get_argument_value(716)),     -- lamp_BD6Bomb
				[112] = convert_lamp (MainPanel:get_argument_value(562)),     -- lamp_PUS1
				[113] = convert_lamp (MainPanel:get_argument_value(563)),     -- lamp_PUS3
				[114] = convert_lamp (MainPanel:get_argument_value(564)),     -- lamp_PUS4
				[115] = convert_lamp (MainPanel:get_argument_value(565)),     -- lamp_PUS6
				[116] = convert_lamp (MainPanel:get_argument_value(561)),     -- lamp_EmergExplode
				[117] = convert_lamp (MainPanel:get_argument_value(705)),     -- lamp_EmergExplodeSec
				[118] = convert_lamp (MainPanel:get_argument_value(710)),     -- lamp_BV_Net_On
				[119] = convert_lamp (MainPanel:get_argument_value(566)),     -- lamp_RS_Net_On
				[120] = convert_lamp (MainPanel:get_argument_value(567)),     -- lamp_GUV_Net_On
				[121] = convert_lamp (MainPanel:get_argument_value(568)),     -- lamp_FKP_On
				[122] = convert_lamp (MainPanel:get_argument_value(778)),     -- lamp_Caution_Weap 1
				[123] = convert_lamp (MainPanel:get_argument_value(586)),     -- lamp_Caution_Weap 2
				[124] = convert_lamp (MainPanel:get_argument_value(587)),     -- lamp_Caution_Weap 3
				[125] = convert_lamp (MainPanel:get_argument_value(588)),     -- lamp_Caution_Weap 4
				[126] = convert_lamp (MainPanel:get_argument_value(786)),     -- SPUU52_lamp
				[127] = convert_lamp (MainPanel:get_argument_value(823)),     -- diss15_check_work_lamp
				[128] = convert_lamp (MainPanel:get_argument_value(824)),     -- diss15_check_failM_lamp
				[129] = convert_lamp (MainPanel:get_argument_value(825)),     -- diss15_check_failC_lamp
				[130] = convert_lamp (MainPanel:get_argument_value(822)),     -- diss15_check_control_lamp
				[131] = convert_lamp (MainPanel:get_argument_value(796)),     -- diss15_W_memory_lamp
				[132] = convert_lamp (MainPanel:get_argument_value(817)),     -- diss15_coord_on_lamp
				[133] = convert_lamp (MainPanel:get_argument_value(458)),     -- ARC_UD_Narrow_Lamp
				[134] = convert_lamp (MainPanel:get_argument_value(459)),     -- ARC_UD_Wide_Lamp
				[135] = convert_lamp (MainPanel:get_argument_value(460)),     -- ARC_UD_Pulse_Lamp
				[136] = convert_lamp (MainPanel:get_argument_value(827)),     -- PU_26_GA_Lamp
				[137] = convert_lamp (MainPanel:get_argument_value(849)),     -- Jadro_ASU_Lamp
				[138] = convert_lamp (MainPanel:get_argument_value(848)),     -- Jadro_Ctl_Lamp
				[139] = convert_lamp (MainPanel:get_argument_value(850)),     -- Jadro_Breakdown_Lamp
				[140] = convert_lamp (MainPanel:get_argument_value(892)),     -- UV26_Left
				[141] = convert_lamp (MainPanel:get_argument_value(891)),     -- UV26_Right
				[142] = convert_lamp (MainPanel:get_argument_value(740)),     -- R828_ASU tune lamp
				[143] = convert_lamp (MainPanel:get_argument_value(306)),     -- lamp_Record_P503B
				[144] = convert_lamp (MainPanel:get_argument_value(325)),     -- Descent Siren
				[145] = convert_lamp (MainPanel:get_argument_value(302)),     -- lamp_IFF_KD
				[146] = convert_lamp (MainPanel:get_argument_value(303)),     -- lamp_IFF_KP
				[147] = convert_lamp (MainPanel:get_argument_value(912)),     -- lamp_IFF_TurnOnReserve
				[148] = convert_lamp (MainPanel:get_argument_value(87))       -- lamp_IFF_Failure
				
			
			} 
					-- flag values in index 1001
					for a=1001, 1148 do
						SendData(tostring(a), string.format("%1d",  lamps_table[a-1000] ) )
					end
					
					
						----------------------------------------------------------
						---- ok, now lets send all this MI-8 data across DCS general interface to Helios
						----------------------------------------------------------			
				
				
				-- gauges and instruments 2  
				
			
					

			
		--	   --[[	
				SendData("3001", string.format("%1d", MainPanel:get_argument_value(497) ) ) -- Standby Generator Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_1
				SendData("3002", string.format("%1d", MainPanel:get_argument_value(496) ) ) -- Battery 2 Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_2
				SendData("3003", string.format("%1d", MainPanel:get_argument_value(495) ) ) -- Battery 1 Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_3
				SendData("3004", string.format("%1d", MainPanel:get_argument_value(502) ) ) -- DC Ground Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_4
				SendData("3005", string.format("%1d", MainPanel:get_argument_value(500) ) ) -- Rectifier 2 Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_5
				SendData("3006", string.format("%1d", MainPanel:get_argument_value(501) ) ) -- Rectifier 3 Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_6
				SendData("3007", string.format("%1d", MainPanel:get_argument_value(499) ) ) -- Rectifier 1 Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_7
				SendData("3008", string.format("%1d", MainPanel:get_argument_value(503) ) ) -- Equipment Test Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_8
				SendData("3009", string.format("%1d", MainPanel:get_argument_value(540) ) ) -- AC Ground Power Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_9
				SendData("3010", string.format("%1d", MainPanel:get_argument_value(538) ) ) -- Generator 1 Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_10
				SendData("3011", string.format("%1d", MainPanel:get_argument_value(539) ) ) -- Generator 2 Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_11
				SendData("3012", string.format("%1d", MainPanel:get_argument_value(148) ) ) -- Net on Rectifier Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_12
				SendData("3013", string.format("%1d", MainPanel:get_argument_value(147) ) ) -- Net on Rectifier Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_13
				SendData("3031", string.format("%1d", MainPanel:get_argument_value(590) ) ) -- CB BW ESBR, ON/OFF >> TOGLEE_SWITCH :: TSwitch_31
				SendData("3032", string.format("%1d", MainPanel:get_argument_value(591) ) ) -- CB Explode, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_32
				SendData("3033", string.format("%1d", MainPanel:get_argument_value(592) ) ) -- CB Control, ON/OFF_mi8	>> TOGLEE_SWITCH :: TSwitch_33
				SendData("3034", string.format("%1d", MainPanel:get_argument_value(593) ) ) -- CB Equipment, ON/OFF >> TOGLEE_SWITCH :: TSwitch_34
				SendData("3035", string.format("%1d", MainPanel:get_argument_value(594) ) ) -- CB RS/GUV Fire, ON/OFF >> TOGLEE_SWITCH :: TSwitch_35
				SendData("3036", string.format("%1d", MainPanel:get_argument_value(595) ) ) -- CB RS/GUV Warning, ON/OFF >> TOGLEE_SWITCH :: TSwitch_36
				SendData("3037", string.format("%1d", MainPanel:get_argument_value(596) ) ) -- CB ESBR Heating, ON/OFF >> TOGLEE_SWITCH :: TSwitch_37
				SendData("3038", string.format("%1d", MainPanel:get_argument_value(597) ) ) -- CB 311, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_38
				SendData("3039", string.format("%1d", MainPanel:get_argument_value(598) ) ) -- CB GUV: Outer 800 Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_39
				SendData("3040", string.format("%1d", MainPanel:get_argument_value(599) ) ) -- CB GUV: Outer 800 Right, ON/OFF >> TOGLEE_SWITCH :: TSwitch_40
				SendData("3041", string.format("%1d", MainPanel:get_argument_value(600) ) ) -- CB GUV: Inner Left 622 Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_41
				SendData("3042", string.format("%1d", MainPanel:get_argument_value(601) ) ) -- CB GUV: Inner Left 622 Right, ON/OFF >> TOGLEE_SWITCH :: TSwitch_42
				SendData("3043", string.format("%1d", MainPanel:get_argument_value(602) ) ) -- CB GUV: Inner Right 622 Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_43
				SendData("3044", string.format("%1d", MainPanel:get_argument_value(603) ) ) -- CB GUV: Inner Right 622 Right, ON/OFF >> TOGLEE_SWITCH :: TSwitch_44
				SendData("3045", string.format("%1d", MainPanel:get_argument_value(604) ) ) -- CB Electric Launch 800 Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_45
				SendData("3046", string.format("%1d", MainPanel:get_argument_value(605) ) ) -- CB Electric Launch 800 Right, ON/OFF >> TOGLEE_SWITCH :: TSwitch_46
				SendData("3047", string.format("%1d", MainPanel:get_argument_value(606) ) ) -- CB PKT, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_47
				SendData("3048", string.format("%1d", MainPanel:get_argument_value(607) ) ) -- CB Emergency Jettison: Bombs and GUV, ON/OFF >> TOGLEE_SWITCH :: TSwitch_48
				SendData("3049", string.format("%1d", MainPanel:get_argument_value(608) ) ) -- CB Emergency Jettison: Power, ON/OFF >> TOGLEE_SWITCH :: TSwitch_49
				SendData("3050", string.format("%1d", MainPanel:get_argument_value(609) ) ) -- CB Emergency Jettison: Armed, ON/OFF >> TOGLEE_SWITCH :: TSwitch_50
				SendData("3051", string.format("%1d", MainPanel:get_argument_value(610) ) ) -- CB Signal Flare, ON/OFF >> TOGLEE_SWITCH :: TSwitch_51
				SendData("3052", string.format("%1d", MainPanel:get_argument_value(611) ) ) -- CB APU Start, ON/OFF >> TOGLEE_SWITCH :: TSwitch_52
				SendData("3053", string.format("%1d", MainPanel:get_argument_value(612) ) ) -- CB APU Ignition, ON/OFF >> TOGLEE_SWITCH :: TSwitch_53
				SendData("3054", string.format("%1d", MainPanel:get_argument_value(613) ) ) -- CB Engine Start, ON/OFF >> TOGLEE_SWITCH :: TSwitch_54
				SendData("3055", string.format("%1d", MainPanel:get_argument_value(614) ) ) -- CB Engine Ignition, ON/OFF >> TOGLEE_SWITCH :: TSwitch_55
				SendData("3056", string.format("%1d", MainPanel:get_argument_value(615) ) ) -- CB RPM CONTROL, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_56
				SendData("3057", string.format("%1d", MainPanel:get_argument_value(616) ) ) -- CB NONAME, ON/OFF >> TOGLEE_SWITCH :: TSwitch_57
				SendData("3058", string.format("%1d", MainPanel:get_argument_value(617) ) ) -- CB Lock Opening Control Main, ON/OFF >> TOGLEE_SWITCH :: TSwitch_58
				SendData("3059", string.format("%1d", MainPanel:get_argument_value(618) ) ) -- CB Lock Opening Control Reserve, ON/OFF >> TOGLEE_SWITCH :: TSwitch_59
				SendData("3060", string.format("%1d", MainPanel:get_argument_value(619) ) ) -- CB TURN INDICATOR, ON/OFF >> TOGLEE_SWITCH :: TSwitch_60
				SendData("3061", string.format("%1d", MainPanel:get_argument_value(620) ) ) -- CB Autopilot: Main, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_61
				SendData("3062", string.format("%1d", MainPanel:get_argument_value(621) ) ) -- CB Autopilot: Friction, ON/OFF >> TOGLEE_SWITCH :: TSwitch_62
				SendData("3063", string.format("%1d", MainPanel:get_argument_value(622) ) ) -- CB Autopilot: Electric Clutches, ON/OFF >> TOGLEE_SWITCH :: TSwitch_63
				SendData("3064", string.format("%1d", MainPanel:get_argument_value(623) ) ) -- CB Hydraulics: Main, ON/OFF >> TOGLEE_SWITCH :: TSwitch_64
				SendData("3065", string.format("%1d", MainPanel:get_argument_value(624) ) ) -- CB Hydraulics: Auxiliary, ON/OFF >> TOGLEE_SWITCH :: TSwitch_65
				SendData("3066", string.format("%1d", MainPanel:get_argument_value(625) ) ) -- CB Radio: SPU (Intercom), ON/OFF >> TOGLEE_SWITCH :: TSwitch_66
				SendData("3067", string.format("%1d", MainPanel:get_argument_value(626) ) ) -- CB Radio: Altimeter, ON/OFF >> TOGLEE_SWITCH :: TSwitch_67
				SendData("3068", string.format("%1d", MainPanel:get_argument_value(627) ) ) -- CB Radio: Command Radio Station (R-863), ON/OFF >> TOGLEE_SWITCH :: TSwitch_68
				SendData("3069", string.format("%1d", MainPanel:get_argument_value(628) ) ) -- CB Radio: 6201, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_69
				SendData("3070", string.format("%1d", MainPanel:get_argument_value(629) ) ) -- CB Fuel System: Bypass Valve, ON/OFF >> TOGLEE_SWITCH :: TSwitch_70
				SendData("3071", string.format("%1d", MainPanel:get_argument_value(630) ) ) -- CB Fuel System: Left Valve, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_71
				SendData("3072", string.format("%1d", MainPanel:get_argument_value(631) ) ) -- CB Fuel System: Right Valve, ON/OFF >> TOGLEE_SWITCH :: TSwitch_72
				SendData("3073", string.format("%1d", MainPanel:get_argument_value(632) ) ) -- CB Fuel System: Fuelmeter, ON/OFF >> TOGLEE_SWITCH :: TSwitch_73
				SendData("3074", string.format("%1d", MainPanel:get_argument_value(633) ) ) -- CB Fuel System: Center Tank Pump, ON/OFF >> TOGLEE_SWITCH :: TSwitch_74
				SendData("3075", string.format("%1d", MainPanel:get_argument_value(634) ) ) -- CB Fuel System: Left Tank Pump, ON/OFF >> TOGLEE_SWITCH :: TSwitch_75
				SendData("3076", string.format("%1d", MainPanel:get_argument_value(635) ) ) -- CB Fuel System: Right Tank Pump, ON/OFF >> TOGLEE_SWITCH :: TSwitch_76
				SendData("3077", string.format("%1d", MainPanel:get_argument_value(636) ) ) -- CB T-819, ON/OFF >> TOGLEE_SWITCH :: TSwitch_77
				SendData("3078", string.format("%1d", MainPanel:get_argument_value(637) ) ) -- CB SPUU-52, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_78
				SendData("3079", string.format("%1d", MainPanel:get_argument_value(638) ) ) -- CB Fire Protection System: Signalization, ON/OFF >> TOGLEE_SWITCH :: TSwitch_79
				SendData("3080", string.format("%1d", MainPanel:get_argument_value(639) ) ) -- CB Fire Protection System: 1 Queue Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_80
				SendData("3081", string.format("%1d", MainPanel:get_argument_value(640) ) ) -- CB Fire Protection System: 1 Queue Right, ON/OFF >> TOGLEE_SWITCH :: TSwitch_81
				SendData("3082", string.format("%1d", MainPanel:get_argument_value(641) ) ) -- CB Fire Protection System: 2 Queue Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_82
				SendData("3083", string.format("%1d", MainPanel:get_argument_value(642) ) ) -- CB Fire Protection System: 2 Queue Right, ON/OFF >> TOGLEE_SWITCH :: TSwitch_83
				SendData("3084", string.format("%1d", MainPanel:get_argument_value(643) ) ) -- CB Radio: Radio Compass MW(ARC-9), ON/OFF	>> TOGLEE_SWITCH :: TSwitch_84
				SendData("3085", string.format("%1d", MainPanel:get_argument_value(644) ) ) -- CB Radio: Radio Compass VHF(ARC-UD), ON/OFF >> TOGLEE_SWITCH :: TSwitch_85
				SendData("3086", string.format("%1d", MainPanel:get_argument_value(645) ) ) -- CB Radio: Doppler Navigator, ON/OFF >> TOGLEE_SWITCH :: TSwitch_86
				SendData("3087", string.format("%1d", MainPanel:get_argument_value(646) ) ) -- CB Radio: Radio Meter, ON/OFF >> TOGLEE_SWITCH :: TSwitch_87
				SendData("3088", string.format("%1d", MainPanel:get_argument_value(647) ) ) -- CB Headlights: Left: Control, ON/OFF >> TOGLEE_SWITCH :: TSwitch_88
				SendData("3089", string.format("%1d", MainPanel:get_argument_value(648) ) ) -- CB Headlights: Left: Light, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_89
				SendData("3090", string.format("%1d", MainPanel:get_argument_value(649) ) ) -- CB Headlights: Right: Control, ON/OFF >> TOGLEE_SWITCH :: TSwitch_90
				SendData("3091", string.format("%1d", MainPanel:get_argument_value(650) ) ) -- CB Headlights: Right: Light, ON/OFF >> TOGLEE_SWITCH :: TSwitch_91
				SendData("3092", string.format("%1d", MainPanel:get_argument_value(651) ) ) -- CB ANO, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_92
				SendData("3093", string.format("%1d", MainPanel:get_argument_value(652) ) ) -- CB Wing Lights, ON/OFF >> TOGLEE_SWITCH :: TSwitch_93
				SendData("3094", string.format("%1d", MainPanel:get_argument_value(653) ) ) -- CB Check Lamps/Flasher, ON/OFF >> TOGLEE_SWITCH :: TSwitch_94
				SendData("3095", string.format("%1d", MainPanel:get_argument_value(918) ) ) -- CB PRF-4 Light Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_95
				SendData("3096", string.format("%1d", MainPanel:get_argument_value(919) ) ) -- CB PRF-4 Light Right, ON/OFF >> TOGLEE_SWITCH :: TSwitch_96
				SendData("3097", string.format("%1d", MainPanel:get_argument_value(656) ) ) -- CB Defrost System: Control, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_97
				SendData("3098", string.format("%1d", MainPanel:get_argument_value(657) ) ) -- CB Defrost System: Left Engine, ON/OFF >> TOGLEE_SWITCH :: TSwitch_98
				SendData("3099", string.format("%1d", MainPanel:get_argument_value(658) ) ) -- CB Defrost System: Right Engine, ON/OFF >> TOGLEE_SWITCH :: TSwitch_99
				SendData("3100", string.format("%1d", MainPanel:get_argument_value(659) ) ) -- CB Defrost System: RIO-3, ON/OFF >> TOGLEE_SWITCH :: TSwitch_100
				SendData("3101", string.format("%1d", MainPanel:get_argument_value(660) ) ) -- CB Defrost System: Glass, ON/OFF >> TOGLEE_SWITCH :: TSwitch_101
				SendData("3102", string.format("%1d", MainPanel:get_argument_value(661) ) ) -- CB Wiper Left, ON/OFF >> TOGLEE_SWITCH :: TSwitch_102
				SendData("3103", string.format("%1d", MainPanel:get_argument_value(662) ) ) -- CB Wiper Right, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_103
				SendData("3104", string.format("%1d", MainPanel:get_argument_value(663) ) ) -- CB RIO-3, ON/OFF >> TOGLEE_SWITCH :: TSwitch_104
				SendData("3105", string.format("%1d", MainPanel:get_argument_value(664) ) ) -- CB Heater KO-50, ON/OFF >> TOGLEE_SWITCH :: TSwitch_105
				SendData("3106", string.format("%1d", MainPanel:get_argument_value(522) ) ) -- Battery Heating Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_106
				SendData("3107", string.format("%1d", MainPanel:get_argument_value(438) ) ) -- Feed Tank Pump Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_107
				SendData("3108", string.format("%1d", MainPanel:get_argument_value(439) ) ) -- Left Tank Pump Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_108
				SendData("3109", string.format("%1d", MainPanel:get_argument_value(440) ) ) -- Right Tank Pump Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_109
				SendData("3110", string.format("%1d", MainPanel:get_argument_value(427) ) ) -- Left Shutoff Valve Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_110
				SendData("3111", string.format("%1d", MainPanel:get_argument_value(429) ) ) -- Right Shutoff Valve Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_111
				SendData("3112", string.format("%1d", MainPanel:get_argument_value(426) ) ) -- Left Shutoff Valve Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_112
				SendData("3113", string.format("%1d", MainPanel:get_argument_value(428) ) ) -- Right Shutoff Valve Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_113
				SendData("3114", string.format("%1d", MainPanel:get_argument_value(431) ) ) -- Crossfeed Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_114
				SendData("3115", string.format("%1d", MainPanel:get_argument_value(430) ) ) -- Crossfeed Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_115
				SendData("3116", string.format("%1d", MainPanel:get_argument_value(433) ) ) -- Bypass Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_116
				SendData("3117", string.format("%1d", MainPanel:get_argument_value(432) ) ) -- Bypass Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_117
				SendData("3118", string.format("%1d", MainPanel:get_argument_value(204) ) ) -- Left Engine Stop Lever >> TOGLEE_SWITCH :: TSwitch_118
				SendData("3119", string.format("%1d", MainPanel:get_argument_value(206) ) ) -- Right Engine Stop Lever >> TOGLEE_SWITCH :: TSwitch_119
				SendData("3120", string.format("%1d", MainPanel:get_argument_value(208) ) ) -- Rotor Brake Handle, UP/DOWN >> TOGLEE_SWITCH :: TSwitch_120
				SendData("3121", string.format("%1d", MainPanel:get_argument_value(167) ) ) -- Left Engine EEC Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_121
				SendData("3122", string.format("%1d", MainPanel:get_argument_value(173) ) ) -- Right Engine EEC Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_122
				SendData("3123", string.format("%1d", MainPanel:get_argument_value(168) ) ) -- Left Engine ER Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_123
				SendData("3124", string.format("%1d", MainPanel:get_argument_value(172) ) ) -- Right Engine ER Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_124
				SendData("3125", string.format("%1d", MainPanel:get_argument_value(406) ) ) -- Main Hydraulic Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_125
				SendData("3126", string.format("%1d", MainPanel:get_argument_value(410) ) ) -- Auxiliary Hydraulic Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_126
				SendData("3127", string.format("%1d", MainPanel:get_argument_value(409) ) ) -- Auxiliary Hydraulic Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_127
				SendData("3128", string.format("%1d", MainPanel:get_argument_value(35) ) ) -- Radar Altimeter Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_128
				SendData("3129", string.format("%1d", MainPanel:get_argument_value(858) ) ) -- HSI Radio Compass Selector Switch, ARC-9/ARC-UD >> TOGLEE_SWITCH :: TSwitch_129
				SendData("3130", string.format("%1d", MainPanel:get_argument_value(921) ) ) -- Weapon Safe/Armed Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_130
				SendData("3131", string.format("%1d", MainPanel:get_argument_value(707) ) ) -- Emergency Explode Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_131
				SendData("3132", string.format("%1d", MainPanel:get_argument_value(706) ) ) -- Emergency Explode Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_132
				SendData("3133", string.format("%1d", MainPanel:get_argument_value(708) ) ) -- Emergency Bomb Release Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_133
				SendData("3134", string.format("%1d", MainPanel:get_argument_value(717) ) ) -- Main Bombs Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_134
				SendData("3135", string.format("%1d", MainPanel:get_argument_value(720) ) ) -- ESBR Heating Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_135
				SendData("3136", string.format("%1d", MainPanel:get_argument_value(731) ) ) -- ESBR Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_136
				SendData("3137", string.format("%1d", MainPanel:get_argument_value(570) ) ) -- Emergency Explode Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_137
				SendData("3138", string.format("%1d", MainPanel:get_argument_value(569) ) ) -- Emergency Explode Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_138
				SendData("3139", string.format("%1d", MainPanel:get_argument_value(571) ) ) -- Emergency Release Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_139
				SendData("3140", string.format("%1d", MainPanel:get_argument_value(575) ) ) -- RS/GUV Selector Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_140
				SendData("3141", string.format("%1d", MainPanel:get_argument_value(349) ) ) -- 800_or_624_622_800 Switch >> TOGLEE_SWITCH :: TSwitch_141
				SendData("3142", string.format("%1d", MainPanel:get_argument_value(348) ) ) -- 800 or 624_622_800 Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_142
				SendData("3143", string.format("%1d", MainPanel:get_argument_value(573) ) ) -- Mine Arms Main Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_143
				SendData("3144", string.format("%1d", MainPanel:get_argument_value(905) ) ) -- PKT Selector Switch, FLIGHT ENGINEER/PILOT >> TOGLEE_SWITCH :: TSwitch_144
				SendData("3145", string.format("%1d", MainPanel:get_argument_value(185) ) ) -- Left Fire RS Button Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_145
				SendData("3146", string.format("%1d", MainPanel:get_argument_value(228) ) ) -- Right Fire RS Button Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_146
				SendData("3147", string.format("%1d", MainPanel:get_argument_value(352) ) ) -- Gun Camera Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_147
				SendData("3148", string.format("%1d", MainPanel:get_argument_value(523) ) ) -- Flasher Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_148
				SendData("3149", string.format("%1d", MainPanel:get_argument_value(525) ) ) -- Transparent Switch, DAY/NIGHT >> TOGLEE_SWITCH :: TSwitch_149
				SendData("3150", string.format("%1d", MainPanel:get_argument_value(332) ) ) -- SPUU-52 Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_150
			--SendData("3151", string.format("%1d", MainPanel:get_argument_value(127) ) ) -- SPUU-52 Control Engage Button >> TOGLEE_SWITCH :: TSwitch_151
				SendData("3152", string.format("%1d", MainPanel:get_argument_value(399) ) ) -- Fire Detector Test Switch >> TOGLEE_SWITCH :: TSwitch_152
				SendData("3153", string.format("%1d", MainPanel:get_argument_value(400) ) ) -- Squib Test Switch >> TOGLEE_SWITCH :: TSwitch_153
				SendData("3154", string.format("%1d", MainPanel:get_argument_value(353) ) ) -- Defrost Mode Switch, AUTO/MANUAL >> TOGLEE_SWITCH :: TSwitch_154
				SendData("3155", string.format("%1d", MainPanel:get_argument_value(355) ) ) -- Left Engine Heater Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_155
				SendData("3156", string.format("%1d", MainPanel:get_argument_value(356) ) ) -- Right Engine Heater Switch, MANUAL/AUTO >> TOGLEE_SWITCH :: TSwitch_156
				SendData("3157", string.format("%1d", MainPanel:get_argument_value(357) ) ) -- Glass Heater Switch, MANUAL/AUTO >> TOGLEE_SWITCH :: TSwitch_157
				SendData("3158", string.format("%1d", MainPanel:get_argument_value(358) ) ) -- Ice Detector Heater Switch, MANUAL/AUTO >> TOGLEE_SWITCH :: TSwitch_158
				SendData("3159", string.format("%1d", MainPanel:get_argument_value(519) ) ) -- Left Pitot Heater Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_159
				SendData("3160", string.format("%1d", MainPanel:get_argument_value(520) ) ) -- Right Pitot Heater Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_160
				SendData("3161", string.format("%1d", MainPanel:get_argument_value(483) ) ) -- Doppler Navigator Power Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_161
				SendData("3162", string.format("%1d", MainPanel:get_argument_value(797) ) ) -- Test/Work Switch >> TOGLEE_SWITCH :: TSwitch_162
				SendData("3163", string.format("%1d", MainPanel:get_argument_value(798) ) ) -- Land/Sea Switch	>> TOGLEE_SWITCH :: TSwitch_163
				SendData("3164", string.format("%1d", MainPanel:get_argument_value(487) ) ) -- Right Attitude Indicator Power Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_164
				SendData("3165", string.format("%1d", MainPanel:get_argument_value(335) ) ) -- Left Attitude Indicator Power Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_165
				SendData("3166", string.format("%1d", MainPanel:get_argument_value(336) ) ) -- VK-53 Power Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_166
				SendData("3167", string.format("%1d", MainPanel:get_argument_value(485) ) ) -- GMC Power Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_167
				SendData("3168", string.format("%1d", MainPanel:get_argument_value(470) ) ) -- GMC Hemisphere Selection Switch, NORTH/SOUTH >> TOGLEE_SWITCH :: TSwitch_168
				SendData("3169", string.format("%1d", MainPanel:get_argument_value(517) ) ) -- Left Engine Dust Protection Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_169
				SendData("3170", string.format("%1d", MainPanel:get_argument_value(518) ) ) -- Right Engine Dust Protection Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_170
				SendData("3171", string.format("%1d", MainPanel:get_argument_value(515) ) ) -- Tip Lights Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_171
				SendData("3172", string.format("%1d", MainPanel:get_argument_value(516) ) ) -- Strobe Light Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_172
				SendData("3173", string.format("%1d", MainPanel:get_argument_value(836) ) ) -- Taxi Light Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_173
				SendData("3174", string.format("%1d", MainPanel:get_argument_value(479) ) ) -- 5.5V Lights Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_174
				SendData("3175", string.format("%1d", MainPanel:get_argument_value(511) ) ) -- Cargo Cabin Duty Lights Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_175
				SendData("3176", string.format("%1d", MainPanel:get_argument_value(512) ) ) -- Cargo Cabin Common Lights Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_176
				SendData("3177", string.format("%1d", MainPanel:get_argument_value(553) ) ) -- Radio/ICS Switch >> TOGLEE_SWITCH :: TSwitch_177
				SendData("3178", string.format("%1d", MainPanel:get_argument_value(551) ) ) -- Network 1/2 Switch (N/F) >> TOGLEE_SWITCH :: TSwitch_178
				SendData("3179", string.format("%1d", MainPanel:get_argument_value(845) ) ) -- Radio/ICS Switch >> TOGLEE_SWITCH :: TSwitch_179
				SendData("3180", string.format("%1d", MainPanel:get_argument_value(843) ) ) -- Network 1/2 Switch (N/F) >> TOGLEE_SWITCH :: TSwitch_180
				SendData("3181", string.format("%1d", MainPanel:get_argument_value(480) ) ) -- Laryngophone Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_181
				SendData("3182", string.format("%1d", MainPanel:get_argument_value(369) ) ) -- R-863, Modulation Switch, FM/AM >> TOGLEE_SWITCH :: TSwitch_182
				SendData("3183", string.format("%1d", MainPanel:get_argument_value(132) ) ) -- R-863, Unit Switch, DIAL/MEMORY >> TOGLEE_SWITCH :: TSwitch_183
				SendData("3184", string.format("%1d", MainPanel:get_argument_value(155) ) ) -- R-863, Squelch Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_184
				SendData("3185", string.format("%1d", MainPanel:get_argument_value(153) ) ) -- R-863, Emergency Receiver Switch, ON/OFF (N/F) >> TOGLEE_SWITCH :: TSwitch_185
				SendData("3186", string.format("%1d", MainPanel:get_argument_value(154) ) ) -- R-863, ARC Switch, ON/OFF (N/F) >> TOGLEE_SWITCH :: TSwitch_186
				SendData("3187", string.format("%1d", MainPanel:get_argument_value(739) ) ) -- R-828, Squelch Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_187
				SendData("3188", string.format("%1d", MainPanel:get_argument_value(756) ) ) -- R-828, Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_188
				SendData("3189", string.format("%1d", MainPanel:get_argument_value(757) ) ) -- R-828, Compass Switch, COMM/NAV >> TOGLEE_SWITCH :: TSwitch_189
				SendData("3190", string.format("%1d", MainPanel:get_argument_value(484) ) ) -- Jadro 1A, Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_190
				SendData("3191", string.format("%1d", MainPanel:get_argument_value(338) ) ) -- RI-65 Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_191
				SendData("3192", string.format("%1d", MainPanel:get_argument_value(295) ) ) -- RI-65 Amplifier Switch, ON/OFF	>> TOGLEE_SWITCH :: TSwitch_192
				SendData("3193", string.format("%1d", MainPanel:get_argument_value(453) ) ) -- ARC-UD, Sensitivity Switch, MORE/LESS >> TOGLEE_SWITCH :: TSwitch_193
				SendData("3194", string.format("%1d", MainPanel:get_argument_value(454) ) ) -- ARC-UD, Wave Switch, MW/D >> TOGLEE_SWITCH :: TSwitch_194
				SendData("3195", string.format("%1d", MainPanel:get_argument_value(481) ) ) -- ARC-UD, Lock Switch, LOCK/UNLOCK >> TOGLEE_SWITCH :: TSwitch_195
				SendData("3196", string.format("%1d", MainPanel:get_argument_value(521) ) ) -- Clock Heating Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_196
				SendData("3197", string.format("%1d", MainPanel:get_argument_value(910) ) ) -- CMD Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_197
				SendData("3198", string.format("%1d", MainPanel:get_argument_value(913) ) ) -- CMD Flares Amount Switch, COUNTER/PROGRAMMING >> TOGLEE_SWITCH :: TSwitch_198
				SendData("3199", string.format("%1d", MainPanel:get_argument_value(930) ) ) -- Parking Brake Handle >> TOGLEE_SWITCH :: TSwitch_199
				SendData("3200", string.format("%1d", MainPanel:get_argument_value(334) ) ) -- Left Fan Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_200
				SendData("3201", string.format("%1d", MainPanel:get_argument_value(488) ) ) -- Right Fan Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_201
				SendData("3202", string.format("%1d", MainPanel:get_argument_value(469) ) ) -- ARC-9, Dialer Switch, MAIN/BACKUP >> TOGLEE_SWITCH :: TSwitch_202
				SendData("3203", string.format("%1d", MainPanel:get_argument_value(444) ) ) -- ARC-9, TLF/TLG Switch >> TOGLEE_SWITCH :: TSwitch_203
				SendData("3204", string.format("%1d", MainPanel:get_argument_value(199) ) ) -- Tactical Cargo Release Button Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_204
				SendData("3205", string.format("%1d", MainPanel:get_argument_value(197) ) ) -- Emergency Cargo Release Button Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_205
				SendData("3206", string.format("%1d", MainPanel:get_argument_value(324) ) ) -- External Cargo Automatic Dropping, ON/OFF >> TOGLEE_SWITCH :: TSwitch_206
				SendData("3207", string.format("%1d", MainPanel:get_argument_value(282) ) ) -- Signal Flares Cassette 1 Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_207
				SendData("3208", string.format("%1d", MainPanel:get_argument_value(283) ) ) -- Signal Flares Cassette 2 Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_208
				SendData("3209", string.format("%1d", MainPanel:get_argument_value(467) ) ) -- KO-50 Fan Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_209
				SendData("3210", string.format("%1d", MainPanel:get_argument_value(315) ) ) -- SARPP-12 Mode Switch, MANUAL/AUTO >> TOGLEE_SWITCH :: TSwitch_210
				SendData("3211", string.format("%1d", MainPanel:get_argument_value(305) ) ) -- Recorder P-503B Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_211
				SendData("3212", string.format("%1d", MainPanel:get_argument_value(301) ) ) -- IFF Transponder Device Selector Switch, WORK/RESERVE >> TOGLEE_SWITCH :: TSwitch_212
				SendData("3213", string.format("%1d", MainPanel:get_argument_value(300) ) ) -- IFF Transponder Device Mode Switch, 1/2 >> TOGLEE_SWITCH :: TSwitch_213
				SendData("3214", string.format("%1d", MainPanel:get_argument_value(296) ) ) -- IFF Transponder Erase Button Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_214
				SendData("3215", string.format("%1d", MainPanel:get_argument_value(298) ) ) -- IFF Transponder Disaster Switch Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_215
				SendData("3216", string.format("%1d", MainPanel:get_argument_value(299) ) ) -- IFF Transponder Disaster Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_216
			-- buttons
				SendData("2001", string.format("%.1f", MainPanel:get_argument_value(882) ) ) -- CB Group 1 ON >> PUSH_BUTTONS :: PB_1
				SendData("2002", string.format("%.1f", MainPanel:get_argument_value(883) ) ) -- CB Group 4 ON >> PUSH_BUTTONS :: PB_2
				SendData("2003", string.format("%.1f", MainPanel:get_argument_value(884) ) ) -- CB Group 7 ON >> PUSH_BUTTONS :: PB_3
				SendData("2004", string.format("%.1f", MainPanel:get_argument_value(885) ) ) -- CB Group 2 ON >> PUSH_BUTTONS :: PB_4
				SendData("2005", string.format("%.1f", MainPanel:get_argument_value(886) ) ) -- CB Group 5 ON >> PUSH_BUTTONS :: PB_5
				SendData("2006", string.format("%.1f", MainPanel:get_argument_value(887) ) ) -- CB Group 8 ON >> PUSH_BUTTONS :: PB_6
				SendData("2007", string.format("%.1f", MainPanel:get_argument_value(888) ) ) -- CB Group 3 ON >> PUSH_BUTTONS :: PB_7
				SendData("2008", string.format("%.1f", MainPanel:get_argument_value(889) ) ) -- CB Group 6 ON >> PUSH_BUTTONS :: PB_8
				SendData("2009", string.format("%.1f", MainPanel:get_argument_value(890) ) ) -- CB Group 9 ON >> PUSH_BUTTONS :: PB_9
				SendData("2010", string.format("%.1f", MainPanel:get_argument_value(413) ) ) -- APU Start Button - Push to start APU >> PUSH_BUTTONS :: PB_10
				SendData("2011", string.format("%.1f", MainPanel:get_argument_value(415) ) ) -- APU Stop Button - Push to stop APU >> PUSH_BUTTONS :: PB_11
				SendData("2012", string.format("%.1f", MainPanel:get_argument_value(419) ) ) -- Engine Start Button - Push to start engine >> PUSH_BUTTONS :: PB_12
				SendData("2013", string.format("%.1f", MainPanel:get_argument_value(421) ) ) -- Abort Start Engine Button - Push to abort start >> PUSH_BUTTONS :: PB_13
				SendData("2014", string.format("%.1f", MainPanel:get_argument_value(310) ) ) -- Vibration Sensor Test Button - Push to test >> PUSH_BUTTONS :: PB_14
				SendData("2015", string.format("%.1f", MainPanel:get_argument_value(311) ) ) -- Cold Temperature Sensor Test Button - Push to test >> PUSH_BUTTONS :: PB_15
				SendData("2016", string.format("%.1f", MainPanel:get_argument_value(312) ) ) -- Hot Temperature Sensor Test Button - Push to test >> PUSH_BUTTONS :: PB_16
				SendData("2017", string.format("%.1f", MainPanel:get_argument_value(313) ) ) -- Left Engine Temperature Regulator Test Button - Push to test >> PUSH_BUTTONS :: PB_17
				SendData("2018", string.format("%.1f", MainPanel:get_argument_value(314) ) ) -- Right Engine Temperature Regulator Test Button - Push to test >> PUSH_BUTTONS :: PB_18
				SendData("2019", string.format("%.1f", MainPanel:get_argument_value(411) ) ) -- Auxiliary Hydraulic Shut Off Button - Push to shut off >> PUSH_BUTTONS :: PB_19
				--SendData("2020", string.format("%.1f", MainPanel:get_argument_value(183) ) ) -- Autopilot Off Left Button >> PUSH_BUTTONS :: PB_20
				--SendData("2021", string.format("%.1f", MainPanel:get_argument_value(226) ) ) -- Autopilot Off Right Button >> PUSH_BUTTONS :: PB_21
				--SendData("2022", string.format("%.1f", MainPanel:get_argument_value(184) ) ) -- Trimmer Left Button >> PUSH_BUTTONS :: PB_22
				--SendData("2023", string.format("%.1f", MainPanel:get_argument_value(227) ) ) -- Trimmer Right Button >> PUSH_BUTTONS :: PB_23
				SendData("2024", string.format("%.1f", MainPanel:get_argument_value(709) ) ) -- Emergency Bomb Release Switch, ON/OFF >> PUSH_BUTTONS :: PB_24
				SendData("2025", string.format("%.1f", MainPanel:get_argument_value(718) ) ) -- Lamps Check Button - Push to check >> PUSH_BUTTONS :: PB_25
				SendData("2026", string.format("%.1f", MainPanel:get_argument_value(572) ) ) -- Emergency Release Switch >> PUSH_BUTTONS :: PB_26
				SendData("2027", string.format("%.1f", MainPanel:get_argument_value(576) ) ) -- Lamps Check Button - Push to check >> PUSH_BUTTONS :: PB_27
				SendData("2028", string.format("%.1f", MainPanel:get_argument_value(574) ) ) -- PUS Arming Button - Push to arm >> PUSH_BUTTONS :: PB_28
				SendData("2029", string.format("%.1f", MainPanel:get_argument_value(186) ) ) -- Left Fire RS Button >> PUSH_BUTTONS :: PB_29
				SendData("2030", string.format("%.1f", MainPanel:get_argument_value(229) ) ) -- Right Fire RS Button >> PUSH_BUTTONS :: PB_30
				SendData("2031", string.format("%.1f", MainPanel:get_argument_value(389) ) ) -- Main Discharge Left Engine Button >> PUSH_BUTTONS :: PB_31
				SendData("2032", string.format("%.1f", MainPanel:get_argument_value(390) ) ) -- Main Discharge Right Engine Button >> PUSH_BUTTONS :: PB_32
				SendData("2033", string.format("%.1f", MainPanel:get_argument_value(391) ) ) -- Main Discharge KO-50 Button >> PUSH_BUTTONS :: PB_33
				SendData("2034", string.format("%.1f", MainPanel:get_argument_value(392) ) ) -- Main Discharge APU GEAR Button >> PUSH_BUTTONS :: PB_34
				SendData("2035", string.format("%.1f", MainPanel:get_argument_value(393) ) ) -- Alternate Discharge Left Engine Button >> PUSH_BUTTONS :: PB_35
				SendData("2036", string.format("%.1f", MainPanel:get_argument_value(394) ) ) -- Alternate Discharge Right Engine Button >> PUSH_BUTTONS :: PB_36
				SendData("2037", string.format("%.1f", MainPanel:get_argument_value(395) ) ) -- Alternate Discharge KO-50 Button >> PUSH_BUTTONS :: PB_37
				SendData("2038", string.format("%.1f", MainPanel:get_argument_value(396) ) ) -- Alternate Discharge APU GEAR Button >> PUSH_BUTTONS :: PB_38
				SendData("2039", string.format("%.1f", MainPanel:get_argument_value(397) ) ) -- Turn Off Fire Signal Button >> PUSH_BUTTONS :: PB_39
				SendData("2040", string.format("%.1f", MainPanel:get_argument_value(354) ) ) -- Defrost OFF Button - Push to turn off >> PUSH_BUTTONS :: PB_40
				SendData("2041", string.format("%.1f", MainPanel:get_argument_value(359) ) ) -- Ice Detector Heater Test Button - Push to test >> PUSH_BUTTONS :: PB_41
				SendData("2042", string.format("%.1f", MainPanel:get_argument_value(339) ) ) -- Left Pitot Heater Test Button - Push to test >> PUSH_BUTTONS :: PB_42
				SendData("2043", string.format("%.1f", MainPanel:get_argument_value(482) ) ) -- Right Pitot Heater Test Button - Push to test >> PUSH_BUTTONS :: PB_43
				SendData("2044", string.format("%.1f", MainPanel:get_argument_value(818) ) ) -- Turn Off Coordinates Calculator Button >> PUSH_BUTTONS :: PB_44
				SendData("2045", string.format("%.1f", MainPanel:get_argument_value(819) ) ) -- Turn On Coordinates Calculator Button >> PUSH_BUTTONS :: PB_45
				SendData("2046", string.format("%.1f", MainPanel:get_argument_value(815) ) ) -- Decrease Map Angle Button >> PUSH_BUTTONS :: PB_46
				SendData("2047", string.format("%.1f", MainPanel:get_argument_value(816) ) ) -- Increase Map Angle Button >> PUSH_BUTTONS :: PB_47
				SendData("2048", string.format("%.1f", MainPanel:get_argument_value(809) ) ) -- Decrease Path KM Button >> PUSH_BUTTONS :: PB_48
				SendData("2049", string.format("%.1f", MainPanel:get_argument_value(810) ) ) -- Increase Path KM Button >> PUSH_BUTTONS :: PB_49
				SendData("2050", string.format("%.1f", MainPanel:get_argument_value(803) ) ) -- Decrease Deviation KM Button >> PUSH_BUTTONS :: PB_50
				SendData("2051", string.format("%.1f", MainPanel:get_argument_value(804) ) ) -- Increase Deviation KM Button >> PUSH_BUTTONS :: PB_51
				SendData("2052", string.format("%.1f", MainPanel:get_argument_value(90) ) ) -- Right Attitude Indicator Cage Knob - Push to cage >> PUSH_BUTTONS :: PB_52
				SendData("2053", string.format("%.1f", MainPanel:get_argument_value(11) ) ) -- Left Attitude Indicator Cage Knob - Push to cage >> PUSH_BUTTONS :: PB_53
				SendData("2054", string.format("%.1f", MainPanel:get_argument_value(322) ) ) -- ANO Code Button >> PUSH_BUTTONS :: PB_54
				SendData("2055", string.format("%.1f", MainPanel:get_argument_value(552) ) ) -- Circular Call Button (N/F) >> PUSH_BUTTONS :: PB_55
				SendData("2056", string.format("%.1f", MainPanel:get_argument_value(846) ) ) -- Circular Call Button (N/F) >> PUSH_BUTTONS :: PB_56
				SendData("2057", string.format("%.1f", MainPanel:get_argument_value(738) ) ) -- R-828, Radio Tuner Button >> PUSH_BUTTONS :: PB_57
				SendData("2058", string.format("%.1f", MainPanel:get_argument_value(742) ) ) -- Jadro 1A, Control Button >> PUSH_BUTTONS :: PB_58
				SendData("2059", string.format("%.1f", MainPanel:get_argument_value(292) ) ) -- RI-65 OFF Button >> PUSH_BUTTONS :: PB_59
				SendData("2060", string.format("%.1f", MainPanel:get_argument_value(293) ) ) -- RI-65 Repeat Button >> PUSH_BUTTONS :: PB_60
				SendData("2061", string.format("%.1f", MainPanel:get_argument_value(294) ) ) -- RI-65 Check Button >> PUSH_BUTTONS :: PB_61
				SendData("2062", string.format("%.1f", MainPanel:get_argument_value(672) ) ) -- ARC-UD, Control Button >> PUSH_BUTTONS :: PB_62
				SendData("2063", string.format("%.1f", MainPanel:get_argument_value(673) ) ) -- ARC-UD, Left Antenna Button >> PUSH_BUTTONS :: PB_63
				SendData("2064", string.format("%.1f", MainPanel:get_argument_value(674) ) ) -- ARC-UD, Right Antenna Button >> PUSH_BUTTONS :: PB_64
				SendData("2065", string.format("%.1f", MainPanel:get_argument_value(914) ) ) -- CMD Num of Sequences Button >> PUSH_BUTTONS :: PB_65
				SendData("2066", string.format("%.1f", MainPanel:get_argument_value(862) ) ) -- CMD Dispense Interval Button >> PUSH_BUTTONS :: PB_66
				SendData("2067", string.format("%.1f", MainPanel:get_argument_value(863) ) ) -- CMD Num in Sequence Button >> PUSH_BUTTONS :: PB_67
				SendData("2068", string.format("%.1f", MainPanel:get_argument_value(866) ) ) -- CMD Start Dispense Button >> PUSH_BUTTONS :: PB_68
				SendData("2069", string.format("%.1f", MainPanel:get_argument_value(911) ) ) -- Start/Stop Dispense Button >> PUSH_BUTTONS :: PB_69
				SendData("2070", string.format("%.1f", MainPanel:get_argument_value(864) ) ) -- CMD Reset to Default Program Button >> PUSH_BUTTONS :: PB_70
				SendData("2071", string.format("%.1f", MainPanel:get_argument_value(865) ) ) -- CMD Stop Dispense Button >> PUSH_BUTTONS :: PB_71
				SendData("2072", string.format("%.1f", MainPanel:get_argument_value(881) ) ) -- Wheel Brakes Handle >> PUSH_BUTTONS :: PB_72
				SendData("2073", string.format("%.1f", MainPanel:get_argument_value(925) ) ) -- Accelerometer Reset Button - Push to reset >> PUSH_BUTTONS :: PB_73
				SendData("2074", string.format("%.1f", MainPanel:get_argument_value(200) ) ) -- Tactical Cargo Release Button - Push to release >> PUSH_BUTTONS :: PB_74
				SendData("2075", string.format("%.1f", MainPanel:get_argument_value(198) ) ) -- Emergency Cargo Release Button - Push to release >> PUSH_BUTTONS :: PB_75
				SendData("2076", string.format("%.1f", MainPanel:get_argument_value(284) ) ) -- Signal Flares Cassette 1 Launch Red Button >> PUSH_BUTTONS :: PB_76
				SendData("2077", string.format("%.1f", MainPanel:get_argument_value(285) ) ) -- Signal Flares Cassette 1 Launch Green Button >> PUSH_BUTTONS :: PB_77
				SendData("2078", string.format("%.1f", MainPanel:get_argument_value(286) ) ) -- Signal Flares Cassette 1 Launch Yellow Button >> PUSH_BUTTONS :: PB_78
				SendData("2079", string.format("%.1f", MainPanel:get_argument_value(287) ) ) -- Signal Flares Cassette 1 Launch White Button >> PUSH_BUTTONS :: PB_79
				SendData("2080", string.format("%.1f", MainPanel:get_argument_value(288) ) ) -- Signal Flares Cassette 2 Launch Red Button >> PUSH_BUTTONS :: PB_80
				SendData("2081", string.format("%.1f", MainPanel:get_argument_value(289) ) ) -- Signal Flares Cassette 2 Launch Green Button >> PUSH_BUTTONS :: PB_81
				SendData("2082", string.format("%.1f", MainPanel:get_argument_value(290) ) ) -- Signal Flares Cassette 2 Launch Yellow Button >> PUSH_BUTTONS :: PB_82
				SendData("2083", string.format("%.1f", MainPanel:get_argument_value(291) ) ) -- Signal Flares Cassette 2 Launch White Button >> PUSH_BUTTONS :: PB_83
				SendData("2084", string.format("%.1f", MainPanel:get_argument_value(464) ) ) -- KO-50 Heater Start Button - Push to start >> PUSH_BUTTONS :: PB_84
				SendData("2085", string.format("%.1f", MainPanel:get_argument_value(297) ) ) -- IFF Transponder Erase Button - Push to erase >> PUSH_BUTTONS :: PB_85
				SendData("2086", string.format("%.1f", MainPanel:get_argument_value(323) ) ) -- Alarm Bell Button - Push to turn on >> PUSH_BUTTONS :: PB_86
				SendData("2087", string.format("%.1f", MainPanel:get_argument_value(134) ) ) -- Autopilot Heading ON Button >> PUSH_BUTTONS :: PB_87
				SendData("2088", string.format("%.1f", MainPanel:get_argument_value(135) ) ) -- Autopilot Heading OFF Button >> PUSH_BUTTONS :: PB_88
				SendData("2089", string.format("%.1f", MainPanel:get_argument_value(138) ) ) -- Autopilot Pitch/Roll ON Button >> PUSH_BUTTONS :: PB_89
				SendData("2090", string.format("%.1f", MainPanel:get_argument_value(144) ) ) -- Autopilot Altitude ON Button >> PUSH_BUTTONS :: PB_90
				SendData("2091", string.format("%.1f", MainPanel:get_argument_value(145) ) ) -- Autopilot Altitude OFF Button >> PUSH_BUTTONS :: PB_91
				SendData("2092", string.format("%.1f", MainPanel:get_argument_value(127) ) ) --  SPUU-52 Control Engage Button 	127  >> PUSH_BUTTONS :: PB_92
				SendData("2093", string.format("%.1f", MainPanel:get_argument_value(32) ) ) -- Radio Altimeter Test Button - Push to test >> PUSH_BUTTONS :: PB_93 
				SendData("2094", string.format("%.1f", MainPanel:get_argument_value(59) ) ) -- Mech clock right lever >> PUSH_BUTTONS :: PB_94 
			-- 3 way switchs
				SendData("5001", string.format("%1d", MainPanel:get_argument_value(541) ) ) -- 115V Inverter Switch, MANUAL/OFF/AUTO >> TREE_WAY_SWITCH :: 3WSwitch_A_1
				SendData("5002", string.format("%1d", MainPanel:get_argument_value(542) ) ) -- 36V Inverter Switch, MANUAL/OFF/AUTO >> TREE_WAY_SWITCH :: 3WSwitch_A_2
				SendData("5003", string.format("%1d", MainPanel:get_argument_value(149) ) ) -- 36V Transformer Switch, MAIN/OFF/AUXILIARY >> TREE_WAY_SWITCH :: 3WSwitch_A_3
				SendData("5004", string.format("%1d", MainPanel:get_argument_value(412) ) ) -- APU Start Mode Switch, START/COLD CRANKING/FALSE START >> TREE_WAY_SWITCH :: 3WSwitch_A_4
				SendData("5005", string.format("%1d", MainPanel:get_argument_value(422) ) ) -- Engine Selector Switch, LEFT/OFF/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_5
				SendData("5006", string.format("%1d", MainPanel:get_argument_value(423) ) ) -- Engine Start Mode Switch, START/OFF/COLD CRANKING >> TREE_WAY_SWITCH :: 3WSwitch_A_6
				SendData("5203", string.format("%0.1f", MainPanel:get_argument_value(437) ) ) -- Refueling Control Switch, REFUEL/OFF/CHECK >> TREE_WAY_SWITCH :: 3WSwitch_C_203
				SendData("5008", string.format("%1d", MainPanel:get_argument_value(342) ) ) -- 8/16/4 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_8
				SendData("5009", string.format("%1d", MainPanel:get_argument_value(343) ) ) -- 1-2-5-6/AUTO/3-4 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_9
				SendData("5010", string.format("%1d", MainPanel:get_argument_value(344) ) ) -- UPK/PKT/RS Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_10
				SendData("5011", string.format("%1d", MainPanel:get_argument_value(345) ) ) -- CUTOFF Switch, ON/OFF >> TREE_WAY_SWITCH :: 3WSwitch_A_11
				SendData("5012", string.format("%1d", MainPanel:get_argument_value(150) ) ) -- Check Switch, LAMPS/OFF/FLASHER >> TREE_WAY_SWITCH :: 3WSwitch_A_12
				SendData("5013", string.format("%1d", MainPanel:get_argument_value(472) ) ) -- GMC Mode Switch, MC/DG/AC(N/F) >> TREE_WAY_SWITCH :: 3WSwitch_A_13
				SendData("5014", string.format("%1d", MainPanel:get_argument_value(837) ) ) -- Left Landing Light Switch, LIGHT/OFF/RETRACT >> TREE_WAY_SWITCH :: 3WSwitch_A_14
				SendData("5015", string.format("%1d", MainPanel:get_argument_value(838) ) ) -- Right Landing Light Switch, LIGHT/OFF/RETRACT >> TREE_WAY_SWITCH :: 3WSwitch_A_15
				SendData("5016", string.format("%1d", MainPanel:get_argument_value(513) ) ) -- ANO Switch, BRIGHT/OFF/DIM >> TREE_WAY_SWITCH :: 3WSwitch_A_16
				SendData("5017", string.format("%1d", MainPanel:get_argument_value(514) ) ) -- Formation Lights Switch, BRIGHT/OFF/DIM >> TREE_WAY_SWITCH :: 3WSwitch_A_17
				SendData("5018", string.format("%1d", MainPanel:get_argument_value(333) ) ) -- Left Ceiling Light Switch, RED/OFF/WHITE >> TREE_WAY_SWITCH :: 3WSwitch_A_18
				SendData("5019", string.format("%1d", MainPanel:get_argument_value(489) ) ) -- Right Ceiling Light Switch, RED/OFF/WHITE >> TREE_WAY_SWITCH :: 3WSwitch_A_19
				SendData("6116", string.format("%.2f", MainPanel:get_argument_value(370) ) ) -- R-863, Radio Channel Selector Knob >>  axis B116		
				SendData("5202", string.format("%0.1f", MainPanel:get_argument_value(859) ) ) -- CMD Board Flares Dispensers Switch, LEFT/BOTH/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_C_201
				SendData("5023", string.format("%1d", MainPanel:get_argument_value(465) ) ) -- KO-50 Heater Mode Switch, MANUAL/OFF/AUTO >> TREE_WAY_SWITCH :: 3WSwitch_A_23
				SendData("5024", string.format("%1d", MainPanel:get_argument_value(466) ) ) -- KO-50 Heater Regime Switch, FILLING/FULL/MEDIUM >> TREE_WAY_SWITCH :: 3WSwitch_A_24
				SendData("5025", string.format("%1d", MainPanel:get_argument_value(425) ) ) -- Engine Ignition Check Switch, LEFT/OFF/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_25
				--SendData("5026", string.format("%1d", MainPanel:get_argument_value(202) ) ) -- Readjust Free Turbine RPM Switch, MORE/OFF/LESS >> TREE_WAY_SWITCH :: 3WSwitch_A_26
				SendData("5027", string.format("%1d", MainPanel:get_argument_value(867) ) ) -- Readjust Free Turbine RPM Switch, MORE/OFF/LESS >> TREE_WAY_SWITCH :: 3WSwitch_A_27
				SendData("5028", string.format("%1d", MainPanel:get_argument_value(169) ) ) -- Left Engine FT Check Switch, ST1/WORK/ST2 >> TREE_WAY_SWITCH :: 3WSwitch_A_28
				SendData("5029", string.format("%1d", MainPanel:get_argument_value(171) ) ) -- Right Engine FT Check Switch, ST1/WORK/ST2 >> TREE_WAY_SWITCH :: 3WSwitch_A_29
				SendData("5030", string.format("%1d", MainPanel:get_argument_value(170) ) ) -- CT Check Switch, RIGHT/WORK/LEFT >> TREE_WAY_SWITCH :: 3WSwitch_A_30
				SendData("5031", string.format("%1d", MainPanel:get_argument_value(476) ) ) -- GMC Control Switch, 0/CONTROL/300 >> TREE_WAY_SWITCH :: 3WSwitch_A_31
				SendData("5032", string.format("%1d", MainPanel:get_argument_value(477) ) ) -- GMC Course Setting Switch, CCW/OFF/CW) >> TREE_WAY_SWITCH :: 3WSwitch_A_32
				SendData("5033", string.format("%1d", MainPanel:get_argument_value(447) ) ) -- ARC-9, Loop Control Switch, LEFT/OFF/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_33
				
		

		
		
			-- axis
				SendData("6010", string.format("%0.2f", MainPanel:get_argument_value(498) ) ) -- Standby Generator Voltage Adjustment Rheostat >> AXIS :: Axis_A_10
				SendData("6011", string.format("%0.2f", MainPanel:get_argument_value(536) ) ) -- Generator 1 Voltage Adjustment Rheostat >> AXIS :: Axis_A_11
				SendData("6012", string.format("%0.2f", MainPanel:get_argument_value(537) ) ) -- Generator 2 Voltage Adjustment Rheostat >> AXIS :: Axis_A_12
			--SendData("6013", string.format("%0.2f", MainPanel:get_argument_value(0) ) ) -- Left Engine Throttle >> AXIS :: Axis_A_13
			--SendData("6014", string.format("%0.2f", MainPanel:get_argument_value(0) ) ) -- Right Engine Throttle >> AXIS :: Axis_A_14
				SendData("6015", string.format("%0.2f", MainPanel:get_argument_value(346) ) ) -- Burst Length Knob >> AXIS :: Axis_A_15
				SendData("6016", string.format("%0.2f", MainPanel:get_argument_value(89) ) ) -- Right Attitude Indicator Zero Pitch Knob >> AXIS :: Axis_A_16 / TSwicth 9
				SendData("6017", string.format("%0.2f", MainPanel:get_argument_value(10) ) ) -- Left Attitude Indicator Zero Pitch Knob >> AXIS :: Axis_A_17 / TSwicth 10
				SendData("6102", string.format("%0.2f", MainPanel:get_argument_value(474) ) ) -- GMC Latitude Selection Knob >> AXIS :: Axis_B_102
				SendData("6018", string.format("%0.2f", MainPanel:get_argument_value(280) ) ) -- Left Red Lights Brightness Group 1 Rheostat >> AXIS :: Axis_A_18
				SendData("6019", string.format("%0.2f", MainPanel:get_argument_value(281) ) ) -- Left Red Lights Brightness Group 2 Rheostat >> AXIS :: Axis_A_19
				SendData("6020", string.format("%0.2f", MainPanel:get_argument_value(491) ) ) -- Right Red Lights Brightness Group 1 Rheostat >> AXIS :: Axis_A_20
				SendData("6021", string.format("%0.2f", MainPanel:get_argument_value(492) ) ) -- Right Red Lights Brightness Group 2 Rheostat >> AXIS :: Axis_A_21
				SendData("6022", string.format("%0.2f", MainPanel:get_argument_value(894) ) ) -- Central Red Lights Brightness Group 1 Rheostat >> AXIS :: Axis_A_22
				SendData("6023", string.format("%0.2f", MainPanel:get_argument_value(895) ) ) -- Central Red Lights Brightness Group 2 Rheostat >> AXIS :: Axis_A_23
				SendData("6024", string.format("%0.2f", MainPanel:get_argument_value(924) ) ) -- 5.5V Lights Brightness Rheostat >> AXIS :: Axis_A_24
				SendData("6103", string.format("%0.2f", MainPanel:get_argument_value(549) ) ) -- Common Volume Knob >> AXIS :: Axis_B_103
				SendData("6104", string.format("%0.2f", MainPanel:get_argument_value(548) ) ) -- Listening Volume Knob >> AXIS :: Axis_B_104
				SendData("6105", string.format("%0.2f", MainPanel:get_argument_value(841) ) ) -- Common Volume Knob >> AXIS :: Axis_B_105
				SendData("6106", string.format("%0.2f", MainPanel:get_argument_value(840) ) ) -- Listening Volume Knob >> AXIS :: Axis_B_106
				SendData("6107", string.format("%0.2f", MainPanel:get_argument_value(156) ) ) -- R-863, Volume Knob >> AXIS :: Axis_B_107
				SendData("6108", string.format("%0.2f", MainPanel:get_argument_value(737) ) ) -- R-828, Volume Knob >> AXIS :: Axis_B_108
				SendData("6109", string.format("%0.2f", MainPanel:get_argument_value(743) ) ) -- Jadro 1A, Volume Knob >> AXIS :: Axis_B_109
				SendData("6110", string.format("%0.2f", MainPanel:get_argument_value(455) ) ) -- ARC-UD, Volume Knob >> AXIS :: Axis_B_110
				SendData("6025", string.format("%0.2f", MainPanel:get_argument_value(589) ) ) -- Sight Brightness Knob >> AXIS :: Axis_A_25
			--SendData("6026", string.format("%0.2f", MainPanel:get_argument_value(855) ) ) -- Sight Limb Knob >> AXIS :: Axis_A_26
				SendData("6111", string.format("%0.2f", MainPanel:get_argument_value(448) ) ) -- ARC-9, Volume Knob >> AXIS :: Axis_B_111
				SendData("6112", string.format("%0.2f", MainPanel:get_argument_value(449) ) ) -- ARC-9, Backup Frequency Tune Knob >> AXIS :: Axis_B_112
				SendData("6113", string.format("%0.2f", MainPanel:get_argument_value(451) ) ) -- ARC-9, Main Frequency Tune Knob >> AXIS :: Axis_B_113
				SendData("6114", string.format("%0.2f", MainPanel:get_argument_value(468) ) ) -- KO-50 Target Temperature Knob >> AXIS :: Axis_B_114
				SendData("6027", string.format("%0.2f", MainPanel:get_argument_value(308) ) ) -- Recorder P-503B Backlight Brightness Knob >> AXIS :: Axis_A_27
				SendData("6028", string.format("%0.2f", MainPanel:get_argument_value(675) ) ) -- ARC-9, Backup 100kHz Rotary Knob>>  AXIS  :: Axis_A_28
				SendData("6029", string.format("%0.2f", MainPanel:get_argument_value(450) ) ) -- ARC-9, Backup 10kHz Rotary Knob>>  AXIS  :: Axis_A_29
				SendData("6030", string.format("%0.2f", MainPanel:get_argument_value(678) ) ) -- ARC-9, Main 100kHz Rotary Knob >>  AXIS  :: Axis_A_30
				SendData("6031", string.format("%0.2f", MainPanel:get_argument_value(452) ) ) --ARC-9, Main 10kHz Rotary Knob >>  AXIS  :: Axis_A_31
				SendData("6032", string.format("%0.2f", MainPanel:get_argument_value(60) ) ) -- Mech clock right lever >>  AXIS  :: Axis_A_32
			-- multi pos switch
				SendData("6101", string.format("%0.2f", MainPanel:get_argument_value(128) ) ) -- SPUU-52 Adjustment Knob >> AXIS :: Axis_B_101
				SendData("7051", string.format("%0.1f", MainPanel:get_argument_value(535) ) ) -- AC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_51
				SendData("7052", string.format("%0.1f", MainPanel:get_argument_value(494) ) ) -- DC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_52
				SendData("7001", string.format("%0.1f", MainPanel:get_argument_value(61) ) ) -- Fuel Meter Switch, OFF/SUM/LEFT/RIGHT/FEED/ADDITIONAL >> MULTI_POS_SWITCH :: Multi6PosSwitch_1
				SendData("7002", string.format("%0.1f", MainPanel:get_argument_value(719) ) ) -- Pod Variants Selector Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_2
				SendData("6115", string.format("%0.2f", MainPanel:get_argument_value(730) ) ) -- ESBR Position Selector Switch >> AXIS :: Axis_B_115
				SendData("7053", string.format("%0.1f", MainPanel:get_argument_value(401) ) ) -- Check Fire Circuits Switch, OFF/CONTROL/1/2/3/4/5/6 >> MULTI_POS_SWITCH :: Multi11PosSwitch_53
				SendData("7054", string.format("%0.1f", MainPanel:get_argument_value(372) ) ) -- Defrost System Amperemeter Selector Switch >> MULTI_POS_SWITCH :: Multi11PosSwitch_54
				SendData("7055", string.format("%0.1f", MainPanel:get_argument_value(735) ) ) -- R-828, Radio Channel Selector Knob >> MULTI_POS_SWITCH :: Multi11PosSwitch_55
				SendData("7003", string.format("%0.1f", MainPanel:get_argument_value(826) ) ) -- Doppler Navigator Mode Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_3
				SendData("7004", string.format("%0.1f", MainPanel:get_argument_value(550) ) ) -- Radio Source Selector Switch, R-863/JADRO-1A/R-828/NF/ARC-9/ARC-UD >> MULTI_POS_SWITCH :: Multi6PosSwitch_4
				SendData("7005", string.format("%0.1f", MainPanel:get_argument_value(842) ) ) -- Radio Source Selector Switch, R-863/JADRO-1A/R-828/NF/ARC-9/ARC-UD >> MULTI_POS_SWITCH :: Multi6PosSwitch_5

				SendData("3014", string.format("%1d", math.floor( (MainPanel:get_argument_value(741)+0.5)))) -- Jadro 1A, Squelch Switch >> TOGLEE_SWITCH :: TSwitch_14
				SendData("5201", string.format("%0.1f", MainPanel:get_argument_value(744) ) ) -- Jadro 1A, Mode Switch, OFF/OM/AM") , >> TREE_WAY_SWITCH :: 3WSwitch_C_201
				SendData("7006", string.format("%0.1f", MainPanel:get_argument_value(456) ) ) -- ARC-UD, Mode Switch, OFF/NARROW/WIDE/PULSE/RC >> MULTI_POS_SWITCH :: Multi6PosSwitch_6
				SendData("7007", string.format("%0.1f", MainPanel:get_argument_value(457) ) ) -- ARC-UD, Channel Selector Switch, 1/2/3/4/5/6 >> MULTI_POS_SWITCH :: Multi6PosSwitch_7
				SendData("7008", string.format("%0.1f", MainPanel:get_argument_value(446) ) ) -- ARC-9, Mode Selector Switch, OFF/COMP/ANT/LOOP >> MULTI_POS_SWITCH :: Multi6PosSwitch_8
				SendData("5101", string.format("%0.1f", MainPanel:get_argument_value(839) ) ) -- Static Pressure System Mode Selector, LEFT/COMMON/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_B_101
				SendData("7009", string.format("%0.1f", math.floor((MainPanel:get_argument_value(304)*10)+ 0.5)/10 ) ) -- IFF Transponder Mode Selector Switch, AUTO/KD/+-15/KP >> MULTI_POS_SWITCH :: Multi6PosSwitch_9
				SendData("7010", string.format("%0.1f", MainPanel:get_argument_value(347) ) ) -- In800Out/800inOr624/622 Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_10
				SendData("7011", string.format("%0.1f", MainPanel:get_argument_value(350) ) ) -- Left PYROCARTRIDGE Switch, I/II/III >> MULTI_POS_SWITCH :: Multi6PosSwitch_11
				SendData("7012", string.format("%0.1f", MainPanel:get_argument_value(351) ) ) -- Right PYROCARTRIDGE Switch, I/II/III >> MULTI_POS_SWITCH :: Multi6PosSwitch_12
				SendData("7013", string.format("%0.1f", MainPanel:get_argument_value(331) ) ) -- Left Windscreen Wiper Control Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_13
				SendData("7014", string.format("%0.1f", MainPanel:get_argument_value(478) ) ) -- Right Windscreen Wiper Control Switch >> MULTI_POS_SWITCH :: Multi6PosSwitch_14
				SendData("4001", string.format("%1d", MainPanel:get_argument_value(163) ) ) -- R-863, 10MHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_1
				SendData("4002", string.format("%1d", MainPanel:get_argument_value(164) ) ) -- R-863, 1MHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_2
				SendData("4003", string.format("%1d", MainPanel:get_argument_value(165) ) ) -- R-863, 100kHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_3
				SendData("4004", string.format("%1d", MainPanel:get_argument_value(166) ) ) -- R-863, 1kHz Rotary Knob >> TOGLEE_SWITCH :: TSwitch_B_4
	
			--rockers
				SendData("8101", string.format("%1d", MainPanel:get_argument_value(129) ) ) -- SPUU-52 Test Switch, P/OFF/t >> ROCKER_AABB :: Rocker_C_101
				SendData("8102", string.format("%1d", MainPanel:get_argument_value(146) ) ) -- Autopilot Altitude Channel Control (Right Button - UP; Left Button - Down)>> ROCKER_AABB :: Rocker_C_102
				SendData("8051", string.format("%1d", MainPanel:get_argument_value(57) ) ) -- -- Mech clock left lever button 1 >> ROCKER_ABAB :: Rocker_B_51
			
			
--[[				
	
				--]]
				
	FlushData()
end

-------------------------------- End of MI-8 exports
----------------------------------------------------

				









function Process_UH1H_HighImportance(MainPanel)
	
	-- prepare frecuencies data
	local ARN_83_Band = MainPanel:get_argument_value(38)
	if ARN_83_Band == 0 then
		ADF_ARN83_Frequency = ValueConvert(MainPanel:get_argument_value(45),{400, 420, 450, 850},{0.0, 0.053, 0.11, 0.550})
		ADF_band_selector=2
    end
    if ARN_83_Band < 0 then
		ADF_ARN83_Frequency = ValueConvert(MainPanel:get_argument_value(45),{190, 200, 400},{0.0, 0.048, 0.550})
		ADF_band_selector=1
    end
    if ARN_83_Band > 0 then
		ADF_ARN83_Frequency = ValueConvert(MainPanel:get_argument_value(45),{850, 900, 1800},{0.0, 0.053, 0.550})
		ADF_band_selector=3
    end

	local UHF_ARC51_Freq1 = ValueConvert(MainPanel:get_argument_value(10),{2.0, 3.0},{0.0, 1.0})
    local UHF_ARC51_Freq2 = MainPanel:get_argument_value(11)*10 
    local UHF_ARC51_Freq3 = MainPanel:get_argument_value(12)*10 
    local UHF_ARC51_Freq4 = MainPanel:get_argument_value(13)*10 
    local UHF_ARC51_Freq5 = MainPanel:get_argument_value(14)*10 
   					
    local NAV_ARN82_Freq1 = MainPanel:get_argument_value(46)*10
    local NAV_ARN82_Freq2 = MainPanel:get_argument_value(47)*10
    local NAV_ARN82_Freq3 = MainPanel:get_argument_value(48)*10
    local NAV_ARN82_Freq4 = MainPanel:get_argument_value(49)*10
    local NAV_ARN82_Freq5 = MainPanel:get_argument_value(50)*10
 
	local VHF_ARC134_Freq1 = MainPanel:get_argument_value(1)*10 
    local VHF_ARC134_Freq2 = MainPanel:get_argument_value(2)*10 
    local VHF_ARC134_Freq3 = MainPanel:get_argument_value(3)
    local VHF_ARC134_Freq4 = MainPanel:get_argument_value(4)
	
	local FM_mask_1 =false
	local FM_mask_2 =false

	local FMknob1 =  MainPanel:get_argument_value(31)
	local FMknob2 =  MainPanel:get_argument_value(32)
	if FMknob1 > 0.55 and  FMknob2 >0.55 then
		FM_mask_1 =0
	else
		FM_mask_1=1
	end

	if FMknob1 > 0.65 and  FMknob2 >0.45 then
		FM_mask_2 =0
	else
		FM_mask_2=1
	end
	
	SendData("7059", string.format("%0.1f", MainPanel:get_argument_value(31) ) ) -- Frequency Tens MHz Selector 
	SendData("7057", string.format("%0.1f", MainPanel:get_argument_value(32) ) ) -- Frequency Ones MHz Selector 

	
	local instruments_table =
	{	
		[1] =	ValueConvert(MainPanel:get_argument_value(151),{-0.7, 0.7},{-1.0, 1.0}),   -- VerticalBar 										
		[2] =	ValueConvert(MainPanel:get_argument_value(152),{-0.7, 0.7},{-1.0, 1.0}),   -- HorisontalBar 									
		[3] =	MainPanel:get_argument_value(31),            -- Frequency Tens MHz Selector 									
		[4] =	MainPanel:get_argument_value(32),            -- Frequency Ones MHz Selector 										
		[5] =	ValueConvert(MainPanel:get_argument_value(156),{0.0, math.pi * 2.0},{0.0, 1.0}),   -- RotCourseCard 									
		[6] =	ADF_ARN83_Frequency,                           -- ADF_ARN83_Frequency 								
		[7] =	MainPanel:get_argument_value(40),              -- ARN83_SignalLevel 	0 to 1  							
		[8] =	MainPanel:get_argument_value(159),             -- GMC_CoursePointer1 0 to 1  								
		[9] =	MainPanel:get_argument_value(160),             -- GMC_CoursePointer2 0 to 1  								
		[10] = 	MainPanel:get_argument_value(162),             -- GMC_HeadingMarker 	0 to 1  							
		[11] = 	MainPanel:get_argument_value(165),             -- GMC_Heading 	0 to 1  									
		[12] = 	ValueConvert(MainPanel:get_argument_value(166),{-1.0, 1.0},{0.0, 1.0}),    -- GMC_Annunciator 									
		[13] = 	MainPanel:get_argument_value(167),             -- GMC_PowerFail 	0 to 1  							
		[14] = 	MainPanel:get_argument_value(266),   -- RMI_CoursePointer1 								
		[15] = 	MainPanel:get_argument_value(267),   -- RMI_CoursePointer2 								
		[16] = 	MainPanel:get_argument_value(269),   -- RMI_Heading 										
		[17] = 	MainPanel:get_argument_value(168),   -- Pointer 	0 to 1  										
		[18] = 	MainPanel:get_argument_value(169),       -- Alt1AAU_10000_footCount 0 to 1  							
		[19] = 	MainPanel:get_argument_value(170),       -- Alt1AAU_1000_footCount 0 to 1  							
		[20] = 	MainPanel:get_argument_value(171),       -- Alt1AAU_100_footCount 	0 to 1  						
		[21] = 	ValueConvert(MainPanel:get_argument_value(174),{0, 1.0},{0.0, 0.3}),   -- AAU_32_Drum_Counter1 							
		[22] = 	MainPanel:get_argument_value(175),       -- AAU_32_Drum_Counter2 	0 to 1  						
		[23] = 	MainPanel:get_argument_value(176),       -- AAU_32_Drum_Counter3 	0 to 1  						
		[24] = 	MainPanel:get_argument_value(177),          -- CodeOff_flag 	0 to 1  								
		[25] =  ADF_band_selector,                           -- ADF_band_selector 					
		[26] = 	MainPanel:get_argument_value(178),          -- Alt_10000_AAU_7A 	0 to 1  							
		[27] = 	MainPanel:get_argument_value(179),          -- Alt_1000_AAU_7A 	0 to 1  								
		[28] = 	MainPanel:get_argument_value(180),          -- Alt_100_AAU_7A 	0 to 1  								
		[29] = 	MainPanel:get_argument_value(182),          -- Press_AAU_7A 		0 to 1  							
		[30] = 	MainPanel:get_argument_value(181),	       -- Pressure_Adjustment_pilot 						
		[31] = 	MainPanel:get_argument_value(113),          -- EngOilPress 										
		[32] = 	MainPanel:get_argument_value(114),          -- EngOilTemp 										
		[33] = 	MainPanel:get_argument_value(115),          -- TransmOilPress 									
		[34] = 	MainPanel:get_argument_value(116),          -- TransmOilTemp 									
		[35] = 	MainPanel:get_argument_value(117),          -- AIRSPEED_Nose 	0 to 1							
		[36] = 	MainPanel:get_argument_value(118),          -- AIRSPEED_Roof 	0 to 1							
		[37] = 	MainPanel:get_argument_value(121),          -- ExhaustTemp 		0 to 1							
		[38] = 	MainPanel:get_argument_value(122),          -- EngineTach		0 to 1							
		[39] = 	MainPanel:get_argument_value(123),          -- RotorTach 		0 to 1							
		[40] = 	MainPanel:get_argument_value(119),          -- GasProducerTach 	0 to 1							
		[41] = 	MainPanel:get_argument_value(120),          -- GasProducerTach_U 0 to 1							
		[42] = 	MainPanel:get_argument_value(124),          -- TorquePress	 									
		[43] = 	MainPanel:get_argument_value(149), 		   -- VoltageDC 		 0 to 1         								
		[44] = 	MainPanel:get_argument_value(150), 		   -- VoltageAC 		 0 to 1         								
		[45] = 	MainPanel:get_argument_value(436), 		   -- LoadmeterMainGen 	 0 to 1         							
		[46] = 	MainPanel:get_argument_value(125), 		   -- LoadmeterSTBYGen 	 0 to 1         							
		[47] = 	MainPanel:get_argument_value(126), 		   -- FuelPress 		                								
		[48] = 	MainPanel:get_argument_value(239), 		   -- FuelQuantity 		                							
		[49] = 	MainPanel:get_argument_value(127), 		   -- CLOCK_hours 		 0 to 1         								
		[50] = 	MainPanel:get_argument_value(128), 		   -- CLOCK_minutes 	 0 to 1         								
		[51] = 	MainPanel:get_argument_value(129), 		   -- CLOCK_seconds 	 0 to 1         								
		[52] = 	MainPanel:get_argument_value(132),		   -- TurnPtr 			-1 to 1         								
		[53] = 	MainPanel:get_argument_value(133), 		   -- SideSlip 			 -1 to 1        							
		[54] = 	MainPanel:get_argument_value(134), 		   -- VertVelocPilot 	 -1 to 1        								
		[55] = 	MainPanel:get_argument_value(251), 		   -- VertVelocCopilot	 -1 to 1        								
		[56] = 	MainPanel:get_argument_value(142), 		   -- Attitude_Roll 	 -1 to 1        								
		[57] = 	MainPanel:get_argument_value(143), 		   -- Attitude_Pitch 	 -1 to 1        								
		[58] = 	MainPanel:get_argument_value(148), 		   -- Attitude_Off_flag  0 to 1 INVERTIDO								
		[59] = 	MainPanel:get_argument_value(145),          -- Attitude_Indicator_Pitch_Trim_Knob_pilot 		
		[60] = 	MainPanel:get_argument_value(144),          -- Attitude_Indicator_Roll_Trim_Knob_pilot 			
		[61] = 	MainPanel:get_argument_value(135),   	   -- Attitude_Roll_left 	-1 to 1							
		[62] = 	MainPanel:get_argument_value(136), 		   -- Attitude_Pitch_left 	-1 to 1 							
		[63] = 	MainPanel:get_argument_value(141),    	   -- Attitude_Off_flag_left 	0 to 1 INVERTIDO						
		[64] = 	ValueConvert(MainPanel:get_argument_value(138),{0.0, 1.0},{-1.0, 1.0}),   -- Attitude_PitchShift 								
		[65] =	MainPanel:get_argument_value(163),           -- Heading_Set_Knob 			
		[66] =	MainPanel:get_argument_value(161),			-- Compass_Synchronizing 		
		[67] =	MainPanel:get_argument_value(155),           -- Course_select_knob 			
		[68] = 	MainPanel:get_argument_value(268),  			-- RMI Pointer						
		[69] =  MainPanel:get_argument_value(463),       -- CHAFF_Digit_2 	0 to 1 								
		[70] = 	(UHF_ARC51_Freq1*100) + (UHF_ARC51_Freq2*10) + (UHF_ARC51_Freq3) + (UHF_ARC51_Freq4/10) + (UHF_ARC51_Freq5/100),  -- UHF_ARC51_FREQ 									
		[71] =	math.floor((MainPanel:get_argument_value(16)*20)+ 0.4),   -- preset_channel_selector 	20 pos 0.05												
		[72] = 	100 + (VHF_ARC134_Freq1*10) + (VHF_ARC134_Freq2) + (VHF_ARC134_Freq3) + (VHF_ARC134_Freq4/10),                    -- VHF_ARC134_FREQ 									
		[73] = 	(NAV_ARN82_Freq1*100) + (NAV_ARN82_Freq2*10) + (NAV_ARN82_Freq3) + (NAV_ARN82_Freq4/10) + (NAV_ARN82_Freq5/100),  -- NAV_ARN82_FREQ 									
		[74] = 	MainPanel:get_argument_value(443), 	        -- RALT_Needle 		0 to 0.98 								
		[75] = 	MainPanel:get_argument_value(444), 	        -- RALT_LO_Index 	0 to 0.744								
		[76] = 	MainPanel:get_argument_value(466), 	        -- RALT_HI_Index	0 to 0.744								
		[77] = 	MainPanel:get_argument_value(468), 	        -- RALT_Digit_1 	0 to 1    								
		[78] = 	MainPanel:get_argument_value(469), 	        -- RALT_Digit_2		0 to 1    								
		[79] = 	MainPanel:get_argument_value(470), 	        -- RALT_Digit_3		0 to 1    								
		[80] = 	MainPanel:get_argument_value(471), 	        -- RALT_Digit_4		0 to 1    								
		[81] = 	MainPanel:get_argument_value(131),           -- clock winding buttton 									
		[82] = 	MainPanel:get_argument_value(460),       -- FLARE_Digit_1 	0 to 1 								
		[83] = 	MainPanel:get_argument_value(461),       -- FLARE_Digit_2 	0 to 1 								
		[84] = 	MainPanel:get_argument_value(462),       -- CHAFF_Digit_1 	0 to 1 
		[85] = 	MainPanel:get_argument_value(437)       -- RamTemp 	0 to 1 			
	
	}		
		-- exporting UH-1H instruments data
		for a=1, 85 do
			SendData(tostring(a), string.format("%0.3f",  instruments_table[a] ) )
		end
	


		local lamps_table =
			{	
					[1] = convert_lamp (MainPanel:get_argument_value(56)),      -- Marker_Beacon_Lamp
					[2] = FM_mask_1,     -- masks for FM knobs
					[3] = FM_mask_2,     -- masks for FM knobs
					[4] = convert_lamp (MainPanel:get_argument_value(467)),     -- lamp_RALT_Off_Flag
					[5] = convert_lamp (MainPanel:get_argument_value(447)),     -- RALT_LO_Lamp
					[6] = convert_lamp (MainPanel:get_argument_value(465)),     -- RALT_HI_Lamp
					[7] = convert_lamp (MainPanel:get_argument_value(91)),		-- lamp_ENGINE_OIL_PRESS
					[8] = convert_lamp (MainPanel:get_argument_value(92)),      -- lamp_ENGINE_ICING    
					[9] = convert_lamp (MainPanel:get_argument_value(93)),      -- lamp_ENGINE_ICE_JET  
					[10] = convert_lamp (MainPanel:get_argument_value(94)),     -- lamp_ENGINE_CHIP_DET 
					[11] = convert_lamp (MainPanel:get_argument_value(95)),     -- lamp_LEFT_FUEL_BOOST 
					[12] = convert_lamp (MainPanel:get_argument_value(96)),     -- lamp_RIGHT_FUEL_BOOST
					[13] = convert_lamp (MainPanel:get_argument_value(97)),     -- lamp_ENG_FUEL_PUMP   
					[14] = convert_lamp (MainPanel:get_argument_value(98)),     -- lamp_20_MINUTE       
					[15] = convert_lamp (MainPanel:get_argument_value(99)),     -- lamp_FUEL_FILTER     
					[16] = convert_lamp (MainPanel:get_argument_value(100)),    -- lamp_GOV_EMERG       
					[17] = convert_lamp (MainPanel:get_argument_value(101)),    -- lamp_AUX_FUEL_LOW    
					[18] = convert_lamp (MainPanel:get_argument_value(102)),    -- lamp_XMSN_OIL_PRESS  
					[19] = convert_lamp (MainPanel:get_argument_value(103)),    -- lamp_XMSN_OIL_HOT    
					[20] = convert_lamp (MainPanel:get_argument_value(104)),    -- lamp_HYD_PRESSURE    
					[21] = convert_lamp (MainPanel:get_argument_value(105)),    -- lamp_ENGINE_INLET_AIR
					[22] = convert_lamp (MainPanel:get_argument_value(106)),    -- lamp_INST_INVERTER   
					[23] = convert_lamp (MainPanel:get_argument_value(107)),    -- lamp_DC_GENERATOR    
					[24] = convert_lamp (MainPanel:get_argument_value(108)),    -- lamp_EXTERNAL_POWER  
					[25] = convert_lamp (MainPanel:get_argument_value(109)),    -- lamp_CHIP_DETECTOR   
					[26] = convert_lamp (MainPanel:get_argument_value(110)),    -- lamp_IFF             
					[27] = convert_lamp (MainPanel:get_argument_value(254)),    -- lamp_ARMED           
					[28] = convert_lamp (MainPanel:get_argument_value(255)),    -- lamp_SAFE            
					[29] = convert_lamp (MainPanel:get_argument_value(275)),    -- lamp_FIRE            
					[30] = convert_lamp (MainPanel:get_argument_value(276)),    -- lamp_LOW_RPM         
					[31] = convert_lamp (MainPanel:get_argument_value(277)),    -- lamp_MASTER          
					[32] = convert_lamp (MainPanel:get_argument_value(76)),     -- lamp_IFF_REPLY
					[33] = convert_lamp (MainPanel:get_argument_value(77)),     -- lamp_IFF_TEST 
					[34] = convert_lamp (MainPanel:get_argument_value(458)),    -- lamp_XM130_ARMED
					[35] = convert_lamp (MainPanel:get_argument_value(157)),    -- lamp_VerticalOFF
					[36] = convert_lamp (MainPanel:get_argument_value(158))    -- lamp_HorisontalOFF
				
			} 
			
					-- flag values in index 1001
					for a=1001, 1036 do
						SendData(tostring(a), string.format("%1d",  lamps_table[a-1000] ) )
					end
	
	
	FlushData()
end



function Process_UH1H_LowImportance(MainPanel)


			SendData(130, string.format("%1d", (MainPanel:get_argument_value(68)*3.03)+0.1 )) --MODE1-WHEEL1  68  4 pos 0.33
			SendData(131, string.format("%1d", (MainPanel:get_argument_value(69)*9.09)+0.1 )) --MODE1-WHEEL2  69  8 pos 0.11
			SendData(132, string.format("%1d", (MainPanel:get_argument_value(70)*9.09)+0.1 )) --MODE3A-WHEEL1  70  8 pos 0.11
			SendData(133, string.format("%1d", (MainPanel:get_argument_value(71)*9.09)+0.1 )) --MODE3A-WHEEL2  71  8 pos 0.11
			SendData(134, string.format("%1d", (MainPanel:get_argument_value(72)*9.09)+0.1 )) --MODE3A-WHEEL3  72  8 pos 0.11
			SendData(135, string.format("%1d", (MainPanel:get_argument_value(73)*9.09)+0.1 )) --MODE3A-WHEEL4  73  8 pos 0.11

		-- BUTTONS
			SendData("2001", string.format("%.1f", MainPanel:get_argument_value(240) ) ) -- Test Fuel Gauge Button - Push to Test >> PUSH_BUTTONS :: PB_1
			SendData("2002", string.format("%.1f", MainPanel:get_argument_value(131) ) ) -- Winding/Adjustment Clock btn >> PUSH_BUTTONS :: PB_2
			SendData("2003", string.format("%.1f", MainPanel:get_argument_value(278) ) ) -- Fire Detector Test Button - Push to test >> PUSH_BUTTONS :: PB_3
			SendData("2004", string.format("%.1f", MainPanel:get_argument_value(140) ) ) -- Cage Copilot Attitude Indicator - Pull to cage >> PUSH_BUTTONS :: PB_4
			SendData("2005", string.format("%.1f", MainPanel:get_argument_value(6) ) ) -- Comm Test Button - Push to test >> PUSH_BUTTONS :: PB_5
			SendData("2006", string.format("%.1f", MainPanel:get_argument_value(258) ) ) -- Rocket Reset Button - Push to reset >> PUSH_BUTTONS :: PB_6
			SendData("2007", string.format("%.1f", MainPanel:get_argument_value(260) ) ) -- Jettison Switch >> PUSH_BUTTONS :: PB_7
			SendData("2008", string.format("%.1f", MainPanel:get_argument_value(189) ) ) -- Force Trim Button >> PUSH_BUTTONS :: PB_8
			SendData("2009", string.format("%.1f", MainPanel:get_argument_value(193) ) ) -- Force Trim Button >> PUSH_BUTTONS :: PB_9
			SendData("2010", string.format("%.1f", MainPanel:get_argument_value(195) ) ) -- Cargo Release Pilot >> PUSH_BUTTONS :: PB_10
			SendData("2011", string.format("%.1f", MainPanel:get_argument_value(198) ) ) -- Cargo Release CoPilot >> PUSH_BUTTONS :: PB_11
			SendData("2012", string.format("%.1f", MainPanel:get_argument_value(464) ) ) -- Flare Dispense Button - Push to dispense >> PUSH_BUTTONS :: PB_12
			SendData("2013", string.format("%.1f", MainPanel:get_argument_value(457) ) ) -- Armed Lamp Test Button - Push to test >> PUSH_BUTTONS :: PB_13
			SendData("2014", string.format("%.1f", MainPanel:get_argument_value(453) ) ) -- Flare counter Reset. press reset >> PUSH_BUTTONS :: PB_14
			SendData("2015", string.format("%.1f", MainPanel:get_argument_value(455) ) ) -- Chaff counter Reset. press reset >> PUSH_BUTTONS :: PB_15
			SendData("2016", string.format("%.1f", MainPanel:get_argument_value(446) ) ) -- Test / Hight Set. Left mouse click to Test >> PUSH_BUTTONS :: PB_16
			--SendData("2017", string.format("%.1f", MainPanel:get_argument_value(419) ) ) -- Open Doors >> PUSH_BUTTONS :: PB_17
			--SendData("2018", string.format("%.1f", MainPanel:get_argument_value(421) ) ) -- Open Doors >> PUSH_BUTTONS :: PB_18
			--SendData("2019", string.format("%.1f", MainPanel:get_argument_value(42) ) ) -- Loop Left Low Speed >> PUSH_BUTTONS :: PB_19
			--SendData("2020", string.format("%.1f", MainPanel:get_argument_value(42) ) ) -- Loop Right Low Speed >> PUSH_BUTTONS :: PB_20
			SendData("2021", string.format("%.1f", MainPanel:get_argument_value(74) ) ) -- Reply Button >> PUSH_BUTTONS :: PB_21
			SendData("2022", string.format("%.1f", MainPanel:get_argument_value(75) ) ) -- Test Button >> PUSH_BUTTONS :: PB_22

		--switches 2 pos
			SendData("3001", string.format("%1d", MainPanel:get_argument_value(219) ) ) -- Battery Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_1
			SendData("3002", string.format("%1d", MainPanel:get_argument_value(220) ) ) -- Starter/Stdby GEN Switch >> TOGLEE_SWITCH :: TSwitch_2
			SendData("3003", string.format("%1d", MainPanel:get_argument_value(221) ) ) -- Non-Essential Bus Switch, NORMAL/MANUAL >> TOGLEE_SWITCH :: TSwitch_3
			SendData("3004", string.format("%1d", MainPanel:get_argument_value(285) ) ) -- CB IFF APX 1 (N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_4
			SendData("3005", string.format("%1d", MainPanel:get_argument_value(287) ) ) -- CB IFF APX 2 (N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_5
			SendData("3006", string.format("%1d", MainPanel:get_argument_value(289) ) ) -- CB Prox. warn.(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_6
			SendData("3007", string.format("%1d", MainPanel:get_argument_value(291) ) ) -- CB Marker beacon, ON/OFF >> TOGLEE_SWITCH :: TSwitch_7
			SendData("3008", string.format("%1d", MainPanel:get_argument_value(293) ) ) -- CB VHF Nav. (ARN-82), ON/OFF >> TOGLEE_SWITCH :: TSwitch_8
			SendData("3009", string.format("%1d", MainPanel:get_argument_value(295) ) ) -- CB LF Nav. (ARN-83), ON/OFF >> TOGLEE_SWITCH :: TSwitch_9
			SendData("3010", string.format("%1d", MainPanel:get_argument_value(297) ) ) -- CB Intercom CPLT(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_10
			SendData("3011", string.format("%1d", MainPanel:get_argument_value(299) ) ) -- CB Intercom PLT, ON/OFF >> TOGLEE_SWITCH :: TSwitch_11
			SendData("3012", string.format("%1d", MainPanel:get_argument_value(349) ) ) -- CB ARC-102 HF Static INVTR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_12
			SendData("3013", string.format("%1d", MainPanel:get_argument_value(351) ) ) -- CB HF ANT COUPLR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_13
			SendData("3014", string.format("%1d", MainPanel:get_argument_value(353) ) ) -- CB HF ARC-102(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_14
			SendData("3015", string.format("%1d", MainPanel:get_argument_value(355) ) ) -- CB FM Radio, ON/OFF >> TOGLEE_SWITCH :: TSwitch_15
			SendData("3016", string.format("%1d", MainPanel:get_argument_value(357) ) ) -- CB UHF Radio, ON/OFF >> TOGLEE_SWITCH :: TSwitch_16
			SendData("3017", string.format("%1d", MainPanel:get_argument_value(359) ) ) -- CB FM 2 Radio(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_17
			SendData("3018", string.format("%1d", MainPanel:get_argument_value(361) ) ) -- CB VHF AM Radio, ON/OFF >> TOGLEE_SWITCH :: TSwitch_18
			SendData("3019", string.format("%1d", MainPanel:get_argument_value(321) ) ) -- CB Pitot tube(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_19
			SendData("3020", string.format("%1d", MainPanel:get_argument_value(345) ) ) -- CB Rescue hoist CTL(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_20
			SendData("3021", string.format("%1d", MainPanel:get_argument_value(347) ) ) -- CB Rescue hoist cable cutter N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_21
			SendData("3022", string.format("%1d", MainPanel:get_argument_value(301) ) ) -- CB Wind wiper CPLT, ON/OFF >> TOGLEE_SWITCH :: TSwitch_22
			SendData("3023", string.format("%1d", MainPanel:get_argument_value(303) ) ) -- CB Wind wiper PLT, ON/OFF >> TOGLEE_SWITCH :: TSwitch_23
			SendData("3024", string.format("%1d", MainPanel:get_argument_value(305) ) ) -- CB KY-28 voice security(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_24
			SendData("3025", string.format("%1d", MainPanel:get_argument_value(403) ) ) -- CB Starter Relay(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_25
			SendData("3026", string.format("%1d", MainPanel:get_argument_value(307) ) ) -- CB Search light power(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_26
			SendData("3027", string.format("%1d", MainPanel:get_argument_value(309) ) ) -- CB Landing light power(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_27
			SendData("3028", string.format("%1d", MainPanel:get_argument_value(311) ) ) -- CB Landing & Search light control(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_28
			SendData("3029", string.format("%1d", MainPanel:get_argument_value(313) ) ) -- CB Anticollision light(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_29
			SendData("3030", string.format("%1d", MainPanel:get_argument_value(363) ) ) -- CB Fuselage lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_30
			SendData("3031", string.format("%1d", MainPanel:get_argument_value(365) ) ) -- CB Navigation lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_31
			SendData("3032", string.format("%1d", MainPanel:get_argument_value(367) ) ) -- CB Dome lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_32
			SendData("3033", string.format("%1d", MainPanel:get_argument_value(369) ) ) -- CB Cockpit lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_33
			SendData("3034", string.format("%1d", MainPanel:get_argument_value(371) ) ) -- CB Caution lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_34
			SendData("3035", string.format("%1d", MainPanel:get_argument_value(373) ) ) -- CB Console lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_35
			SendData("3036", string.format("%1d", MainPanel:get_argument_value(375) ) ) -- CB INST Panel lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_36
			SendData("3037", string.format("%1d", MainPanel:get_argument_value(377) ) ) -- CB INST SEC lights(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_37
			SendData("3038", string.format("%1d", MainPanel:get_argument_value(323) ) ) -- CB Cabin heater (Outlet valve)(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_38
			SendData("3039", string.format("%1d", MainPanel:get_argument_value(325) ) ) -- CB Cabin heater (Air valve)(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_39
			SendData("3040", string.format("%1d", MainPanel:get_argument_value(343) ) ) -- CB Rescue hoist PWR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_40
			SendData("3041", string.format("%1d", MainPanel:get_argument_value(327) ) ) -- CB RPM Warning system(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_41
			SendData("3042", string.format("%1d", MainPanel:get_argument_value(329) ) ) -- CB Engine anti-ice(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_42
			SendData("3043", string.format("%1d", MainPanel:get_argument_value(331) ) ) -- CB Fire detector(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_43
			SendData("3044", string.format("%1d", MainPanel:get_argument_value(333) ) ) -- CB LH fuel boost pump(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_44
			SendData("3045", string.format("%1d", MainPanel:get_argument_value(335) ) ) -- CB Turn & Slip indicator, ON/OFF >> TOGLEE_SWITCH :: TSwitch_45
			SendData("3046", string.format("%1d", MainPanel:get_argument_value(337) ) ) -- CB TEMP indicator(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_46
			SendData("3047", string.format("%1d", MainPanel:get_argument_value(339) ) ) -- CB HYD Control(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_47
			SendData("3048", string.format("%1d", MainPanel:get_argument_value(341) ) ) -- CB FORCE Trim(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_48
			SendData("3049", string.format("%1d", MainPanel:get_argument_value(379) ) ) -- CB Cargo hook release(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_49
			SendData("3050", string.format("%1d", MainPanel:get_argument_value(381) ) ) -- CB EXT Stores jettison(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_50
			SendData("3051", string.format("%1d", MainPanel:get_argument_value(383) ) ) -- CB Spare inverter PWR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_51
			SendData("3052", string.format("%1d", MainPanel:get_argument_value(385) ) ) -- CB Inverter CTRL (N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_52
			SendData("3053", string.format("%1d", MainPanel:get_argument_value(387) ) ) -- CB Main inverter PWR(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_53
			SendData("3054", string.format("%1d", MainPanel:get_argument_value(389) ) ) -- CB Generator & Bus Reset(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_54
			SendData("3055", string.format("%1d", MainPanel:get_argument_value(391) ) ) -- CB STBY Generator Field(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_55
			SendData("3056", string.format("%1d", MainPanel:get_argument_value(393) ) ) -- CB Governor Control(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_56
			SendData("3057", string.format("%1d", MainPanel:get_argument_value(395) ) ) -- CB IDLE Stop release(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_57
			SendData("3058", string.format("%1d", MainPanel:get_argument_value(397) ) ) -- CB RH fuel boost pump(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_58
			SendData("3059", string.format("%1d", MainPanel:get_argument_value(399) ) ) -- CB Fuel TRANS(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_59
			SendData("3060", string.format("%1d", MainPanel:get_argument_value(401) ) ) -- CB Fuel valves(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_60
			SendData("3061", string.format("%1d", MainPanel:get_argument_value(315) ) ) -- CB Heated blanket 1(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_61
			SendData("3062", string.format("%1d", MainPanel:get_argument_value(317) ) ) -- CB Heated blanket 2(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_62
			SendData("3063", string.format("%1d", MainPanel:get_argument_value(319) ) ) -- CB Voltmeter Non Ess Bus(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_63
			SendData("3064", string.format("%1d", MainPanel:get_argument_value(405) ) ) -- CB Ignition system(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_64
			SendData("3065", string.format("%1d", MainPanel:get_argument_value(423) ) ) -- CB Pilot ATTD1(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_65
			SendData("3066", string.format("%1d", MainPanel:get_argument_value(424) ) ) -- CB Pilot ATTD2(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_66
			SendData("3067", string.format("%1d", MainPanel:get_argument_value(425) ) ) -- CB Copilot ATTD1(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_67
			SendData("3068", string.format("%1d", MainPanel:get_argument_value(426) ) ) -- CB Copilot ATTD2(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_68
			SendData("3069", string.format("%1d", MainPanel:get_argument_value(427) ) ) -- CB Gyro Cmps(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_69
			SendData("3070", string.format("%1d", MainPanel:get_argument_value(428) ) ) -- CB Fuel Quantity(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_70
			SendData("3071", string.format("%1d", MainPanel:get_argument_value(429) ) ) -- CB 28V Trans(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_71
			SendData("3072", string.format("%1d", MainPanel:get_argument_value(430) ) ) -- CB Fail Relay(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_72
			SendData("3073", string.format("%1d", MainPanel:get_argument_value(431) ) ) -- CB Pressure Fuel(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_73
			SendData("3074", string.format("%1d", MainPanel:get_argument_value(432) ) ) -- CB Pressure Torque(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_74
			SendData("3075", string.format("%1d", MainPanel:get_argument_value(433) ) ) -- CB Pressure XMSN(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_75
			SendData("3076", string.format("%1d", MainPanel:get_argument_value(434) ) ) -- CB Pressure Eng(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_76
			SendData("3077", string.format("%1d", MainPanel:get_argument_value(435) ) ) -- CB Course Ind(N/F), ON/OFF >> TOGLEE_SWITCH :: TSwitch_77
			SendData("3078", string.format("%1d", MainPanel:get_argument_value(238) ) ) -- Pitot Heater Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_78
			SendData("3079", string.format("%1d", MainPanel:get_argument_value(217) ) ) -- Main generator switch cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_79
			SendData("3080", string.format("%1d", MainPanel:get_argument_value(81) ) ) -- Main Fuel Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_80
			SendData("3081", string.format("%1d", MainPanel:get_argument_value(67) ) ) -- IFF On/Out Switch >> TOGLEE_SWITCH :: TSwitch_81
			SendData("3082", string.format("%1d", MainPanel:get_argument_value(206) ) ) -- Throttle Stop Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_82
			SendData("3083", string.format("%1d", MainPanel:get_argument_value(84) ) ) -- De-Ice Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_83
			SendData("3084", string.format("%1d", MainPanel:get_argument_value(80) ) ) -- Low RPM Warning Switch, AUDIO/OFF >> TOGLEE_SWITCH :: TSwitch_84
			SendData("3085", string.format("%1d", MainPanel:get_argument_value(85) ) ) -- Governor Switch, EMER/AUTO >> TOGLEE_SWITCH :: TSwitch_85
			SendData("3086", string.format("%1d", MainPanel:get_argument_value(90) ) ) -- Hydraulic Control Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_86
			SendData("3087", string.format("%1d", MainPanel:get_argument_value(89) ) ) -- Force Trim Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_87
			SendData("3088", string.format("%1d", MainPanel:get_argument_value(23) ) ) -- VHF FM Radio Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_88
			SendData("3089", string.format("%1d", MainPanel:get_argument_value(24) ) ) -- UHF Radio Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_89
			SendData("3090", string.format("%1d", MainPanel:get_argument_value(25) ) ) -- VHF AM Radio Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_90
			SendData("3091", string.format("%1d", MainPanel:get_argument_value(26) ) ) -- Receiver 4 N/F Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_91
			SendData("3092", string.format("%1d", MainPanel:get_argument_value(27) ) ) -- INT Receiver Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_92
			SendData("3093", string.format("%1d", MainPanel:get_argument_value(28) ) ) -- Receiver NAV Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_93
			SendData("3094", string.format("%1d", MainPanel:get_argument_value(22) ) ) -- Squelch Disable Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_94
			SendData("3095", string.format("%1d", MainPanel:get_argument_value(55) ) ) -- Marker Beacon Sensing Switch, HIGH/LOW >> TOGLEE_SWITCH :: TSwitch_95
			SendData("3096", string.format("%1d", MainPanel:get_argument_value(41) ) ) -- BFO Switch (N/F), BFO/OFF >> TOGLEE_SWITCH :: TSwitch_96
			--SendData("3097", string.format("%1d", MainPanel:get_argument_value(43) ) ) -- Gain control / Mode. Right mouse click to cycle mode >> TOGLEE_SWITCH :: TSwitch_97
			--SendData("3098", string.format("%1d", MainPanel:get_argument_value(38) ) ) -- Tune control / Band selection. Right mouse click to select a band >> TOGLEE_SWITCH :: TSwitch_98
			SendData("3099", string.format("%1d", MainPanel:get_argument_value(224) ) ) -- Position Lights Switch, DIM/BRIGHT >> TOGLEE_SWITCH :: TSwitch_99
			SendData("3100", string.format("%1d", MainPanel:get_argument_value(225) ) ) -- Anti-Collision Lights Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_100
			SendData("3101", string.format("%1d", MainPanel:get_argument_value(202) ) ) -- Landing Light Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_101
			SendData("3102", string.format("%1d", MainPanel:get_argument_value(164) ) ) -- ADF/VOR Control Switch >> TOGLEE_SWITCH :: TSwitch_102
			SendData("3103", string.format("%1d", MainPanel:get_argument_value(241) ) ) -- Gyro Mode Switch, DG/Slave >> TOGLEE_SWITCH :: TSwitch_103
			--SendData("3104", string.format("%1d", MainPanel:get_argument_value(0) ) ) -- Pilot Sight, Armed/Safe >> TOGLEE_SWITCH :: TSwitch_104
			--SendData("3105", string.format("%1d", MainPanel:get_argument_value(439) ) ) -- Pilot Sight Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_105
			SendData("3106", string.format("%1d", MainPanel:get_argument_value(228) ) ) -- Cargo Safety >> TOGLEE_SWITCH :: TSwitch_106
			SendData("3107", string.format("%1d", MainPanel:get_argument_value(450) ) ) -- Ripple Fire Cover, OPEN/CLOSE >> TOGLEE_SWITCH :: TSwitch_107
			SendData("3108", string.format("%1d", MainPanel:get_argument_value(451) ) ) -- Ripple Fire Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_108
			SendData("3109", string.format("%1d", MainPanel:get_argument_value(456) ) ) -- ARM Switch, SAFE/ARM >> TOGLEE_SWITCH :: TSwitch_109
			SendData("3110", string.format("%1d", MainPanel:get_argument_value(459) ) ) -- Chaff Mode Switch, MAN/PGRM >> TOGLEE_SWITCH :: TSwitch_110
			SendData("3111", string.format("%1d", MainPanel:get_argument_value(449) ) ) -- Radar Altimeter Power Switch, ON/OFF >> TOGLEE_SWITCH :: TSwitch_111
				
		-- TREE WAY SWITCHES	
			SendData("5001", string.format("%1d", MainPanel:get_argument_value(215) ) ) -- Inverter Switch, MAIN/OFF/SPARE >> TREE_WAY_SWITCH :: 3WSwitch_A_1
			SendData("5002", string.format("%1d", MainPanel:get_argument_value(60) ) ) -- Audio/light Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_2
			SendData("5003", string.format("%1d", MainPanel:get_argument_value(223) ) ) -- Position Lights Switch, STEADY/OFF/FLASH >> TREE_WAY_SWITCH :: 3WSwitch_A_3
			SendData("5004", string.format("%1d", MainPanel:get_argument_value(201) ) ) -- Search Light Switch, ON/OFF/STOW >> TREE_WAY_SWITCH :: 3WSwitch_A_4
			SendData("5005", string.format("%1d", MainPanel:get_argument_value(205) ) ) -- Landing Light Control Switch, EXT/OFF/RETR >> TREE_WAY_SWITCH :: 3WSwitch_A_5
			SendData("5006", string.format("%1d", MainPanel:get_argument_value(226) ) ) -- Dome Light Switch, WHITE/OFF/GREEN >> TREE_WAY_SWITCH :: 3WSwitch_A_6
			SendData("5007", string.format("%1d", MainPanel:get_argument_value(252) ) ) -- Armament Switch, ARMED/SAFE/OFF >> TREE_WAY_SWITCH :: 3WSwitch_A_7
			SendData("5008", string.format("%1d", MainPanel:get_argument_value(253) ) ) -- Gun Selector Switch, LEFT/ALL/RIGHT >> TREE_WAY_SWITCH :: 3WSwitch_A_8
			SendData("5009", string.format("%1d", MainPanel:get_argument_value(256) ) ) -- Armament Selector Switch, 7.62/2.75/40 >> TREE_WAY_SWITCH :: 3WSwitch_A_9
			SendData("5010", string.format("%1d", MainPanel:get_argument_value(259) ) ) -- Jettison Switch Cover, OPEN/CLOSE >> TREE_WAY_SWITCH :: 3WSwitch_A_10
			--SendData("5011", string.format("%1d", MainPanel:get_argument_value(408) ) ) -- Sighting Station Lamp Switch, BACKUP/OFF/MAIN >> TREE_WAY_SWITCH :: 3WSwitch_A_11
			SendData("5012", string.format("%1d", MainPanel:get_argument_value(227) ) ) -- Wiper Selector Switch, PILOT/BOTH/COPILOT >> TREE_WAY_SWITCH :: 3WSwitch_A_12
			SendData("5013", string.format("%1d", MainPanel:get_argument_value(111) ) ) -- Reset/Test switch >> TREE_WAY_SWITCH :: 3WSwitch_A_13
			SendData("5014", string.format("%1d", MainPanel:get_argument_value(112) ) ) -- Bright/Dim switch >> TREE_WAY_SWITCH :: 3WSwitch_A_14
			SendData("5015", string.format("%1d", MainPanel:get_argument_value(86) ) ) -- Chip Detector Switch, LMB - Tail Rotor / RMB - XMSN >> TREE_WAY_SWITCH :: 3WSwitch_A_15
			SendData("5016", string.format("%1d", MainPanel:get_argument_value(203) ) ) -- Governor RPM Switch, Decrease/Increase >> TREE_WAY_SWITCH :: 3WSwitch_A_16
			SendData("5017", string.format("%1d", MainPanel:get_argument_value(216) ) ) -- Main generator Switch (Left button - ON/OFF. Right button RESET) >> TREE_WAY_SWITCH :: 3WSwitch_A_17
			SendData("5018", string.format("%1d", MainPanel:get_argument_value(61) ) ) -- Test M-1 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_18
			SendData("5019", string.format("%1d", MainPanel:get_argument_value(62) ) ) -- Test M-2 Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_19
			SendData("5020", string.format("%1d", MainPanel:get_argument_value(63) ) ) -- Test M-3A Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_20
			SendData("5021", string.format("%1d", MainPanel:get_argument_value(64) ) ) -- Test M-C Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_21
			SendData("5022", string.format("%1d", MainPanel:get_argument_value(65) ) ) -- RAD Switch, TEST/MON >> TREE_WAY_SWITCH :: 3WSwitch_A_22
			SendData("5023", string.format("%1d", MainPanel:get_argument_value(66) ) ) -- Ident/Mic Switch >> TREE_WAY_SWITCH :: 3WSwitch_A_23	
			SendData("5025", string.format("%1d", MainPanel:get_argument_value(38) ) )-- Tune control / Band selection. Right mouse click to select a band >> TREE_WAY_SWITCH :: 3WSwitch_A_25 				
		
		-- AXIS		
			--SendData("6001", string.format("%.2f", MainPanel:get_argument_value(146) ) ) -- Attitude Indicator Pitch Trim Knob copilot>> AXIS :: Axis_A_1
			--SendData("6002", string.format("%.2f", MainPanel:get_argument_value(145) ) ) -- Attitude Indicator Pitch Trim Knob >> AXIS :: Axis_A_2
			--SendData("6003", string.format("%.2f", MainPanel:get_argument_value(144) ) ) -- Attitude Indicator Roll Trim Knob >> AXIS :: Axis_A_3
			--SendData("6004", string.format("%.2f", MainPanel:get_argument_value(172) ) ) -- Pressure Adjustment Knob >> AXIS :: Axis_A_4
			--SendData("6005", string.format("%.2f", MainPanel:get_argument_value(181) ) ) -- Pressure Adjustment Knob >> AXIS :: Axis_A_5
			SendData("6006", string.format("%.2f", MainPanel:get_argument_value(21) ) ) -- UHF Volume Knob >> AXIS :: Axis_A_6
			--SendData("6007", string.format("%.2f", MainPanel:get_argument_value(163) ) ) -- Heading Set Knob >> AXIS :: Axis_A_7
			SendData("6101", string.format("%.2f", MainPanel:get_argument_value(161) ) ) -- Compass Synchronizing Knob >> AXIS :: Axis_B_101
			--SendData("6008", string.format("%.2f", MainPanel:get_argument_value(155) ) ) -- Course Select Knob >> AXIS :: Axis_A_8
			--SendData("6009", string.format("%.2f", MainPanel:get_argument_value(281) ) ) -- Sighting Station Intensity Knob >> AXIS :: Axis_A_9
			--SendData("6010", string.format("%.2f", MainPanel:get_argument_value(440) ) ) -- Pilot Sighting Station Intensity Knob >> AXIS :: Axis_A_10
			--SendData("6011", string.format("%.2f", MainPanel:get_argument_value(445) ) ) -- Low Altitude Setting Knob >> AXIS :: Axis_A_11
			SendData("6012", string.format("%.2f", MainPanel:get_argument_value(29) ) ) -- Intercom Volume Knob >> AXIS :: Axis_A_12
			SendData("6013", string.format("%.2f", MainPanel:get_argument_value(18) ) ) -- 10 MHz Selector >> AXIS :: Axis_A_13
			SendData("6014", string.format("%.2f", MainPanel:get_argument_value(19) ) ) -- 1 MHz Selector >> AXIS :: Axis_A_14
			SendData("6015", string.format("%.2f", MainPanel:get_argument_value(20) ) ) -- 50 kHz Selector >> AXIS :: Axis_A_15
			SendData("6016", string.format("%.2f", MainPanel:get_argument_value(37) ) ) -- Volume Knob >> AXIS :: Axis_A_16
			SendData("6017", string.format("%.2f", MainPanel:get_argument_value(57) ) ) -- Marker Beacon Knob, ON/OFF/Volume >> AXIS :: Axis_A_17
			SendData("6018", string.format("%.2f", MainPanel:get_argument_value(230) ) ) -- Overhead Console Panel Lights Brightness Rheostat >> AXIS :: Axis_A_18
			SendData("6019", string.format("%.2f", MainPanel:get_argument_value(231) ) ) -- Pedestal Lights Brightness Rheostat >> AXIS :: Axis_A_19
			SendData("6020", string.format("%.2f", MainPanel:get_argument_value(232) ) ) -- Secondary Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_20
			SendData("6021", string.format("%.2f", MainPanel:get_argument_value(233) ) ) -- Engine Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_21
			SendData("6022", string.format("%.2f", MainPanel:get_argument_value(234) ) ) -- Copilot Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_22
			SendData("6023", string.format("%.2f", MainPanel:get_argument_value(235) ) ) -- Pilot Instrument Lights Brightness Rheostat >> AXIS :: Axis_A_23	
			SendData("6024", string.format("%.2f", MainPanel:get_argument_value(44) ) ) -- Gain control / Mode. Rotate mouse wheel to adjust gain >> AXIS :: Axis_A_24
			SendData("6025", string.format("%.2f", MainPanel:get_argument_value(452) ) ) -- Flare counter Reset. Rotate mouse wheel to set Number >> AXIS :: Axis_A_25
			SendData("6026", string.format("%.2f", MainPanel:get_argument_value(454) ) ) -- Chaff counter Reset. Rotate mouse wheel to set Number >> AXIS :: Axis_A_26
			--SendData("6027", string.format("%.2f", MainPanel:get_argument_value(448) ) ) -- Test / Hight Set. Rotate mouse wheel to set Hight >> AXIS :: Axis_A_27
			SendData("6028", string.format("%.2f", MainPanel:get_argument_value(9) ) ) -- VHF_ARC_134 Volume >> AXIS :: Axis_A_28 
			SendData("6029", string.format("%.2f", MainPanel:get_argument_value(53) ) ) -- NAV Frequency kHz / Volume VOLUME     -KHz>> AXIS :: Axis_A_29 
			SendData("6102", string.format("%.2f", MainPanel:get_argument_value(132) ) ) -- Winding/Adjustment Clock lev >> AXIS :: Axis_B_102
			SendData("6103", string.format("%.2f", MainPanel:get_argument_value(39) ) ) -- Tune control / Band selection. Rotate mouse wheel to adjust tune >> AXIS :: Axis_B_103
			SendData("6104", string.format("%.2f", MainPanel:get_argument_value(16) ) ) -- Preset Channel Selector >> AXIS :: Axis_B_104
			SendData("6030", string.format("%.2f", MainPanel:get_argument_value(8) ) ) -- VHF_ARC_134 Khz >> AXIS :: Axis_A_30
			SendData("6031", string.format("%.2f", MainPanel:get_argument_value(7) ) ) -- VHF_ARC_134 Mhz >> AXIS :: Axis_A_31
			SendData("6032", string.format("%.2f", MainPanel:get_argument_value(5) ) ) -- VHF_ARC_134 POWER >> AXIS :: Axis_A_32
			SendData("6033", string.format("%.2f", MainPanel:get_argument_value(54) ) ) -- NAV Frequency kHz / Volume VOLUME   - VOLUME>> AXIS :: Axis_A_33 
			SendData("6034", string.format("%.2f", MainPanel:get_argument_value(51) ) ) -- NAV CON  POWER >> AXIS :: Axis_A_34	
			SendData("6035", string.format("%.2f", MainPanel:get_argument_value(52) ) ) -- NAV Frequency MHz / Volume VOLUME   - Mhz>> AXIS :: Axis_A_35
			SendData("6036", string.format("%.2f", MainPanel:get_argument_value(250)+1 ) ) -- Throttle>> AXIS :: Axis_A_36
	
	-- MULTIPOSITIONS	
			SendData("7001", string.format("%0.1f", MainPanel:get_argument_value(218) ) ) -- DC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi6PosSwitch_1
			SendData("7002", string.format("%0.1f", MainPanel:get_argument_value(214) ) ) -- AC Voltmeter Selector >> MULTI_POS_SWITCH :: Multi6PosSwitch_2
			SendData("7003", string.format("%0.1f", MainPanel:get_argument_value(59) ) ) -- Master Knob, OFF/STBY/LOW/NORM/EMER >> MULTI_POS_SWITCH :: Multi6PosSwitch_3
			--SendData("7004", string.format("%0.1f", MainPanel:get_argument_value(68) ) ) -- MODE1-WHEEL1 >> MULTI_POS_SWITCH :: Multi6PosSwitch_4
			--SendData("7051", string.format("%0.1f", MainPanel:get_argument_value(69) ) ) -- MODE1-WHEEL2 >> MULTI_POS_SWITCH :: Multi11PosSwitch_51
			--SendData("7052", string.format("%0.1f", MainPanel:get_argument_value(70) ) ) -- MODE3A-WHEEL1 >> MULTI_POS_SWITCH :: Multi11PosSwitch_52
			--SendData("7053", string.format("%0.1f", MainPanel:get_argument_value(71) ) ) -- MODE3A-WHEEL2 >> MULTI_POS_SWITCH :: Multi11PosSwitch_53
			--SendData("7054", string.format("%0.1f", MainPanel:get_argument_value(72) ) ) -- MODE3A-WHEEL3 >> MULTI_POS_SWITCH :: Multi11PosSwitch_54
			--SendData("7055", string.format("%0.1f", MainPanel:get_argument_value(73) ) ) -- MODE3A-WHEEL4 >> MULTI_POS_SWITCH :: Multi11PosSwitch_55
			SendData("7005", string.format("%0.1f", MainPanel:get_argument_value(30) ) ) -- Intercom Mode (PVT,INT,VHF FM,UHF,VHF AM,Not used) >> MULTI_POS_SWITCH :: Multi6PosSwitch_5
			SendData("5201", string.format("%0.1f", MainPanel:get_argument_value(194) ) ) -- Radio/ICS Switch >> TREE_WAY_SWITCH :: 3WSwitch_C_201
			SendData("7006", string.format("%0.1f", MainPanel:get_argument_value(15) ) ) -- Frequency Mode Dial >> MULTI_POS_SWITCH :: Multi6PosSwitch_6
			SendData("7007", string.format("%0.1f", MainPanel:get_argument_value(17) ) ) -- Function Dial >> MULTI_POS_SWITCH :: Multi6PosSwitch_7
			SendData("7008", string.format("%0.1f", MainPanel:get_argument_value(222) ) ) -- Navigation Lights Switch, OFF/1/2/3/4/BRT >> MULTI_POS_SWITCH :: Multi6PosSwitch_8
			SendData("7009", string.format("%0.1f", MainPanel:get_argument_value(236) ) ) -- Bleed Air Switch, OFF/1/2/3/4 >> MULTI_POS_SWITCH :: Multi6PosSwitch_9
			SendData("7056", string.format("%0.1f", MainPanel:get_argument_value(257) ) ) -- Rocket Pair Selector Switch >> MULTI_POS_SWITCH :: Multi11PosSwitch_56
			SendData("7059", string.format("%0.1f", MainPanel:get_argument_value(31) ) ) -- Frequency Tens MHz Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_59
			SendData("7057", string.format("%0.1f", MainPanel:get_argument_value(32) ) ) -- Frequency Ones MHz Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_57
			SendData("7058", string.format("%0.1f", MainPanel:get_argument_value(33) ) ) -- Frequency Decimals MHz Selector >> MULTI_POS_SWITCH :: Multi11PosSwitch_58
			SendData("7011", string.format("%0.1f", MainPanel:get_argument_value(34) ) ) -- Frequency Hundredths MHz Selector >> MULTI_POS_SWITCH :: Multi6PosSwitch_11
			SendData("7012", string.format("%0.1f", MainPanel:get_argument_value(35) ) ) -- Mode Switch, OFF/TR/RETRAN(N/F)/HOME(N/F) >> MULTI_POS_SWITCH :: Multi6PosSwitch_12
			SendData("7013", string.format("%0.1f", MainPanel:get_argument_value(36) ) ) -- Squelch Mode Switch, DIS/CARR/TONE >> MULTI_POS_SWITCH :: Multi6PosSwitch_13
			SendData("7014", string.format("%0.1f", MainPanel:get_argument_value(229) ) ) -- Wipers Speed Switch, PARK/OFF/LOW/MED/HIGH >> MULTI_POS_SWITCH :: Multi6PosSwitch_14 
			SendData("7015", string.format("%0.1f", MainPanel:get_argument_value(43) ) ) -- Gain control / Mode. Right mouse click to cycle mode >> MULTI_POS_SWITCH :: Multi6PosSwitch_15 
			SendData("7016", string.format("%0.1f", MainPanel:get_argument_value(42) ) ) --ADF Loop Antenna speed 42 5 pos 0.1	 >> MULTI_POS_SWITCH :: Multi6PosSwitch_16 
			SendData("7017", string.format("%0.1f", MainPanel:get_argument_value(58) ) ) -- Code Knob, ZERO/B/A/HOLD >> MULTI_POS_SWITCH :: Multi6PosSwitch_17

		

	FlushData()
end


--------------------------------------------------------------------------------------------------------------
----------------------------------------------- end export Uh1H data -----------------------------------------










-----------------------------   I   N   P   U   T   S   ---------------------------









-- Take any inputs from Helios and pass them to DCS World
function ProcessInput()

	local lInput = c:receive()
	local lCommand, lCommandArgs, lDevice, lArgument, lLastValue

	if lInput then

		lCommand = string.sub(lInput,1,1)

		if lCommand == "R" then
			ResetChangeValues()
		end

		if (lCommand == "C") then
			lCommandArgs = StrSplit(string.sub(lInput,2),",")

			
			------------------- correct the changes on the A-10C TACAN device from DCS 1.5.6.1938 - added by Capt Zeen  
			if gCurrentAircraft == "A-10C" and lCommandArgs[1] == "51" then
			local command_temp="3000"
				if lCommandArgs[2] == "3006" then command_temp="3004" end
				if lCommandArgs[2] == "3007" then command_temp="3005" end
				if lCommandArgs[2] == "3001" then command_temp="3001" end
				if lCommandArgs[2] == "3003" then command_temp="3002" end
				if lCommandArgs[2] == "3005" then
				command_temp="3003"
					if lCommandArgs[3] <="0.9" then
						lCommandArgs[3]=0
					else
						lCommandArgs[3]=1
					end
				end
				if lCommandArgs[2] == "3008" then command_temp="3006" end
				if command_temp ~= "3000" then
					lCommandArgs[2] = command_temp
					lCommandArgs[1] = "74"
				end
			end
			------------------------------- end of TACAN fix
			
			
			lDevice = GetDevice(lCommandArgs[1])
			if type(lDevice) == "table" then
				lDevice:performClickableAction(lCommandArgs[2],lCommandArgs[3])	
			end
		end
    end 
end




-- Take any inputs from Helios and Convert them from KA50 to SA342 before pass them to DCS World
function  ProcessInputSA342()
    local lInput = c:receive()
    local lCommand, lCommandArgs, lDevice, lArgument, lLastValue
    local sIndex, lConvDevice
	local valor_axis, absoluto, min_clamp
	
    if lInput then
	
        lCommand = string.sub(lInput,1,1)
        
		if lCommand == "R" then
			ResetChangeValues()
		end
	
		if (lCommand == "C") then
			lCommandArgs = StrSplit(string.sub(lInput,2),",")
			sIndex = lCommandArgs[1]..","..lCommandArgs[2]
			lConvDevice = SA342ExportArguments[sIndex] 	
			lArgument = StrSplit(string.sub(lConvDevice,1),",")
			min_clamp = 0
			
			if lArgument[3]=="300" then   -- several axis exported in the same rotator encoder, because i dont have enought axis outputs in the KA50 interface
				local valor_actual = GetDevice(0)
				local absoluto= math.abs(lCommandArgs[3])
				local variacion= (lCommandArgs[3]/absoluto)/10
					
				if absoluto==0.1 then
					valor_axis= valor_actual:get_argument_value(182) + variacion
					lArgument = {27,3003,1} -- A342 PH bright
				end
				if absoluto==0.15 then
					valor_axis= valor_actual:get_argument_value(386) + variacion
					lArgument = {31,3004,1} -- SA342 UHF PAGE
				end
				if absoluto==0.2 then
					valor_axis= valor_actual:get_argument_value(330) + variacion
					lArgument = {23,3001,1} -- NADIR bright
				end
				if absoluto==0.25 then
					valor_axis= valor_actual:get_argument_value(122) + variacion
					lArgument = {24,3005,1} -- SA342 RWR brt
				end
				if absoluto==0.3 then
					valor_axis= valor_actual:get_argument_value(121) + variacion
					lArgument = {24,3004,1} -- SA342 RWR Audio
				end
				if absoluto==0.35 then
					valor_axis= valor_actual:get_argument_value(30) + variacion
					lArgument = {15,3010,1} -- Anti-collision bright
				end
				if absoluto==0.4 then
					valor_axis= valor_actual:get_argument_value(21) + variacion
					lArgument = {14,3002,1} -- SA342 Console Lighting   PUP
				end
				if absoluto==0.45 then
					valor_axis= valor_actual:get_argument_value(22) + variacion
					lArgument = {14,3001,1} -- SA342 Main Dashboard Lighting  POB
				end
				if absoluto==0.5 then
					valor_axis= valor_actual:get_argument_value(357) + variacion
					lArgument = {26,3009,1} -- A342 WP1 Brt
				end
				if absoluto==0.55 then
					valor_axis= valor_actual:get_argument_value(230) + variacion
					lArgument = {15,3012,1} -- formation lights bright
				end
				if absoluto==0.6 then
					valor_axis= valor_actual:get_argument_value(145) + variacion
					lArgument = {14,3003,1} -- UV light bright
				end
				if absoluto==0.65 then
					valor_axis =  variacion
					lArgument = {9,3001,1} -- HA rot
					min_clamp = -1
				end
				if absoluto==0.7 then
					valor_axis =  variacion
					lArgument = {9,3003,1} -- stanby HA rot
					min_clamp = -1
				end
				if absoluto==0.75 then
					valor_axis =  variacion
					lArgument = {19,3001,1} -- QFE adjust rot
					min_clamp = -1
				end
				if absoluto==0.8 then
					valor_axis =  variacion
					lArgument = {20,3001,1} -- CLOCK exterior ring (podria ser el btn 4 en vez del 1)
					min_clamp = -1
				end
				if absoluto==0.85 then
					valor_axis = variacion
					lArgument = {18,3001,1} -- Ralt safe bug rot
					min_clamp = -1
				end
				
				
				lCommandArgs[3]=math.max(min_clamp, math.min(1, valor_axis))	
			end
			
			lDevice = GetDevice(lArgument[1])
			if type(lDevice) == "table" then
			
				if lArgument[3]=="100" then   -- convert 0.2 0.1 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = ((0.2-temporal)*10)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="101" then   -- convert 1 0.5 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="102" then   -- convert 1 0 to 1 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				
				
			
				lDevice:performClickableAction(lArgument[2],lCommandArgs[3]*lArgument[3])
				
			end
		end
    end 
end



-- Take any inputs from Helios and Convert them from A10C to MIG-21 before pass them to DCS World
function  ProcessInputMIG21()
    local lInput = c:receive()
    local lCommand, lCommandArgs, lDevice, lArgument, lLastValue
    local sIndex, lConvDevice
	local valor_axis, absoluto, min_clamp
	
    if lInput then
	
        lCommand = string.sub(lInput,1,1)
        
		if lCommand == "R" then
			ResetChangeValues()
		end
	
		if (lCommand == "C") then
			lCommandArgs = StrSplit(string.sub(lInput,2),",")
			sIndex = lCommandArgs[1]..","..lCommandArgs[2]
			lConvDevice = MIG21ExportArguments[sIndex] 	
			lArgument = StrSplit(string.sub(lConvDevice,1),",")
			min_clamp = 0
			
			if lArgument[3]>"299" then   -- rockers special cases
				local valor_actual = GetDevice(0)
				local absoluto= math.abs(lCommandArgs[3])
				local variacion= (lCommandArgs[3]/100)
				
				if lArgument[3]=="300" then 
					valor_axis= valor_actual:get_argument_value(262) + variacion
					lArgument = {32,3073,1} -- Altimeter pressure knob 262 axis lim 0.02 
					min_clamp = -1
				end
				if lArgument[3]=="301" then 
					valor_axis= valor_actual:get_argument_value(260) + variacion
					lArgument = {28,3141,1} -- KPP Set 260 axis lim 0.0001
					min_clamp = -1
				end
				
				if lArgument[3]=="302" then 
				
					valor_axis= variacion
					lArgument = {23,3144,1} -- NPP Course set 263 axis 0.1 
					min_clamp = -1
				end
				
				
			
			lCommandArgs[3]=math.max(min_clamp, math.min(1, valor_axis))	
			end
			


			lDevice = GetDevice(lArgument[1])
			if type(lDevice) == "table" then
			
				if lArgument[3]=="100" then   -- convert 0.2 0.1 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = ((0.2-temporal)*10)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="101" then   -- convert 1 0.5 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="102" then   -- convert 1 0 to 1 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="103" then   -- convert 1 0 -1 to 1 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal+1)/2
					lArgument[3] = 1
				end
				
			
				lDevice:performClickableAction(lArgument[2],lCommandArgs[3]*lArgument[3])
				
			end
		end
    end 
end

-- Take any inputs from Helios and Convert them from A10C to L39ZA before pass them to DCS World
function  ProcessInputL39ZA()
    local lInput = c:receive()
    local lCommand, lCommandArgs, lDevice, lArgument, lLastValue
    local sIndex, lConvDevice
	local valor_axis, absoluto, min_clamp
	
    if lInput then
	
        lCommand = string.sub(lInput,1,1)
        
		if lCommand == "R" then
			ResetChangeValues()
		end
	
		if (lCommand == "C") then
			lCommandArgs = StrSplit(string.sub(lInput,2),",")
			sIndex = lCommandArgs[1]..","..lCommandArgs[2]
			lConvDevice = L39ZA_ExportArguments[sIndex] 	
			lArgument = StrSplit(string.sub(lConvDevice,1),",")
			min_clamp = 0
			max_clamp = 1
			
			if lArgument[3]>"299" then   -- rockers special cases
				local valor_actual = GetDevice(0)
				local absoluto= math.abs(lCommandArgs[3])
				local variacion= (lCommandArgs[3]/100)
				
				if lArgument[3]=="300" then -- latitude
					valor_axis= valor_actual:get_argument_value(209) + 0.01
					lArgument = {17,3006,1} -- latitude
					min_clamp = 0
					max_clamp = 0.727
				end
				if lArgument[3]=="301" then -- latitude
					valor_axis= valor_actual:get_argument_value(209) - 0.01
					lArgument = {17,3006,1} -- latitude
					min_clamp = 0
					max_clamp = 0.727
				end
				
				lCommandArgs[3]=math.max(min_clamp, math.min(max_clamp, valor_axis))	
			end

			
			
			lDevice = GetDevice(lArgument[1])
			if type(lDevice) == "table" then
			
				if lArgument[3]=="100" then   -- convert 0.2 0.1 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = ((0.2-temporal)*10)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="101" then   -- convert 1 0.5 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="102" then   -- convert 1 0 to 1 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="103" then   -- convert 1 0 -1 to 1 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal+1)/2
					lArgument[3] = 1
				end
				if lArgument[3]=="104" then   -- convert 0.2 0.1 0.0 to 0.2 0.1 0.3
				 --local temporal= lCommandArgs[3]
	
					if lCommandArgs[3] <= "0.05" then
					 lCommandArgs[3] = 0.3
					end
					lArgument[3] = 1
				end
				
			--if debug_output_file then
				--debug_output_file:write(string.format("ID %s\r\n", lArgument[2] ) )
				--debug_output_file:write(string.format("valor %s\r\n", lCommandArgs[3] ) )
			--end
				--lDevice = GetDevice(lArgument[1])
				lDevice:performClickableAction(lArgument[2],lCommandArgs[3]*lArgument[3])
				
			end
		end
    end 
end

-- Take any inputs from Helios and Convert them from A10C to FA18C before pass them to DCS World-------------------------------------------------------------------- FA18C
function  ProcessInput_FA18C()
    local lInput = c:receive()
    local lCommand, lCommandArgs, lDevice, lArgument, lLastValue
    local sIndex, lConvDevice
	local valor_axis, absoluto, min_clamp
	
    if lInput then
	
        lCommand = string.sub(lInput,1,1)
        
		if lCommand == "R" then
			ResetChangeValues()
		end
	
		if (lCommand == "C") then
			lCommandArgs = StrSplit(string.sub(lInput,2),",")
			sIndex = lCommandArgs[1]..","..lCommandArgs[2]
			lConvDevice = FA18C_ExportArguments[sIndex] 	
			lArgument = StrSplit(string.sub(lConvDevice,1),",")
			min_clamp = 0
			max_clamp = 1
			
			if lArgument[3]=="300" then   -- several axis exported in the same rotator encoder, because i dont have enought axis outputs in the A10C Helios interface
				local valor_actual = GetDevice(0)
				local absoluto= math.abs(lCommandArgs[3])
				local variacion= (lCommandArgs[3]/absoluto)/10
					
				if absoluto==0.1 then
					valor_axis= valor_actual:get_argument_value(174) + variacion
					lArgument = {33,3007,1} -- IFEI Lights Dimmer Control max 0.5?
				end
				if absoluto==0.15 then
					valor_axis =  variacion/10
					lArgument = {32,3003,1} -- -- Cage Standby Attitude Indicator  var 0.3
					min_clamp = -1
				end
				if absoluto==0.2 then
					valor_axis =  variacion/10
					lArgument = {26,3001,1} -- AAU-52 Altimeter Pressure Setting Knob lim 0.04-0.6 var 0.01
					min_clamp = -1
				end
				if absoluto==0.25 then
					valor_axis= valor_actual:get_argument_value(262) + variacion
					lArgument = {0,3130,1} -- ALR-67 AUDIO Control Knob (no function) var 0.01
				end
				if absoluto==0.3 then
					valor_axis= valor_actual:get_argument_value(357) + variacion
					lArgument = {40,3002,1} -- VOX Volume Control Knob var 0.01
				end
				if absoluto==0.35 then
					valor_axis =  variacion/10
					lArgument = {30,3002,1} --ID2163A low altitude var 0.01
					min_clamp = -1
				end
				if absoluto==0.40 then
					valor_axis =  variacion
					lArgument = {44,3002,1} -- INS Switch, OFF/CV/GND/NAV/IFA/GYRO/GB/TEST
					min_clamp = -1
				end
				if absoluto==0.45 then
					valor_axis= valor_actual:get_argument_value(446) + variacion
					lArgument = {41,3002,1} -- KY58_FillSw 8 pos
				end
				if absoluto==0.50 then
					valor_axis= valor_actual:get_argument_value(440) + variacion
					lArgument = {42,3001,1} -- KY58_radarSw 4 pos
				end
				if absoluto==0.55 then
					valor_axis= valor_actual:get_argument_value(504) + variacion
					lArgument = {2,3012,1} -- Throttles Friction Adjusting Lever
				end

				
				lCommandArgs[3]=math.max(min_clamp, math.min(1, valor_axis))	
			end
				
			
			lDevice = GetDevice(lArgument[1])    -- data conversions between switches A10C and F18
			if type(lDevice) == "table" then
			
				if lArgument[3]=="100" then   -- convert 0.2 0.1 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = ((temporal)*10)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="101" then   -- convert 1 0.5 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="102" then   -- convert 1 0 to 1 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="103" then   -- convert 1 0 -1 to 1 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal+1)/2
					lArgument[3] = 1
				end
				if lArgument[3]=="104" then   -- convert 0.2 0.1 0.0 to 0.2 0.1 0.3
				 --local temporal= lCommandArgs[3]
	
					if lCommandArgs[3] <= "0.05" then
					 lCommandArgs[3] = 0.3
					end
					lArgument[3] = 1
				end
				if lArgument[3]=="105" then   -- convert 0.0 0.1 0.2 0.3 0.4  to -0.1 0.0 0.1 0.2 0.3
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = temporal - 0.1
					lArgument[3] = 1
					
				end
				if lArgument[3]=="106" then   -- convert 0.2 0.1 0.0  to 1.0 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = temporal*5
					lArgument[3] = 1
					
				end
				
				lDevice:performClickableAction(lArgument[2],lCommandArgs[3]*lArgument[3])
				
			end
		end
    end 
end
----------------------------------------------------- end of F18





-- Take any inputs from Helios and Convert them from Extended to MI-8 before pass them to DCS World-------------------------------------------------------------------- MI8
function  ProcessInput_MI8()
    local lInput = c:receive()
    local lCommand, lCommandArgs, lDevice, lArgument, lLastValue
    local sIndex, lConvDevice
	local valor_axis, absoluto, min_clamp
	
    if lInput then
	
        lCommand = string.sub(lInput,1,1)
        
		if lCommand == "R" then
			ResetChangeValues()
		end
	
		if (lCommand == "C") then
			lCommandArgs = StrSplit(string.sub(lInput,2),",")
			sIndex = lCommandArgs[1]..","..lCommandArgs[2]
			lConvDevice = MI8_ExportArguments[sIndex] 	
			lArgument = StrSplit(string.sub(lConvDevice,1),",")
			min_clamp = 0
			max_clamp = 1
			
					
			lDevice = GetDevice(lArgument[1])    -- data conversions between switches extended and MI8
			if type(lDevice) == "table" then
			
				if lArgument[3]=="100" then   -- convert 0.2 0.1 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = ((temporal)*10)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="101" then   -- convert 1 0.5 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="102" then   -- convert 1 0 to 1 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="103" then   -- convert 1 0 -1 to 1 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal+1)/2
					lArgument[3] = 1
				end
				if lArgument[3]=="104" then   -- convert 0.2 0.1 0.0 to 0.2 0.1 0.3
				 --local temporal= lCommandArgs[3]
	
					if lCommandArgs[3] <= "0.05" then
					 lCommandArgs[3] = 0.3
					end
					lArgument[3] = 1
				end
				if lArgument[3]=="105" then   -- convert 0.0 0.1 0.2 0.3 0.4  to -0.1 0.0 0.1 0.2 0.3
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = temporal - 0.1
					lArgument[3] = 1
					
				end
				if lArgument[3]=="106" then   -- convert 0.2 0.1 0.0  to 1.0 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = temporal*5
					lArgument[3] = 1
					
				end
				
				lDevice:performClickableAction(lArgument[2],lCommandArgs[3]*lArgument[3])
				
			end
		end
    end 
end
----------------------------------------------------- end of F18



-- Take any inputs from Helios and Convert them from Extended to UH-1H before pass them to DCS World-------------------------------------------------------------------UH1H
function  ProcessInput_UH1H()
    local lInput = c:receive()
    local lCommand, lCommandArgs, lDevice, lArgument, lLastValue
    local sIndex, lConvDevice
	local valor_axis, absoluto, min_clamp
	
    if lInput then
	
        lCommand = string.sub(lInput,1,1)
        
		if lCommand == "R" then
			ResetChangeValues()
		end
	
		if (lCommand == "C") then
			lCommandArgs = StrSplit(string.sub(lInput,2),",")
			sIndex = lCommandArgs[1]..","..lCommandArgs[2]
			lConvDevice = UH1H_ExportArguments[sIndex] 	
			lArgument = StrSplit(string.sub(lConvDevice,1),",")
			min_clamp = 0
			max_clamp = 1
			
					
			lDevice = GetDevice(lArgument[1])    -- data conversions between switches extended and UH1H
			if type(lDevice) == "table" then
			
				if lArgument[3]=="100" then   -- convert 0.2 0.1 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = ((temporal)*10)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="101" then   -- convert 1 0.5 0.0 to 1 0 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="102" then   -- convert 1 0 to 1 -1
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal*2)-1
					lArgument[3] = 1
				end
				if lArgument[3]=="103" then   -- convert 1 0 -1 to 1 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = (temporal+1)/2
					lArgument[3] = 1
				end
				if lArgument[3]=="104" then   -- convert 0.2 0.1 0.0 to 0.2 0.1 0.3
				 --local temporal= lCommandArgs[3]
	
					if lCommandArgs[3] <= "0.05" then
					 lCommandArgs[3] = 0.3
					end
					lArgument[3] = 1
				end
				if lArgument[3]=="105" then   -- convert 0.0 0.1 0.2 0.3 0.4  to -0.1 0.0 0.1 0.2 0.3
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = temporal - 0.1
					lArgument[3] = 1
					
				end
				if lArgument[3]=="106" then   -- convert 0.2 0.1 0.0  to 1.0 0.5 0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = temporal*5
					lArgument[3] = 1
					
				end
				if lArgument[3]=="107" then   -- convert 0.0  1.0  to -1.0  0.0
				 local temporal= lCommandArgs[3]
					lCommandArgs[3] = temporal-1
					lArgument[3] = 1
					
				end
				
				if lArgument[3]=="108" then   -- comando directo de lomac

				 LoSetCommand(lArgument[2],up) -- aqui vendra el comando a enviar al dcs
				
				else 
				
					lDevice:performClickableAction(lArgument[2],lCommandArgs[3]*lArgument[3])  
				
				end
				
				
				
			end
		end
    end 
end
----------------------------------------------------- end of UH-1H















-------------     H  E  L  P  E  R  S    F  U  N  C  T  I  O  N  S     ---------------------------












----------------------
-- Helper Functions --
----------------------

function StrSplit(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
        return { str }
    end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then break end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end


function Degrees(radians)
	return radians * 57.2957795
end


--------------------------------
-- Status Gathering Functions --
--------------------------------

-- Handles simple-case data that can be simply read via device:get_argument_value
function ProcessArguments(device, arguments)
	local lArgument , lFormat , lArgumentValue
		
	if gCurrentAircraft == "A-10C" then ----------------------------- A10C TACAN FIX for Helios & DCS 1.5.6+
		for lArgument, lFormat in pairs(arguments) do 
			lArgumentValue = string.format(lFormat,device:get_argument_value(lArgument))
			if lArgument == 266 then -- x/y tacan mode display
				if device:get_argument_value(lArgument)==0 then
					lArgumentValue = string.format(lFormat,0)
				else
					lArgumentValue = string.format(lFormat,1)
				end
			end
			if lArgument == 258 then -- x/y tacan mode switch
				if device:get_argument_value(lArgument)==0 then
					lArgumentValue = string.format(lFormat,0.87)
				else
					lArgumentValue = string.format(lFormat,0.93)
				end
			end
			SendData(lArgument, lArgumentValue)		
		end	
	else   -- Other airplanes
		for lArgument, lFormat in pairs(arguments) do 	
			lArgumentValue = string.format(lFormat,device:get_argument_value(lArgument))	
			SendData(lArgument, lArgumentValue)
		end
	end
end


-----------------------
-- Network Functions --
-----------------------

function SendData(id, value)	
	if string.len(value) > 3 and value == string.sub("-0.00000000",1, string.len(value)) then
		value = value:sub(2)
	end
	
	if gLastData[id] == nil or gLastData[id] ~= value then
		local data =  id .. "=" .. value
		local dataLen = string.len(data)

		if dataLen + gPacketSize > 576 then
			FlushData()
		end

		table.insert(gSendStrings, data)
		gLastData[id] = value	
		gPacketSize = gPacketSize + dataLen + 1
	end	
end


function FlushData()
	if #gSendStrings > 0 then
		local 	packet = gSimID .. table.concat(gSendStrings, ":") .. "\n"
		socket.try(c:sendto(packet, gHost, gPort))
		gSendStrings = {}
		gPacketSize = 0
	end
end

function ResetChangeValues()
	gLastData = {}
	gTickCount = 10
end


-------------------------------
-- HANDLE DIFFERENT AIRCRAFT --
-------------------------------

function SelectAircraft()

	-- Select aircraft...

	local myInfo = LoGetSelfData()

	if myInfo == nil then

		gCurrentAircraft = ""
		gKnownAircraft = false
		gFlamingCliffsAircraft = false

		-- DEBUGGING STUFF:
		if debug_output_file then
			debug_output_file:write("LoGetSelfData() returned nil" )
		end

	elseif myInfo.Name ~= gCurrentAircraft then

		gCurrentAircraft = myInfo.Name
		log.write('EXPORT',log.INFO,'Selected aircraft type = '..gCurrentAircraft)
		
			-- DEBUGGING STUFF:
			--if debug_output_file then
				--debug_output_file:write(string.format("Selecting %s\r\n", gCurrentAircraft ) )
			--end

		if gCurrentAircraft == "A-10C" then
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = gA10HighImportanceArguments
			gLowImportanceArguments = gA10LowImportanceArguments 
			ProcessHighImportance = ProcessA10HighImportance
			ProcessLowImportance =  ProcessA10LowImportance
		elseif gCurrentAircraft == "Ka-50" then
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = gKa50HighImportanceArguments
			gLowImportanceArguments = gKa50LowImportanceArguments 
			ProcessHighImportance = ProcessNoHighImportance
			ProcessLowImportance =  ProcessKa50LowImportance
		elseif gCurrentAircraft == "FA-18C_hornet" then 
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = Process_FA18C_HighImportance
			ProcessLowImportance =  Process_FA18C_LowImportance
			ProcessInput = ProcessInput_FA18C		  				
		elseif gCurrentAircraft == "Mi-8MT" then 
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = ProcessNoHighImportance
			ProcessLowImportance =  ProcessNoLowImportance
			ProcessInput = ProcessInput_MI8	
		elseif gCurrentAircraft == "UH-1H" then 
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
		  	gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = Process_UH1H_HighImportance
			ProcessLowImportance =  Process_UH1H_LowImportance
			ProcessInput = ProcessInput_UH1H	
		elseif ( gCurrentAircraft == "SA342M" or gCurrentAircraft == "SA342L"  or gCurrentAircraft == "SA342Mistral" or gCurrentAircraft == "SA342Minigun" ) then
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = ProcessSA342HighImportance
			ProcessLowImportance =  ProcessSA342LowImportance
			ProcessInput = ProcessInputSA342
		elseif gCurrentAircraft == "AV8BNA" then
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = gAV8BHighImportanceArguments
			gLowImportanceArguments = gAV8BLowImportanceArguments 
			ProcessHighImportance = ProcessAV8BHighImportance
			ProcessLowImportance =  ProcessAV8BLowImportance
		elseif gCurrentAircraft == "MiG-21Bis"  then 
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = ProcessNoHighImportance
			ProcessLowImportance =  ProcessNoLowImportance
			ProcessInput = ProcessInputMIG21	  
		elseif ( gCurrentAircraft == "L-39ZA" or gCurrentAircraft == "L-39C") then 
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			  gHighImportanceArguments = {}
			  gLowImportanceArguments = {} 
			  ProcessHighImportance = ProcessL39ZAHighImportance
			  ProcessLowImportance =  ProcessL39ZALowImportance
			  ProcessInput = ProcessInputL39ZA	
		elseif gCurrentAircraft == "P-51D" or gCurrentAircraft == "TF-51D" or gCurrentAircraft == "P-51D-30-NA" then
			gKnownAircraft = true
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = ProcessNoHighImportance
			ProcessLowImportance =  ProcessNoLowImportance  
		elseif gCurrentAircraft == "A-10A" -- Flaming Cliffs
			or gCurrentAircraft == "F-15C"
			or gCurrentAircraft == "MiG-29A"
			or gCurrentAircraft == "MiG-29G"
			or gCurrentAircraft == "MiG-29K"
			or gCurrentAircraft == "MiG-29S"
			or gCurrentAircraft == "Su-25"
			or gCurrentAircraft == "Su-25T"
			or gCurrentAircraft == "Su-25TM"
			or gCurrentAircraft == "Su-27"
			or gCurrentAircraft == "Su-33" then

				  -- DEBUGGING STUFF:
				  --if debug_output_file then
					--debug_output_file:write("Unrecognised aircraft - assuming Flaming Cliffs.\r\n")
				  --end

			gKnownAircraft = true
			gFlamingCliffsAircraft = true
			gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = ProcessNoHighImportance
			ProcessLowImportance =  ProcessNoLowImportance
		  
		else -- Unknown aircraft; fail safe

			-- if debug_output_file then
				--debug_output_file:write("Unknown aircraft - disabling exports.\r\n")
			--end
			gKnownAircraft = false
			gFlamingCliffsAircraft = false
			gHighImportanceArguments = {}
			gLowImportanceArguments = {} 
			ProcessHighImportance = ProcessNoHighImportance
			ProcessLowImportance =  ProcessNoLowImportance

		end

	end

end


-------------------------------------------------
---  This function convert the actual code-value  to the correct cockpit-value one,
--   taking in consideration the different scale ranges inside each instrument (output table and input table fron CreateGauges)
---              by CaptZeen
---------------------------------------------------


function ValueConvert(actual_value, input, output)
local range=1
local real_value=0
local slope = {}
	for a=1,#output-1 do -- calculating the table of slopes
		slope[a]= (input[a+1]-input[a]) / (output[a+1]-output[a])
	end

	for a=1,#output-1 do 
		if actual_value >= output[a] and actual_value <= output[a+1] then
            		range = a
           		break
       		end     -- check the range of the value
	end

	final_value= ( slope[range] * (actual_value-output[range]) ) + input[range]
	
	return final_value
end




function check(indicator)
	if indicator == nil then
		return " "
	else
		return indicator
	end
end
function check_num(indicator)
	if indicator == nil then
		return 0
	else
		return 1
	end
end


---------------------------------------------
-----------------------------------------------
---------------------------------------------


---------------------------------------------
-- DCS Export API Function Implementations --
---------------------------------------------

function HeliosExportStart()
-- Works once just before mission start.
-- (and before player selects their aircraft, if there is a choice!)

	log.write('EXPORT',log.INFO,'Mission Started')

    -- DEBUGGING STUFF: uncomment to enable debug log file
    -- debug_output_file = io.open("./ExportDebug.log", "wa")
	
    -- 2) Setup udp sockets to talk to helios
    package.path  = package.path..";.\\LuaSocket\\?.lua"
    package.cpath = package.cpath..";.\\LuaSocket\\?.dll"
   
    socket = require("socket")
    
    c = socket.udp()

    if c == nil then

      -- DEBUGGING STUFF:
	  if debug_output_file then
	    debug_output_file:write("ERROR CREATING HELIOS SOCKET!\r\n")
      end

    else
      c:setsockname("*", 0)
      c:setoption('broadcast', true)
      c:settimeout(.001) -- set the timeout for reading the socket

      -- DEBUGGING STUFF:
	  if debug_output_file then
	    debug_output_file:write("HELIOS SOCKET CREATED!\r\n")
      end

    end

end


function HeliosExportBeforeNextFrame()
	ProcessInput()
end


function HeliosExportActivityNextEvent(t)

	t = t + gExportInterval

	gTickCount = gTickCount + 1

	SelectAircraft() -- point globals to appropriate functions and data.

	if gKnownAircraft then

		if gFlamingCliffsAircraft then

			ProcessFCExports ()

		else

			local lDevice = GetDevice(0)
			if type(lDevice) == "table" then

				if gCurrentAircraft == "P-51D" or gCurrentAircraft == "TF-51D" or gCurrentAircraft == "P-51D-30-NA" then	
					ProcessP51Exports ()  --process P51 as FC
				
				elseif gCurrentAircraft == "Mi-8MT" then	
					ProcessMI8Exports ()  --process MI-8 as General purpose interface
				--[[
				elseif gCurrentAircraft == "UH-1H" then	
					Process_HUEY_Exports ()  --process HUEY as FC
				--]]
				elseif gCurrentAircraft == "MiG-21Bis" then	
					ProcessMIG21HighImportance ()  --process Mig21 as A10C
				
				else 	
					lDevice:update_arguments()

					-- Handle the simple-case data that can be simply read via device:get_argument_value
					ProcessArguments(lDevice, gHighImportanceArguments) -- A10, Ka50, SA342 or AV-8B arguments as appropriate
					-- Handle the more complex calculations that need special logic...
					ProcessHighImportance(lDevice) -- A10, Ka50 SA342 or AV-8B, as appropriate; determined in SelectAircraft()

					if gTickCount >= gExportLowTickInterval then
						-- Handle the simple-case data that can be simply read via device:get_argument_value
						ProcessArguments(lDevice, gLowImportanceArguments) -- A10, Ka50 SA342 or AV-8B  arguments as appropriate
						-- Handle the more complex calculations that need special logic...
						ProcessLowImportance(lDevice) -- A10, Ka50 SA342 or AV-8B  as appropriate; determined in SelectAircraft()
						gTickCount = 0 -- start Low Importance tick counting again
					end
				end

				FlushData()

			end

		end

	else

		-- unknown aircraft - do nothing.

	end

	return t
end


function HeliosExportStop()
-- Works once just after mission stop.
    -- c:close()
	
	log.write('EXPORT',log.INFO,'Mission Ended')

    -- DEBUGGING STUFF:
	if debug_output_file then
	  debug_output_file:write("LuaExportStop called.\r\n")
	  io.close(debug_output_file)
    end

end

