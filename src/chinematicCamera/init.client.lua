

local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local part = Workspace:WaitForChild("Part")

local count = 1

local function tween(goal)
	local info = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
	local goals = {CFrame = goal}
end

local function cinematicCamera(basePart)
	local startPositions = {
		CFrame.new(basePart.Position + (basePart.CFrame.LookVector * 5), basePart.Position - (basePart.CFrame.RightVector * -2.5));
		CFrame.new(basePart.Position + (basePart.CFrame.LookVector * 5) + Vector3.new(3, 2, 0), basePart.Position);
		CFrame.new(basePart.Position + (basePart.CFrame.LookVector * 5), basePart.Position - (basePart.CFrame.RightVector * -2.5));
	}
	
	local goals = {
		
	}
	
	while (true) do
		local c = startPositions[count]
		camera.CFrame = c
		local t = tween()
		t.Completed:Wait()
		count += 1
		
		if (count >= #startPositions) then
			count = 1
		end
	end
end

cinematicCamera(part)