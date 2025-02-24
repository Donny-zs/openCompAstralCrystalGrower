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

function checkFluid() --Возвращает true если жидкость присутствует
  return redstone.getInput(2) > 0 
end

function fillBath()
  redstone.setOutput(fluidPlacerSide, 15)
  sleep(2)
  redstone.setOutput(fluidPlacerSide, 0)
  if checkFluid() then
    return true
  else
    error("Out of starlight")
  end
end

inventoryParser()
  local crystals = {}
  local perfect = {}

    -- Проверяем все слоты кроме последнего (эталона)
    for slot = 1, vacoomChestSize do
        local stack = transposer.getStackInSlot(vacoomChestSide, slot)
        if stack then
                table.insert(crystals, slot)
            if transposer.compareStacks(vacoomChestSide, slot, compareSlot) then
                table.insert(perfect, slot)
            end
        end
    end
    
    return {crystals,perfect}

end

itemManagment()
  if  !transposer.getStackInSlot(vacoomChest,1) == nil then
    sleep(SLEEP_TIME)
    if !transposer.getStackInSlot(vacoomChest,1) == nil then
    error("Crystal lost!")
    end
  end

end



while true do
  if  checkFluid() then
    sleep(SLEEP_TIME)
  else
    itemManagment()
    sleep(SLEEP_TIME)
end

--transferItem(sourceSide:number, sinkSide:number, count:number, sourceSlot:number, sinkSlot:number):number
--compareStacks(side:number, slotA:number, slotB:number, checkNBT:boolean=false):boolean
