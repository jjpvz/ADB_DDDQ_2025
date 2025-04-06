/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     6-4-2025 14:06:07                            */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BAND') and o.name = 'FK_BAND_BANDCOUNT_COUNTRY')
alter table BAND
   drop constraint FK_BAND_BANDCOUNT_COUNTRY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BAND') and o.name = 'FK_BAND_IS_A_ARTI_ARTIST')
alter table BAND
   drop constraint FK_BAND_IS_A_ARTI_ARTIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANDMEMBERSHIP') and o.name = 'FK_BANDMEMB_BANDMEMBE_BAND')
alter table BANDMEMBERSHIP
   drop constraint FK_BANDMEMB_BANDMEMBE_BAND
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANDMEMBERSHIP') and o.name = 'FK_BANDMEMB_BANDMEMBE_ARTIST')
alter table BANDMEMBERSHIP
   drop constraint FK_BANDMEMB_BANDMEMBE_ARTIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHART') and o.name = 'FK_CHART_COUNTRYOF_COUNTRY')
alter table CHART
   drop constraint FK_CHART_COUNTRYOF_COUNTRY
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMPOSEROFSONG') and o.name = 'FK_COMPOSER_COMPOSERO_SONG')
alter table COMPOSEROFSONG
   drop constraint FK_COMPOSER_COMPOSERO_SONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMPOSEROFSONG') and o.name = 'FK_COMPOSER_COMPOSERO_ARTIST')
alter table COMPOSEROFSONG
   drop constraint FK_COMPOSER_COMPOSERO_ARTIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DJINYEAR') and o.name = 'FK_DJINYEAR_DJOFDJINY_DJ')
alter table DJINYEAR
   drop constraint FK_DJINYEAR_DJOFDJINY_DJ
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DJINYEAR') and o.name = 'FK_DJINYEAR_DJOFTOP20_TOP2000L')
alter table DJINYEAR
   drop constraint FK_DJINYEAR_DJOFTOP20_TOP2000L
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FEATURINGARTISTOFSONG') and o.name = 'FK_FEATURIN_FEATURING_SONG')
alter table FEATURINGARTISTOFSONG
   drop constraint FK_FEATURIN_FEATURING_SONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FEATURINGARTISTOFSONG') and o.name = 'FK_FEATURIN_FEATURING_ARTIST')
alter table FEATURINGARTISTOFSONG
   drop constraint FK_FEATURIN_FEATURING_ARTIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GENREOFSONG') and o.name = 'FK_GENREOFS_GENREOFSO_GENRE')
alter table GENREOFSONG
   drop constraint FK_GENREOFS_GENREOFSO_GENRE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('GENREOFSONG') and o.name = 'FK_GENREOFS_GENREOFSO_SONG')
alter table GENREOFSONG
   drop constraint FK_GENREOFS_GENREOFSO_SONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('LISTENER') and o.name = 'FK_LISTENER_POSTALCOD_POSTALCO')
alter table LISTENER
   drop constraint FK_LISTENER_POSTALCOD_POSTALCO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PERSON') and o.name = 'FK_PERSON_IS_A_ARTI_ARTIST')
alter table PERSON
   drop constraint FK_PERSON_IS_A_ARTI_ARTIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('POSTALCODE') and o.name = 'FK_POSTALCO_POSTALCOD_MUNICIPA')
alter table POSTALCODE
   drop constraint FK_POSTALCO_POSTALCOD_MUNICIPA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('POSTALCODE') and o.name = 'FK_POSTALCO_POSTALCOD_PLACE')
alter table POSTALCODE
   drop constraint FK_POSTALCO_POSTALCOD_PLACE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONG') and o.name = 'FK_SONG_SONGOFART_ARTIST')
alter table SONG
   drop constraint FK_SONG_SONGOFART_ARTIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONGNOTONSTANDARDLIST') and o.name = 'FK_SONGNOTO_NOTSTANDA_VOTELIST')
alter table SONGNOTONSTANDARDLIST
   drop constraint FK_SONGNOTO_NOTSTANDA_VOTELIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONGOFVOTE') and o.name = 'FK_SONGOFVO_SONGOFVOT_VOTELIST')
alter table SONGOFVOTE
   drop constraint FK_SONGOFVO_SONGOFVOT_VOTELIST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONGOFVOTE') and o.name = 'FK_SONGOFVO_SONGOFVOT_SONG')
alter table SONGOFVOTE
   drop constraint FK_SONGOFVO_SONGOFVOT_SONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONGONCHART') and o.name = 'FK_SONGONCH_CHARTOFSO_CHART')
