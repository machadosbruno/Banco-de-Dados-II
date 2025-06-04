/* BDAula04062025_3139786: */

create database BDAula04062025_3139786

use BDAula04062025_3139786

CREATE TABLE TBProfessor (
    CodProfessor int PRIMARY KEY,
    CodTitulacao int,
    Titulacao varchar(40)
);

CREATE TABLE TBAluno (
    CodAluno int PRIMARY KEY,
    NumeroSalaEstuda int,
    NumeroSerie int
);

CREATE TABLE TBUsuario (
    IDUsuario int PRIMARY KEY,
    NomeUsuario varchar(50),
    DataCadastro datetime,
    Telefone bigint,
    Email varchar(50),
    Endereco varchar(50),
    Numero int,
    Municipio varchar(40),
    UF varchar(2)
);

CREATE TABLE TBFuncionario (
    CodFuncionario int PRIMARY KEY,
    DataAdmissao date,
    Funcao varchar(40)
);

CREATE TABLE TBMaterial (
    IDMaterial int PRIMARY KEY,
    DescricaoMaterial varchar(50),
    Custo decimal(12,2),
    CodFuncionario int,
    DataCadastro datetime,
    Tipo int
);

CREATE TABLE TBEmprestimo (
    IDEmprestimo int PRIMARY KEY,
    DataEmprestimo datetime,
    DataPrevisaoDevolucao datetime,
    CodUsuario int,
    CodFuncionario int,
    TotalDiasEmprestimo int,
    Observacao varchar(100)
);

CREATE TABLE TBDVD (
    CodDVD int PRIMARY KEY,
    Titulo varchar(50),
    DataLancamento date,
    DescricaoDVD varchar(50),
    Assunto varchar(50),
    Produtora varchar(50),
    Autor varchar(50)
);

CREATE TABLE TBMaterialEmprestado (
    CodEmprestimo int,
    CodMaterial int,
    DataEmprestimo date,
    DataDevolucao date,
    Quantidade int,
    Observacao varchar(100),
    PRIMARY KEY (CodEmprestimo, CodMaterial)
);

CREATE TABLE TBDevolucaoMaterial (
    IDDevolucao int PRIMARY KEY,
    CodEmprestimo int,
    CodMaterial int,
    CodFuncionario int,
    DataDevolucao datetime,
    Observacao varchar(200),
    DiasAtraso int,
    ValorMulta decimal(12,2)
);

CREATE TABLE TBImpressao (
    CodImpressao int PRIMARY KEY,
    Titulo varchar(50),
    DataImpressao date,
    NomeEditora varchar(50),
    NumeroVolume int,
    NomeAutor varchar(50)
);
 
ALTER TABLE TBProfessor ADD CONSTRAINT FK_TBProfessor_2
    FOREIGN KEY (CodProfessor)
    REFERENCES TBUsuario (IDUsuario);
 
ALTER TABLE TBAluno ADD CONSTRAINT FK_TBAluno_2
    FOREIGN KEY (CodAluno)
    REFERENCES TBUsuario (IDUsuario);
 
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_2
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBUsuario (IDUsuario);
 
ALTER TABLE TBMaterial ADD CONSTRAINT FK_TBMaterial_2
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (CodFuncionario);
 
ALTER TABLE TBEmprestimo ADD CONSTRAINT FK_TBEmprestimo_2
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (CodFuncionario);
 
ALTER TABLE TBEmprestimo ADD CONSTRAINT FK_TBEmprestimo_3
    FOREIGN KEY (CodUsuario)
    REFERENCES TBUsuario (IDUsuario);
 
ALTER TABLE TBDVD ADD CONSTRAINT FK_TBDVD_2
    FOREIGN KEY (CodDVD)
    REFERENCES TBMaterial (IDMaterial);
 
