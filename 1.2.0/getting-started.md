# Getting Started

## Installing
1. Download GMLspeak's .yymps from [releases!](https://github.com/tabularelf/GMLspeak/releases)
2. With your GameMaker Project, drag the .yymps (or at the top go to Tools -> Import Local Package)
3. Press "Add All" and press "Import". (Unles you are using a different version of Catspeak that GMLspeak provides for you. As of writing, it uses Catspeak v3.2.0)

## Updating to a new version

1. Delete GMLspeak's folder (with all scripts inside.)
2. Follow the steps through [Installing](#installing), but with the latest version.

## Coming from GML

As GMLspeak is an addon of [Catspeak](https://www.katsaii.com/catspeak-lang/), there is some specific differences between GML and Catspeak. And while GMLspeak aims to maintain a majority of compatibility, it does offer some slight differences. The following is noted.

### All variables not defined will just return undefined.
Catspeak will return all values as is, even ones that aren't set.
So if you have a piece of code that does this
```gml
show_debug_message(name);
```
And `name` is not set, it will return `undefined`.

!> If you wish to instead throw an exception on variables that don't exist, there is a [compile flag](gmlspeakenvironment.md?id=compile-flags) for this.

## Using GMLspeak
GMLspeak supports a majority of GML-like syntax and behaviours. The following you can use:
- switch/case (including fallthrough cases and default)
- for loops
- do until loops
- repeat loops
- while loops
- exit (similar to `return;`)
- nullish coalescence `value ?? false`/`value ??= buffer_create(1, buffer_grow, 1)` 
- tenary operator `value > 4 ? true : false;`
- `with(scope)` support
- Automatic methodizing of functions on creation.
- Comment blocks `/* Secret little message */`
- Almost every single GML constant, up to 2024.8
- Support for `global` variables (which includes a custom `global` struct to separate from native GM global)
- `try/catch` (no `finally` at this time)

GMLspeak will not support the following:
- Defining Macros via code (Requires preprocessor implementation by end user. Exposing constants is however supported)
- Defining Enums via code (Requires preprocessor implementation by end user. Exposing constants is however supported. (Enums will need to be exposed as a struct, soft limitation))
- Static Variables 

## Compiling your first GMLspeak program
Anything not covered here in terms of use case, should be referred to [Catspeaks documentation](https://www.katsaii.com/catspeak-lang/3.2.0/hom-welcome.html) instead.

To start using GMLspeak, the first thing you need to do is create the environment itself. GMLspeak doesn't do this automatically, so you will need to specify it.
```gml
global.GMLspeak = new GMLspeakEnvironment();
```
This will initialize everything to do with GMLspeak for you. From the functions that it does use, to most of GML constants. As well as attempting to initiliaze any that aren't apart of LTS. (all the way up to 2024.6 as of writing)
As GMLspeak exposes no functions for you, we'll need to expose them.
We can use `environment.exposeFunction(name, function_method, ...)` to expose multiple functions. For now we'll just expose `show_debug_message`.

```gml
global.GMLspeak.exposeFunction("show_debug_message", show_debug_message);
```

The next step is to parse some code. Catspeak has two approaches to it. 
1. Buffer approach (used with loading from files) `environment.parse(buffer, offset, size)`
2. Parsing a string `environment.parseString(str)`

For the sake of this getting started guide, I'll just write down a simple code example and use `.parseString(str)`
```gml
var codeString = @'
	show_debug_message("Hello world!")
';
```
Now that we have our code, we can now parse this.
```gml
var ast = global.GMLspeak.parseString(codeString);
```
The parser functions return a struct that represents an abstract syntax tree. Abstract syntax trees (short for AST) is effectively a structure of how the compiled program is executed. You can save this struct to a file at any time for caching, uploading over the internet, etc. and be loaded back in.
This same struct is also used to compile all GMLspeak programs (and by extension, Catspeak). We can compile our code using `environment.compileGML(ast)`
```gml
program = global.gmlSpeak.compileGML(ast);
```
Now that our program is compiled and ran successfully, we can move onto the next step. Executing it!
We can execute any programs directly.
```gml
program();
```
Now we should get this in the output window
```
Hello world!
```
Congratulations! You've made your first program in GMLspeak!

Final note. 

This will actually execute from the `global` scope, but we may not want to do that. Fortunately, Catspeak offers a way of switching the self scope!
```gml
catspeak_execute(program);
// Or
catspeak_execute_ext(program, some_scope);
```