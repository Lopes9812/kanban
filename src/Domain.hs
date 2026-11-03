module Domain where

import Model

-- Pessoa C: pesquisa, inserção, remoção e consultas, primeira ja fiz eu
procurarTarefa :: TarefaId -> Quadro -> Maybe Tarefa
procurarTarefa _ []= Nothing
procurarTarefa procurado (t:ts)
 |tarefaId t== procurado = Just t
 |otherwise=procurarTarefa procurado ts


adicionarTarefa :: Tarefa -> Quadro -> Either String Quadro
adicionarTarefa = undefined

removerTarefa :: TarefaId -> Quadro -> Quadro
removerTarefa = undefined

tarefasPorEstado :: Estado -> Quadro -> [Tarefa]
tarefasPorEstado = undefined

dependenciasDiretas :: TarefaId -> Quadro -> [TarefaId]
dependenciasDiretas = undefined

contarPorEstado :: Estado -> Quadro -> Int
contarPorEstado = undefined

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
construirArvore = undefined

profundidade :: ArvoreDeps -> Int
profundidade = undefined