ALTER TABLE TBMaterialEmprestado ADD CONSTRAINT FK_TBMaterialEmprestado_2
    FOREIGN KEY (CodEmprestimo)
    REFERENCES TBEmprestimo (IDEmprestimo);
 
ALTER TABLE TBMaterialEmprestado ADD CONSTRAINT FK_TBMaterialEmprestado_3
    FOREIGN KEY (CodMaterial)
    REFERENCES TBMaterial (IDMaterial);
 
ALTER TABLE TBDevolucaoMaterial ADD CONSTRAINT FK_TBDevolucaoMaterial_2
    FOREIGN KEY (CodEmprestimo, CodMaterial)
    REFERENCES TBMaterialEmprestado (CodEmprestimo, CodMaterial);
 
ALTER TABLE TBDevolucaoMaterial ADD CONSTRAINT FK_TBDevolucaoMaterial_3
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (CodFuncionario);
 
ALTER TABLE TBImpressao ADD CONSTRAINT FK_TBImpressao_2
    FOREIGN KEY (CodImpressao)
    REFERENCES TBMaterial (IDMaterial);

--fazendo os inserts
USE BDAula04062025_3139786;

-- TBUsuario (45 records: 15 para Professores, 15 para Alunos, 15 para Funcionarios)
INSERT INTO TBUsuario (IDUsuario, NomeUsuario, DataCadastro, Telefone, Email, Endereco, Numero, Municipio, UF) VALUES
-- Professores (1-15)
(1, 'Ana Silva Prof', '2024-10-01 08:00:00.100', 17991000001, 'ana.silva.prof@email.com', 'Rua das Palmeiras', 10, 'Barretos', 'SP'),
(2, 'Bruno Costa Prof', '2024-11-01 09:15:30.250', 17991000002, 'bruno.costa.prof@email.com', 'Avenida Jatobá', 20, 'Barretos', 'SP'),
(3, 'Carla Dias Prof', '2024-12-01 10:30:45.500', 17991000003, 'carla.dias.prof@email.com', 'Travessa Girassol', 30, 'Colina', 'SP'),
(4, 'Daniel Martins Prof', '2024-13-01 11:05:10.750', 17991000004, 'daniel.martins.prof@email.com', 'Praça da Sé', 40, 'Barretos', 'SP'),
(5, 'Elisa Ferreira Prof', '2024-14-01 14:20:00.900', 17991000005, 'elisa.ferreira.prof@email.com', 'Rua dos Ipes', 50, 'Guaira', 'SP'),
(6, 'Fernando Moura Prof', '2024-15-01 08:00:00.110', 17991000006, 'fernando.moura.prof@email.com', 'Rua A', 11, 'Barretos', 'SP'),
(7, 'Beatriz Santos Prof', '2024-16-01 09:00:00.220', 17991000007, 'beatriz.santos.prof@email.com', 'Rua B', 12, 'Barretos', 'SP'),
(8, 'Ricardo Alves Prof', '2024-17-01 10:00:00.330', 17991000008, 'ricardo.alves.prof@email.com', 'Rua C', 13, 'Colina', 'SP'),
(9, 'Sofia Lima Prof', '2024-18-01 11:00:00.440', 17991000009, 'sofia.lima.prof@email.com', 'Rua D', 14, 'Barretos', 'SP'),
(10, 'Lucas Gomes Prof', '2024-19-01 12:00:00.550', 17991000010, 'lucas.gomes.prof@email.com', 'Rua E', 15, 'Guaira', 'SP'),
(11, 'Camila Costa Prof', '2024-20-01 13:00:00.660', 17991000011, 'camila.costa.prof@email.com', 'Rua F', 16, 'Barretos', 'SP'),
(12, 'Gustavo Pereira Prof', '2024-21-01 14:00:00.770', 17991000012, 'gustavo.pereira.prof@email.com', 'Rua G', 17, 'Barretos', 'SP'),
(13, 'Laura Fernandes Prof', '2024-22-01 15:00:00.880', 17991000013, 'laura.fernandes.prof@email.com', 'Rua H', 18, 'Colina', 'SP'),
(14, 'Pedro Azevedo Prof', '2024-23-01 16:00:00.990', 17991000014, 'pedro.azevedo.prof@email.com', 'Rua I', 19, 'Barretos', 'SP'),
(15, 'Julia Castro Prof', '2024-24-01 17:00:00.000', 17991000015, 'julia.castro.prof@email.com', 'Rua J', 21, 'Guaira', 'SP'),
-- Alunos (16-30)
(16, 'Felipe Alves Aluno', '2024-01-02 08:30:00.123', 17991000016, 'felipe.alves.aluno@email.com', 'Avenida Principal', 100, 'Barretos', 'SP'),
(17, 'Gabriela Lima Aluno', '2024-02-02 09:45:15.456', 17991000017, 'gabriela.lima.aluno@email.com', 'Rua Secundaria', 200, 'Barretos', 'SP'),
(18, 'Hugo Mendes Aluno', '2024-03-02 10:50:30.789', 17991000018, 'hugo.mendes.aluno@email.com', 'Travessa Terciaria', 300, 'Colina', 'SP'),
(19, 'Isabela Barros Aluno', '2024-04-02 11:55:45.012', 17991000019, 'isabela.barros.aluno@email.com', 'Praça Central', 400, 'Barretos', 'SP'),
(20, 'João Rocha Aluno', '2024-05-02 15:00:00.345', 17991000020, 'joao.rocha.aluno@email.com', 'Rua Larga', 500, 'Guaira', 'SP'),
(21, 'Manuela Pinto Aluno', '2024-06-02 08:00:00.110', 17991000021, 'manuela.pinto.aluno@email.com', 'Rua K', 110, 'Barretos', 'SP'),
(22, 'Davi Silva Aluno', '2024-07-02 09:00:00.220', 17991000022, 'davi.silva.aluno@email.com', 'Rua L', 120, 'Barretos', 'SP'),
(23, 'Valentina Souza Aluno', '2024-08-02 10:00:00.330', 17991000023, 'valentina.souza.aluno@email.com', 'Rua M', 130, 'Colina', 'SP'),
(24, 'Arthur Moreira Aluno', '2024-09-02 11:00:00.440', 17991000024, 'arthur.moreira.aluno@email.com', 'Rua N', 140, 'Barretos', 'SP'),
(25, 'Helena Ribeiro Aluno', '2024-10-02 12:00:00.550', 17991000025, 'helena.ribeiro.aluno@email.com', 'Rua O', 150, 'Guaira', 'SP'),
(26, 'Bernardo Correia Aluno', '2024-11-02 13:00:00.660', 17991000026, 'bernardo.correia.aluno@email.com', 'Rua P', 160, 'Barretos', 'SP'),
(27, 'Alice Rodrigues Aluno', '2024-12-02 14:00:00.770', 17991000027, 'alice.rodrigues.aluno@email.com', 'Rua Q', 170, 'Barretos', 'SP'),
(28, 'Miguel Nogueira Aluno', '2024-13-02 15:00:00.880', 17991000028, 'miguel.nogueira.aluno@email.com', 'Rua R', 180, 'Colina', 'SP'),
(29, 'Sophia Martins Aluno', '2024-14-02 16:00:00.990', 17991000029, 'sophia.martins.aluno@email.com', 'Rua S', 190, 'Barretos', 'SP'),
(30, 'Theo Barbosa Aluno', '2024-15-02 17:00:00.000', 17991000030, 'theo.barbosa.aluno@email.com', 'Rua T', 210, 'Guaira', 'SP'),
-- Funcionarios (31-45)
(31, 'Larissa Souza Func', '2023-10-03 08:00:00.000', 17991000031, 'larissa.souza.func@email.com', 'Alameda dos Anjos', 600, 'Barretos', 'SP'),
(32, 'Marcos Andrade Func', '2023-11-03 09:00:00.000', 17991000032, 'marcos.andrade.func@email.com', 'Rua Estreita', 700, 'Barretos', 'SP'),
(33, 'Natalia Gomes Func', '2022-15-08 10:00:00.000', 17991000033, 'natalia.gomes.func@email.com', 'Avenida Longa', 800, 'Colina', 'SP'),
(34, 'Otavio Pinto Func', '2022-20-09 11:00:00.000', 17991000034, 'otavio.pinto.func@email.com', 'Travessa Curta', 900, 'Barretos', 'SP'),
(35, 'Patricia Neves Func', '2023-25-01 14:00:00.000', 17991000035, 'patricia.neves.func@email.com', 'Praça Menor', 1000, 'Guaira', 'SP'),
(36, 'Roberto Dias Func', '2023-10-02 08:00:00.110', 17991000036, 'roberto.dias.func@email.com', 'Rua U', 610, 'Barretos', 'SP'),
(37, 'Vanessa Almeida Func', '2023-11-02 09:00:00.220', 17991000037, 'vanessa.almeida.func@email.com', 'Rua V', 620, 'Barretos', 'SP'),
(38, 'Diego Rocha Func', '2022-12-08 10:00:00.330', 17991000038, 'diego.rocha.func@email.com', 'Rua W', 630, 'Colina', 'SP'),
(39, 'Eduarda Melo Func', '2022-18-09 11:00:00.440', 17991000039, 'eduarda.melo.func@email.com', 'Rua X', 640, 'Barretos', 'SP'),
(40, 'Thiago Barros Func', '2023-20-01 12:00:00.550', 17991000040, 'thiago.barros.func@email.com', 'Rua Y', 650, 'Guaira', 'SP'),
(41, 'Yasmin Santos Func', '2023-01-03 13:00:00.660', 17991000041, 'yasmin.santos.func@email.com', 'Rua Z', 660, 'Barretos', 'SP'),
(42, 'Bruno Oliveira Func', '2023-05-03 14:00:00.770', 17991000042, 'bruno.oliveira.func@email.com', 'Av. A', 670, 'Barretos', 'SP'),
(43, 'Clara Ferreira Func', '2022-22-08 15:00:00.880', 17991000043, 'clara.ferreira.func@email.com', 'Av. B', 680, 'Colina', 'SP'),
(44, 'Francisco Justo Func', '2022-28-09 16:00:00.990', 17991000044, 'francisco.justo.func@email.com', 'Av. C', 690, 'Barretos', 'SP'),
(45, 'Gabrielly Matos Func', '2023-30-01 17:00:00.000', 17991000045, 'gabrielly.matos.func@email.com', 'Av. D', 710, 'Guaira', 'SP');

