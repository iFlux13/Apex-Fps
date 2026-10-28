--============================================================
--TURK MACRO V1
--============================================================

local players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayers = Players.LocalPlayer

--============================================================
--ACTIVATE MACRO
--============================================================
local my_key = Enum.KeyCode.Z --KEY TO ACTIVATE MACRO
local active status = false --INITIAL STATE(OF)

--STRIKE SPEED (a bit slow and with control)
local hitDelays = {
  3.05, --combo 1
  3.90, --combo 2 
  3.10, --combo 4
  4.00, --combo 5
}
local combo = 0 
local lastPunch = 0
local isPunching = false

--=============================================================
--HITBOX AND ATTACK
--=============================================================
local function executeHitboxAttack()
  local character = LocalPlayer.Character
  if not character then return end

  local rootPart = character:FindFirstChild("HumanoidRootPart")
  local humanoid = character:FindFirstChildOfClass("Humanoid")
  if humanoid and humanoid.Healt > 0 and rootPart then
    --frontal hitbox detection
    
    local overlapParams = OverlapParams.new()
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude
    overlapParams.FilterDescendantsInstances = {character}

    local hitBoxSize = Vector.new(5, 6, 5,)--HITBOX SIZE
    local hitBoxCFrame = rootPart.CFrame * CFrame.New(0, 0, -3)

    local partsInRegion =  Workspace:GetPartBoundsInbox(hitBoxCFrame, hitBoxSize, overlapParams)

    for _, part in ipairs(partsInRegion) do
      local targetHumanoid = part.Parent:FindFirstChildOfClass("Humanoid")
      if targetHumanoid and targetHumanoid.Healt > 0 then
        targetHumanoid:TakeDamage(10) --DEALS DAMAGE TO ENEMIES WITHIN RANGE
        break
      end
    end
  end
end

--============================================================
--AUTOMATIC MACRO LOOP
--============================================================

task.spawn(function()
    while true do 
      if activate_status then
        local now = tick()
        combo = combo +1
        if combo > #hitDelays then combo = 1 end
        local currentDelay = hitdelays [combo]

        --EXECUTE THE STRIKE USING THE HITBOX
        executeHitboxAttack()

        --WAIT FOR THE SPEED OF THE CURRENT COMBO
        task.wait(0.05)
      end
    end
  end

  --==========================================================
  --ACTIVATE WITH Z KEY
  --==========================================================

  userInputService.InputBegan:Connect(function(input, gameProcessed)
      if not gameProcessed and input.KeyCode ==my_key then
        activate_status = not active_status
        if active_status then
          print("TURK MACRO V1) ON -EXECUTING COMBOS WITH HITBOX")
        else
          print("[TURK MACRO V1"] OFF")
          end
        end
      end

    
