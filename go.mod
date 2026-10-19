module github.com/go-rouge/docs

go 1.27.2

require github.com/imfing/hextra v0.13.0

// ⛔ The theme is OUR FORK, not upstream. It keeps upstream's module path, so
// it is reached through a replace rather than by importing a different path --
// and it is tagged independently and ahead: v0.16.0 against upstream's v0.13.0.
//
// The pattern comes from go-pdfkit/docs, the first repository in the fleet to
// consume it. The CI prints the resolved module graph, so a build that
// silently fell back to upstream shows up in the log rather than in the
// rendering.
replace github.com/imfing/hextra => github.com/tannevaled/hextra v0.16.0