-- TBProfessor (15 records linked to TBUsuario 1-15)
INSERT INTO TBProfessor (CodProfessor, CodTitulacao, Titulacao) VALUES
(1, 1, 'Doutorado'),(2, 2, 'Mestrado'),(3, 1, 'Doutorado'),(4, 3, 'Especialização'),(5, 2, 'Mestrado'),
(6, 1, 'Doutorado'),(7, 2, 'Mestrado'),(8, 1, 'Doutorado'),(9, 3, 'Especialização'),(10, 2, 'Mestrado'),
(11, 1, 'Doutorado'),(12, 2, 'Mestrado'),(13, 1, 'Doutorado'),(14, 3, 'Especialização'),(15, 2, 'Mestrado');

-- TBAluno (15 records linked to TBUsuario 16-30)
INSERT INTO TBAluno (CodAluno, NumeroSalaEstuda, NumeroSerie) VALUES
(16, 101, 1),(17, 102, 2),(18, 103, 3),(19, 201, 1),(20, 202, 2),
(21, 101, 2),(22, 102, 3),(23, 103, 1),(24, 201, 2),(25, 202, 3),
(26, 101, 1),(27, 102, 1),(28, 103, 2),(29, 201, 3),(30, 202, 1);

-- TBFuncionario (15 records linked to TBUsuario 31-45)
INSERT INTO TBFuncionario (CodFuncionario, DataAdmissao, Funcao) VALUES
(31, '2023-03-10', 'Bibliotecário Chefe'),
(32, '2023-03-11', 'Auxiliar de Biblioteca'),
(33, '2022-08-15', 'Atendente'),
(34, '2022-09-20', 'Auxiliar de Biblioteca'),
(35, '2023-01-25', 'Estagiário'),
(36, '2023-02-10', 'Bibliotecário Jr'),
(37, '2023-02-11', 'Atendente'),
(38, '2022-08-12', 'Auxiliar de Biblioteca'),
(39, '2022-09-18', 'Estagiário'),
(40, '2023-01-20', 'Bibliotecário Pleno'),
(41, '2023-03-01', 'Atendente Volante'),
(42, '2023-03-05', 'Organizador de Acervo'),
(43, '2022-08-22', 'Auxiliar Administrativo'),
(44, '2022-09-28', 'Segurança'),
(45, '2023-01-30', 'Limpeza');