alter table SONGONCHART
   drop constraint FK_SONGONCH_CHARTOFSO_CHART
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONGONCHART') and o.name = 'FK_SONGONCH_SONGOFSON_SONG')
alter table SONGONCHART
   drop constraint FK_SONGONCH_SONGOFSON_SONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONGONTOP10LIST') and o.name = 'FK_SONGONTO_SONGOFSON_SONG')
alter table SONGONTOP10LIST
   drop constraint FK_SONGONTO_SONGOFSON_SONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SONGONTOP10LIST') and o.name = 'FK_SONGONTO_TOP10LIST_TOP10LIS')
alter table SONGONTOP10LIST
   drop constraint FK_SONGONTO_TOP10LIST_TOP10LIS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TOP10LIST') and o.name = 'FK_TOP10LIS_MUNICIPAL_MUNICIPA')
alter table TOP10LIST
   drop constraint FK_TOP10LIS_MUNICIPAL_MUNICIPA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TOP10LIST') and o.name = 'FK_TOP10LIS_TOP2000LI_TOP2000L')
alter table TOP10LIST
   drop constraint FK_TOP10LIS_TOP2000LI_TOP2000L
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TOP2000LISTENTRY') and o.name = 'FK_TOP2000L_EDITIONOF_TOP2000L')
alter table TOP2000LISTENTRY
   drop constraint FK_TOP2000L_EDITIONOF_TOP2000L
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('TOP2000LISTENTRY') and o.name = 'FK_TOP2000L_SONGOFTOP_SONG')
alter table TOP2000LISTENTRY
   drop constraint FK_TOP2000L_SONGOFTOP_SONG
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VOTELIST') and o.name = 'FK_VOTELIST_TOP2000LI_TOP2000L')
alter table VOTELIST
   drop constraint FK_VOTELIST_TOP2000LI_TOP2000L
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VOTELIST') and o.name = 'FK_VOTELIST_VOTELISTO_LISTENER')
alter table VOTELIST
   drop constraint FK_VOTELIST_VOTELISTO_LISTENER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ARTIST')
            and   type = 'U')
   drop table ARTIST
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BAND')
            and   name  = 'BANDCOUNTRY_FK'
            and   indid > 0
            and   indid < 255)
   drop index BAND.BANDCOUNTRY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BAND')
            and   type = 'U')
   drop table BAND
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANDMEMBERSHIP')
            and   name  = 'BANDMEMBERSHIP2_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANDMEMBERSHIP.BANDMEMBERSHIP2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANDMEMBERSHIP')
            and   name  = 'BANDMEMBERSHIP_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANDMEMBERSHIP.BANDMEMBERSHIP_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANDMEMBERSHIP')
            and   type = 'U')
   drop table BANDMEMBERSHIP
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHART')
            and   name  = 'COUNTRYOFCHART_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHART.COUNTRYOFCHART_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHART')
            and   type = 'U')
   drop table CHART
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('COMPOSEROFSONG')
            and   name  = 'COMPOSEROFSONG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index COMPOSEROFSONG.COMPOSEROFSONG2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('COMPOSEROFSONG')
            and   name  = 'COMPOSEROFSONG_FK'
            and   indid > 0
            and   indid < 255)
   drop index COMPOSEROFSONG.COMPOSEROFSONG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMPOSEROFSONG')
            and   type = 'U')
   drop table COMPOSEROFSONG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COUNTRY')
            and   type = 'U')
   drop table COUNTRY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DJ')
            and   type = 'U')
   drop table DJ
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DJINYEAR')
            and   name  = 'DJOFTOP200LIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index DJINYEAR.DJOFTOP200LIST_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DJINYEAR')
            and   name  = 'DJOFDJINYEAR_FK'
            and   indid > 0
            and   indid < 255)
   drop index DJINYEAR.DJOFDJINYEAR_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DJINYEAR')
            and   type = 'U')
   drop table DJINYEAR
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FEATURINGARTISTOFSONG')
            and   name  = 'FEATURINGARTISTOFSONG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index FEATURINGARTISTOFSONG.FEATURINGARTISTOFSONG2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FEATURINGARTISTOFSONG')
            and   name  = 'FEATURINGARTISTOFSONG_FK'
            and   indid > 0
            and   indid < 255)
   drop index FEATURINGARTISTOFSONG.FEATURINGARTISTOFSONG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FEATURINGARTISTOFSONG')
            and   type = 'U')
   drop table FEATURINGARTISTOFSONG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GENRE')
            and   type = 'U')
   drop table GENRE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GENREOFSONG')
            and   name  = 'GENREOFSONG2_FK'
            and   indid > 0
            and   indid < 255)
   drop index GENREOFSONG.GENREOFSONG2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('GENREOFSONG')
            and   name  = 'GENREOFSONG_FK'
            and   indid > 0
            and   indid < 255)
   drop index GENREOFSONG.GENREOFSONG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('GENREOFSONG')
            and   type = 'U')
   drop table GENREOFSONG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('LISTENER')
            and   name  = 'POSTALCODEOFLISTENER_FK'
            and   indid > 0
            and   indid < 255)
   drop index LISTENER.POSTALCODEOFLISTENER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LISTENER')
            and   type = 'U')
   drop table LISTENER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MUNICIPALITY')
            and   type = 'U')
   drop table MUNICIPALITY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PERSON')
            and   type = 'U')
   drop table PERSON
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PLACE')
            and   type = 'U')
   drop table PLACE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('POSTALCODE')
            and   name  = 'POSTALCODEPLACE_FK'
            and   indid > 0
            and   indid < 255)
   drop index POSTALCODE.POSTALCODEPLACE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('POSTALCODE')
            and   name  = 'POSTALCODEMUNICIPALITY_FK'
            and   indid > 0
            and   indid < 255)
   drop index POSTALCODE.POSTALCODEMUNICIPALITY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('POSTALCODE')
            and   type = 'U')
   drop table POSTALCODE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONG')
            and   name  = 'SONGOFARTIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONG.SONGOFARTIST_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SONG')
            and   type = 'U')
   drop table SONG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONGNOTONSTANDARDLIST')
            and   name  = 'NOTSTANDARDSONGOFVOTELIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONGNOTONSTANDARDLIST.NOTSTANDARDSONGOFVOTELIST_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SONGNOTONSTANDARDLIST')
            and   type = 'U')
   drop table SONGNOTONSTANDARDLIST
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONGOFVOTE')
            and   name  = 'SONGOFVOTE2_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONGOFVOTE.SONGOFVOTE2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONGOFVOTE')
            and   name  = 'SONGOFVOTE_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONGOFVOTE.SONGOFVOTE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SONGOFVOTE')
            and   type = 'U')
   drop table SONGOFVOTE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONGONCHART')
            and   name  = 'CHARTOFSONGONCHART_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONGONCHART.CHARTOFSONGONCHART_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONGONCHART')
            and   name  = 'SONGOFSONGONCHART_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONGONCHART.SONGOFSONGONCHART_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SONGONCHART')
            and   type = 'U')
   drop table SONGONCHART
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONGONTOP10LIST')
            and   name  = 'TOP10LISTOFSONGONTOP10LIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONGONTOP10LIST.TOP10LISTOFSONGONTOP10LIST_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SONGONTOP10LIST')
            and   name  = 'SONGOFSONGONTOP10LIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index SONGONTOP10LIST.SONGOFSONGONTOP10LIST_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SONGONTOP10LIST')
            and   type = 'U')
   drop table SONGONTOP10LIST
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TOP10LIST')
            and   name  = 'TOP2000LISTOFTOP10LIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index TOP10LIST.TOP2000LISTOFTOP10LIST_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TOP10LIST')
            and   name  = 'MUNICIPALITYOFTOP10LIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index TOP10LIST.MUNICIPALITYOFTOP10LIST_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TOP10LIST')
            and   type = 'U')
   drop table TOP10LIST
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TOP2000LIST')
            and   type = 'U')
   drop table TOP2000LIST
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TOP2000LISTENTRY')
            and   name  = 'EDITIONOFTOP2000LISTENTRY_FK'
            and   indid > 0
            and   indid < 255)
   drop index TOP2000LISTENTRY.EDITIONOFTOP2000LISTENTRY_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('TOP2000LISTENTRY')
            and   name  = 'SONGOFTOP2000LISTENTRY_FK'
            and   indid > 0
            and   indid < 255)
   drop index TOP2000LISTENTRY.SONGOFTOP2000LISTENTRY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TOP2000LISTENTRY')
            and   type = 'U')
   drop table TOP2000LISTENTRY
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VOTELIST')
            and   name  = 'TOP2000LISTVOTELIST_FK'
            and   indid > 0
            and   indid < 255)
   drop index VOTELIST.TOP2000LISTVOTELIST_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VOTELIST')
            and   name  = 'VOTELISTOFLISTENER_FK'
            and   indid > 0
            and   indid < 255)
   drop index VOTELIST.VOTELISTOFLISTENER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VOTELIST')
            and   type = 'U')
   drop table VOTELIST
