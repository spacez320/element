# Element

This is an infrastructure-as-code tool I'm working on to address common pitfalls in other mainstream projects.

1. It assumes that configuration management and bootstrapping are both just state management problems that can be combined into one software.
2. It manages state with actors (as in [the Actor Model](https://en.wikipedia.org/wiki/Actor_model)).
3. It prefers a simple API that covers less ground but is easier to use.

The idea is that infrastructure can be managed in specific ways that are currently a little difficult:

1. Updates are transparent and show the entirety of what will be affected by a state change.
2. Updates automatically propagate according to dependencies.
3. Updates are very fast.
4. State is immediately restored if changed out-of-band.

It is a hobby project and may not work as expected, or at all.
