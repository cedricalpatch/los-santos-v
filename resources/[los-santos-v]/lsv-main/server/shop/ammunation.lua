RegisterNetEvent('lsv:updateWeaponTint')
AddEventHandler('lsv:updateWeaponTint', function(weaponHash, tintIndex)
	local player = source
	if not Scoreboard.IsPlayerOnline(player) then return end

	local tint = Settings.weaponTints[tintIndex]

	if Scoreboard.GetPlayerKills(player) < tint.kills then return end
	if Scoreboard.GetPlayerRank(player) < tint.rank then return end

	if Scoreboard.GetPlayerCash(player) >= tint.cash then
		Db.UpdateCash(player, -tint.cash, function()
			TriggerClientEvent('lsv:weaponTintUpdated', player, weaponHash, tint.index)
		end)
	else TriggerClientEvent('lsv:weaponTintUpdated', player, nil) end
end)


RegisterNetEvent('lsv:updateWeaponComponent')
AddEventHandler('lsv:updateWeaponComponent', function(weapon, componentIndex)
	local player = source
	if not Scoreboard.IsPlayerOnline(player) then return end

	local component = Weapon.GetWeapon(weapon).components[componentIndex]
	if component.rank and component.rank > Scoreboard.GetPlayerRank(player) then return end

	if Scoreboard.GetPlayerCash(player) >= component.cash then
		Db.UpdateCash(player, -component.cash, function()
			TriggerClientEvent('lsv:weaponComponentUpdated', player, weapon, componentIndex)
		end)
	else TriggerClientEvent('lsv:weaponComponentUpdated', player, nil) end
end)


RegisterNetEvent('lsv:purchaseWeapon')
AddEventHandler('lsv:purchaseWeapon', function(id)
	local player = source
	if not Scoreboard.IsPlayerOnline(player) then return end

	local weapon = Weapon.GetWeapon(id)
	if weapon.rank and weapon.rank > Scoreboard.GetPlayerRank(player) then return end

	if Scoreboard.GetPlayerCash(player) >= weapon.cash then
		Db.UpdateCash(player, -weapon.cash, function()
			TriggerClientEvent('lsv:weaponPurchased', player, id)
		end)
	else TriggerClientEvent('lsv:weaponPurchased', player, nil) end
end)


RegisterNetEvent('lsv:refillAmmo')
AddEventHandler('lsv:refillAmmo', function(ammoType, weapon)
	local player = source

	local refillPrice = Settings.ammuNationRefillAmmo[ammoType].price

	if Scoreboard.GetPlayerCash(player) >= refillPrice then
		Db.UpdateCash(player, -refillPrice, function()
			TriggerClientEvent('lsv:ammoRefilled', player, weapon, Settings.ammuNationRefillAmmo[ammoType].ammo)
		end)
	else TriggerClientEvent('lsv:ammoRefilled', player, weapon, nil) end
end)


RegisterNetEvent('lsv:refillSpecialAmmo')
AddEventHandler('lsv:refillSpecialAmmo', function(weapon)
	local player = source

	local refillPrice = Settings.ammuNationSpecialAmmo[weapon].price

	if Scoreboard.GetPlayerCash(player) >= refillPrice then
		Db.UpdateCash(player, -refillPrice, function()
			TriggerClientEvent('lsv:specialAmmoRefilled', player, weapon, Settings.ammuNationSpecialAmmo[weapon].ammo)
		end)
	else TriggerClientEvent('lsv:specialAmmoRefilled', player, weapon, nil) end
end)


RegisterNetEvent('lsv:refillFullAmmo')
AddEventHandler('lsv:refillFullAmmo', function(ammoType, weapon, ammoClipCount)
	if ammoClipCount == 0 then return end

	local player = source

	local refillPrice = ammoClipCount * Settings.ammuNationRefillAmmo[ammoType].price

	if Scoreboard.GetPlayerCash(player) >= refillPrice then
		Db.UpdateCash(player, -refillPrice, function()
			TriggerClientEvent('lsv:fullAmmoRefilled', player, weapon, ammoClipCount)
		end)
	else TriggerClientEvent('lsv:fullAmmoRefilled', player, weapon, nil) end
end)