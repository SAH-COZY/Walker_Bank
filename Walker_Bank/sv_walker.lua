ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Walker_Bank:deposerargent")
AddEventHandler("Walker_Bank:deposerargent", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xMoney = xPlayer.getMoney()

    if xMoney >= amount then
	xPlayer.removeMoney(amount)
	xPlayer.addAccountMoney('bank', amount)
 
	TriggerClientEvent('esx:showNotification', source, "~g~Vous avez deposé ~g~"..amount.."$~s~ à la banque !")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez ~r~d\'argent~s~ !")
    end    
end)

RegisterServerEvent("Walker_Bank:retirerargent")
AddEventHandler("Walker_Bank:retirerargent", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bankmoney = xPlayer.getAccount('bank').money

    if bankmoney >= amount then
	xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
        TriggerClientEvent('esx:showNotification', source, "~g~Vous avez retiré ~g~"..amount.."$~s~ de la banque !")
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur votre compte bancaire !")  
    end
end)

RegisterServerEvent("walker:solde") 
AddEventHandler("walker:solde", function(action, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerMoney = xPlayer.getAccount('bank').money

    TriggerClientEvent("walker:solderefresh", source, playerMoney)
end)

RegisterServerEvent('Walker_Bank:virement')
AddEventHandler('Walker_Bank:virement', function(receiver, amount)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xTarget = ESX.GetPlayerFromId(receiver)
    local Sender_BankMoney = xPlayer.getAccount('bank').money

    if xTarget == nil or xTarget == -1 or _src == tonumber(receiver) then
        TriggerClientEvent('esx:showNotification', source, "~r~Ce destinataire n'existe pas sur notre base de données")
    else
	if Sender_BankMoney >= amount then
            xPlayer.removeAccountMoney('bank', tonumber(amount))
            xTarget.addAccountMoney('bank', tonumber(amount))
            TriggerClientEvent('esx:showNotification', source, "~g~Transfert réussi. Vous avez envoyé "..tonumber(amount).." $ à "..xTarget.getName())
            TriggerClientEvent('esx:showNotification', receiver, "~g~Vous avez reçu un virement de "..tonumber(amount).." $ de la part de "..xPlayer.getName())
	else
	    TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur votre compte bancaire")
	end
    end
end)
