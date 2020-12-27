# Intcode compiler

Compiles (a subset of) Ruby code into intcode. Built in case there was a task (turns out there was not) that would require writing intcode.

Use `rake compile` up the directory to use compiler.

Files:
- compiler.rb is top level file calling other classes.
- ir.rb walks the tree created by [parser gem](https://rubygems.org/gems/parser) and converts to node AST.
- code_generator.rb takes AST and generates intcode.

Supported:
- Variables: bool, int, string, array of bool/int/string
- Math: `+ - * > < ==`
- Control structures: if/else, while/break/next, case/when/else
- Functions: recursion is supported
- IO: print/read

See `samples/` for examples that are supported.