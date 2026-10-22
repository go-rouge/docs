---
title: "Overview"
weight: 10
---

# go-rouge documentation

**Pure-Go syntax highlighting.** A family of language lexers that tokenize
source and emit highlighted HTML, in the Rouge/Pygments tradition — with
`CGO_ENABLED=0`, no Ruby runtime, and a build for `GOOS=js/wasm`, so all of it
runs in a browser tab.

The CSS short-codes are the gem's own (`k`, `s`, `c`, `nf`, …), so any
stylesheet written for Ruby [`rouge`](https://github.com/rouge-ruby/rouge) —
or for Pygments — styles this output unchanged.

{{< callout type="info" >}}
**Validated against the reference gem, byte for byte**

Every lexer is a transcription of the reference `rouge` 5.0.0 gem's own lexer
source, and every corpus file in the module's `testdata/` is highlighted by
**both** implementations and compared **exactly**. Where a lexer cannot be
byte-identical, the module's README names the deviation and the measurement
behind it rather than leaving it to be discovered.
{{< /callout >}}

## Packages

{{< cards >}}
  {{< card link="packages/rouge/" title="rouge" subtitle="Rouge/Pygments-class lexers that tokenize source and emit highlighted HTML — 31 languages." >}}
{{< /cards >}}

Everything here is **pure Go** (`CGO_ENABLED=0`), standard-library-first, and
cross-compiles to every 64-bit Go target. Licensed BSD-3-Clause.