-- TBMaterial (30 records: 15 DVDs, 15 Impressos. CodFuncionario from 31-45)
INSERT INTO TBMaterial (IDMaterial, DescricaoMaterial, Custo, CodFuncionario, DataCadastro, Tipo) VALUES
-- DVDs (1-15)
(1, 'Filme Aventura Antiga', 25.00, 31, '2024-01-03 10:00:00.111', 2),
(2, 'Documentário Natureza', 30.00, 32, '2024-01-03 10:05:00.222', 2),
(3, 'Show Musical Clássico', 22.50, 33, '2024-02-03 11:00:00.333', 2),
(4, 'Filme Drama Intenso', 28.00, 34, '2024-02-03 11:05:00.444', 2),
(5, 'Curso Idiomas Básico', 45.00, 35, '2024-03-03 12:00:00.555', 2),
(6, 'Animação Infantil Educativa', 20.00, 31, '2024-03-03 12:05:00.666', 2),
(7, 'Série Suspense Completa T1', 75.00, 32, '2024-04-03 13:00:00.777', 2),
(8, 'Filme Comédia Romântica', 23.00, 33, '2024-04-03 10:10:00.101', 2),
(9, 'Documentário História Mundial', 32.00, 34, '2024-05-03 10:15:00.202', 2),
(10, 'Show Rock Progressivo', 26.50, 35, '2024-05-03 11:10:00.303', 2),
(11, 'Filme Ficção Científica Cult', 29.00, 31, '2024-06-03 11:15:00.404', 2),
(12, 'Curso Culinária Avançada', 48.00, 32, '2024-06-03 12:10:00.505', 2),
(13, 'Animação Japonesa Clássica', 21.00, 33, '2024-07-03 12:15:00.606', 2),
(14, 'Série Drama Policial T2', 78.00, 34, '2024-07-03 13:10:00.707', 2),
(15, 'Filme Terror Psicológico', 27.00, 35, '2024-08-03 13:15:00.808', 2),
-- Impressos (16-30)
(16, 'Livro Romance Clássico', 55.00, 36, '2024-05-03 09:00:00.888', 1),
(17, 'Revista Ciência Atual', 15.00, 37, '2024-05-03 09:05:00.999', 1),
(18, 'Livro História do Brasil', 60.00, 38, '2024-06-03 10:00:00.001', 1),
(19, 'Manual Técnico Mecânica', 90.00, 39, '2024-06-03 10:05:00.112', 1),
(20, 'Livro Poesia Moderna', 40.00, 40, '2024-07-03 11:00:00.223', 1),
(21, 'Revista Viagem Mundo', 18.00, 36, '2024-07-03 11:05:00.334', 1),
(22, 'Livro Contos Fantásticos', 48.00, 37, '2024-08-03 12:00:00.445', 1),
(23, 'Enciclopédia Juvenil Volume 1', 120.00, 38, '2024-08-03 12:05:00.556', 1),
(24, 'Livro Filosofia Antiga', 65.00, 39, '2024-09-03 09:10:00.101', 1),
(25, 'Revista HQ Super Heróis', 12.00, 40, '2024-09-03 09:15:00.202', 1),
(26, 'Livro Biografia Famosa', 58.00, 36, '2024-10-03 10:10:00.303', 1),
(27, 'Atlas Geográfico Completo', 95.00, 37, '2024-10-03 10:15:00.404', 1),
(28, 'Livro Autoajuda BestSeller', 42.00, 38, '2024-11-03 11:10:00.505', 1),
(29, 'Revista Decoração Interiores', 20.00, 39, '2024-11-03 11:15:00.606', 1),
(30, 'Livro Suspense Policial', 50.00, 40, '2024-12-03 12:10:00.707', 1);

