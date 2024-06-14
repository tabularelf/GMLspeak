!> Note: These are only necessary if you've removed `__VramDoctorMacroAssist`!!!

### `VramDoctorAddFont(font)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`font`|`Font`|Font you wish for Vram Doctor to track.|

Adds the font to Vram Doctor to track vram usage.

### `VramDoctorAddSprite(sprite)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`sprite`|`Sprite`|Sprite you wish for Vram Doctor to track.|

Adds the sprite to Vram Doctor to track vram usage.

### `VramDoctorAddSurface(surface)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`surface`|`surface`|Surface you wish for Vram Doctor to track.|

Adds the surface to Vram Doctor to track vram usage.

### `VramDoctorAddVertexBuffer(vertexBuffer)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`vertexBuffer`|`Vertex buffer`|Vertex buffer you wish for Vram Doctor to track.|

Adds the vertex buffer to Vram Doctor to track vram usage.

### `VramDoctorRemoveVertexBuffer(vertexBuffer)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`vertexBuffer`|`Vertex buffer`|Vertex buffer you wish for Vram Doctor to remove.|

Remove the vertex buffer from Vram Doctor.

!> While Vram Doctor does have a way of removing vertex buffers automatically, this was added in place as the way Vram Doctor determines if a vertex buffer is freed is through try/catch. And catching as of GameMaker Runtime v2024.4.0.168 isn't *fast*.