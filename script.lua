-- Large amounts of code in this borrowed from https://github.com/vysheng/tg repository

require "./helperfuncs"
require "./PluginEventHandler"


started = 0
our_id = 0


print ("HI, this is lua script")



-- Check for plugins here












function ok_cb(extra, success, result)
end

-- Notification code {{{

function get_title (P, Q)
  if (Q.type == 'user') then
    return P.first_name .. " " .. P.last_name
  elseif (Q.type == 'chat') then
    return Q.title
  elseif (Q.type == 'encr_chat') then
    return 'Secret chat with ' .. P.first_name .. ' ' .. P.last_name
  else
    return ''
  end
end

-- }}}

function on_msg_receive (msg)
  PluginEventHandler.notify('on_msg_receive')

  if started == 0 then
    return
  end
  if msg.out then
    return
  end
  print("MSG RECV\n")
  print(get_title (msg.from, msg.to))
  print(msg.text)
 
  if (msg.text == 'ping') then
    if (msg.to.id == our_id) then
      send_msg (msg.from.print_name, 'pong', ok_cb, false)
    else
      send_msg (msg.to.print_name, 'pong', ok_cb, false)
    end
    return
  end
  if (msg.text == 'PING') then
    if (msg.to.id == our_id) then
      fwd_msg (msg.from.print_name, msg.id, ok_cb, false)
    else
      fwd_msg (msg.to.print_name, msg.id, ok_cb, false)
    end
    return
  end
end

function on_our_id (id)
  PluginEventHandler.notify('on_our_id')
  our_id = id
end

function on_user_update (user, what)
  PluginEventHandler.notify('on_user_update')
  print("USER UPDATE RECV\n")
  vardump (user)
end

function on_chat_update (chat, what)
    PluginEventHandler.notify('on_chat_update')
	print("CHAT UPDATE RECV\n")
  vardump (chat)
end

function on_secret_chat_update (schat, what)
    PluginEventHandler.notify('on_secret_chat_update')
	print("SECRET CHAT UPDATE RECV\n")
  vardump (schat)
end

function on_get_difference_end ()
	PluginEventHandler.notify('on_get_difference_end')
end

function cron()
  -- do something
  postpone (cron, false, 1.0)
end

function on_binlog_replay_end ()
  PluginEventHandler.notify('on_binlog_replay_end')
  started = 1
  postpone (cron, false, 1.0)
end