-- TBDVD (15 records linked to TBMaterial 1-15)
INSERT INTO TBDVD (CodDVD, Titulo, DataLancamento, DescricaoDVD, Assunto, Produtora, Autor) VALUES
(1, 'Aventura Antiga', '2005-05-10', 'Jornada épica em terras distantes.', 'Aventura', 'Produtora X', 'Diretor A'),
(2, 'Segredos da Natureza', '2018-11-20', 'Documentário sobre vida selvagem.', 'Natureza', 'Produtora Y', 'Narrador B'),
(3, 'Concerto Memorável', '2010-02-15', 'Gravação de show ao vivo.', 'Musical', 'Produtora Z', 'Banda C'),
(4, 'Lagrimas no Inverno', '2015-08-01', 'Drama familiar comovente.', 'Drama', 'Estudios Alfa', 'Diretor D'),
(5, 'Inglês para Iniciantes', '2020-01-30', 'Curso prático de inglês.', 'Educacional', 'Cursos Beta', 'Professor E'),
(6, 'Aprender Brincando', '2019-06-25', 'Desenho animado educativo.', 'Infantil', 'Animadora Gama', 'Criador F'),
(7, 'Noites de Terror T1', '2021-10-05', 'Primeira temporada completa.', 'Suspense', 'Produtora Omega', 'Roteirista G'),
(8, 'A Vida em Cores', '2008-06-11', 'Comédia romântica leve.', 'Comédia', 'Produtora Beta', 'Diretor H'),
(9, 'Grandes Guerras', '2017-03-22', 'Documentário sobre conflitos.', 'História', 'Produtora Delta', 'Narrador I'),
(10, 'Rock Sinfônico', '2012-07-18', 'Show de rock com orquestra.', 'Musical', 'Produtora Epsilon', 'Banda J'),
(11, 'Planeta Distante', '2014-09-03', 'Ficção científica clássica.', 'Ficção', 'Estudios Zeta', 'Diretor K'),
(12, 'Segredos do Chef', '2021-02-28', 'Curso de culinária gourmet.', 'Educacional', 'Cursos Eta', 'Chef L'),
(13, 'Meu Amigo Totoro', '1988-04-16', 'Animação japonesa icônica.', 'Infantil', 'Studio Ghibli', 'Hayao Miyazaki'),
(14, 'Noites de Terror T2', '2022-11-07', 'Segunda temporada completa.', 'Suspense', 'Produtora Omega', 'Roteirista M'),
(15, 'O Iluminado', '1980-06-13', 'Terror psicológico aclamado.', 'Terror', 'Warner Bros.', 'Stanley Kubrick');

