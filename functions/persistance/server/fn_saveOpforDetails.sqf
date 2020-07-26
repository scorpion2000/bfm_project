_inidbi = ["new", "BFM_OpforDetails"] call OO_INIDBI;

_saveArray = [];
_saveArray pushBack (missionNamespace getVariable "opf_reservesRegularCount");
_saveArray pushBack (missionNamespace getVariable "opf_reservesEliteCount");
_saveArray pushBack (missionNamespace getVariable "opf_reservesTankCount");
_saveArray pushBack (missionNamespace getVariable "opf_reservesHeliCount");
_saveArray pushBack reinf_timer;

["write", ["opfor_settings", "opfor_resource_details", _saveArray]] call _inidbi;