go

/*==============================================================*/
/* Table: ARTIST                                                */
/*==============================================================*/
create table ARTIST (
   ARTIST_NAME          nvarchar(255)        not null,
   ARTIST_TYPE          nvarchar(255)        not null,
   constraint PK_ARTIST primary key (ARTIST_NAME)
)
go

/*==============================================================*/
/* Table: BAND                                                  */
/*==============================================================*/
create table BAND (
   ARTIST_NAME          nvarchar(255)        not null,
   COUNTRY_CODE         char(2)              not null,
   FOUNDING_YEAR        int                  not null,
   DISSOLUTION_YEAR     int                  null,
   constraint PK_BAND primary key (ARTIST_NAME)
)
go

/*==============================================================*/
/* Index: BANDCOUNTRY_FK                                        */
/*==============================================================*/




create nonclustered index BANDCOUNTRY_FK on BAND (COUNTRY_CODE ASC)
go

/*==============================================================*/
/* Table: BANDMEMBERSHIP                                        */
/*==============================================================*/
create table BANDMEMBERSHIP (
   BAND_ARTIST_NAME     nvarchar(255)        not null,
   ARTIST_NAME          nvarchar(255)        not null,
   constraint PK_BANDMEMBERSHIP primary key (BAND_ARTIST_NAME, ARTIST_NAME)
)
go

