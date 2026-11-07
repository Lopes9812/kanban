# Kanban Task Manager

A Kanban task manager with task dependencies, developed in Haskell for the Functional Programming course at UTAD. It models tasks with a status, priority, deadline, and dependencies, and checks board consistency (for example, by detecting dependency cycles).

## Current status (Phase 1)

- Data model: `Status`, `Priority`, `Task`, `Board`, `DependencyTree`
- Task search, addition, and removal
- Direct and transitive dependencies
- Cycle detection
- Dependency tree construction
- Sample data and initial tests

## Requirements

- GHC (Glasgow Haskell Compiler)

## Compile and run the demonstration

From the project root directory:

```powershell
ghc -isrc app/Main.hs -o haskban
.\haskban.exe
```

You can also run the program directly without creating an executable:

```powershell
runghc -isrc app/Main.hs
```

## Run the tests

Run the tests directly:

```powershell
runghc -isrc test/Spec.hs
```

Alternatively, compile the tests and run the generated executable:

```powershell
ghc -isrc test/Spec.hs -o tests
.\tests.exe
```

## Project structure

```text
haskban/
├── app/Main.hs       -- demonstration program
├── src/
│   ├── Model.hs      -- data types
│   ├── Domain.hs     -- pure domain functions
│   └── Sample.hs     -- sample data
├── test/Spec.hs      -- tests
└── README.md
```
