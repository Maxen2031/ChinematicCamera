

local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local part = Workspace:WaitForChild("Part")

local function tween(goal)
	local info = TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
	local goals = {CFrame = goal}

	local tweenObject = TweenService:Create(camera, info, goals)
	tweenObject:Play()

	return tweenObject
end

--[[
	Data format:

	{
		extract = {1, 2};
		insert = {1, 2};
		cFrames = {
			start = {CFrame.new()};
			goal = {CFrame.new()};
		}
	}
]]

local function cinematicCamera(basePart, data)
	local count = 1
	local position = basePart.Position
	local lookVector = basePart.CFrame.LookVector
	local rightVector = basePart.CFrame.RightVector
	local upVector = basePart.CFrame.UpVector

	local function getStartCFrames()
		return {
			CFrame.new (
				position + (lookVector * 15) + (rightVector * 2.5) + (upVector * 5),
				position + (rightVector * 2.5)
			);
			CFrame.new (
				position + (lookVector * 15) - (Vector3.new(((basePart.Size.X/2) * 2), 0, 0)) + (upVector * 5),
				basePart.Position
			);
			CFrame.new (
				position + (lookVector * 10),
				basePart.Position
			);
		}
	end

	local function getGoalCFrames()
		return {
			CFrame.new (
				position + (lookVector * 15) - (rightVector * 2.5) + (upVector * 5),
				position - (rightVector * 2.5)
			);
	
			CFrame.new (
				position + (lookVector * -15) - (Vector3.new(((basePart.Size.X/2) * 2), 0, 0)) + (upVector * 5),
				basePart.Position
			);
			CFrame.new (
				position + (lookVector * 28) + (upVector * 8),
				basePart.Position
			);
		}
	end

	local startCFrames = getStartCFrames()
	local goalCFrames = getGoalCFrames()

	local function handleCFrames()
		if (not data) then return end

		for _, extractPosition in pairs(data.extract) do
			table.remove(startCFrames, extractPosition)
			table.remove(goalCFrames, extractPosition)
		end

		for index, insertPosition in pairs(data.insert) do
			local startCFrame = data.cFrames.start[index]
			local goalCFrame = data.cFrames.goal[index]

			table.insert(startCFrames, startCFrame, insertPosition)
			table.insert(goalCFrames, goalCFrame, insertPosition)
		end
	end

	local function execution()
		camera.CameraType = Enum.CameraType.Scriptable
	
		while (true) do
			local c = startCFrames[count]
			camera.CFrame = c
			local t = tween(goalCFrames[count])
			t.Completed:Wait()

			count += 1

			count = if (count > #startCFrames) then 1 else count

			-- Fade dispaly dark and wait for fade completition. Use Utility module to implement fade feature
		end
	end

	handleCFrames()
	execution()	
end

task.wait(3)

cinematicCamera(part)