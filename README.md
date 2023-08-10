# Oxbow

Navigate Meandering Callflow Graphs from within Neovim.
Named after [Oxbow lakes](https://en.wikipedia.org/wiki/Oxbow_lake) which are formed by meandering streams.

## Short Term Goals

- [x] Add a basic lua function to call cflow from Neovim
- [x] Add a script to translate cflow output into a Mermaid diagram.
- [x] Call cflow with the function under the cursor as the "main" function
- [x] Allow the user to select a "target" function to end the callgraph at

## Long Term Goals

- [ ] Use the LSP server to generate the callgraph instead of cflow (generalize to other languages).
- [ ] Use treesitter to make it easier to get the currently selected function
- [ ] Use the output to generate a live-updating graph of caller-callee relationships for the current function (i.e. SourceInsight/Obsidian)
