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
dependenciasTransitivas = undefined

temCiclo :: Quadro -> Bool
temCiclo = undefined

construirArvore :: TarefaId -> Quadro -> Maybe ArvoreDeps
construirArvore = undefined

profundidade :: ArvoreDeps -> Int
profundidade = undefined