/*==============================================================*/
/* Index: BANDMEMBERSHIP_FK                                     */
/*==============================================================*/




create nonclustered index BANDMEMBERSHIP_FK on BANDMEMBERSHIP (BAND_ARTIST_NAME ASC)
go

/*==============================================================*/
/* Index: BANDMEMBERSHIP2_FK                                    */
/*==============================================================*/




create nonclustered index BANDMEMBERSHIP2_FK on BANDMEMBERSHIP (ARTIST_NAME ASC)
go

/*==============================================================*/
/* Table: CHART                                                 */
/*==============================================================*/
create table CHART (
   CHART_NAME           nvarchar(255)        not null,
   COUNTRY_CODE         char(2)              not null,
   constraint PK_CHART primary key (CHART_NAME)
)
go

/*==============================================================*/
/* Index: COUNTRYOFCHART_FK                                     */
/*==============================================================*/




create nonclustered index COUNTRYOFCHART_FK on CHART (COUNTRY_CODE ASC)
go

/*==============================================================*/
/* Table: COMPOSEROFSONG                                        */
/*==============================================================*/
create table COMPOSEROFSONG (
   SONG_ARTIST_NAME     nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   ARTIST_NAME          nvarchar(255)        not null,
   constraint PK_COMPOSEROFSONG primary key (SONG_ARTIST_NAME, SONG_NAME, ARTIST_NAME)
)
go

/*==============================================================*/
/* Index: COMPOSEROFSONG_FK                                     */
/*==============================================================*/




create nonclustered index COMPOSEROFSONG_FK on COMPOSEROFSONG (SONG_ARTIST_NAME ASC,
  SONG_NAME ASC)
go

/*==============================================================*/
/* Index: COMPOSEROFSONG2_FK                                    */
/*==============================================================*/




create nonclustered index COMPOSEROFSONG2_FK on COMPOSEROFSONG (ARTIST_NAME ASC)
go

/*==============================================================*/
/* Table: COUNTRY                                               */
/*==============================================================*/
create table COUNTRY (
   COUNTRY_CODE         char(2)              not null,
   COUNTRY_NAME         nvarchar(255)        not null,
   constraint PK_COUNTRY primary key (COUNTRY_CODE)
)
go

/*==============================================================*/
/* Table: DJ                                                    */
/*==============================================================*/
create table DJ (
   CODE                 nvarchar(255)        not null,
   FIRST_NAME           nvarchar(255)        not null,
   PREFIX               nvarchar(255)        null,
   LAST_NAME            nvarchar(255)        not null,
   constraint PK_DJ primary key (CODE)
)
go

/*==============================================================*/
/* Table: DJINYEAR                                              */
/*==============================================================*/
create table DJINYEAR (
   CODE                 nvarchar(255)        not null,
   EDITION_YEAR         int                  not null,
   START_DATETIME       datetime             not null,
   constraint PK_DJINYEAR primary key (CODE, EDITION_YEAR)
)
go

/*==============================================================*/
/* Index: DJOFDJINYEAR_FK                                       */
/*==============================================================*/




create nonclustered index DJOFDJINYEAR_FK on DJINYEAR (CODE ASC)
go

/*==============================================================*/
/* Index: DJOFTOP200LIST_FK                                     */
/*==============================================================*/




create nonclustered index DJOFTOP200LIST_FK on DJINYEAR (EDITION_YEAR ASC)
go

