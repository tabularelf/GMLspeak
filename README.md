# GMLspeak
 A GML parser/lexer addon for Catspeak! (**Experimental currently!!!**)

# Supported Features
- For loops
- Repeat loops
- Almost every single constant and dynamic constant GML has to offer (including `global`).

# To be added
- do/until loops
- Switch/case (as oppose to match/case)
- Unlimited non-named Arguments ([Core Catspeak addition](https://github.com/katsaii/catspeak-lang/issues/52))
- Enums (would be nice)
- Self/other support (ideally as arguments, user controllable)
- with ([Core Catspeak addition](https://github.com/katsaii/catspeak-lang/issues/22))

# Will probably never be added
- Macros (Doable, but complicates any and all code caches, so won't be a core feature of GMLspeak. I may leave a note on how to achieve it.)
- Adding all GML functions (I'm happy to provide constants, but not GML functions. You can expose those yourself.)
- Static variables (Very complicated, not dealing with that)
- Global functions (Doable but requires a whole separate system for checking every single GML string, compiling them in order of first usage, and then compiling the rest. Probably best for a separate library that utilises GMLspeak + Catspeak as a dependency)
- Rollback constants (Beta only anyway, so why?)

## Notes:
This does support a majority of constants, between LTS to latest. Ensuring that regardless of the version use, you will have most of them.
