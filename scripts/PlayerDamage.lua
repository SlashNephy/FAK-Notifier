local _check_bleed_out_original = PlayerDamage._check_bleed_out

function PlayerDamage:_check_bleed_out(can_activate_berserker, ignore_movement_state)
	if self:get_real_health() == 0 and not self._check_berserker_done then
		if self._unit:movement():zipline_unit() then
			return
		end
		if not ignore_movement_state and self._unit:movement():current_state():bleed_out_blocked() then
			return
		end
		local time = Application:time()
		if not self._block_medkit_auto_revive and time > self._uppers_elapsed + self._UPPERS_COOLDOWN then
			local auto_recovery_kit = FirstAidKitBase.GetFirstAidKit(self._unit:position())
			if auto_recovery_kit then
				managers.hud:show_hint( { text = "あなたの周りのFirst Aid Kitで復活した" } )
			end
		end
	end
	_check_bleed_out_original(self, can_activate_berserker, ignore_movement_state)
end
