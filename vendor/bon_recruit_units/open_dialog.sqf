if (player != (leader group player)) exitWith {
    hint localize "Only group leaders may recruit units.";
};
createDialog "RecruitUnitsDialog";
