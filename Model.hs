module Model where

-- Identificador único de uma tarefa
type TarefaId = Int

-- Estado atual de uma tarefa no quadro Kanban
data Estado = Todo | Doing | Done
    deriving (Eq, Show)

-- Prioridade de uma tarefa
data Prioridade = Baixa | Media | Alta
    deriving (Eq, Ord, Show)

-- Dados que descrevem uma tarefa
data Tarefa = Tarefa
    { tarefaId     :: TarefaId
    , titulo       :: String
    , estado       :: Estado
    , prioridade   :: Prioridade
    , prazo        :: Maybe String
    , dependencias :: [TarefaId]
    } deriving (Eq)
instance Show Tarefa where
    show t =
        "Tarefa #" ++ show (tarefaId t) ++
        "\n  Titulo: " ++ titulo t ++
        "\n  Estado: " ++ show (estado t) ++
        "\n  Prioridade: " ++ show (prioridade t) ++
        "\n  Prazo: " ++ mostrarPrazo (prazo t) ++
        "\n  Dependencias: " ++ mostrarDependencias (dependencias t)

mostrarPrazo:: Maybe String-> String
mostrarPrazo Nothing ="Não definido"
mostrarPrazo (Just prazo)=prazo

mostrarDependencias:: [TarefaId]->String
mostrarDependencias [] = "nenhuma"
mostrarDependencias ids =show ids

-- Um quadro é uma lista de tarefas
type Quadro = [Tarefa]

-- Árvore que representa uma tarefa e as suas dependências
data ArvoreDeps = No Tarefa [ArvoreDeps]
    deriving (Eq, Show)
