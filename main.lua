local component = require("component")
local computer = require("computer")
local os = require("os")
local redstone = component.redstone
local transposer = component.transposer
local sleep = os.sleep

local fluidSensor = 2 --сторона редстоунIO с которой подаётся сигнал о наличии жидкости
local fluidPlacer = 4 --сторона редстоунIO с которой активируется блок отвечающий за выливание жидкости в мир
local outputChest = 1 --сторона транспозера - контейнер, который отдаёт кристалл в дроппер
local storage = 2     --сторона транспозера - хранилище готовых кристаллов
local vacoomChest = 4 --сторона транспозера - воронка забирающая готовый кристалл
local vacoomChestSize = component.transposer.getInventorySize(vacoomChest) - 1 --все слоты в воронке - 1
local compareSlot = component.transposer.getInventorySize(vacoomChest) --последний слот, в котором хранится кристалл для сравнения(кладётся руками)
local SLEEP_TIME = 10 --время паузы в глобальном цикле и между проверками

local inventory = nil -- placeholder для коллекции результата парсинга инвентаря

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

    for slot = 1, vacoomChestSize do -- Проверяем все слоты кроме последнего (эталона)
        local stack = transposer.getStackInSlot(vacoomChest, slot)
        if stack then
                table.insert(crystals, slot)
            if transposer.compareStacks(vacoomChest, slot, compareSlot) then
                table.insert(perfect, slot)
            end
        end
    end
    
    return {crystals,perfect}

end

function itemManagment()

  inventory = inventoryParser()
  if  inventory == nil then
    sleep(SLEEP_TIME)
    inventory = inventoryParser()
    if inventory == nil then
      
    end
  end

fillBath()

if #inventory[crystals] == 1 then
    -- Если в коллекции inventoryParser() только один кристалл - отправляем его на рост, не сверяя перфект он или нет
    --transposer.transferItem(vacoomChest, outputChest, 1, slot, 1)
  elseif #inventory[crystals] > 1 then

    if #inventory[perfect] > 0 then
      -- Если больше одного - проверяем, есть ли перфект и отправляем его в хранилище если он есть,
      --transposer.transferItem(vacoomChest, storage, 1, slot, 1).
      --первый не перфект отправялем на рост
      --добавить обработку на случай если все perfect
      --transposer.transferItem(vacoomChest, outputChest, 1, slot, 1)
      
    else
      -- Если нет перфекта первый из списка отправляется на рост  
      -- transposer.transferItem(vacoomChest, outputChest, 1, slot, 1)
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

--transferItem(sourceSide:number, sinkSide:number, count:number, sourceSlot:number, sinkSlot:number):number
