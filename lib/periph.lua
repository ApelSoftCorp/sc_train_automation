--- include
local	component = require("component")
local	computer = require("computer")
local	log = require("log")

local periph = {}

function log.periph_pass(periph_type, periph_subtype, name, addr, str)
	local	periph_fmt = periph_type..":"..periph_subtype..":"..name.."|"..addr

	log.print("[")
	log.printc(computer.uptime(), log.c.yellow)
	log.print("]")
	log.print("[")
	log.printc("⌨", log.c.cyan)
	log.print("]")
	log.print("[")
	log.printc("OK", log.c.green)
	log.print("][")
	log.printc(periph_fmt, log.c.cyan)
	log.print("]"..log.sep..str.."\n")
end

function log.periph_fail(periph_type, periph_subtype, name, addr, str)
	local	periph_fmt = periph_type..":"..periph_subtype..":"..name.."|"..addr

	log.print("[")
	log.printc(computer.uptime(), log.c.yellow)
	log.print("]")
	log.print("[")
	log.printc("🛠", log.c.cyan)
	log.print("]")
	log.print("[")
	log.printc("KO", log.c.red)
	log.print("]")
	log.printc(periph_fmt, log.c.cyan)
	log.print("]"..log.sep..str.."\n")
end

function	periph.wrapper(periph_type, periph_subtype, name, addr)
	local	a = component.get(addr)
	local	fmt = "%s: %s: %s"

	if a == nil then
		log.periph_fail(periph_type, periph_subtype, name, addr, "KO: get")
		return nil
	end

	local	c = component.proxy(a)
	if c then
		log.periph_pass(periph_type, periph_subtype, name, addr, "Success")
	else
		log.periph_fail(periph_type, periph_subtype, name, addr,
			"Error cannot proxy addr")
	end
	return c
end

return periph
