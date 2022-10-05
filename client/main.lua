local usar = false

RegisterNetEvent('zcmg_matriculafalsa:usar')
AddEventHandler('zcmg_matriculafalsa:usar', function()
    local PlayerPed = PlayerPedId()
    local coords = GetEntityCoords(PlayerPed)
    local veiculo, distancia = ESX.Game.GetClosestVehicle(coords)
    local matricula = GeneratePlate() 


    if distancia <= 3.0 then
        if not IsPedInAnyVehicle(PlayerPed, false) then

            if not usar then
                usar = true
        
                Citizen.CreateThread(function()
                    DisableAllControlActions(0)
                    local anim_lib, anim_dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer"
                    local x,y,z = table.unpack(GetEntityCoords(PlayerPed))
        
                    ESX.Streaming.RequestAnimDict(anim_lib, function()
                    TaskPlayAnim(PlayerPed, anim_lib, anim_dict, 8.0, -8.0, -1, 0, 0, false, false, false)
        
                        Citizen.Wait((Config.timeStart * 1000))
        
                        usar = false
                        ClearPedTasksImmediately(PlayerPed)
                        SetVehicleNumberPlateText(veiculo, matricula)
                        exports['zcmg_notificacao']:Alerta("Matricula", "Matricula substituida com sucesso.", 5000, 'sucesso')
                        TriggerServerEvent("zcmg_matriculafalsa:remover")
                    end)
                end)
            end
        else
            exports['zcmg_notificacao']:Alerta("Matricula", "Não pode fazer isso no interior do veículo!", 5000, 'erro')
        end
    else
        exports['zcmg_notificacao']:Alerta("Matricula", "Não há nenhum veículo por perto!", 5000, 'erro')
    end
end)

Citizen.CreateThread(function()
    while true do 
        local wait = 1000        
        
        if usar then
            wait = 0   
            DisableAllControlActions(0)
        end 
        Citizen.Wait(wait)
	end
end)