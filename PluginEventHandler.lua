local clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end

-- Events are handled in a SINGLE thread one at a time IN ORDER


TestPlugin = {}
function TestPlugin.notify()
	print("TestPlugin notify called\n")

end
-- TestPlugin

PluginEventHandler = { plugins = {} }

PluginEventHandler.events = {
	on_binlog_replay_end = {},
	on_get_difference_end = {},
	on_our_id = {},
	on_msg_receive = {},
	on_user_update = {},
	on_chat_update = {},
	on_secret_chat_update = {}
}


function PluginEventHandler.notify(...)

	local arg = {...}
	limit = #arg
	
	
	
	print(arg[1] .. " was fired. Observers will be notified...\n")
	print("Extra args: ")
	for i=2,limit do
		print(arg[i])
	end
	
	print("\nEnd of arg list\n")
	
	
--[[	
	for idx,event in ipairs(arg) do
		-- Notify events
		print(event .. " was fired. Observers will be notified...\n")
		
	
	
	end
	sleep(1)
	
--]]
	
end
