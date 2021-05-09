local PlayerData, aktif = {}, true

QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

--[[RegisterCommand("hackbasla", function()
    TriggerEvent('wert-hackgorevi:basla-level-1')
end)]]

--Belli bir polis sayısına göre çalışmasını istiyorsanız call back oluşturup not aktifin üzerine ekleyebilirsiniz

RegisterNetEvent('wert-hackgorevi:basla-level-1')
AddEventHandler('wert-hackgorevi:basla-level-1', function()
    local ped = PlayerPedId()
    if not IsPedInAnyVehicle(ped, false) then --araç en son 
        if not aktif then
           aktif = true
           TriggerEvent('mhacking:show')
           TriggerEvent('mhacking:start', 5, 20, hackBitti) -- 3 sağ ve soldan kaç kutu seçilecek / 20 kaç saniyede yapması gerek / hackBitti fonksiyon bitince nereyi triggerlasın (success)
           QBCore.Functions.Notify("WASD TUŞLARI İLE SEÇİM, SPACE VE ENTER TUŞU İLE ONAYLANAMA YAPABİLİRSİN")
           --Polis bildirimi ekleyiniz.
        else
            QBCore.Functions.Notify("Bu işlemi yapmak için beklemelisin!", "error")
        end
    else
        QBCore.Functions.Notify("Araç içinde iken bu işlemi yapamazsın!", "error")
    end
end)

RegisterNetEvent('wert-hackgorevi:basla-level-2')
AddEventHandler('wert-hackgorevi:basla-level-2', function()
    local ped = PlayerPedId()
    local data = QBCore.Functions.GetPlayerData().metadata["hack"]
    if data > 50 then
        if not IsPedInAnyVehicle(ped, false) then --araç en son 
            if not aktif then
                aktif = true
                TriggerEvent('mhacking:show')
                TriggerEvent('mhacking:start', 3, 15, seviyeIki)
                QBCore.Functions.Notify("WASD TUŞLARI İLE SEÇİM, SPACE VE ENTER TUŞU İLE ONAYLANAMA YAPABİLİRSİN")
                --Polis bildirimi ekleyiniz.
            else
                QBCore.Functions.Notify("Bu işlemi yapmak için beklemelisin!", "error")
            end
        else
            QBCore.Functions.Notify("Araç içinde iken bu işlemi yapamazsın!", "error")
        end
    else
        QBCore.Functions.Notify("Bunu yapabilecek kadar gelişmedin!", "error")
    end
end)

RegisterNetEvent('wert-hackgorevi:basla-level-3')
AddEventHandler('wert-hackgorevi:basla-level-3', function()
    local ped = PlayerPedId()
    local data = QBCore.Functions.GetPlayerData().metadata["hack"]
    if data > 200 then
        if not IsPedInAnyVehicle(ped, false) then --araç en son 
            if not aktif then
                aktif = true
               TriggerEvent('mhacking:show')
               TriggerEvent('mhacking:start', 1, 15, seviyeUc)
               QBCore.Functions.Notify("WASD TUŞLARI İLE SEÇİM, SPACE VE ENTER TUŞU İLE ONAYLANAMA YAPABİLİRSİN")
               --Polis bildirimi ekleyiniz.
            else
                QBCore.Functions.Notify("Bu işlemi yapmak için beklemelisin!", "error")
            end
        else
            QBCore.Functions.Notify("Araç içinde iken bu işlemi yapamazsın!", "error")
        end
    else
        QBCore.Functions.Notify("Bunu yapabilecek kadar gelişmedin!", "error")
    end
end)


function hackBitti(success, timeremaining)
    TriggerEvent('mhacking:hide')
    if success then
      TriggerServerEvent("wert-hack:islem-bitti", "bir")
    else
        TriggerServerEvent("wert-hack:esya-sil", "bir")
    end
end

function seviyeIki(success, timeremaining)
    TriggerEvent('mhacking:hide')
    if success then
      TriggerServerEvent("wert-hack:islem-bitti", "iki")
    else
        TriggerServerEvent("wert-hack:esya-sil", "iki")
    end
end

function seviyeUc(success, timeremaining)
    TriggerEvent('mhacking:hide')
    if success then
      TriggerServerEvent("wert-hack:islem-bitti", "uc")
    else
        TriggerServerEvent("wert-hack:esya-sil", "uc")
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if aktif then
            Citizen.Wait(1800000) --60000 = 60 saniye [1 dakika] (burası 30 dakika oldu)
            aktif = false
            --print(aktif)
        end
    end
end)

