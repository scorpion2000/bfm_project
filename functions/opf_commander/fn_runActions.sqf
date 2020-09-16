if ((ACTION_ARRAY select 1) != "WAITING") then {
    {
        [] remoteExec [_x, 2, false];
        sleep 10;
    } forEach ACTION_ARRAY;
}