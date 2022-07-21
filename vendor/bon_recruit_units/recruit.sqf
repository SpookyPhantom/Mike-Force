// by Bon_Inf*

_numUnits = (count (units group player) + count bon_recruit_queue) - 1; // don't count the player
_grpSizeLim = 9;
if(_numUnits >= _grpSizeLim) exitWith {hint format ["You've reached the group limit of %1.", _grpSizeLim + 1]};

#include "dialog\definitions.sqf"
disableSerialization;

_update_queue = {
	_display = findDisplay BON_RECRUITING_DIALOG;
	_queuelist = _display displayCtrl BON_RECRUITING_QUEUE;
	_queuelist ctrlSetText format["Units queued: %1",count bon_recruit_queue];
};

_display = findDisplay BON_RECRUITING_DIALOG;
_listbox = _display displayCtrl BON_RECRUITING_UNITLIST;
_sel = lbCurSel _listbox; if(_sel < 0) exitWith{};

_unittype = bon_recruit_recruitableunits select _sel;
_typename = lbtext [BON_RECRUITING_UNITLIST,_sel];

_queuepos = 0;
_queuecount = count bon_recruit_queue;
if(_queuecount > 0) then {
	_queuepos = (bon_recruit_queue select (_queuecount - 1)) + 1;
	hint parseText format["<t size='1.0' color='#ffd800'>%1</t> added to requisition queue.",_typename];
};
bon_recruit_queue pushBack _queuepos;

call _update_queue;

WaitUntil{_queuepos == bon_recruit_queue select 0};
sleep (1.5 * (_queuepos min 1));
hint parseText format["Requesting one <t size='1.0' color='#ffd800'>%1</t>.",_typename];

sleep 1.0;

_unit = group player createUnit [_unittype, [(getPos player select 0) + 10 - random 10,(getPos player select 1) + 10 - random 20,0], [], 0, "FORM"];
_unit setName [_typename, "", _typename];
[_unit] execVM (BON_RECRUIT_PATH+"init_newunit.sqf");

hint parseText format["<t size='1.0' color='#ffd800'>%1</t> joined your squad.",name _unit];
bon_recruit_queue = bon_recruit_queue - [_queuepos];

call _update_queue;