-- TBImpressao (15 records linked to TBMaterial 16-30)
INSERT INTO TBImpressao (CodImpressao, Titulo, DataImpressao, NomeEditora, NumeroVolume, NomeAutor) VALUES
(16, 'Amor Eterno', '1998-07-12', 'Editora Clássicos', 1, 'Autor H'),
(17, 'Ciência Hoje - Ed. 35', '2024-02-01', 'Edições Científicas', 35, 'Vários Autores'),
(18, 'Brasil: Uma História', '2002-03-22', 'Editora Saber', 1, 'Historiador I'),
(19, 'Motores e Cia', '2017-09-05', 'Publicações Técnicas', 2, 'Engenheiro J'),
(20, 'Versos Livres', '2011-04-18', 'Poetas Reunidos', 1, 'Poeta K'),
(21, 'Destinos Incríveis - Ed.12', '2024-01-15', 'Mundo Viagens', 12, 'Vários Autores'),
(22, 'O Portal Mágico', '2008-12-01', 'Fantasia Books', 1, 'Autor L'),
(23, 'Descobrindo o Mundo Vol.1', '2015-06-10', 'Saber Juvenil', 1, 'Educador M'),
(24, 'A República', '2000-01-01', 'Clássicos da Filosofia', 1, 'Platão'),
(25, 'Batman: Ano Um', '1987-02-01', 'DC Comics', 1, 'Frank Miller'),
(26, 'Steve Jobs', '2011-10-24', 'Companhia das Letras', 1, 'Walter Isaacson'),
(27, 'Atlas do Mundo Moderno', '2019-08-10', 'Editora Geográfica', 5, 'Vários Cartógrafos'),
(28, 'O Poder do Hábito', '2012-02-28', 'Objetiva', 1, 'Charles Duhigg'),
(29, 'Casa e Jardim - Ed. 50', '2023-11-01', 'Editora Globo', 50, 'Vários Decoradores'),
(30, 'O Código Da Vinci', '2003-03-18', 'Sextante', 1, 'Dan Brown');

