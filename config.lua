Config = {}

--[[
▀█▀ █▀▀ █▀▀ ▀█ █▄█   █▀▀ █▀█ █▀█ █▀▀   █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▄▀█ █▀▀ █▄░█ ▀█▀
░█░ ██▄ ██▄ █▄ ░█░   █▄▄ █▄█ █▀▄ ██▄   █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ █░▀░█ ██▄ █░▀█ ░█░
]]

Config.Lang = 'en'
Config.Debug = false                      -- if you want to see debug messages in console

Config.TargetResource = 'ox_target'       -- supported: ox_target, qb-target
Config.InventoryResource = 'ox_inventory' -- supported: ox_inventory, qb-inventory, ps-inventory, qs-inventory
Config.SQLResource = 'oxmysql'            -- supported: oxmysql, mysql-async, ghmattimysql

Config.UseCommand = true                  -- if you want to use command to give starter pack to player
Config.Command = 'starterpack'            -- command to give starter package to player

Config.UseTarget = true                   -- if you want to use target script to give starter pack to player
Config.Target = {
    ped = 'a_m_y_business_03',            -- https://docs.fivem.net/docs/game-references/ped-models/
    label = 'Get your starter pack',
    coords = vec4(-1040.479126, -2731.582520, 20.164062, 238.110229),
    distance = 2.0,
}

Config.StarterPackItems = { -- items that will be given to player
    { item = 'bread',    amount = 5 },
    { item = 'water',    amount = 5 },
    { item = 'phone',    amount = 1 },
    { item = 'lockpick', amount = 5 },
    { item = 'money',    amount = 5000 },
}

Config.EnableStarterVehicle = true -- if you want to give starter vehicle to player
Config.StarterVehicle = {
    model = 'adder',               -- https://wiki.rage.mp/index.php?title=Vehicles
    teleport_player = true,        -- player will be teleported to the vehicle
    vehicle_spawn = vec4(-1040.123047, -2727.138428, 20.046143, 238.110229), -- vehicle spawn location and heading
    fuel = 100.0,                  -- fuel level of the vehicle
}

---@param vehicle any
---@param fuel number
---@decription Set fuel level of the vehicle by default it uses LegacyFuel
Config.SetFuel = function(vehicle, fuel)
    exports.LegacyFuel:SetFuel(vehicle, fuel)
end

---@param vehicle any
---@return string
---@decription If you have a custom vehicle key system you can give the key to the player
Config.GiveKey = function (vehicle)
    local Core, Framework = GetCore()
    if Framework == "esx" then
        -- ESX Vehicle Key System
    else
        TriggerEvent("vehiclekeys:client:SetOwner", Core.Functions.GetPlate(vehicle))
    end
end

Config.Notification = function(message, type, is_server, src)
    local Core, Framework = GetCore()
    if is_server then
        if Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 5000)
        end
    else
        if Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 5000)
        end
    end
end

Config.Locale = {
    ['en'] = {
        ['received'] = 'You have already received your starter pack',
        ['success'] = 'You have received your starter pack, Enjoy!',
        ['canceled'] = 'You have canceled the starter pack',
        ['not_near_receiving_point'] = 'You are not near the receiving point',
    },
}
