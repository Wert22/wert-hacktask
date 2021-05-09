
QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("wert-hack:islem-bitti")
AddEventHandler("wert-hack:islem-bitti", function(lvl)
	local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    local hackData = ply.PlayerData.metadata["hack"]

    if lvl == "bir" then
        ply.Functions.SetMetaData("hack", hackData + 5) -- Hack seviyesi
        ply.Functions.AddMoney("bank", 500)
    elseif lvl == "iki" then
        ply.Functions.SetMetaData("hack", hackData + 10)
        ply.Functions.AddMoney("bank", 1500)
    elseif lvl == "uc" then
        ply.Functions.AddMoney("bank", 3000)
    end
    TriggerClientEvent("QBCore:Notify", src, "Hack işlemini başarıyla tamamladığın için banka hesabına bir miktar para yattı!", "success")
end)

RegisterServerEvent("wert-hack:esya-sil")
AddEventHandler("wert-hack:esya-sil", function(lvl)
	local src = source
    local ply = QBCore.Functions.GetPlayer(src)
    if lvl == "bir" then
        ply.Functions.RemoveItem("hbtablet", 1)
    elseif lvl == "iki" then
        ply.Functions.RemoveItem("hitablet", 1)
    elseif lvl == "uc" then
        ply.Functions.RemoveItem("hutablet", 1)
    end
    TriggerClientEvent("QBCore:Notify", src, "Hack işlemi başarısız, tablet yandı!", "error")
end)

QBCore.Functions.CreateUseableItem('hbtablet', function(source, item)
    local Ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('wert-hackgorevi:basla-level-1', Ply.PlayerData.source)
end)

QBCore.Functions.CreateUseableItem('hitablet', function(source, item)
    local Ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('wert-hackgorevi:basla-level-2', Ply.PlayerData.source)
end)

QBCore.Functions.CreateUseableItem('hutablet', function(source, item)
    local Ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('wert-hackgorevi:basla-level-3', Ply.PlayerData.source)
end)


