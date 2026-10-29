module Main where

import Model

tarefa0:: Tarefa
tarefa0 = Tarefa
        {tarefaId= 1
        ,titulo="fazer pesquisa"
        , estado=Todo
        , prioridade=Media
        , prazo=Nothing
        , dependencias=[]
    }
tarefa1:: Tarefa
tarefa1 = Tarefa
        {tarefaId= 2
        ,titulo="tratar pesquisa"
        , estado=Todo
        , prioridade=Media
        , prazo=Nothing
        , dependencias=[1]
    }
main :: IO ()
main = do
    putStrLn "Gestor Kanban com Dependencias"
    putStrLn "Projeto de Programacao Funcional em Haskell"
    print tarefa0
    print tarefa1
