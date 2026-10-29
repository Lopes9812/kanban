## Descrição
Gestor Kanban com dependências entre tarefas, desenvolvido em Haskell
para a UC de Programação Funcional (UTAD). Permite modelar tarefas com estado, prioridade, prazo e dependências, e validar a consistência do quadro (por exemplo, detetar ciclos).

## Estado atual (Fase 1)

- Modelo de dados: `Estado`, `Prioridade`, `Tarefa`, `Quadro`, `ArvoreDeps`
- Funções de pesquisa, inserção e remoção de tarefas
- Dependências diretas e transitivas
- Deteção de ciclos
- Construção da árvore de dependências

## Requisitos

- GHC

## Compilar e executar

A partir da pasta raiz do projeto:


ghc -isrc app/Main.hs -o haskban
./haskban


Em Windows, o executável é `haskban.exe`.

Em alternativa, sem gerar executável:

```
runghc -isrc app/Main.hs
```

## Estrutura do projeto

```
haskban/
├── app/Main.hs       -- demonstração
├── src/
│   ├── Model.hs      -- tipos de dados
│   ├── Domain.hs     -- funções puras do domínio
│   └── Sample.hs     -- dados de exemplo
├── test/Spec.hs      -- testes
└── README.md
