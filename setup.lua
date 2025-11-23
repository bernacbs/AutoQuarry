-- Based on Sedrowow code
-- Modded by Mexy
-- --- Configuration ---
local githubBaseUrl = "https://raw.githubusercontent.com/bernacbs/AutoQuarry/main/"

-- List the exact filenames for each setup type.
local quarryFiles = {"Quarry/quarry.lua", "Quarry/blacklist.txt"} -- Add any other scripts here
local monitorFiles = {"Quarry Monitor/quarryMonitor.lua", "Quarry Monitor/startup.lua"}
---------------------

-- Function to download a script and provide feedback
local function downloadFiles(fileName)
    local fullUrl = githubBaseUrl .. fileName
    print("Downloading " .. fileName .. "...")
    local success = shell.run("wget " .. fullUrl .. " " .. fileName)
    if success then
        print(filetName .. " downloaded.")
        return true
    else
        print("Error downloading " .. fileName .. ".")
        print("Please check if the URL are correct: " .. fullUrl)
        print("And ensure you have an internet connection.")
        return false
    end
end

-- --- Main Setup Logic ---

print("##Universal Download and Setup##")
print("  ----- Modded by Mexy -----")
print("Is this the 1=Quarry or 2=monitor?")

local setupType = io.read()

if setupType == "1" then
    -- --- Quarry Setup ---
    print("Setting up as Quarry...")

    -- Download Quarry files
    local allDownloaded = true
    for _, fileName in ipairs(quarryFiles) do
        if not downloadScript(fileName) then
            allDownloaded = false
            -- Optionally stop if a critical script fails to download
            -- break
        end
    end

    if allDownloaded then
        -- Label the turtle if it is one
        if turtle then
            print("What should be the name of this Turtle?")
            name = io.read()
            if name == "" then
                name = "Bob"
            end
            shell.run("label set " .. name)
            print("Turtle labeled '" .. name .. "'.")
        else
            print("Not a turtle. Skipping labeling.")
        end

        os.sleep(2)

        -- Ask about automatic setup
        print("automatically set up? 1:yes 2:no")
        local autoSetup = io.read()

        if autoSetup == "1" then
            print("ETAPA 1 for initial setup...")
            --shell.run("flex.lua")
            print("ETAPA 1 setup done.")
            os.sleep(1)

            print("ETAPA 2 for setup...")
            --shell.run("dig.lua")
            print("ETAPA 2 setup done.")
            os.sleep(1)

            print("------------------------------------")
            print("Setup complete!")
            print("use command 'quarry arg1 arg2 arg3 ...' or 'quarry help' for usage")
            print("or check blacklist.txt for black item list")
            print("------------------------------------")
        else
            print("Manual setup selected.")
        end
    else
        print("Some files failed to download. Please check the error messages above.")
    end

elseif setupType == "2" then
    -- --- Monitor Setup ---
    print("Setting up as Monitor...")
    print("1= pocket computer or 2= normal computer?")
    local computerType = io.read()

    if computerType == "1" then
        -- Pocket Computer Setup
        print("Setting up on Pocket Computer...")

        -- Download Receiver Scripts
        local allDownloaded = true
        for _, fileName in ipairs(monitorFiles) do
            if not downloadScript(fileName) then
                allDownloaded = false
                 -- Optionally stop if a critical script fails to download
                 -- break
            end
        end

        if allDownloaded then
            print("download done.")

            print("Running flex.lua for initial setup...")
            --shell.run("flex.lua")
            os.sleep(1)

            print("---------------------------------------")
            print("'check flex_options.cfg' for settings")
            print("or run 'receive' to start receiving")
            print("---------------------------------------")
        else
             print("Some scripts failed to download. Please check the error messages above.")
        end

    elseif computerType == "2" then
        -- Normal Computer Setup
        print("Setting up on Computer Craft...")

        -- Download Receiver Scripts
         local allDownloaded = true
        for _, fileName in ipairs(monitorFiles) do
            if not downloadScript(fileName) then
                allDownloaded = false
                 -- Optionally stop if a critical script fails to download
                 -- break
            end
        end

        if allDownloaded then
            print("download done.")

            print("Running flex.lua for initial setup...")
            --shell.run("flex.lua")
            os.sleep(1)

            -- Ask about creating startup.lua
            print("create startup.lua for constant monitor usage? 1=Yes/2=No")
            local createStartup = io.read()

            if createStartup == "1" then
                print("Select monitor side on computer craft: 1=top 2=left 3=right 4=bottom")
                local monitorPositionChoice = io.read()
                local monitorPosition = nil

                if monitorPositionChoice == "1" then
                    monitorPosition = "top"
                elseif monitorPositionChoice == "2" then
                    monitorPosition = "left"
                elseif monitorPositionChoice == "3" then
                    monitorPosition = "right"
                elseif monitorPositionChoice == "4" then
                    monitorPosition = "bottom"
                else
                    print("Invalid choice. Skipping startup.lua creation.")
                end

                if monitorPosition then
                    local startupFile = fs.open("startup.lua", "w")
                    if startupFile then
                        --startupFile.write('shell.run("monitor scale ' .. monitorPosition .. ' 0.5")\n')
                        --startupFile.write('shell.run("monitor ' .. monitorPosition .. ' receive")\n')
                        startupFile.close()
                        print("startup.lua created successfully.")
                    else
                        print("Error creating startup.lua.")
                    end
                end
            end

            print("---------------------------------------")
            print("'check flex_options.cfg' for settings")
            print("or run 'receive' to start receiving")
            print("---------------------------------------")
         else
             print("Some scripts failed to download. Please check the error messages above.")
        end

    else
        print("Invalid choice for computer type. Please enter 1 or 2.")
    end
else
    print("Invalid choice for setup type. Please enter 1 or 2.")
end

print("Setup script finished.")

--[[
elseif setupType == "3" then
    -- --- Ore Miner Setup ---
    print("Setting up as Ore Miner...")

    -- Download Ore Miner Scripts
    local allDownloaded = true
    for _, scriptName in ipairs(oreminerScripts) do
        if not downloadScript(scriptName) then
            allDownloaded = false
        end
    end

    if allDownloaded then
        -- Label the turtle if it is one
        if turtle then
            print("What should be the name of this Turtle?")
            name = io.read()
            if name == "" then
                name = "OreMiner"
            end
            shell.run("label set " .. name)
            print("Turtle labeled '" .. name .. "'.")
        else
            print("Not a turtle. Skipping labeling.")
        end

        os.sleep(2)

        -- Ask about automatic setup
        print("automatically set up? 1:yes 2:no")
        local autoSetup = io.read()

        if autoSetup == "1" then
            print("Running flex.lua for initial setup...")
            shell.run("flex.lua")
            print("flex setup done.")
            os.sleep(1)

            print("Running dig.lua for setup...")
            shell.run("dig.lua")
            print("dig setup done.")
            os.sleep(1)

            print("------------------------------------")
            print("Setup complete!")
            print("use command 'oreminer' for usage")
            print("or check flex_options.cfg for settings")
            print("------------------------------------")
        else
            print("Manual setup selected.")
            print("Please run 'flex.lua' and 'dig.lua' manually to configure.")
            print("Check flex_options.cfg for settings.")
        end
    else
        print("Some scripts failed to download. Please check the error messages above.")
    end
--]]