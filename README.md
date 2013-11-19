## Phoenix

Fork of Zephyros that's scripted in [Beowulf](https://github.com/sdegutis/beowulf).

#### Status

Not ready for actual use just yet. Beowulf needs clojure.core ported first.

#### Rationale

Embedding a scripting language is much less complex than scripting
over TCP. This will let me add features faster.

Because Zephyros scripts over TCP, it can't accept return-values from
our functions. But embedded languages don't have this problem.

I chose Beowulf for the language because it's easy to embed, natural
to bridge with ObjC, and has simple semantics, consistent syntax,
macros, and lazy sequences.
