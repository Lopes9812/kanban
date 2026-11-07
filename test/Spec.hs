module Main where

import Domain
import Model
import Sample
import Data.List (sort)

testeProcurarTarefa ::String
testeProcurarTarefa =
    let res1=
            case procurarTarefa 1 quadroExemplo of
                Just tarefa
                    | tarefaId tarefa == 1 -> "sucesso"
                    | otherwise-> "falhou: foi encontrada tarefa com ID errado. "
                Nothing ->  "falhou (Tarefa com ID 1 não encontrada)"
        res2=
            case procurarTarefa (-1) quadroExemplo of
                Just tarefa -> "falhou: encontrou tarefa que não deveria de existir."
                Nothing -> "sucesso"
    in "Procurar tarefa existente: "++ res1
        ++ "\nProcurar tarefa inexistente: "++ res2

testeAdicionarTarefa :: String
testeAdicionarTarefa =
    let res1 =
            case adicionarTarefa tarefa7 quadroExemplo of
                Left _  -> "Falhou"
                Right _ -> "Sucesso"

        res2 =
            case adicionarTarefa tarefa1 quadroExemplo of
                Left _  -> "Sucesso"
                Right _ -> "Falhou: adicionou uma tarefa com ID duplicado"

    in "Adicionar tarefa nova: " ++ res1
       ++ "\nAdicionar tarefa duplicada: " ++ res2

testeRemoverTarefa :: String
testeRemoverTarefa=
    let res1 =
            case removerTarefa 6 quadroExemplo of
                Left _  -> "Falhou"
                Right _ -> "Sucesso"

        res2 =
            case removerTarefa (-1) quadroExemplo of
                Left _  -> "sucesso"
                Right _ -> "Falhou"

    in "Remover tarefa existente: " ++ res1
       ++ "\nRemover tarefa nao existente: " ++ res2

testeEstados :: String
testeEstados =
    let res1 =
            if contarPorEstado Todo quadroExemplo == 2
                then "Sucesso"
                else "Falhou: contagem de Todo incorreta"

        res2 =
            if contarPorEstado Doing quadroExemplo == 2
                then "Sucesso"
                else "Falhou: contagem de Doing incorreta"

    in "Contar tarefas Todo: " ++ res1
       ++ "\nContar tarefas Doing: " ++ res2

testeDependencias :: String
testeDependencias =
    let res1 =
            if sort (dependenciasDiretas 4 quadroExemplo) == [3]
                then "Sucesso"
                else "Falhou"
        res2 =
            if sort (dependenciasTransitivas 6 quadroExemplo) == [1, 2, 3, 4, 5]
                then "Sucesso"
                else "Falhou"
    in "Dependências diretas: " ++ res1
       ++ "\nDependências transitivas: " ++ res2

testeciclos:: String
testeciclos=
    let res1=
            if (temCiclo quadrocomciclo)==True
                then "sucesso"
                else "erro: não detetou ciclo"
        res2=
            if (temCiclo quadroExemplo)== False
                then "sucesso"
                else "erro: detetou ciclo inexistente"
    in"Deteção de ciclo existente: " ++ res1
       ++ "\ndeteção de ciclo inexistente: " ++ res2

testeConstruirArvore :: String
testeConstruirArvore =
    let res1=
        case construirArvore 4 quadroExemplo of
            Just arvore ->
                if arvore == arvoreEsperada
                    then "Sucesso: árvore correta"
                    else "Falhou: árvore diferente da esperada"

            Nothing -> "Falhou: não conseguiu construir a árvore"
        res2=
            case construirArvore 10 quadrocomciclo of
                Just arvore->"erro: criou arvore com dependencias circulares"
                Nothing-> "sucesso"
    in"criação de ciclo: " ++ res1
       ++ "\ncriação de ciclo ilegal: " ++ res2

main :: IO ()
main = do
    putStrLn "A executar testes..."
    putStrLn testeProcurarTarefa
    putStrLn testeAdicionarTarefa
    putStrLn testeRemoverTarefa
    putStrLn testeEstados
    putStrLn testeDependencias
    putStrLn testeciclos