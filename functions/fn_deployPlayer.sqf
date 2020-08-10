params ["_player"];

titleText [ format ["<t size='2.0' colorLink='#0000ff' font='PuristaBold'>You are being deployed to the battlefield!</t>"], "BLACK", 3, false, true];
sleep 5;
_player setPosATL getPosATL blufor_default vectorAdd [random [-3, 0, 3], random [-3, 0, 3], 0];
sleep 5;
titleFadeOut 1;
