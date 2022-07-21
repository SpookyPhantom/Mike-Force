params ["_unit"];

_unit action ["getOut", vehicle _unit];

sleep 2;

hint parseText format["<t size='1.0' color='#ffd800'>%1</t> was dismissed.",name _unit];

deleteVehicle _unit;
