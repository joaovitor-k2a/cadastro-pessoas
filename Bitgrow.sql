USE [sistema]
GO
/****** Object:  Table [dbo].[Estudantes]    Script Date: 14/12/2023 16:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estudantes](
	[EstudanteID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](100) NOT NULL,
	[CEP] [nvarchar](10) NOT NULL,
	[DataNascimento] [date] NOT NULL,
	[Endereco] [nvarchar](255) NULL,
	[Observacao] [nvarchar](max) NULL,
	[Escolaridade] [nvarchar](50) NULL,
	[NomeEscola] [nvarchar](100) NULL,
	[DataHoraCadastro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EstudanteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 14/12/2023 16:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMaster](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](20) NOT NULL,
	[Password] [varchar](50) NULL,
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Estudantes] ADD  DEFAULT (getdate()) FOR [DataHoraCadastro]
GO
ALTER TABLE [dbo].[Estudantes]  WITH CHECK ADD  CONSTRAINT [CHK_MinAge] CHECK  ((datediff(year,[DataNascimento],getdate())>=(21)))
GO
ALTER TABLE [dbo].[Estudantes] CHECK CONSTRAINT [CHK_MinAge]
GO
/****** Object:  StoredProcedure [dbo].[AtualizarEstudante]    Script Date: 14/12/2023 16:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AtualizarEstudante]
    @EstudanteID INT,
    @Nome NVARCHAR(255),
    @CEP NVARCHAR(10),
    @DataNascimento DATE,
    @Endereco NVARCHAR(255),
    @Observacao NVARCHAR(MAX),
    @Escolaridade NVARCHAR(50),
    @NomeEscola NVARCHAR(255)
AS
BEGIN
    UPDATE Estudantes
    SET
        Nome = @Nome,
        CEP = @CEP,
        DataNascimento = @DataNascimento,
        Endereco = @Endereco,
        Observacao = @Observacao,
        Escolaridade = @Escolaridade,
        NomeEscola = @NomeEscola
    WHERE 
	EstudanteID = @EstudanteID;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeletarEstudante]    Script Date: 14/12/2023 16:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletarEstudante]
    @EstudanteID INT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Estudantes WHERE EstudanteID = @EstudanteID)
    BEGIN
        DELETE FROM Estudantes WHERE EstudanteID = @EstudanteID;

        SELECT 'Estudante deletado com sucesso.' AS Mensagem;
    END
    ELSE
    BEGIN
        SELECT 'Estudante não encontrado.' AS Mensagem;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[ExcluirEstudante]    Script Date: 14/12/2023 16:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExcluirEstudante]
    @EstudanteID INT
AS
BEGIN
    DELETE FROM Estudantes
    WHERE EstudanteID = @EstudanteID;
END;
GO
/****** Object:  StoredProcedure [dbo].[InserirNovoEstudante]    Script Date: 14/12/2023 16:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InserirNovoEstudante]
    @Nome NVARCHAR(255),
    @CEP NVARCHAR(10),
    @DataNascimento DATE,
    @Endereco NVARCHAR(255),
    @Observacao NVARCHAR(MAX),
    @Escolaridade NVARCHAR(50),
    @NomeEscola NVARCHAR(255),
    @DataHoraCadastro DATETIME
AS
BEGIN
    INSERT INTO Estudantes (Nome, CEP, DataNascimento, Endereco, Observacao, Escolaridade, NomeEscola, DataHoraCadastro)
    VALUES (@Nome, @CEP, @DataNascimento, @Endereco, @Observacao, @Escolaridade, @NomeEscola, @DataHoraCadastro);
END;
GO
/****** Object:  StoredProcedure [dbo].[ObterEstudantes]    Script Date: 14/12/2023 16:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObterEstudantes]
AS
BEGIN
    SELECT
		EstudanteID,
        Nome,
        CEP,
        DataNascimento,
        Endereco,
        Observacao,
        Escolaridade,
        NomeEscola,
        DataHoraCadastro
    FROM
        Estudantes;
END;
GO
