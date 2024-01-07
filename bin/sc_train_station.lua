
--- IMPORT

	--- VANILLA
local	event = require("event")
local	term = require("term")
	--- CUSTOM
local	periph = require("periph")
local	periph_im = require("periph-im")
local	utils = require("utils")
local	log = require("log")

--- ATTRIBUTS
local	conf_path = nil
local	conf = nil

--- TEST

--- INIT
if utils.hostname then
	local	conf_path = "/usr/etc/"..utils.hostname..".lua"

	conf = loadfile(conf_path)
	if conf == nil then
		log.fail("sc_train_station: config file, "..conf_path..", not found")
	else
		conf = conf()
	end
else
	log.fail("sc_train_station: hostname not found, aborting.")
end

if conf == nil then os.exit(1) end

utils.enum_table(conf)

for p_k, p_v in pairs(conf.platform) do
	log.info("setup platform "..p_k)
	for ad_k, ad_v in pairs(p_v.AD) do
		conf.platform[p_k].AD[ad_k] = periph.get(ad_k, ad_v)
		if not conf.platform[p_k].AD[ad_k] then
			os.exit(1)
		end
	end
	for ac_k, ac_v in pairs(p_v.AC) do
		conf.platform[p_k].AC[ac_k] = periph.get(ac_k, ac_v)
		if not conf.platform[p_k].AC[ac_k] then
			os.exit(1)
		end
	end
end

for a_k, a_v in pairs(conf.arrival) do
	log.info("setup arrival "..a_k)
	-- for a_ad_k, a_ad_v in pairs(a_v.AC) do
	-- 	conf.arrival[a_k].AC[a_ad_k] = periph.get("arrival_"..a_ad_k, a_ad_v)
	-- end
	conf.arrival[a_k].AC = periph.get("arrival_"..a_k, a_v.AC)
	if not conf.arrival[a_k].AC then os.exit(1)
	end
	conf.arrival[a_k].AD = periph.get("arrival_"..a_k, a_v.AD)
	if not conf.arrival[a_k].AD then os.exit(1) end
end

function	get_dot(i)
	return string.rep(".", i)..string.rep(" ", 3 - i)
end

function	train_arrival(info)
	local	info
	-- utils.enum_table(info)

	conf.arrival["01"].AD.setTag("01-arrived")
	conf.arrival["01"].AC.setThrottle(0)
	conf.arrival["01"].AC.setBrake(0.95)

	local	waiting_for_train = 1
	local	term_x, term_y = term.getCursor()

	while true do
		log.info("waiting for train"..get_dot(waiting_for_train))
		term.setCursor(term_x, term_y - 1)
		info = conf.platform["01"].AD["end"].getTag()

		if info == "01-arrived" then
			break
		end

		os.sleep(utils.tick)
		if waiting_for_train < 3 then
			waiting_for_train = waiting_for_train + 1
		else
			waiting_for_train = 1
		end
	end
	term.setCursor(term_x, term_y)

	conf.platform["01"].AD["end"].setTag("01-at-station")
	conf.platform["01"].AC["end"].setBrake(1)
	conf.platform["01"].AC["deadend"].setBrake(1)
	conf.platform["01"].AC["end"].setThrottle(0)
	conf.platform["01"].AC["deadend"].setThrottle(0)

	log.pass("Train successfully arrived at platform 01")

	conf.platform["01"].AC["end"].setBrake(1)
	conf.platform["01"].AC["deadend"].setBrake(1)

	local	waiting_for_departure = 10
	local	term_x, term_y = term.getCursor()

	info = conf.platform["01"].AD["end"].info()

	while waiting_for_departure > 0 do
		info = conf.platform["01"].AD["end"].info()
		log.info("Train departure in "..waiting_for_departure.." sec ("..info.passengers.."/60)"..get_dot((waiting_for_departure % 3) + 1))
		term.setCursor(term_x, term_y - 1)
		waiting_for_departure = waiting_for_departure - 1

		conf.platform["01"].AC["end"].setBrake(1)
		conf.platform["01"].AC["deadend"].setBrake(1)
		conf.platform["01"].AC["end"].setThrottle(0)
		conf.platform["01"].AC["deadend"].setThrottle(0)
		os.sleep(1)
	end
	term.setCursor(term_x, term_y)

	info = conf.platform["01"].AD["end"].info()
	conf.platform["01"].AC["end"].setThrottle(0.75)
	conf.platform["01"].AC["deadend"].setThrottle(0.75)
	conf.platform["01"].AC["end"].setBrake(0)
	conf.platform["01"].AC["deadend"].setBrake(0)
	if info.passengers == 1 then
		log.info("train go off with "..info.passengers.." passenger")
	else
		log.info("train go off with "..info.passengers.." passengers")
	end
end

running = true

while running do
	local	info = conf.arrival["01"].AD.info()

	if info then
		train_arrival(info)
	end
	os.sleep(0.5)
end

conf.arrival["01"].AD.setTag("01-arrived")


--- MAIN

