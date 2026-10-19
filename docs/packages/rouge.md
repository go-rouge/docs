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

23 lexers. Each is a transcription of the reference `rouge` 5.0.0 gem's own
lexer source, and each is validated **byte-for-byte** against HTML produced by
that gem: every corpus file in `testdata/` is highlighted by both and the
output compared exactly.

| Language | Tags |
|---|---|
| C | `c` |
| C++ | `cpp`, `c++` |
| COBOL | `cobol` |
| CSS | `css` |
| diff | `diff`, `patch`, `udiff` |
| Fortran | `fortran` |
| Go | `go`, `golang` |
| Hashicorp Configuration Language | `hcl` |
| HTML | `html` |
| Java | `java` |
| JavaScript | `javascript`, `js` |
| JSON | `json` |
| Markdown | `markdown`, `md`, `mkd` |
| PHP | `php`, `php3`, `php4`, `php5` |
| Plain Text | `plaintext`, `text` |
| Python | `python`, `py` |
| Ruby | `ruby`, `rb` |
| Rust | `rust`, `rs` (+ the six rust-skeptic aliases) |
| shell | `shell`, `bash`, `zsh`, `ksh`, `sh` |
| SQL | `sql` |
| Terraform | `terraform`, `tf` |
| TeX | `latex`, `tex`, `TeX`, `LaTeX` |
| YAML | `yaml`, `yml` |

!!! note "Where a lexer is not byte-identical, the module says so"
    The README carries a **documented simplifications** section listing every
    deviation from the gem and the measurement behind it — for example that
    the gem's `^` and lookbehind assertions do not constrain where it evaluates
    them, so three rules drop them; and that HCL's here-document rule is not
    transcribed because the gem's own rule ordering makes it unreachable.
    Nothing is left to be discovered by surprise.

## Links

- Source: <https://github.com/go-rouge/rouge>
- API reference: <https://pkg.go.dev/github.com/go-rouge/rouge>

!!! note
    See the module's README for full, up-to-date details.
