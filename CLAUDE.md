# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Lua scripts for OpenTX/FreedomTX firmware. Target hardware: TNS Tango 2 controller.

## Development & Testing

- Scripts deployed to `SCRIPTS/` folder on SD card
- Telemetry scripts: `SCRIPTS/TELEMETRY/`
- Model scripts: `SCRIPTS/MIXES/`
- Functions: `SCRIPTS/FUNCTIONS/`
- Test on TNS Tango 2 or OpenTX Companion simulator
- Use OpenTX Simulator for rapid iteration before hardware testing

## OpenTX/FreedomTX Lua API

### Core Functions
- `getFieldInfo()` - get telemetry sensor info
- `getValue()` - read telemetry/switch/input values
- `playFile()`, `playNumber()`, `playTone()` - audio feedback
- `model.getTimer()`, `model.setTimer()` - timer operations
- `lcd.drawText()`, `lcd.drawNumber()`, `lcd.drawLine()` - display rendering

### Script Types
- **Telemetry**: periodic screen updates, `init()` and `run(event)` required
- **One-time**: run once, no event loop
- **Mix scripts**: custom mixing logic

### Constraints
- Memory limited (check with `getAvailableMemory()`)
- CPU cycles limited - avoid heavy computations in `run()`
- Use global vars sparingly
- No standard Lua libs (io, os, debug)

## TNS Tango 2 Specifics

- 128x64 monochrome LCD
- 2.4GHz multi-protocol TX module support
- OpenTX 2.2+ compatible
- Check switch mappings in model config