/*==============================================================*/
/* Table: FEATURINGARTISTOFSONG                                 */
/*==============================================================*/
create table FEATURINGARTISTOFSONG (
   SONG_ARTIST_NAME     nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   ARTIST_NAME          nvarchar(255)        not null,
   constraint PK_FEATURINGARTISTOFSONG primary key (SONG_ARTIST_NAME, SONG_NAME, ARTIST_NAME)
)
go

/*==============================================================*/
/* Index: FEATURINGARTISTOFSONG_FK                              */
/*==============================================================*/




create nonclustered index FEATURINGARTISTOFSONG_FK on FEATURINGARTISTOFSONG (SONG_ARTIST_NAME ASC,
  SONG_NAME ASC)
go

/*==============================================================*/
/* Index: FEATURINGARTISTOFSONG2_FK                             */
/*==============================================================*/




create nonclustered index FEATURINGARTISTOFSONG2_FK on FEATURINGARTISTOFSONG (ARTIST_NAME ASC)
go

/*==============================================================*/
/* Table: GENRE                                                 */
/*==============================================================*/
create table GENRE (
   GENRE_NAME           nvarchar(255)        not null,
   constraint PK_GENRE primary key (GENRE_NAME)
)
go

/*==============================================================*/
/* Table: GENREOFSONG                                           */
/*==============================================================*/
create table GENREOFSONG (
   GENRE_NAME           nvarchar(255)        not null,
   ARTIST_NAME          nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   constraint PK_GENREOFSONG primary key (GENRE_NAME, ARTIST_NAME, SONG_NAME)
)
go

/*==============================================================*/
/* Index: GENREOFSONG_FK                                        */
/*==============================================================*/




create nonclustered index GENREOFSONG_FK on GENREOFSONG (GENRE_NAME ASC)
go

/*==============================================================*/
/* Index: GENREOFSONG2_FK                                       */
/*==============================================================*/




create nonclustered index GENREOFSONG2_FK on GENREOFSONG (ARTIST_NAME ASC,
  SONG_NAME ASC)
go

/*==============================================================*/
/* Table: LISTENER                                              */
/*==============================================================*/
create table LISTENER (
   EMAIL                nvarchar(255)        not null,
   POSTAL_CODE_NUMBERS  int                  not null,
   FIRST_NAME           nvarchar(255)        not null,
   PREFIX               nvarchar(255)        null,
   LAST_NAME            nvarchar(255)        not null,
   GENDER               nvarchar(255)        not null,
   AGE_CATEGORY         nvarchar(255)        not null,
   constraint PK_LISTENER primary key (EMAIL)
)
go

/*==============================================================*/
/* Index: POSTALCODEOFLISTENER_FK                               */
/*==============================================================*/




create nonclustered index POSTALCODEOFLISTENER_FK on LISTENER (POSTAL_CODE_NUMBERS ASC)
go

/*==============================================================*/
/* Table: MUNICIPALITY                                          */
/*==============================================================*/
create table MUNICIPALITY (
   MUNICIPALITY_CODE    varchar(255)         not null,
   constraint PK_MUNICIPALITY primary key (MUNICIPALITY_CODE)
)
go

/*==============================================================*/
/* Table: PERSON                                                */
/*==============================================================*/
create table PERSON (
   ARTIST_NAME          nvarchar(255)        not null,
   BIRTH_DATE           date                 not null,
   DEATH_YEAR           int                  null,
   PERSON_NAME          nvarchar(255)        not null,
   constraint PK_PERSON primary key (ARTIST_NAME)
)
go

/*==============================================================*/
/* Table: PLACE                                                 */
/*==============================================================*/
create table PLACE (
   PLACE_CODE           varchar(255)         not null,
   constraint PK_PLACE primary key (PLACE_CODE)
)
go

/*==============================================================*/
/* Table: POSTALCODE                                            */
/*==============================================================*/
create table POSTALCODE (
   POSTAL_CODE_NUMBERS  int                  not null,
   MUNICIPALITY_CODE    varchar(255)         not null,
   PLACE_CODE           varchar(255)         not null,
   constraint PK_POSTALCODE primary key (POSTAL_CODE_NUMBERS)
)
go

/*==============================================================*/
/* Index: POSTALCODEMUNICIPALITY_FK                             */
/*==============================================================*/




create nonclustered index POSTALCODEMUNICIPALITY_FK on POSTALCODE (MUNICIPALITY_CODE ASC)
go

/*==============================================================*/
/* Index: POSTALCODEPLACE_FK                                    */
/*==============================================================*/




create nonclustered index POSTALCODEPLACE_FK on POSTALCODE (PLACE_CODE ASC)
go

