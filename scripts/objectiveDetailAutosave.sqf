while {true} do {
	//Some scripts do this save manually, but there's a chance it might not occur for minutes. This eleminates that.
	[] remoteExec ["bfm_fnc_saveObjectiveDetails", 2, false];
	sleep 30;
}