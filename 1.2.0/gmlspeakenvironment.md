# GMLspeak Environment

!> GMLspeaks Enviroment is a child of Catspeaks Environment, so anything not listed here should be followed from [here](https://www.katsaii.com/catspeak-lang/3.2.0/lib-environment.html).

## Sandbox-Specific

GMLspeak follows the default nature of Catspeak, by ensuring that everything is sandboxed. Or as sandboxed as it could be. However, some people may prefer to allow some control over it.
So these methods are here to allow such changes.

### `.enableWritingRoom(bool)`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`bool`|`Bool`|Whether to enable or disable writing to `room` directly.|

Sets whether `room` is allowed to be changed or not in GMLspeak programs.

### `.enableWritingRoomProperties(bool)`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`bool`|`Bool`|Whether to enable or disable writing to room-specific properties.|

Sets whether writing to room-specific properties or not in GMLspeak programs.
The following values that are affected:
- `room_width`
- `room_height`
- `room_persistent`

### `.enableWritingIOProperties(bool)`

Returns: `self`

|Name|Datatype|Purpose|
|---|---|---|
|`bool`|`Bool`|Whether to enable or disable writing to io-specific properties.|

Sets whether writing to io-specific properties or not in GMLspeak programs.
The following values that are affected:
- `keyboard_string`
- `keyboard_key`
- `keyboard_lastchar`
- `keyboard_lastkey`
- `mouse_lastbutton`
- `cursor_sprite`

## Compile Flags
While Catspeak doesn't have compile flags, GMLspeak carries some specific compile-flags. Accessible via `environment.interface.compileFlags`.
The follow compile flags that are implmeneted:

|Name|Datatype|Default|Purpose|
|---|---|---|---|
|`checkForVariables`|`Bool`|`false`|Whether variables should be checked on fetching/updating with specific operators.|
|`useVariableHashes`|`Bool`|`false`|Whether variables should use variable hashes (2023.1+ only) or not for faster lookups.|