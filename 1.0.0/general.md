### `gmlspeak_method(scope, function)`

Returns: `method`

|Name|Datatype|Purpose|
|---|---|---|
|`scope`|`Instance or struct`|Scope you wish to bind|
|`function`|`function or method`|Function or method you wish to bind with|

Returns a method that respects GMLspeak methods.

### `is_gmlspeak(value)`

Returns: `bool`

|Name|Datatype|Purpose|
|---|---|---|
|`value`|`Any`|Value to check if it's a valid GMLspeak program/function or not|

Returns whether it is a valid GMLspeak program/function/method, or not.

### `gmlspeak_self()`

Returns: `Current self`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current self being used for GMLspeak. In cases where the current self needs to be referred to.

### `gmlspeak_other()`

Returns: `Current other`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Returns the current other being used for GMLspeak. In cases where the current other needs to be referred to.

### `gmlspeak_push_scope(scope)`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`scope`|`Instance or struct`|Scope you wish to push|

Pushes the current self in GMLspeak to GMLspeak `other` and sets the current new self scope.

### `gmlspeak_pop_scope()`

Returns: `N/A`

|Name|Datatype|Purpose|
|---|---|---|
|`N/A`|||

Reverts back to the previous scopes for self and other for GMLspeak.