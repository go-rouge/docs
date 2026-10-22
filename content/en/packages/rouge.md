---
title: "rouge"
weight: 10
---

# rouge

Rouge/Pygments-class lexers that tokenize source and emit highlighted HTML.

## Install

```bash
go get github.com/go-rouge/rouge
```

Requires Go 1.26.4 or newer. `CGO_ENABLED=0`.

## Use

```go
import "github.com/go-rouge/rouge"

html, err := rouge.Highlight(`puts "hello"`, "ruby", "html")
// => <span class="nb">puts</span> <span class="s2">"hello"</span>

lex := rouge.FindLexer("rb")        // by tag or alias, case-insensitive
lex = rouge.Guess(src)              // content sniff; never nil (PlainText fallback)
toks := lex.Lex(src)                // []TokenValue{Token, Value}
page := rouge.WrapHTML(rouge.HTMLFormatter{}.Format(toks))
```

The CSS short-codes are the gem's own (`k`, `s`, `c`, `nf`, …), so any
stylesheet written for Ruby `rouge` — or for Pygments — styles this output
unchanged.

## Languages

31 lexers, as of **v0.7.0**. Each is a transcription of the reference `rouge`
5.0.0 gem's own lexer source, and each is validated **byte-for-byte** against
HTML produced by that gem: every corpus file in `testdata/` is highlighted by
both and the output compared exactly.

| Language | Tags |
|---|---|
| C | `c` |
| C++ | `cpp`, `c++` |
| COBOL | `cobol` |
| CSS | `css` |
| diff | `diff`, `patch`, `udiff` |
| Docker | `docker`, `dockerfile`, `Dockerfile`, `containerfile`, `Containerfile` |
| Fortran | `fortran` |
| Go | `go`, `golang` |
| Hashicorp Configuration Language | `hcl` |
| HTML | `html` |
| Java | `java` |
| JavaScript | `javascript`, `js` |
| JSON | `json` |
| JSX | `jsx`, `react` |
| Make | `make`, `makefile`, `mf`, `gnumake`, `bsdmake` |
| Markdown | `markdown`, `md`, `mkd` |
| PHP | `php`, `php3`, `php4`, `php5` |
| Plain Text | `plaintext`, `text` |
| Protobuf | `protobuf`, `proto` |
| Python | `python`, `py` |
| Ruby | `ruby`, `rb` |
| Rust | `rust`, `rs` (+ the six rust-skeptic aliases) |
| shell | `shell`, `bash`, `zsh`, `ksh`, `sh` |
| SQL | `sql` |
| Terraform | `terraform`, `tf` |
| TeX | `latex`, `tex`, `TeX`, `LaTeX` |
| TOML | `toml` |
| TSX | `tsx` |
| TypeScript | `typescript`, `ts` |
| XML | `xml` |
| YAML | `yaml`, `yml` |

The XML lexer is also the **SVG** lexer, as it is in the gem: it claims `*.svg`
and `*.plist` along with `*.xml`, `*.xsl`, `*.xsd`, `*.wsdl` and `*.rss`.

Where the gem writes a lexer as a subclass, so does this port. TypeScript, JSX
and TSX share one JavaScript machine, and C++ shares C's, so a rule added to
the parent is a rule the children get rather than a copy that drifts.

{{< callout type="info" >}}
**Where a lexer is not byte-identical, the module says so**

The README carries a **documented simplifications** section listing every
deviation from the gem and the measurement behind it — for example that the
gem's `^` and lookbehind assertions do not constrain where it evaluates them,
so COBOL, Fortran and TypeScript rules drop them; and that HCL's here-document
rule and Make's `:shell` function rule are not reachable in the gem itself, so
they are recorded rather than quietly "fixed". Nothing is left to be discovered
by surprise.
{{< /callout >}}

## Safety

A lexer is a parser fed untrusted input, so the module treats it as one.

- **Every lexer is fuzzed** — all 31, enforced by a test that reads the lexer
  registry and fails on one that is registered but not fuzzed. The invariant is
  the one that holds whatever the input: lexing **accounts for every byte** —
  none dropped, which would delete source from a rendered page, and none
  invented, which would be an injection.
- **Lexing is linear in the input for 28 of the 31 lexers**, including against
  inputs built to defeat the lazy quantifiers the gem's rules use: unterminated
  comments, strings, tags, macros and template literals. Measured at 1k/2k/4k
  bytes, where linear is 2x per doubling and 4x is quadratic.
- **Coverage is 100%**, with zero uncovered blocks rather than a rounded total.

{{< callout type="warning" >}}
**C, C++ and Java are quadratic on an unterminated block comment**

32 KiB of `/*` with no closing `*/` takes about 26 seconds
([#17](https://github.com/go-rouge/rouge/issues/17)). The C-family
function-signature rule scans forward for a `{` or `;` that never arrives, and
the lexer retries it at every scan position — O(n) attempts of O(n) work. The
rule is transcribed from the gem, so the behaviour is inherited rather than
introduced, but it is a denial of service on exactly the untrusted input this
library exists to highlight. **Do not highlight untrusted C, C++ or Java
without a size limit or a timeout** until that issue is closed.

This page previously said lexing was linear across the board, with the worst
doubling ratio at 2.36x. Nothing measured it; when the measurement was written,
three of thirty-one lexers turned out to be quadratic.
{{< /callout >}}

## Links

- Source: <https://github.com/go-rouge/rouge>
- API reference: <https://pkg.go.dev/github.com/go-rouge/rouge>

{{< callout >}}
See the module's README for full, up-to-date details.
{{< /callout >}}
