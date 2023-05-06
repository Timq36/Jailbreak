getgenv().toggled = true-- change this to false to stop kill aura. 

if getgenv().killauraloaded then return end

local old = require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollideWithIgnoreList

local function getNearestEnemy()
    local nearestDistance, nearestEnemy = 1000, nil
    local myTeam = tostring(game:GetService("Players").LocalPlayer.Team)
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        local theirTeam = tostring(v.Team)
     if ((myTeam == "Police" and theirTeam == "Criminal") or theirTeam == "Police") and theirTeam ~= myTeam and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
      if (v.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < nearestDistance then
          nearestDistance, nearestEnemy = (v.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude, v
      end
     end
 end
    return nearestEnemy
end
local function shoot()
    local currentGun = require(game:GetService("ReplicatedStorage").Game:WaitForChild("ItemSystem"):WaitForChild("ItemSystem")).GetLocalEquipped()
    if not currentGun then return end
    require(game:GetService("ReplicatedStorage").Game:WaitForChild("Item"):WaitForChild("Gun"))._attemptShoot(currentGun)
end
getgenv().killauraloaded = true
while wait(0.5) do
 if getgenv().toggled == false then continue end
 if not game:GetService("Players").LocalPlayer.Character then continue end
 if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then continue end
    
    local nearestEnemy = getNearestEnemy()
    if nearestEnemy then
        require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollideWithIgnoreList = function(...)
         local arg = {old(...)}
         if (tostring(getfenv(2).script) == "BulletEmitter" or tostring(getfenv(2).script) == "Taser") and nearestEnemy and nearestEnemy.Character and nearestEnemy.Character:FindFirstChild("HumanoidRootPart") and nearestEnemy.Character:FindFirstChild("Humanoid") and (nearestEnemy.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 600 and nearestEnemy.Character.Humanoid.Health > 0 then
            arg[1] = nearestEnemy.Character.HumanoidRootPart
            arg[2] = nearestEnemy.Character.HumanoidRootPart.Position
        end
         return unpack(arg)
     end
     if not game:GetService("Players").LocalPlayer.Folder:FindFirstChild("Pistol") then
         fireclickdetector(workspace.Givers:GetChildren()[17].ClickDetector)
     end
     if game:GetService("Players").LocalPlayer.Folder:FindFirstChild("Pistol") then
         while game:GetService("Players").LocalPlayer.Folder:FindFirstChild("Pistol") and nearestEnemy and nearestEnemy.Character and nearestEnemy.Character:FindFirstChild("HumanoidRootPart") and nearestEnemy.Character:FindFirstChild("Humanoid") and (nearestEnemy.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 600 and nearestEnemy.Character.Humanoid.Health > 0 do
             game:GetService("Players").LocalPlayer.Folder.Pistol.InventoryEquipRemote:FireServer(true)
             wait()
             shoot()
         end
     end
     if game:GetService("Players").LocalPlayer.Folder:FindFirstChild("Pistol") then
         game:GetService("Players").LocalPlayer.Folder.Pistol.InventoryEquipRemote:FireServer(false)
     end
    else
        require(game:GetService("ReplicatedStorage").Module.RayCast).RayIgnoreNonCollideWithIgnoreList = old
    end
end

--прядки loadstring(game:HttpGet("https://raw.githubusercontent.com/OneProtocol/Project/main/Loader", true))()

--esp
local workspace = game:GetService("Workspace")
local player = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera

--// Settings:
local on = true -- Use this if your making gui

local Box_Color = Color3.fromRGB(0, 255, 50)
local Box_Thickness = 1.4
local Box_Transparency = 1 -- 1 Visible, 0 Not Visible

local Tracers = true
local Tracer_Color = Color3.fromRGB(0, 255, 50)
local Tracer_Thickness = 1.4
local Tracer_Transparency = 1 -- 1 Visible, 0 Not Visible

local Autothickness = false -- Makes screen less encumbered

local Team_Check = false
local red = Color3.fromRGB(227, 52, 52)
local green = Color3.fromRGB(88, 217, 24)

local function NewLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(1, 1)
    line.Color = Box_Color
    line.Thickness = Box_Thickness
    line.Transparency = Box_Transparency
    return line
end

--// Main Function:
for i, v in pairs(game.Players:GetChildren()) do
    --// Lines for 3D box (12)
    local lines = {
        line1 = NewLine(),
        line2 = NewLine(),
        line3 = NewLine(),
        line4 = NewLine(),
        line5 = NewLine(),
        line6 = NewLine(),
        line7 = NewLine(),
        line8 = NewLine(),
        line9 = NewLine(),
        line10 = NewLine(),
        line11 = NewLine(),
        line12 = NewLine(),
        Tracer = NewLine()
    }

    lines.Tracer.Color = Tracer_Color
    lines.Tracer.Thickness = Tracer_Thickness
    lines.Tracer.Transparency = Tracer_Transparency

    --// Updates ESP (lines) in render loop
    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if on and v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Name ~= player.Name and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") ~= nil then
                local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if vis then
                    local Scale = v.Character.Head.Size.Y/2
                    local Size = Vector3.new(2, 3, 1.5) * (Scale * 2) -- Change this for different box size

                    local Top1 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, -Size.Z)).p)
                    local Top2 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, Size.Z)).p)
                    local Top3 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, Size.Z)).p)
                    local Top4 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, -Size.Z)).p)

                    local Bottom1 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, -Size.Z)).p)
                    local Bottom2 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, Size.Z)).p)
                    local Bottom3 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, Size.Z)).p)
                    local Bottom4 = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, -Size.Z)).p)

                    --// Top:
                    lines.line1.From = Vector2.new(Top1.X, Top1.Y)
                    lines.line1.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line2.From = Vector2.new(Top2.X, Top2.Y)
                    lines.line2.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line3.From = Vector2.new(Top3.X, Top3.Y)
                    lines.line3.To = Vector2.new(Top4.X, Top4.Y)

                    lines.line4.From = Vector2.new(Top4.X, Top4.Y)
                    lines.line4.To = Vector2.new(Top1.X, Top1.Y)

                    --// Bottom:
                    lines.line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                    lines.line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                    lines.line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                    lines.line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                    --//S ides:
                    lines.line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line9.To = Vector2.new(Top1.X, Top1.Y)

                    lines.line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line10.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line11.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line12.To = Vector2.new(Top4.X, Top4.Y)

                    --// Tracer:
                    if Tracers then
                        local trace = camera:WorldToViewportPoint((v.Character.HumanoidRootPart.CFrame * CFrame.new(0, -Size.Y, 0)).p)

                        lines.Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                        lines.Tracer.To = Vector2.new(trace.X, trace.Y)
                    end

                    --// Teamcheck:
                    if Team_Check then
                        if v.TeamColor == player.TeamColor then
                            for u, x in pairs(lines) do
                                x.Color = green
                            end
                        else 
                            for u, x in pairs(lines) do
                                x.Color = red
                            end
                        end
                    end

                    --// Autothickness:
                    if Autothickness then
                        local distance = (player.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                        for u, x in pairs(lines) do
                            x.Thickness = value
                        end
                    else 
                        for u, x in pairs(lines) do
                            x.Thickness = Box_Thickness
                        end
                    end

                    for u, x in pairs(lines) do
                        if x ~= lines.Tracer then
                            x.Visible = true
                        end
                    end
                    if Tracers then
                        lines.Tracer.Visible = true
                    end
                else 
                    for u, x in pairs(lines) do
                        x.Visible = false
                    end
                end
            else 
                for u, x in pairs(lines) do
                    x.Visible = false
                end
                if game.Players:FindFirstChild(v.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end

game.Players.PlayerAdded:Connect(function(newplr)
    --// Lines for 3D box (12)
    local lines = {
        line1 = NewLine(),
        line2 = NewLine(),
        line3 = NewLine(),
        line4 = NewLine(),
        line5 = NewLine(),
        line6 = NewLine(),
        line7 = NewLine(),
        line8 = NewLine(),
        line9 = NewLine(),
        line10 = NewLine(),
        line11 = NewLine(),
        line12 = NewLine(),
        Tracer = NewLine()
    }

    lines.Tracer.Color = Tracer_Color
    lines.Tracer.Thickness = Tracer_Thickness
    lines.Tracer.Transparency = Tracer_Transparency

    --// Updates ESP (lines) in render loop
    local function ESP()
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if on and newplr.Character ~= nil and newplr.Character:FindFirstChild("Humanoid") ~= nil and newplr.Character:FindFirstChild("HumanoidRootPart") ~= nil and newplr.Name ~= player.Name and newplr.Character.Humanoid.Health > 0 and newplr.Character:FindFirstChild("Head") ~= nil then
                local pos, vis = camera:WorldToViewportPoint(newplr.Character.HumanoidRootPart.Position)
                if vis then
                    local Scale = newplr.Character.Head.Size.Y/2
                    local Size = Vector3.new(2, 3, 1.5) * (Scale * 2) -- Change this for different box size

                    local Top1 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, -Size.Z)).p)
                    local Top2 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, Size.Y, Size.Z)).p)
                    local Top3 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, Size.Z)).p)
                    local Top4 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, Size.Y, -Size.Z)).p)

                    local Bottom1 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, -Size.Z)).p)
                    local Bottom2 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(-Size.X, -Size.Y, Size.Z)).p)
                    local Bottom3 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, Size.Z)).p)
                    local Bottom4 = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(Size.X, -Size.Y, -Size.Z)).p)

                    --// Top:
                    lines.line1.From = Vector2.new(Top1.X, Top1.Y)
                    lines.line1.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line2.From = Vector2.new(Top2.X, Top2.Y)
                    lines.line2.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line3.From = Vector2.new(Top3.X, Top3.Y)
                    lines.line3.To = Vector2.new(Top4.X, Top4.Y)

                    lines.line4.From = Vector2.new(Top4.X, Top4.Y)
                    lines.line4.To = Vector2.new(Top1.X, Top1.Y)

                    --// Bottom:
                    lines.line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                    lines.line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                    lines.line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                    lines.line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                    --//S ides:
                    lines.line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                    lines.line9.To = Vector2.new(Top1.X, Top1.Y)

                    lines.line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                    lines.line10.To = Vector2.new(Top2.X, Top2.Y)

                    lines.line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                    lines.line11.To = Vector2.new(Top3.X, Top3.Y)

                    lines.line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                    lines.line12.To = Vector2.new(Top4.X, Top4.Y)

                    --// Tracer:
                    if Tracers then
                        local trace = camera:WorldToViewportPoint((newplr.Character.HumanoidRootPart.CFrame * CFrame.new(0, -Size.Y, 0)).p)
                        lines.Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                        lines.Tracer.To = Vector2.new(trace.X, trace.Y)
                    end

                    --// Teamcheck:
                    if Team_Check then
                        if newplr.TeamColor == player.TeamColor then
                            for u, x in pairs(lines) do
                                x.Color = green
                            end
                        else 
                            for u, x in pairs(lines) do
                                x.Color = red
                            end
                        end
                    end

                    --// Autothickness:
                    if Autothickness then
                        local distance = (player.Character.HumanoidRootPart.Position - newplr.Character.HumanoidRootPart.Position).magnitude
                        local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                        for u, x in pairs(lines) do
                            x.Thickness = value
                        end
                    else 
                        for u, x in pairs(lines) do
                            x.Thickness = Box_Thickness
                        end
                    end

                    for u, x in pairs(lines) do
                        if x ~= lines.Tracer then
                            x.Visible = true
                        end
                    end
                    if Tracers then
                        lines.Tracer.Visible = true
                    end
                else 
                    for u, x in pairs(lines) do
                        x.Visible = false
                    end
                end
            else 
                for u, x in pairs(lines) do
                    x.Visible = false
                end
                if game.Players:FindFirstChild(newplr.Name) == nil then
                    connection:Disconnect()
                end
            end
        end)
    end
    coroutine.wrap(ESP)()
end)
