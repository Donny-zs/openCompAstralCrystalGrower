local component = require("component")
local computer = require("computer")
local os = require("os")
local redstone = component.redstone
local transposer = component.transposer
local sleep = os.sleep

local outputChest = 1
local storage = 2
local vacoomChest = 4

--transferItem(sourceSide:number, sinkSide:number, count:number, sourceSlot:number, sinkSlot:number):number
--compareStacks(side:number, slotA:number, slotB:number, checkNBT:boolean=false):boolean

function checkFluid()
  return redstone.getInput(2) != 0 -- пример для стороны 2
end

