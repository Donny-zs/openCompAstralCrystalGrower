local component = require("component")
local computer = require("computer")
local os = require("os")
local math = require("math")
local redstone = component.redstone
local transposer = component.transposer
local sleep = os.sleep
local random = math.random

local fluidSensor = 2 --сторона редстоунIO с которой подаётся сигнал о наличии жидкости
local fluidPlacer = 4 --сторона редстоунIO с которой активируется блок отвечающий за выливание жидкости в мир
local outputChest = 1 --сторона транспозера - контейнер, который отдаёт кристалл в дроппер
local storage = 2     --сторона транспозера - хранилище готовых кристаллов
local vacoomChest = 4 --сторона транспозера - воронка забирающая готовый кристалл
local vacoomChestSize = component.transposer.getInventorySize(vacoomChest) - 1 --все слоты в воронке - 1
local compareSlot = component.transposer.getInventorySize(vacoomChest) --последний слот, в котором хранится кристалл для сравнения(кладётся руками)
local SLEEP_TIME = 10 --время паузы в глобальном цикле и между проверками

function checkCompareCrystal()
  return transposer.getStackInSlot(vacoomChest, compareSlot) ~= nil
end

function checkFluid() --Возвращает true если жидкость присутствует
  return redstone.getInput(fluidSensor) > 0 
end

function fillBath()
  redstone.setOutput(fluidPlacer, 15)
  sleep(2)
  redstone.setOutput(fluidPlacer, 0)
  if checkFluid() then
    return true
  else
    error("Out of starlight")
  end
end

function inventoryParser()
  local crystals = {}
  local perfect = {}
  local usual = {}

    for slot = 1, vacoomChestSize do -- Проверяем все слоты кроме последнего (эталона)
        local stack = transposer.getStackInSlot(vacoomChest, slot)
        if stack then
                table.insert(crystals, slot)
            if transposer.compareStacks(vacoomChest, slot, compareSlot, true) then
                table.insert(perfect, slot)
            else
                table.insert(usual, slot)
            end
        end
    end
    
    return {crystals, perfect, usual}

end

function itemManagment()

  if checkCompareCrystal() == nil then
    error("lost perfect crystal in 27 slot, provide it for compare")
  end
  
  local inventory = inventoryParser()
  if  inventory == nil then
    sleep(SLEEP_TIME)
    inventory = inventoryParser()
    if inventory == nil then
      
    end
  end

local crystals = inventory[1]
local perfect = inventory[2]
local usual = inventory[3]

if #crystals == vacoomChestSize then
    error("Do cuttings to gems!")
end
  
fillBath()

if #crystals == 1 then -- Если в коллекции inventoryParser() только один кристалл - отправляем его на рост, не сверяя перфект он или нет
    transposer.transferItem(vacoomChest, outputChest, 1, crystals[1], 1)
elseif #crystals > 1 then

    if #perfect > 0 then
      -- Если есть не перфеткт - все перфект отправляем его в хранилище,
      if #usual > 0 then
          for _, slot in ipairs(perfect) do
              transposer.transferItem(vacoomChest, storage, 1, slot, 1)
              sleep(2)
          end
          transposer.transferItem(vacoomChest, outputChest, 1, usual[random(#usual)], 1)
      else
          --Если нет неперфекта, отправляем случайный перфект
          transposer.transferItem(vacoomChest, outputChest, 1, perfect[random(#perfect)], 1)
      end
      
    else
      -- Если нет перфекта случайный из списка отправляется на рост  
      transposer.transferItem(vacoomChest, outputChest, 1, random(#crystals), 1)
    end
  else
    error("Crystal lost!")
end

inventory = nil
end



while true do
  if  checkFluid() then
    sleep(SLEEP_TIME)
  else
    itemManagment()
    sleep(SLEEP_TIME)
  end
end
