# General

### `VramDoctorGetTexturePageSize()`

Returns: `Real`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current total texture pages (sprites, fonts, tilesets) size in bytes.

!> Texture pages are calculated as `width * height * 4`, where 4 is RGBA (8 bytes per color value)

### `VramDoctorGetSurfaceTextureSize()`

Returns: `Real`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current total surfaces size in bytes.

!> Surfaces are calculated as `width * height * surfaceFormat`, where surfaceFormat depends on the format used. See the graph below for their byte size.

|Surface Format Type|Size (bytes)|Notes|
|---|---|---|
|`surface_rgbaunorm`|4|The default for all surfaces, when no format is specified.|
|`surface_r8unorm`|1|||
|`surface_rg8unorm`|2||
|`surface_rgba4unorm`|2||
|`surface_rgba16float`|8||
|`surface_r16float`|2||
|`surface_rgba32float`|16||
|`surface_r32float`|4||

### `VramDoctorGetTextureSize()`

Returns: `Real`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current total texture size for all surfaces and texture pages size in bytes.

### `VramDoctorGetVBOSize()`

Returns: `Real`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current total frozen vertex buffers size in bytes.

### `VramDoctorGetTotalSize()`

Returns: `Real`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the total size of everything. Effectively the same as calling `VramDoctorGetTexturePageSize()`, `VramDoctorGetSurfaceTextureSize()`, `VramDoctorGetTextureSize()` and `VramDoctorGetVBOSize()`.

### `VramDoctorSetAutoTick(bool)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`value`|`Boolean`|The state you wish to set.|

Sets whether Vram Doctor should automatically tick every frame or not. Turning this off requires calling `VramDoctorUpdate()` manually. The default is `true`.

### `VramDoctorSetSeconds(seconds)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`seconds`|`Real`|The seconds you wish to set.|

Sets how many seconds between each tick should Vram Doctor wait before recalculating sizes. The default is `0.01` seconds.

### `VramDoctorUpdate()`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Forces Vram Doctor to tick automatically.

!> You can only use this if Vram Doctor auto tick is set to false. This will throw an exception otherwise.