/*==============================================================*/
/* Table: SONG                                                  */
/*==============================================================*/
create table SONG (
   ARTIST_NAME          nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   DURATION             time(0)              null,
   RELEASE_YEAR         int                  null,
   constraint PK_SONG primary key (ARTIST_NAME, SONG_NAME)
)
go

/*==============================================================*/
/* Index: SONGOFARTIST_FK                                       */
/*==============================================================*/




create nonclustered index SONGOFARTIST_FK on SONG (ARTIST_NAME ASC)
go

/*==============================================================*/
/* Table: SONGNOTONSTANDARDLIST                                 */
/*==============================================================*/
create table SONGNOTONSTANDARDLIST (
   SONG_ID              int                  not null,
   EMAIL                nvarchar(255)        not null,
   EDITION_YEAR         int                  not null,
   ARTIST_NAME_NOT_STANDARD nvarchar(255)        not null,
   SONG_NAME_NOT_STANDARD nvarchar(255)        not null,
   constraint PK_SONGNOTONSTANDARDLIST primary key (SONG_ID)
)
go

/*==============================================================*/
/* Index: NOTSTANDARDSONGOFVOTELIST_FK                          */
/*==============================================================*/




create nonclustered index NOTSTANDARDSONGOFVOTELIST_FK on SONGNOTONSTANDARDLIST (EMAIL ASC,
  EDITION_YEAR ASC)
go

/*==============================================================*/
/* Table: SONGOFVOTE                                            */
/*==============================================================*/
create table SONGOFVOTE (
   EMAIL                nvarchar(255)        not null,
   EDITION_YEAR         int                  not null,
   ARTIST_NAME          nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   constraint PK_SONGOFVOTE primary key (EMAIL, EDITION_YEAR, ARTIST_NAME, SONG_NAME)
)
go

/*==============================================================*/
/* Index: SONGOFVOTE_FK                                         */
/*==============================================================*/




create nonclustered index SONGOFVOTE_FK on SONGOFVOTE (EMAIL ASC,
  EDITION_YEAR ASC)
go

/*==============================================================*/
/* Index: SONGOFVOTE2_FK                                        */
/*==============================================================*/




create nonclustered index SONGOFVOTE2_FK on SONGOFVOTE (ARTIST_NAME ASC,
  SONG_NAME ASC)
go

/*==============================================================*/
/* Table: SONGONCHART                                           */
/*==============================================================*/
create table SONGONCHART (
   ARTIST_NAME          nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   CHART_NAME           nvarchar(255)        not null,
   DURATION             int                  not null,
   SEDFESFSEFSEF        int                  not null,
   constraint PK_SONGONCHART primary key (ARTIST_NAME, SONG_NAME, CHART_NAME)
)
go

/*==============================================================*/
/* Index: SONGOFSONGONCHART_FK                                  */
/*==============================================================*/




create nonclustered index SONGOFSONGONCHART_FK on SONGONCHART (ARTIST_NAME ASC,
  SONG_NAME ASC)
go

/*==============================================================*/
/* Index: CHARTOFSONGONCHART_FK                                 */
/*==============================================================*/




create nonclustered index CHARTOFSONGONCHART_FK on SONGONCHART (CHART_NAME ASC)
go

/*==============================================================*/
/* Table: SONGONTOP10LIST                                       */
/*==============================================================*/
create table SONGONTOP10LIST (
   ARTIST_NAME          nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   MUNICIPALITY_CODE    nvarchar(255)        not null,
   EDITION_YEAR         int                  not null,
   GDFDFRGDGDG          int                  not null,
   constraint PK_SONGONTOP10LIST primary key (ARTIST_NAME, SONG_NAME, MUNICIPALITY_CODE, EDITION_YEAR)
)
go

/*==============================================================*/
/* Index: SONGOFSONGONTOP10LIST_FK                              */
/*==============================================================*/




create nonclustered index SONGOFSONGONTOP10LIST_FK on SONGONTOP10LIST (ARTIST_NAME ASC,
  SONG_NAME ASC)
go

/*==============================================================*/
/* Index: TOP10LISTOFSONGONTOP10LIST_FK                         */
/*==============================================================*/




create nonclustered index TOP10LISTOFSONGONTOP10LIST_FK on SONGONTOP10LIST (MUNICIPALITY_CODE ASC,
  EDITION_YEAR ASC)
go

/*==============================================================*/
/* Table: TOP10LIST                                             */
/*==============================================================*/
create table TOP10LIST (
   MUNICIPALITY_CODE    nvarchar(255)        not null,
   EDITION_YEAR         int                  not null,
   constraint PK_TOP10LIST primary key (MUNICIPALITY_CODE, EDITION_YEAR)
)
go

