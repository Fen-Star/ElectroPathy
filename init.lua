function startup()
  dofile('NAME.lua')
end

tmr.alarm(0,2500,0,startup)
