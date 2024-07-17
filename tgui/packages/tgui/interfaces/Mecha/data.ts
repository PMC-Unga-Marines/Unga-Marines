export const InternalDamageToDamagedDesc = {
  'MECHA_INT_FIRE': 'Internal fire detected',
  'MECHA_INT_CONTROL_LOST': 'Control module damaged',
};

export const InternalDamageToNormalDesc = {
  'MECHA_INT_FIRE': 'No internal fires detected',
  'MECHA_INT_CONTROL_LOST': 'Control module active',
};

export type AccessData = {
  name: string;
  number: number;
};

type MechElectronics = {
  microphone: boolean;
  speaker: boolean;
  frequency: number;
  minfreq: number;
  maxfreq: number;
};

export type MechWeapon = {
  name: string;
  desc: string;
  ref: string;
  isballisticweapon: boolean;
  integrity: number;
  energy_per_use: number;
  // null when not ballistic weapon
  disabledreload: boolean | null;
  projectiles: number | null;
  max_magazine: number | null;
  projectiles_cache: number | null;
  projectiles_cache_max: number | null;
  ammo_type: string | null;
  // first entry is always "snowflake_id"=snowflake_id if snowflake
  snowflake: any;
};

export type MainData = {
  isoperator: boolean;
};

export type MaintData = {
  name: string;
  mecha_flags: number;
  mechflag_keys: string[];
  cell: string;
  scanning: string;
  capacitor: string;
  operation_req_access: AccessData[];
  idcard_access: AccessData[];
};

export type OperatorData = {
  name: string;
  integrity: number;
  power_level: number | null;
  power_max: number | null;
  mecha_flags: number;
  internal_damage: number;
  internal_damage_keys: string[];
  mechflag_keys: string[];
  dna_lock: string | null;
  mech_electronics: MechElectronics;
  right_arm_weapon: MechWeapon | null;
  left_arm_weapon: MechWeapon | null;
  weapons_safety: boolean;
  mech_equipment: string[];
  mech_view: string;
  mineral_material_amount: number;
};

export type MechaUtility = {
  activated: boolean;
  name: string;
  ref: string;
  snowflake: any;
};
