id=0
sda = 6 		-- SDA Pin
scl = 5 		-- SCL Pin
ACC = 0x29 		-- LIS3DE Address

--REGISTERS (See documentation for more)
DRE = 0x20 		--Data Rate & Enable
FSS = 0x23 		--Full scale selection
OUT_X = 0x29 	--X acc values
OUT_Y = 0x2B	--Y acc values
OUT_Z = 0x2D	--Z acc values

--Values
DEN = 0x97 --Default enable and rate
P4K = 0x77 --400Hz
H01 = 0x17 --1Hz
H50 = 0x47 --50Hz

G02 = 0x00 --+-2G
G04 = 0x10 --+-4G
G08 = 0x20 --+-8G
G16 = 0x30 --+-16G

local M = {}

local function read_reg(dev_addr, reg_addr)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, reg_addr)
    i2c.stop(id)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.RECEIVER)
    c = i2c.read(id, 1)
    i2c.stop(id)
    return c
end

local function write_reg(dev_addr, reg_addr, reg_val)
    i2c.start(id)
    i2c.address(id, dev_addr, i2c.TRANSMITTER)
    i2c.write(id, reg_addr, reg_val)
    i2c.stop(id)
end

local function readVAL(REG)
	return string.byte(read_reg(ACC,REG))
end

local function readACC(REG)
	TMP = readVAL(REG)
	if TMP<128 then
		return TMP
	else
		return (TMP-255)
	end
end

function M.initDEF() --set default values
	write_reg(ACC,DRE,DEN)
	write_reg(ACC,FSS,G16)
end

function M.readX()
	return readACC(OUT_X)
end

function M.readY()
	return readACC(OUT_Y)
end

function M.readZ()
	return readACC(OUT_Z)
end

function M.testL()
	return('bob')
end


return M

