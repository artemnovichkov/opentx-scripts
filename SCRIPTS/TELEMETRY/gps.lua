-- GPS telemetry script for OpenTX/FreedomTX
-- Deploy to: SCRIPTS/TELEMETRY/hello.lua

local gpsId, galtId, gspdId, hdgId

local function getTelemetryId(name)
  local field = getFieldInfo(name)
  if field then
    return field.id
  else
    return -1
  end
end

local function rnd(v, d)
  if d then
    return math.floor((v * 10^d) + 0.5) / (10^d)
  else
    return math.floor(v + 0.5)
  end
end

local function init()
  gpsId = getTelemetryId("GPS")
  galtId = getTelemetryId("GAlt")
  gspdId = getTelemetryId("GSpd")
  hdgId = getTelemetryId("Hdg")
end

local function run(event)
  lcd.clear()

  -- Get GPS coordinates
  local gpsLatLon = getValue(gpsId)
  local gpsLat, gpsLon

  if type(gpsLatLon) == "table" then
    gpsLat = rnd(gpsLatLon["lat"], 6)
    gpsLon = rnd(gpsLatLon["lon"], 6)
  end

  -- Get other telemetry
  local alt = getValue(galtId)
  local spd = getValue(gspdId)
  local hdg = getValue(hdgId)

  -- Convert knots to km/h
  if spd then
    spd = spd * 1.852
  end

  -- Display header
  lcd.drawText(1, 1, "GPS Coordinates", SMLSIZE)

  -- Display latitude
  if gpsLat and gpsLat ~= 0 then
    lcd.drawText(1, 12, string.format("Lat: %.4f", gpsLat), SMLSIZE)
  else
    lcd.drawText(1, 12, "Lat: ---", SMLSIZE)
  end

  -- Display longitude
  if gpsLon and gpsLon ~= 0 then
    lcd.drawText(1, 22, string.format("Lon: %.4f", gpsLon), SMLSIZE)
  else
    lcd.drawText(1, 22, "Lon: ---", SMLSIZE)
  end

  -- Display altitude
  if alt and alt ~= 0 then
    lcd.drawText(1, 32, string.format("Alt: %.0fm", alt), SMLSIZE)
  else
    lcd.drawText(1, 32, "Alt: ---", SMLSIZE)
  end

  -- Display speed
  if spd and spd ~= 0 then
    lcd.drawText(1, 42, string.format("Spd: %.0fkm/h", spd), SMLSIZE)
  else
    lcd.drawText(1, 42, "Spd: ---", SMLSIZE)
  end

  -- Display heading
  if hdg and hdg ~= 0 then
    lcd.drawText(1, 52, string.format("Hdg: %.0f", hdg), SMLSIZE)
  else
    lcd.drawText(1, 52, "Hdg: ---", SMLSIZE)
  end

  return 0
end

return { init=init, run=run }