-- TBEmprestimo (15 records. CodUsuario from 1-45, CodFuncionario from 31-45)
INSERT INTO TBEmprestimo (IDEmprestimo, DataEmprestimo, DataPrevisaoDevolucao, CodUsuario, CodFuncionario, TotalDiasEmprestimo, Observacao) VALUES
(1, '2025-01-05 10:00:00.123', '2025-08-05 10:00:00.000', 1, 31, 7, 'Empréstimo regular prof.'),
(2, '2025-02-05 11:15:00.456', '2025-09-05 11:15:00.000', 16, 32, 7, 'Empréstimo regular aluno'),
(3, '2025-03-05 14:30:00.789', '2025-10-05 14:30:00.000', 2, 33, 7, 'Empréstimo prof.'),
(4, '2025-04-05 09:00:00.012', '2025-11-05 09:00:00.000', 17, 34, 7, 'Empréstimo aluno'),
(5, '2025-05-05 16:00:00.345', '2025-12-05 16:00:00.000', 3, 35, 7, 'Devolver sem falta prof.'),
(6, '2025-06-05 10:30:00.678', '2025-20-05 10:30:00.000', 18, 31, 14, 'Empréstimo especial aluno'),
(7, '2025-07-05 11:45:00.901', '2025-21-05 11:45:00.000', 4, 32, 14, 'Empréstimo prof. período maior'),
(8, '2025-08-05 15:00:00.234', '2025-15-05 15:00:00.000', 19, 33, 7, 'Empréstimo aluno'),
(9, '2025-09-05 09:30:00.567', '2025-16-05 09:30:00.000', 5, 34, 7, 'Empréstimo prof.'),
(10, '2025-10-05 17:00:00.890', '2025-17-05 17:00:00.000', 20, 35, 7, 'Empréstimo aluno'),
(11, '2025-11-05 10:10:00.112', '2025-18-05 10:10:00.000', 6, 31, 7, 'Outro empréstimo prof.'),
(12, '2025-12-05 11:20:00.334', '2025-19-05 11:20:00.000', 21, 32, 7, 'Outro empréstimo aluno'),
(13, '2025-13-05 14:40:00.556', '2025-27-05 14:40:00.000', 31, 33, 14, 'Empréstimo funcionário'),
(14, '2025-14-05 09:50:00.778', '2025-21-05 09:50:00.000', 32, 34, 7, 'Empréstimo funcionário'),
(15, '2025-15-05 16:30:00.990', '2025-22-05 16:30:00.000', 36, 35, 7, 'Empréstimo funcionário');

