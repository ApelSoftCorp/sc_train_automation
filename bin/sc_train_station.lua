
--- IMPORT

	--- VANILLA
local	event = require("event")
local	term = require("term")
	--- CUSTOM
local	periph = require("periph")
local	periph_im = require("periph-im")
local	utils = require("utils")
local	log = require("log")

--- UTILS
function	get_dot(i) return string.rep(".", i)..string.rep(" ", 3 - i) end

--- STATION
local	STATION_CONF_PATH = "/usr/etc/"

station = {}

	--- INIT
function	station.get_conf()
	local	conf_path = nil
	if utils.hostname then
		STATION_CONF_PATH = STATION_CONF_PATH..utils.hostname..".lua"
		station.conf = loadfile(STATION_CONF_PATH)
		if station.conf == nil then
			log.fail("station: config file, "..STATION_CONF_PATH..", not found")
		else
			station.conf = station.conf()
		end
	else
		log.fail("station: hostname not found, aborting.")
	end
	if station.conf == nil then os.exit(1) end
end

function	station.get_peripheral()
	for p_k, p_v in pairs(station.conf.platform) do
		log.info("setup platform "..p_k)

		for ad_k, ad_v in pairs(p_v.AD) do
			station.conf.platform[p_k].AD[ad_k] = periph.get(ad_k, ad_v)
			if not station.conf.platform[p_k].AD[ad_k] then os.exit(1) end
		end

		for ac_k, ac_v in pairs(p_v.AC) do
			station.conf.platform[p_k].AC[ac_k] = periph.get(ac_k, ac_v)
			if not station.conf.platform[p_k].AC[ac_k] then os.exit(1) end
		end
	end

	for a_k, a_v in pairs(station.conf.arrival) do
		log.info("setup arrival "..a_k)

		station.conf.arrival[a_k].AC = periph.get("arrival_"..a_k, a_v.AC)
		if not station.conf.arrival[a_k].AC then os.exit(1) end

		station.conf.arrival[a_k].AD = periph.get("arrival_"..a_k, a_v.AD)
		if not station.conf.arrival[a_k].AD then os.exit(1) end
	end
end

function	station.init()
	station.get_conf(STATION_CONF_PATH)
	log.info("setup station "..station.conf.name)
	-- utils.enum_table(station.conf)
	station.get_peripheral()
end

	--- RUN
function	station.arrival_brake(arrival, platform_id)
	arrival.AD.setTag(platform_id.."-arrived")
	arrival.AC.setThrottle(0)
	arrival.AC.setBrake(arrival.brake)
end

function	station.platform_wait_for_arrival(platform, platform_id)
	local	i = 1
	local	term_x, term_y = term.getCursor()
	local	msg = station.name..": Waiting for arrival at "..platform_id

	log.info(msg)
	while true do
		print(msg..get_dot(i))
		term.setCursor(term_x, term_y - 1)
		info = platform.AD["end"].getTag()

		if info == platform_id.."-arrived" then break end

		if i < 3 then
			i = i + 1
		else
			i = 1
		end
		os.sleep(utils.tick)
	end
	term.setCursor(term_x, term_y)
	platform_ad.setTag(platform_id.."-at-station")
	platform.AD["end"].setTag(platform_id.."-at-station")
	platform.AC["end"].setBrake(1)
	platform.AC["deadend"].setBrake(1)
	platform.AC["end"].setThrottle(0)
	platform.AC["deadend"].setThrottle(0)
end

function	station.platform_wait_for_departure(platform, platform_id)
	local	term_x, term_y = term.getCursor()
	local	fmt = station.name..": Train departure in %d sec (%d/60)"
	local	info = nil

	for i = platform.depart_time, 1, -1 do
		info = platform.AD["end"].info()
		print(string.format(fmt, i, info.passengers))
		term.setCursor(term_x, term_y - 1)
		platform.AC["end"].setBrake(1)
		platform.AC["deadend"].setBrake(1)
		platform.AC["end"].setThrottle(0)
		platform.AC["deadend"].setThrottle(0)
		os.sleep(1)
	end
	term.setCursor(term_x, term_y)

	info = platform.AD["end"].info()
	platform.AD["end"].setTag("")
	platform.AC["end"].setThrottle(platform.throttle)
	platform.AC["deadend"].setThrottle(platform.throttle)
	platform.AC["end"].setBrake(0)
	platform.AC["deadend"].setBrake(0)
	if info.passengers == 1 then
		log.info(station.name..": Train go off with "..info.passengers.." passenger")
	else
		log.info(station.name..": Train go off with "..info.passengers.." passengers")
	end
end

function	station.train_arrival(arrival, platform_id)
	local	platform = station.conf.platform[platform_id]
	local	info = nil

	station.arrival_train_brake(arrival, platform_id)
	station.platform_wait_for_train(platform.AD["end"], platform_id)
	log.pass(station.name..": Train successfully arrived at platform "..platform_id)
	station.platform_wait_for_departure(platform, platform_id)
end

function	station.run()
	station.running = true

	while station.running do
		local	info = station.conf.arrival["01"].AD.info()

		if info then
			station.train_arrival(station.conf.arrival["01"], "01")
		end
		os.sleep(utils.tick)
	end
end

--- MAIN

station.init()
station.run()