/*==============================================================*/
/* Index: MUNICIPALITYOFTOP10LIST_FK                            */
/*==============================================================*/




create nonclustered index MUNICIPALITYOFTOP10LIST_FK on TOP10LIST (MUNICIPALITY_CODE ASC)
go

/*==============================================================*/
/* Index: TOP2000LISTOFTOP10LIST_FK                             */
/*==============================================================*/




create nonclustered index TOP2000LISTOFTOP10LIST_FK on TOP10LIST (EDITION_YEAR ASC)
go

/*==============================================================*/
/* Table: TOP2000LIST                                           */
/*==============================================================*/
create table TOP2000LIST (
   EDITION_YEAR         int                  not null,
   constraint PK_TOP2000LIST primary key (EDITION_YEAR)
)
go

/*==============================================================*/
/* Table: TOP2000LISTENTRY                                      */
/*==============================================================*/
create table TOP2000LISTENTRY (
   ARTIST_NAME          nvarchar(255)        not null,
   SONG_NAME            nvarchar(255)        not null,
   EDITION_YEAR         int                  not null,
   POSITION             int                  not null,
   START_DATETIME       datetime             null,
   constraint PK_TOP2000LISTENTRY primary key (ARTIST_NAME, SONG_NAME, EDITION_YEAR, POSITION)
)
go

/*==============================================================*/
/* Index: SONGOFTOP2000LISTENTRY_FK                             */
/*==============================================================*/




create nonclustered index SONGOFTOP2000LISTENTRY_FK on TOP2000LISTENTRY (ARTIST_NAME ASC,
  SONG_NAME ASC)
go

/*==============================================================*/
/* Index: EDITIONOFTOP2000LISTENTRY_FK                          */
/*==============================================================*/




create nonclustered index EDITIONOFTOP2000LISTENTRY_FK on TOP2000LISTENTRY (EDITION_YEAR ASC)
go

/*==============================================================*/
/* Table: VOTELIST                                              */
/*==============================================================*/
create table VOTELIST (
   EMAIL                nvarchar(255)        not null,
   EDITION_YEAR         int                  not null,
   constraint PK_VOTELIST primary key (EMAIL, EDITION_YEAR)
)
go

/*==============================================================*/
/* Index: VOTELISTOFLISTENER_FK                                 */
/*==============================================================*/




create nonclustered index VOTELISTOFLISTENER_FK on VOTELIST (EMAIL ASC)
go

/*==============================================================*/
/* Index: TOP2000LISTVOTELIST_FK                                */
/*==============================================================*/




create nonclustered index TOP2000LISTVOTELIST_FK on VOTELIST (EDITION_YEAR ASC)
go

alter table BAND
   add constraint FK_BAND_BANDCOUNT_COUNTRY foreign key (COUNTRY_CODE)
      references COUNTRY (COUNTRY_CODE)
go

alter table BAND
   add constraint FK_BAND_IS_A_ARTI_ARTIST foreign key (ARTIST_NAME)
      references ARTIST (ARTIST_NAME)
go

alter table BANDMEMBERSHIP
   add constraint FK_BANDMEMB_BANDMEMBE_BAND foreign key (BAND_ARTIST_NAME)
      references BAND (ARTIST_NAME)
go

alter table BANDMEMBERSHIP
   add constraint FK_BANDMEMB_BANDMEMBE_ARTIST foreign key (ARTIST_NAME)
      references ARTIST (ARTIST_NAME)
go

alter table CHART
   add constraint FK_CHART_COUNTRYOF_COUNTRY foreign key (COUNTRY_CODE)
      references COUNTRY (COUNTRY_CODE)
go

alter table COMPOSEROFSONG
   add constraint FK_COMPOSER_COMPOSERO_SONG foreign key (SONG_ARTIST_NAME, SONG_NAME)
      references SONG (ARTIST_NAME, SONG_NAME)
go

alter table COMPOSEROFSONG
   add constraint FK_COMPOSER_COMPOSERO_ARTIST foreign key (ARTIST_NAME)
      references ARTIST (ARTIST_NAME)
go

alter table DJINYEAR
   add constraint FK_DJINYEAR_DJOFDJINY_DJ foreign key (CODE)
      references DJ (CODE)
go

alter table DJINYEAR
   add constraint FK_DJINYEAR_DJOFTOP20_TOP2000L foreign key (EDITION_YEAR)
      references TOP2000LIST (EDITION_YEAR)
go

