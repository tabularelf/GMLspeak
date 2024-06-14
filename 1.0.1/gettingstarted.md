# Getting Started

## Installing
1. Download Vram Doctor's .yymps from [releases!](https://github.com/tabularelf/VramDoctor/releases)
2. With your GameMaker Project, drag the .yymps (or at the top go to Tools -> Import Local Package)
3. Press "Add All" and press "Import".

## Updating to a new version

1. Delete Vram Doctor's folder (with all scripts inside.)
2. Follow the steps through [Installing](#installing), but with the latest version.

## Using Vram Doctor

Vram Doctor automatically ticks in the background by default. There is almost no manual manage needed. As `__VramDoctorMacroAssist` provides a bunch of replacement macros for built in functionality.

If for any reason you prefer to manually manage memory, you can remove `__VramDoctorMacroAssist` and manually assign entries as per [Memory Management](memory-management.md).

Otherwise, you may use the many `VramDoctorGet*Size()` functions to retrieve the total amount of size.

All of the sizes are returned in bytes, so if you wish to be represented as bytes, kilobytes, megabytes or gigabytes, you'll need to convert them. Here's an example function you can use along side.

```gml
function ByteFormat_num() {
	static _nums = [
		"B",
		"KB",
		"MB",
		"GB"
	];
	var _i = 0;
	while(_num > 1000) {
		_num /= 1000;
		++_i;
	}
	
	return string(_num) + _nums[_i];
}
```

Which can be used as
```gml
draw_text(8, 8, ByteFormat(VramDoctorGetTotalSize()));
```