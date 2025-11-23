--Quarry monitor startup
shell.run("clear")
print("Now Resuming Quarry Monitor on channel 1")
print("Press any key to quit. You have 20 seconds.")
local event
if fs.exists("quarryMonitor.lua") then
  for i=20, 1, -1 do
	term.setCursorPos(1,6)
	if i < 10 then
	  term.write(" ")	
	end
    print(i)
    os.startTimer(1)
	event = os.pullEvent()
    if event == "key" then break end
  end
  if event == "timer" then
	  print("Opening...")
	  shell.run("quarryMonitor -auto 1 8")
  else
	  print("Key was pressed! Stopped!")
  end
else
  print("No monitor file found!!")
end