alter table FEATURINGARTISTOFSONG
   add constraint FK_FEATURIN_FEATURING_SONG foreign key (SONG_ARTIST_NAME, SONG_NAME)
      references SONG (ARTIST_NAME, SONG_NAME)
go

alter table FEATURINGARTISTOFSONG
   add constraint FK_FEATURIN_FEATURING_ARTIST foreign key (ARTIST_NAME)
      references ARTIST (ARTIST_NAME)
go

alter table GENREOFSONG
   add constraint FK_GENREOFS_GENREOFSO_GENRE foreign key (GENRE_NAME)
      references GENRE (GENRE_NAME)
go

alter table GENREOFSONG
   add constraint FK_GENREOFS_GENREOFSO_SONG foreign key (ARTIST_NAME, SONG_NAME)
      references SONG (ARTIST_NAME, SONG_NAME)
go

alter table LISTENER
   add constraint FK_LISTENER_POSTALCOD_POSTALCO foreign key (POSTAL_CODE_NUMBERS)
      references POSTALCODE (POSTAL_CODE_NUMBERS)
go

alter table PERSON
   add constraint FK_PERSON_IS_A_ARTI_ARTIST foreign key (ARTIST_NAME)
      references ARTIST (ARTIST_NAME)
go

alter table POSTALCODE
   add constraint FK_POSTALCO_POSTALCOD_MUNICIPA foreign key (MUNICIPALITY_CODE)
      references MUNICIPALITY (MUNICIPALITY_CODE)
go

alter table POSTALCODE
   add constraint FK_POSTALCO_POSTALCOD_PLACE foreign key (PLACE_CODE)
      references PLACE (PLACE_CODE)
go

alter table SONG
   add constraint FK_SONG_SONGOFART_ARTIST foreign key (ARTIST_NAME)
      references ARTIST (ARTIST_NAME)
go

alter table SONGNOTONSTANDARDLIST
   add constraint FK_SONGNOTO_NOTSTANDA_VOTELIST foreign key (EMAIL, EDITION_YEAR)
      references VOTELIST (EMAIL, EDITION_YEAR)
go

alter table SONGOFVOTE
   add constraint FK_SONGOFVO_SONGOFVOT_VOTELIST foreign key (EMAIL, EDITION_YEAR)
      references VOTELIST (EMAIL, EDITION_YEAR)
go

alter table SONGOFVOTE
   add constraint FK_SONGOFVO_SONGOFVOT_SONG foreign key (ARTIST_NAME, SONG_NAME)
      references SONG (ARTIST_NAME, SONG_NAME)
go

alter table SONGONCHART
   add constraint FK_SONGONCH_CHARTOFSO_CHART foreign key (CHART_NAME)
      references CHART (CHART_NAME)
go

alter table SONGONCHART
   add constraint FK_SONGONCH_SONGOFSON_SONG foreign key (ARTIST_NAME, SONG_NAME)
      references SONG (ARTIST_NAME, SONG_NAME)
go

alter table SONGONTOP10LIST
   add constraint FK_SONGONTO_SONGOFSON_SONG foreign key (ARTIST_NAME, SONG_NAME)
      references SONG (ARTIST_NAME, SONG_NAME)
go

alter table SONGONTOP10LIST
   add constraint FK_SONGONTO_TOP10LIST_TOP10LIS foreign key (MUNICIPALITY_CODE, EDITION_YEAR)
      references TOP10LIST (MUNICIPALITY_CODE, EDITION_YEAR)
go

alter table TOP10LIST
   add constraint FK_TOP10LIS_MUNICIPAL_MUNICIPA foreign key (MUNICIPALITY_CODE)
      references MUNICIPALITY (MUNICIPALITY_CODE)
go

alter table TOP10LIST
   add constraint FK_TOP10LIS_TOP2000LI_TOP2000L foreign key (EDITION_YEAR)
      references TOP2000LIST (EDITION_YEAR)
go

alter table TOP2000LISTENTRY
   add constraint FK_TOP2000L_EDITIONOF_TOP2000L foreign key (EDITION_YEAR)
      references TOP2000LIST (EDITION_YEAR)
go

alter table TOP2000LISTENTRY
   add constraint FK_TOP2000L_SONGOFTOP_SONG foreign key (ARTIST_NAME, SONG_NAME)
      references SONG (ARTIST_NAME, SONG_NAME)
go

alter table VOTELIST
   add constraint FK_VOTELIST_TOP2000LI_TOP2000L foreign key (EDITION_YEAR)
      references TOP2000LIST (EDITION_YEAR)
go

alter table VOTELIST
   add constraint FK_VOTELIST_VOTELISTO_LISTENER foreign key (EMAIL)
      references LISTENER (EMAIL)
go

