# GMLspeak v1.1.1
 A GML parser/lexer addon for [Catspeak](https://github.com/katsaii/catspeak-lang)! (**Experimental currently!!!**)

# Supported Features
- For loops
- Repeat loops
- Comment blocks (every developers favourite `/* Secret little message */`)
- Almost every single constant and dynamic constant GML has to offer (including custom `global`).
- custom self/other scope system. (head programs require passing self/other scope as arguments)
- with() support (via Catspeak)
- do/until loops
- automatic methodizing of functions (respects the caller scope)
- Switch/case (as oppose to match/case)
- Nullish coalescing operator `valueA ?? valueB` and tenary operator `value == otherValue ? valueA : valueB` support
- Unlimited non-named Arguments (via Catspeak)
- Accessors
- The ability to allow writing to specific IO/room properties

# To be added
- methods with "global" scope self assign as "undefined" instead.
  
# Will probably never be added
- Macros (Doable, but complicates any and all code caches, so won't be a core feature of GMLspeak. I may leave a note on how to achieve it.)
- Adding all GML functions (I'm happy to provide constants, but not GML functions. You can expose those yourself.)
- Static variables (Very complicated, not dealing with that)
- Global Catspeak functions (Doable but requires a whole separate system for checking every single GML string before passing to GMLspeak, compiling them in order of first usage, and then compiling the rest. Probably best for a separate library that utilises GMLspeak + Catspeak as a dependency)
- Enums (would be nice, complicated to support. Similar issue with global Catspeak functions)
- Rollback constants (Beta only anyway, so why?)

## Notes:
This does support a majority of constants, between LTS to latest. Ensuring that regardless of the version use, you will have most of them.