-- TBMaterialEmprestado (15 records, linking IDEmprestimo 1-15 to IDMaterial 1-15 for simplicity in devolutions)
INSERT INTO TBMaterialEmprestado (CodEmprestimo, CodMaterial, DataEmprestimo, DataDevolucao, Quantidade, Observacao) VALUES
(1, 1, '2025-05-01', '2025-05-10', 1, 'Material 1 emprestado'),
(2, 2, '2025-05-02', '2025-05-12', 1, 'Material 2 emprestado'),
(3, 3, '2025-05-03', '2025-05-15', 1, 'Material 3 emprestado'),
(4, 4, '2025-05-04', '2025-05-13', 1, 'Material 4 emprestado'),
(5, 5, '2025-05-05', '2025-05-20', 1, 'Material 5 emprestado'),
(6, 6, '2025-05-06', '2025-05-20', 1, 'Material 6 emprestado'),
(7, 7, '2025-05-07', '2025-05-21', 1, 'Material 7 emprestado'),
(8, 8, '2025-05-08', '2025-05-14', 1, 'Material 8 emprestado'),
(9, 9, '2025-05-09', '2025-05-16', 1, 'Material 9 emprestado'),
(10, 10, '2025-05-10', '2025-05-17', 1, 'Material 10 emprestado'),
(11, 11, '2025-05-11', '2025-05-18', 1, 'Material 11 emprestado'),
(12, 12, '2025-05-12', '2025-05-19', 1, 'Material 12 emprestado'),
(13, 13, '2025-05-13', '2025-05-26', 1, 'Material 13 emprestado'),
(14, 14, '2025-05-14', '2025-05-20', 1, 'Material 14 emprestado'),
(15, 15, '2025-05-15', '2025-05-22', 1, 'Material 15 emprestado');

-- TBDevolucaoMaterial (5 records with multa, corresponding to the first 5 TBMaterialEmprestado. CodFuncionario from 31-45)
INSERT INTO TBDevolucaoMaterial (IDDevolucao, CodEmprestimo, CodMaterial, CodFuncionario, DataDevolucao, Observacao, DiasAtraso, ValorMulta) VALUES
-- Emprestimo 1: Previsto 2025-08-05, Devolvido 2025-10-05 (2 dias de atraso)
(1, 1, 1, 32, '2025-10-05 17:00:00.100', 'Devolvido com atraso, multa aplicada.', 2, 10.00),
-- Emprestimo 2: Previsto 2025-09-05, Devolvido 2025-12-05 (3 dias de atraso)
(2, 2, 2, 31, '2025-12-05 17:15:00.200', 'Devolvido com atraso, multa aplicada.', 3, 10.00),
-- Emprestimo 3: Previsto 2025-10-05, Devolvido 2025-15-05 (5 dias de atraso)
(3, 3, 3, 33, '2025-15-05 18:00:00.300', 'Devolvido com atraso, multa aplicada.', 5, 10.00),
-- Emprestimo 4: Previsto 2025-11-05, Devolvido 2025-13-05 (2 dias de atraso)
(4, 4, 4, 34, '2025-13-05 10:00:00.400', 'Devolvido com atraso, multa aplicada.', 2, 10.00),
-- Emprestimo 5: Previsto 2025-12-05, Devolvido 2025-20-05 (8 dias de atraso)
(5, 5, 5, 35, '2025-20-05 09:30:00.500', 'Devolvido com atraso considerável, multa aplicada.', 8, 10.00);

