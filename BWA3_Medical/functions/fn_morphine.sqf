/*
 * Author: KoffeinFlummi
 *
 * Administers the unit morphine.
 * 
 * Argument:
 * 0: Unit to be treated (Object)
 * 
 * Return value:
 * none
 */

#define MORPHINETIMEMEDIC 5
#define MORPHINETIMENONMEDIC 10
#define MORPHINEHEAL 0.4

_this spawn {
  _unit = _this select 0;

  if (_unit getVariable "BWA3_Painkiller" == 0) exitWith {
    if (_unit == player) then {
      [0, "BLACK", 0.15, 1] call BIS_fnc_FadeEffect;
    };
    [-2, {
      _this switchMove "Unconscious";
      _this playAction "GestureSpasm4";
    }, _unit] call CBA_fnc_globalExecute;
    _unit spawn {
      sleep 20;
      _this setHitPointDamage ["HitHead", 1];
    };
  };

  // DETERMINE IF UNIT IS MEDIC
  _morphinetime = 0;
  if ([_unit] call BWA3_Medical_fnc_isMedic) then {
    _morphinetime = MORPHINETIMEMEDIC;
  } else {
    _morphinetime = MORPHINETIMENONMEDIC;
  };

  player playMoveNow "AinvPknlMstpSnonWnonDnon_medic1"; // healing animation

  // START COUNTDOWN RSC (this is just a placeholder)
  _i = _morphinetime;
  while {_i > 0} do {
    hintSilent format ["Injecting Morphine:\n%1", _i];
    _i = _i - 1;
    sleep 1;
  };
  hintSilent "Injecting Morphine:\nDone.";
  sleep 1;
  hintSilent "";
  // STOP COUNTDOWN RSC

  _painkiller = (_unit getVariable "BWA3_Painkiller" - MORPHINEHEAL) max 0;
  _unit setVariable ["BWA3_Painkiller", _painkiller];

  _pain = (_unit getVariable "BWA3_Pain" - MORPHINEHEAL) max 0;
  _unit setVariable ["BWA3_Pain", _pain];
};