# GMLspeak v1.0.0
 A GML parser/lexer addon for [Catspeak](https://github.com/katsaii/catspeak-lang)! (**Experimental currently!!!**)

# Supported Features
- For loops
- Repeat loops
- Comment blocks (every developers favourite `/* Secret little message */`)
- Almost every single constant and dynamic constant GML has to offer (including custom `global`, sith a toggle to fully expose global).
- custom self/other scope system. (head programs require passing self/other scope as arguments)
- with() support (one scope at a time currently, works with `break` due to a hackaround)
- do/until loops
- automatic methodizing
- Switch/case (as oppose to match/case)
- Nullish coalescing operator `valueA ?? valueB` and tenary operator `value == otherValue ? valueA : valueB` support

# To be added
- with support for objects.
- with support for break/continue/return. ([Core Catspeak addition](https://github.com/katsaii/catspeak-lang/issues/118))
- methods with "global" scope self assign as "undefined" instead.
- Unlimited non-named Arguments ([Core Catspeak addition](https://github.com/katsaii/catspeak-lang/issues/52))
  
# Will probably never be added
- Macros (Doable, but complicates any and all code caches, so won't be a core feature of GMLspeak. I may leave a note on how to achieve it.)
- Adding all GML functions (I'm happy to provide constants, but not GML functions. You can expose those yourself.)
- Static variables (Very complicated, not dealing with that)
- Global Catspeak functions (Doable but requires a whole separate system for checking every single GML string before passing to GMLspeak, compiling them in order of first usage, and then compiling the rest. Probably best for a separate library that utilises GMLspeak + Catspeak as a dependency)
- Enums (would be nice, complicated to support. Similar issue with global Catspeak functions)
- Rollback constants (Beta only anyway, so why?)

## Notes:
This does support a majority of constants, between LTS to latest. Ensuring that regardless of the version use, you will have most of them.
