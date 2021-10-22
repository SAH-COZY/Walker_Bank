ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Walker_Bank:deposerargent")
AddEventHandler("Walker_Bank:deposerargent", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xMoney = xPlayer.getMoney()
    print(xPlayer.getMoney()) -- j'ai eu la flemme de le supp quand j'étais entrain de le faire hahah (c'est walker)
    if amount == 0  then
        return
    end
    if xMoney == 0 then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez ~r~d\'argent~s~ !")
    else
    xPlayer.addAccountMoney('bank', amount)
    xPlayer.removeMoney(amount)
 
         TriggerClientEvent('esx:showNotification', source, "~g~Vous avez deposé ~g~"..amount.."$~s~ à la banque !")
    end    
end)
RegisterServerEvent("Walker_Bank:retirerargent")
AddEventHandler("Walker_Bank:retirerargent", function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bankmoney = xPlayer.getAccount('bank').money
    print(xPlayer.getMoney()) -- celui la aussi faites le si vous voulez le supp allez y haha

    if amount == 0 then
        return
    end
    if bankmoney == 0 then
        TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur votre compte bancaire !")
    else
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
     
             TriggerClientEvent('esx:showNotification', source, "~g~Vous avez retiré ~g~"..amount.."$~s~ de la banque !")
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
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayer2 = ESX.GetPlayerFromId(receiver)
	local virement = 0
    local bankmoneysender = xPlayer.getAccount('bank').money

    if xPlayer2 == nil or xPlayer2 == -1 or source == tonumber(receiver) then
        TriggerClientEvent('esx:showNotification', source, "~r~Ce destinataire n'éxiste pas sur notre base de données")
        
    else
        if bankmoneysender == 0 then

            TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent sur votre compte bancaire")
        else
            print(bankmoneysender)
            xPlayer.removeAccountMoney('bank', tonumber(amount))
            xPlayer2.addAccountMoney('bank', tonumber(amount))
            TriggerClientEvent('esx:showNotification', source, "~g~Transfert réussi. Vous avez envoyé "..tonumber(amount).." $ à "..xPlayer2.getName())
            TriggerClientEvent('esx:showNotification', receiver, "~g~Vous avez reçu un virement de "..tonumber(amount).." $ de la part de "..xPlayer.getName())

        end
    end


end)