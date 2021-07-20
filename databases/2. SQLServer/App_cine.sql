USE [master]
GO
/****** Object:  Database [app_cine]    Script Date: 20/02/2021 7:30:41 p. m. ******/
CREATE DATABASE [app_cine]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'app_cine', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\app_cine.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'app_cine_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\app_cine_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [app_cine] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [app_cine].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [app_cine] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [app_cine] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [app_cine] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [app_cine] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [app_cine] SET ARITHABORT OFF 
GO
ALTER DATABASE [app_cine] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [app_cine] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [app_cine] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [app_cine] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [app_cine] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [app_cine] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [app_cine] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [app_cine] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [app_cine] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [app_cine] SET  ENABLE_BROKER 
GO
ALTER DATABASE [app_cine] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [app_cine] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [app_cine] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [app_cine] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [app_cine] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [app_cine] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [app_cine] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [app_cine] SET RECOVERY FULL 
GO
ALTER DATABASE [app_cine] SET  MULTI_USER 
GO
ALTER DATABASE [app_cine] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [app_cine] SET DB_CHAINING OFF 
GO
ALTER DATABASE [app_cine] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [app_cine] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [app_cine] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [app_cine] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'app_cine', N'ON'
GO
ALTER DATABASE [app_cine] SET QUERY_STORE = OFF
GO
USE [app_cine]
GO
/****** Object:  UserDefinedFunction [dbo].[calificacion_peliculas]    Script Date: 20/02/2021 7:30:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[calificacion_peliculas](@pelicula float)
RETURNS FLOAT
AS
BEGIN
DECLARE @suma float;
DECLARE @total float;
SET @suma=(SELECT sum(calificacion) FROM opiniones WHERE id_pelicula=@pelicula);
SET @total=(SELECT count(calificacion) FROM opiniones WHERE id_pelicula=@pelicula);
RETURN round(@suma/@total, 2);
END
GO
/****** Object:  Table [dbo].[PELICULAS]    Script Date: 20/02/2021 7:30:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PELICULAS](
	[id_pelicula] [bigint] IDENTITY(1,1) NOT NULL,
	[titulo_distribucion] [varchar](50) NULL,
	[titulo_original] [varchar](50) NOT NULL,
	[genero] [varchar](250) NOT NULL,
	[idioma_original] [varchar](20) NOT NULL,
	[subtitulos] [varchar](10) NOT NULL,
	[pais_origen] [varchar](50) NULL,
	[anio_produccion] [int] NULL,
	[url] [varchar](50) NULL,
	[duracion] [time](7) NOT NULL,
	[clasificacion] [varchar](15) NOT NULL,
	[fecha_estreno_santiago] [date] NOT NULL,
	[resumen] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_pelicula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[titulo_original] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FUNCIONES]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUNCIONES](
	[id_funcion] [bigint] IDENTITY(1,1) NOT NULL,
	[duracion] [time](7) NOT NULL,
	[hora_inicio] [time](7) NOT NULL,
	[id_sala] [bigint] NOT NULL,
	[numero_sala] [bigint] NOT NULL,
	[id_pelicula] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_funcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MasFunciones]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MasFunciones]
AS
SELECT p.titulo_original, count(f.id_pelicula)AS Cantidad 
FROM peliculas p, funciones f WHERE p.id_pelicula=f.id_pelicula GROUP BY p.titulo_original;

GO
/****** Object:  Table [dbo].[SALAS]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALAS](
	[id_sala] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[butacas] [bigint] NOT NULL,
	[numero_sala] [bigint] NOT NULL,
	[nombre_cine] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sala] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CINES]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CINES](
	[nombre] [varchar](50) NOT NULL,
	[direccion] [varchar](50) NOT NULL,
	[telefono] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[telefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[direccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CineInfo]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CineInfo] AS
SELECT c.nombre AS CINE, c.direccion AS DIRECCIÓN, s.numero_sala as '#SALA', s.butacas AS BUTACAS FROM CINES c, SALAS s WHERE s.nombre_cine=c.nombre;
GO
/****** Object:  Table [dbo].[OPINIONES]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OPINIONES](
	[id_opinion] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre_persona] [varchar](50) NOT NULL,
	[edad] [int] NULL,
	[fecha_registro] [date] NOT NULL,
	[calificacion] [float] NOT NULL,
	[comentario] [varchar](250) NOT NULL,
	[id_pelicula] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_opinion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PELICULAS_FUERA_DE_CARTELERA]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PELICULAS_FUERA_DE_CARTELERA](
	[pk_fuera_de_cartelera] [bigint] IDENTITY(1,1) NOT NULL,
	[id_pelicula] [bigint] NOT NULL,
	[titulo_original] [varchar](50) NOT NULL,
	[titulo_distribucion] [varchar](50) NULL,
	[genero] [varchar](250) NOT NULL,
	[idioma_original] [varchar](20) NOT NULL,
	[subtitulos] [varchar](10) NOT NULL,
	[pais_origen] [varchar](50) NULL,
	[anio_produccion] [int] NULL,
	[url] [varchar](50) NULL,
	[duracion] [time](7) NOT NULL,
	[clasificacion] [varchar](15) NULL,
	[fecha_estreno_santiago] [date] NULL,
	[resumen] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[pk_fuera_de_cartelera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PELICULAS_PERSONAS]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PELICULAS_PERSONAS](
	[pk_peliculas_personas] [bigint] IDENTITY(1,1) NOT NULL,
	[id_pelicula] [bigint] NOT NULL,
	[nombre_persona] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pk_peliculas_personas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PERSONAS]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERSONAS](
	[nombre] [varchar](50) NOT NULL,
	[nacionalidad] [varchar](20) NOT NULL,
	[cantidad_de_peliculas] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROMOCIONES]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROMOCIONES](
	[id_promocion] [bigint] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](250) NOT NULL,
	[descuento] [decimal](18, 0) NOT NULL,
	[id_funcion] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_promocion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLES]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLES](
	[id_rol] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre_rol] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROLES_PERSONAS]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLES_PERSONAS](
	[pk_roles_personas] [bigint] IDENTITY(1,1) NOT NULL,
	[id_rol] [bigint] NOT NULL,
	[nombre_persona] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pk_roles_personas] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [duracion_idx]    Script Date: 20/02/2021 7:30:43 p. m. ******/
