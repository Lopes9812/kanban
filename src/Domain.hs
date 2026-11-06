module Domain where

import Model

-- Pessoa C: pesquisa, inserção, remoção e consultas, primeira ja fiz eu
procurarTarefa :: TarefaId -> Quadro -> Maybe Tarefa
procurarTarefa _ []= Nothing
procurarTarefa procurado (t:ts)
 |tarefaId t== procurado = Just t
 |otherwise=procurarTarefa procurado ts


adicionarTarefa :: Tarefa -> Quadro -> Either String Quadro
adicionarTarefa t quadro =
    case procurarTarefa (tarefaId t) quadro of
        Just _  -> Left ("Já existe uma tarefa com o id " ++ show (tarefaId t))
        Nothing -> Right (quadro ++ [t])

removerTarefa :: TarefaId -> Quadro -> Quadro
removerTarefa _ [] = []
removerTarefa id (t:ts)
    | tarefaId t == id = ts
    | otherwise        = t : removerTarefa id ts

tarefasPorEstado :: Estado -> Quadro -> [Tarefa]
tarefasPorEstado e quadro = filter (\t -> estado t == e) quadro

dependenciasDiretas :: TarefaId -> Quadro -> [TarefaId]
dependenciasDiretas id quadro =
    case procurarTarefa id quadro of
        Nothing -> []
        Just t  -> dependencias t

contarPorEstado :: Estado -> Quadro -> Int
contarPorEstado e quadro = length (tarefasPorEstado e quadro)

-- Pessoa B: análise das dependências
dependenciasTransitivas :: TarefaId -> Quadro -> [TarefaId]
dependenciasTransitivas id quadro =
    filter (/= id) (aux (dependenciasDiretas id quadro) [id] quadro)
    where
        aux :: [TarefaId] -> [TarefaId] -> Quadro -> [TarefaId]
        aux [] visitado _ = visitado
        aux (x:xs) visitado quadro
         | elem x visitado = aux xs visitado quadro
         |  otherwise = aux (xs ++ dependenciasDiretas x quadro) (x:visitado) quadro


temCiclo :: Quadro -> Bool
temCiclo quadro = verificarQuadro quadro quadro
    where
        verificarQuadro [] _ = False
        verificarQuadro (t:ts) quadro
            | aux (tarefaId t) [] quadro = True
            | otherwise = verificarQuadro ts quadro

        aux x caminho quadro
            | elem x caminho = True
            | otherwise = verificarDeps deps novoCaminho quadro
            where
                novoCaminho = x : caminho
                deps = dependenciasDiretas x quadro

        verificarDeps :: [TarefaId] -> [TarefaId] -> Quadro -> Bool
        verificarDeps [] _ _ = False
        verificarDeps (x:xs) caminho q
            | aux x caminho q = True
            | otherwise = verificarDeps xs caminho q


construirArvore :: TarefaId -> Quadro -> Maybe ArvoreDeps
construirArvore id quadro = aux id [] quadro
    where
        aux :: TarefaId -> [TarefaId] -> Quadro -> Maybe ArvoreDeps
        aux x caminho quadro
            | elem x caminho = Nothing          
            | otherwise =
                case procurarTarefa x quadro of
                    Nothing -> Nothing
                    Just tarefa ->
                        case construirFilhos (dependenciasDiretas x quadro) novoCaminho quadro of
                            Nothing -> Nothing
                            Just filhos -> Just (No tarefa filhos)
            where
                novoCaminho = x : caminho

        construirFilhos :: [TarefaId] -> [TarefaId] -> Quadro -> Maybe [ArvoreDeps]
        construirFilhos [] _ _ = Just []
        construirFilhos (x:xs) caminho quadro =
            case aux x caminho quadro of
                Nothing -> Nothing
                Just arvore ->
                    case construirFilhos xs caminho quadro of
                        Nothing -> Nothing
                        Just restantes -> Just (arvore : restantes)


profundidade :: ArvoreDeps -> Int
profundidade (No _ []) = 1
profundidade (No _ filhos) = 1 + maximum(map profundidade filhos)
