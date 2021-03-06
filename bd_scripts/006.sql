

CREATE TABLE #temp_cobranca (
	[id] [int], 
	[nome] [varchar](50) NOT NULL,
	[ind_pagar] [tinyint] NOT NULL, 
	[ind_receber] [tinyint] NOT NULL,
	[data_exclusao] [datetime] NULL
) 
go

insert into #temp_cobranca
select id, nome, ind_pagar, ind_receber, data_exclusao from cobranca
go


ALTER TABLE dbo.prm_coleta
	DROP CONSTRAINT FK_prm_coleta_cobranca
GO
ALTER TABLE dbo.parcela
	DROP CONSTRAINT FK_parcela_cobranca
GO

DROP TABLE [dbo].[cobranca]
GO

CREATE TABLE [dbo].[cobranca](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](50) NOT NULL,
	[ind_pagar] [tinyint] NOT NULL CONSTRAINT [DF_cobranca_ind_pagar]  DEFAULT ((0)),
	[ind_receber] [tinyint] NOT NULL CONSTRAINT [DF_cobranca_ind_receber]  DEFAULT ((0)),
	[data_exclusao] [datetime] NULL,
 CONSTRAINT [PK_cobranca] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

DBCC CHECKIDENT ('cobranca', RESEED, 0)
GO

INSERT into cobranca(nome, ind_pagar, ind_receber, data_exclusao)
select nome, ind_pagar, ind_receber, data_exclusao from #temp_cobranca
go

ALTER TABLE dbo.parcela ADD CONSTRAINT
	FK_parcela_cobranca FOREIGN KEY
	(
	idcobranca
	) REFERENCES dbo.cobranca
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.prm_coleta ADD CONSTRAINT
	FK_prm_coleta_cobranca FOREIGN KEY
	(
	idCobranca_coleta
	) REFERENCES dbo.cobranca
	(
	id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

ALTER TABLE dbo.cobranca ADD
	uuid nvarchar(50) NULL
GO

drop table #temp_cobranca
go