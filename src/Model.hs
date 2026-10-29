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
    } deriving (Eq, Show)

-- Um quadro é uma lista de tarefas
type Quadro = [Tarefa]

-- Árvore que representa uma tarefa e as suas dependências
data ArvoreDeps = No Tarefa [ArvoreDeps]
    deriving (Eq, Show)
