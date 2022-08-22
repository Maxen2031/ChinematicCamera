

local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local part = Workspace:WaitForChild("Part")

local count = 1

local function tween(goal)
	local info = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
	local goals = {CFrame = goal}
end

local function cinematicCamera(basePart)
	camera.CameraType = Enum.CameraType.Scriptable

	local startPositions = {
		CFrame.new(basePart.Position + (basePart.CFrame.LookVector * 5) - (basePart.CFrame.RightVector * 2.5), basePart.Position - (basePart.CFrame.RightVector * 2.5));
		CFrame.new(basePart.Position + (basePart.CFrame.LookVector * 5) + Vector3.new(3, 2, 0), basePart.Position);
		CFrame.new(basePart.Position + (basePart.CFrame.LookVector * 5), basePart.Position - (basePart.CFrame.RightVector * -2.5));
	}
	
	local goals = {
		CFrame.new(basePart.Position + (basePart.CFrame.LookVector * 5) + (basePart.CFrame.RightVector * 2.5), basePart.Position + (basePart.CFrame.RightVector * 2.5));
	}
	
	while (true) do
		local c = startPositions[count]
		camera.CFrame = c
		local t = tween(goals[count])
		t.Completed:Wait()
		count += 1
		
		count = if (count >= #startPositions) then 1 else count
		break
	end
end

cinematicCamera(part)