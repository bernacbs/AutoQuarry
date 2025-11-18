--Quarry monitor startup
shell.run("clear")
print("Now Resuming Quarry Monitor on channel 1")
print("Press any key to quit. You have 10 seconds.")
if fs.exists("QuarryMonitor.lua") then
  for i=10, 1, -1 do
	term.setCursorPos(1,6)
	if i < 10 then
	  term.write(" ")	
	end
    print(i)
    os.sleep(1)
    if event == "key" then break end
  end
  print("Opening...")
  shell.run("QuarryMonitor -receiveChannel 1")
else
  print("No monitor file found!!")
end
