module Main where

import Model
import Domain
import Sample

main :: IO ()
main = do
    putStrLn "Gestor Kanban com Dependencias"
    putStrLn "Projeto de Programacao Funcional em Haskell"
    putStrLn ""

    putStrLn "Tarefas em andamento:"
    mapM_ print (tarefasPorEstado Doing quadroExemplo)

    putStrLn ""
    putStrLn "Pesquisa da tarefa com ID 6:"
    print (procurarTarefa 6 quadroExemplo)

    putStrLn ""
    putStrLn "Dependencias transitivas da tarefa com ID 6:"
    print (dependenciasTransitivas 6 quadroExemplo)

    putStrLn ""
    putStrLn "O quadro de exemplo tem ciclos?"
    print (temCiclo quadroExemplo)
