## Descrição
Gestor Kanban com dependências entre tarefas, desenvolvido em Haskell
para a UC de Programação Funcional (UTAD). Permite modelar tarefas com estado,
prioridade, prazo e dependências, e validar a consistência do quadro (por exemplo,
detetar ciclos).

## Estado atual (Fase 1)

- Modelo de dados: `Estado`, `Prioridade`, `Tarefa`, `Quadro`, `ArvoreDeps`
- Funções de pesquisa, inserção e remoção de tarefas
- Dependências diretas e transitivas
- Deteção de ciclos
- Construção da árvore de dependências

## Requisitos

- GHC (Glasgow Haskell Compiler)

## Compilar e executar a demonstração

A partir da pasta raiz do projeto:

```powershell
ghc -isrc app/Main.hs -o haskban
.\haskban.exe
```

Também é possível executar diretamente, sem criar um executável:

```powershell
runghc -isrc app/Main.hs
```

## Executar os testes

Para executar os testes diretamente:

```powershell
runghc -isrc test/Spec.hs
```

Em alternativa, para compilar os testes e executar o programa gerado:

```powershell
ghc -isrc test/Spec.hs -o testes
.\testes.exe
```

## Estrutura do projeto

```text
haskban/
├── app/Main.hs       -- demonstração das funções do domínio
├── src/
│   ├── Model.hs      -- tipos de dados
│   ├── Domain.hs     -- funções puras do domínio
│   └── Sample.hs     -- dados de exemplo
├── test/Spec.hs      -- testes
└── README.md
```
