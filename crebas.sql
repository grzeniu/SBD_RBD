/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     15.06.2019 12:18:29                          */
/*==============================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('Dzia³')
            and   type = 'U')
   drop table Dzia³
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Klient')
            and   type = 'U')
   drop table Klient
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Ocena')
            and   type = 'U')
   drop table Ocena
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Pracownik')
            and   name  = 'Dzial_Pracowwnika_FK'
            and   indid > 0
            and   indid < 255)
   drop index Pracownik.Dzial_Pracowwnika_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Pracownik')
            and   type = 'U')
   drop table Pracownik
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Rozmowa')
            and   name  = 'Ocena_Rozmowy_FK'
            and   indid > 0
            and   indid < 255)
   drop index Rozmowa.Ocena_Rozmowy_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Rozmowa')
            and   name  = 'Rozmowy_Klienta_FK'
            and   indid > 0
            and   indid < 255)
   drop index Rozmowa.Rozmowy_Klienta_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Rozmowa')
            and   name  = 'Rozmowy_Pracownika_FK'
            and   indid > 0
            and   indid < 255)
   drop index Rozmowa.Rozmowy_Pracownika_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Rozmowa')
            and   type = 'U')
   drop table Rozmowa
go

/*==============================================================*/
/* Table: Dzia³                                                 */
/*==============================================================*/
create table Dzia³ (
   Dzial_ID             int                  identity,
   Nazwa_Dzialu         varchar(50)          not null,
   constraint PK_DZIA£ primary key nonclustered (Dzial_ID)
)
go

/*==============================================================*/
/* Table: Klient                                                */
/*==============================================================*/
create table Klient (
   Pesel_Klient         numeric              identity,
   Imie                 varchar(20)          not null,
   Nazwisko             varchar(20)          not null,
   Data_Urodzenia       datetime             not null,
   constraint PK_KLIENT primary key nonclustered (Pesel_Klient)
)
go

/*==============================================================*/
/* Table: Ocena                                                 */
/*==============================================================*/
create table Ocena (
   Ocena_ID             int                  identity,
   Wartosc              int                  null,
   Opis                 varchar(1024)        null,
   constraint PK_OCENA primary key nonclustered (Ocena_ID)
)
go

/*==============================================================*/
/* Table: Pracownik                                             */
/*==============================================================*/
create table Pracownik (
   Pesel_Pracownik      numeric              identity,
   Dzial_ID             int                  not null,
   Imie                 varchar(20)          not null,
   Nazwisko             varchar(20)          not null,
   Data_Zatrudnienia    datetime             null,
   constraint PK_PRACOWNIK primary key nonclustered (Pesel_Pracownik)
)
go

/*==============================================================*/
/* Index: Dzial_Pracowwnika_FK                                  */
/*==============================================================*/
create index Dzial_Pracowwnika_FK on Pracownik (
Dzial_ID ASC
)
go

/*==============================================================*/
/* Table: Rozmowa                                               */
/*==============================================================*/
create table Rozmowa (
   Rozmowa_ID           int                  identity,
   Pesel_Pracownik      varchar(11)          not null,
   Pesel_Klient         varchar(11)          not null,
   Ocena_ID             int                  not null,
   Data                 datetime             null,
   Czas_Trwania         int                  null,
   Czas_Oczekiwania     int                  null,
   constraint PK_ROZMOWA primary key nonclustered (Rozmowa_ID)
)
go

/*==============================================================*/
/* Index: Rozmowy_Pracownika_FK                                 */
/*==============================================================*/
create index Rozmowy_Pracownika_FK on Rozmowa (
Pesel_Pracownik ASC
)
go

/*==============================================================*/
/* Index: Rozmowy_Klienta_FK                                    */
/*==============================================================*/
create index Rozmowy_Klienta_FK on Rozmowa (
Pesel_Klient ASC
)
go

/*==============================================================*/
/* Index: Ocena_Rozmowy_FK                                      */
/*==============================================================*/
create index Ocena_Rozmowy_FK on Rozmowa (
Ocena_ID ASC
)
go

