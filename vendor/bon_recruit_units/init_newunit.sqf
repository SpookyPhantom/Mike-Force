params ["_unit"];

if(isServer) then{
	[_unit] execFSM (BON_RECRUIT_PATH+"unit_lifecycle.fsm");
} else {
	bon_recruit_newunit = _unit;
	publicVariable "bon_recruit_newunit";
};

_unit addAction ["<t color='#e0000f'>Dismiss</t><img size='2' image='\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_passLeadership_ca.paa'/>",BON_RECRUIT_PATH+"dismiss.sqf",[],-10,false,true,""];
_unit SetUnitPos "UP";

// Set unit to veteran skill level
// https://community.bistudio.com/wiki/setSkill
_unit setSkill 0.85;
