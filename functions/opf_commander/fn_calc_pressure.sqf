/*
    This function calculates the commander's pressure level

    The commander has one big pressure variable, and it goes up to 100
    The fallowing things can increase the commander's pressure:
    Player Count At Objectives  (UP TO 20)
    Captured Objectives         (UP TO 20)
    Active Objectives           (UP TO 20)
    Objectives Left             (UP TO 40)
*/

COMMANDER_PRESSURE = 0;
_activePlayerTotal = 0;

if (count opfObjAreas_ACTIVE != 0) then {
    {
        _tgr = _x;
        _c = {_x inArea _tgr} count allPlayers;
        _activePlayerTotal = _activePlayerTotal + _c;
    } forEach opfObjAreas_ACTIVE;

    if (_activePlayerTotal > 20) then {
        COMMANDER_PRESSURE = COMMANDER_PRESSURE + 20;
    } else {
        COMMANDER_PRESSURE = COMMANDER_PRESSURE + _activePlayerTotal;
    };   
};

switch (opfObjAreas_ACTIVE) do {
    case 1: {COMMANDER_PRESSURE = COMMANDER_PRESSURE +10};
    case 2: {COMMANDER_PRESSURE = COMMANDER_PRESSURE +20};
    default {diag_log "This message is meant to confuse anyone reading it. Is this a bug message? Is this an error? What is this? You'll never know lol"};
};


