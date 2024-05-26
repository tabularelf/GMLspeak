# GMLspeak
 A GML parser/lexer addon for [Catspeak](https://github.com/katsaii/catspeak-lang)! (**Experimental currently!!!**)

# Supported Features
- For loops
- Repeat loops
- Comment blocks (every developers favourite `/* Secret little message */`)
- Almost every single constant and dynamic constant GML has to offer (including `global`).

# To be added
- do/until loops
- Switch/case (as oppose to match/case)
- Unlimited non-named Arguments ([Core Catspeak addition](https://github.com/katsaii/catspeak-lang/issues/52))
- Self/other support (ideally as arguments, user controllable)
- with ([Core Catspeak addition](https://github.com/katsaii/catspeak-lang/issues/22))
- method() support (I have a way of making this work in Catspeak, without also accidentally allowing defining numbers as functions. But requires the previous two to be resolved.)

# Will probably never be added
- Macros (Doable, but complicates any and all code caches, so won't be a core feature of GMLspeak. I may leave a note on how to achieve it.)
- Adding all GML functions (I'm happy to provide constants, but not GML functions. You can expose those yourself.)
- Static variables (Very complicated, not dealing with that)
- Global Catspeak functions (Doable but requires a whole separate system for checking every single GML string before passing to GMLspeak, compiling them in order of first usage, and then compiling the rest. Probably best for a separate library that utilises GMLspeak + Catspeak as a dependency)
- Enums (would be nice, complicated to support. Similar issue with global Catspeak functions)
- Rollback constants (Beta only anyway, so why?)

## Notes:
This does support a majority of constants, between LTS to latest. Ensuring that regardless of the version use, you will have most of them.