CREATE NONCLUSTERED INDEX [duracion_idx] ON [dbo].[FUNCIONES]
(
	[duracion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [titulo_idx]    Script Date: 20/02/2021 7:30:43 p. m. ******/
CREATE NONCLUSTERED INDEX [titulo_idx] ON [dbo].[PELICULAS]
(
	[titulo_original] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [nombre_idx]    Script Date: 20/02/2021 7:30:43 p. m. ******/
CREATE NONCLUSTERED INDEX [nombre_idx] ON [dbo].[PERSONAS]
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FUNCIONES]  WITH CHECK ADD  CONSTRAINT [fk_funciones_peliculas] FOREIGN KEY([id_pelicula])
REFERENCES [dbo].[PELICULAS] ([id_pelicula])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FUNCIONES] CHECK CONSTRAINT [fk_funciones_peliculas]
GO
ALTER TABLE [dbo].[FUNCIONES]  WITH CHECK ADD  CONSTRAINT [fk_funciones_salas] FOREIGN KEY([id_sala])
REFERENCES [dbo].[SALAS] ([id_sala])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FUNCIONES] CHECK CONSTRAINT [fk_funciones_salas]
GO
ALTER TABLE [dbo].[OPINIONES]  WITH CHECK ADD  CONSTRAINT [fk_opiniones_peliculas] FOREIGN KEY([id_pelicula])
REFERENCES [dbo].[PELICULAS] ([id_pelicula])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OPINIONES] CHECK CONSTRAINT [fk_opiniones_peliculas]
GO
ALTER TABLE [dbo].[PELICULAS_PERSONAS]  WITH CHECK ADD  CONSTRAINT [fk_peliculas_personas] FOREIGN KEY([id_pelicula])
REFERENCES [dbo].[PELICULAS] ([id_pelicula])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PELICULAS_PERSONAS] CHECK CONSTRAINT [fk_peliculas_personas]
GO
ALTER TABLE [dbo].[PELICULAS_PERSONAS]  WITH CHECK ADD  CONSTRAINT [fk_personas_peliculas] FOREIGN KEY([nombre_persona])
REFERENCES [dbo].[PERSONAS] ([nombre])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PELICULAS_PERSONAS] CHECK CONSTRAINT [fk_personas_peliculas]
GO
ALTER TABLE [dbo].[PROMOCIONES]  WITH CHECK ADD  CONSTRAINT [fk_promociones_funciones] FOREIGN KEY([id_funcion])
REFERENCES [dbo].[FUNCIONES] ([id_funcion])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PROMOCIONES] CHECK CONSTRAINT [fk_promociones_funciones]
GO
ALTER TABLE [dbo].[ROLES_PERSONAS]  WITH CHECK ADD  CONSTRAINT [fk_roles_personas] FOREIGN KEY([id_rol])
REFERENCES [dbo].[ROLES] ([id_rol])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ROLES_PERSONAS] CHECK CONSTRAINT [fk_roles_personas]
GO
ALTER TABLE [dbo].[ROLES_PERSONAS]  WITH CHECK ADD  CONSTRAINT [fk_roles_personass] FOREIGN KEY([nombre_persona])
REFERENCES [dbo].[PERSONAS] ([nombre])
GO
ALTER TABLE [dbo].[ROLES_PERSONAS] CHECK CONSTRAINT [fk_roles_personass]
GO
ALTER TABLE [dbo].[SALAS]  WITH CHECK ADD  CONSTRAINT [fk_salas_cines] FOREIGN KEY([nombre_cine])
REFERENCES [dbo].[CINES] ([nombre])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SALAS] CHECK CONSTRAINT [fk_salas_cines]
GO
/****** Object:  StoredProcedure [dbo].[peliculas_actor]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[peliculas_actor]
@actor varchar(100)
as
begin

SELECT titulo_original FROM PELICULAS WHERE id_pelicula IN(SELECT id_pelicula FROM peliculas_personas WHERE @actor=nombre_persona);
	
end
GO
/****** Object:  StoredProcedure [dbo].[peliculas_genero]    Script Date: 20/02/2021 7:30:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[peliculas_genero]
@genre varchar(100)
as
begin

SELECT * FROM PELICULAS WHERE genero LIKE concat('%', @genre ,'%');
	
end
GO
USE [master]
GO
ALTER DATABASE [app_cine] SET  READ_WRITE 
GO
