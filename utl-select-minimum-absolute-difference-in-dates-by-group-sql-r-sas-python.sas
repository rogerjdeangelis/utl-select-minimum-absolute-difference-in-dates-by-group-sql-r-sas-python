%let pgm=utl-select-minimum-absolute-difference-in-dates-by-group-sql-r-sas-python;

%stop_submission;

Select minimum absolute difference in dates by group sql r sas python

SOLUTIONS
  1 sas sql

  2 r sql

  3 python sql (less mature than R SQL?)
    (python does not automaticaaly handle dates like R
     so you need additional non sql conversion code)

  4 sql excel matlab spss
    (not a direct soultion to this problem - you may need to edit code)
    matlab https://tinyurl.com/bded7jc6
    spss https://tinyurl.com/yrzh99mt
    excel https://tinyurl.com/4e6yaap8

PROBLEM: Small Example.
Select smallest absolute difference by id event_date

INPUT
=====              WANT
      INPUT     |  SMALLLEST
   EVENT  RECORD|  ABSOLUTE
ID  DATE   DATE |  DIFFERENCE
                |
 1   27     23  |
 1   27     25  |   *  2
 1   27     33  |
 1   27     34  |

PROCESS
=======
proc sql;
  select
    id
   ,event_date
   ,record_date
   ,abs(event_date - record_date) as dif
  from
    have
  group
    by id, event_date
  having
    abs(event_date - record_date)=
      min(abs(event_date - record_date))
;quit;

OUTPUT (same code in,
 slight difference in python)
=============================

      EVENT_    RECORD_
ID     DATE       DATE     DIF

 1      27         25       2
 1      33         33       0
 2      30         31       1
 2      35         34       1
github
https://tinyurl.com/yvtds8v4
https://github.com/rogerjdeangelis/utl-select-minimum-absolute-difference-in-dates-by-group-sql-r-sas-python

communities.sas
https://tinyurl.com/mwv86v2y
https://communities.sas.com/t5/SAS-Programming/Selecting-only-the-record-with-the-smallest-difference-between/m-p/743913#M232996

/**************************************************************************************************************************/
/*  INPUT                                    | PROCESS                                    |OUTPUT                         */
/*  =====                                    | =======                                    |======                         */
/*                   RECORD_                 | 1 SAS SQL                                  |   EVENT RECORD                */
/*  ID EVENT_DATE    DATE                    | ---------                                  |ID  DATE   DATE DIF            */
/*                                           |                                            |                               */
/*   1 1960-01-28 1960-01-24                 | proc sql;                                  | 1   27     25   2             */
/*   1 1960-01-28 1960-01-26                 |   create                                   | 1   33     33   0             */
/*   1 1960-01-28 1960-02-03                 |     table want as                          | 2   30     31   1             */
/*   1 1960-01-28 1960-02-04                 |   select                                   | 2   35     34   1             */
/*                                           |     id                                     |                               */
/*  PROCESS (same in R extra code in Python) |    ,event_date                             |                               */
/*  =======================================) |    ,record_date                            |                               */
/*  proc sql;                                |    ,abs(event_date - record_date) as dif   |                               */
/*    select                                 |   from                                     |                               */
/*      id                                   |     have                                   |                               */
/*     ,event_date                           |   group                                    |                               */
/*     ,record_date                          |     by id, event_date                      |                               */
/*     ,abs(event_date - record_date) as dif |   having                                   |                               */
/*    from                                   |     abs(event_date - record_date)=         |                               */
/*      have                                 |       min(abs(event_date - record_date))   |                               */
/*    group                                  | ;quit;                                     |                               */
/*      by id, event_date                    |                                            |                               */
/*    having                                 |                                            |                               */
/*      abs(event_date - record_date)=       |----------------------------------------------------------------------------*/
/*        min(abs(event_date - record_date)) |                                            |                               */
/*  ;quit;                                   | 2 R SQL                                    | R                             */
/*  OUTPUT                                   | -------                                    | ID EVENT_DATE RECORD_DATE DIF */
/*  ======            SMALLLEST              |                                            |  1 1960-01-28  1960-01-26   2 */
/*     EVENT  RECORD  ABSOLUTE               | proc datasets lib=sd1                      |  1 1960-02-03  1960-02-03   0 */
/*  ID  DATE   DATE   DIFFERENCE             |  nolist nodetails;                         |  2 1960-01-31  1960-02-01   1 */
/*                                           |  delete want;                              |  2 1960-02-05  1960-02-04   1 */
/*   1   27     23                           | run;quit;                                  |                               */
/*   1   27     25     *  2                  |                                            |                               */
/*   1   27     33                           | %utl_rbeginx;                              | SAS                           */
/*   1   27     34                           | parmcards4;                                |    EVENT RECORD               */
/*                                           | library(haven)                             | ID  DATE   DATE  MIN          */
/*                                           | library(sqldf)                             |                               */
/*                                           | source("c:/oto/fn_tosas9x.R")              |  1   27     25    2           */
/*  INPUT (DAYS SINCE 1/1/1960)              | options(sqldf.dll = "d:/dll/sqlean.dll")   |  1   33     33    0           */
/*  ===========================              | have<-read_sas("d:/sd1/have.sas7bdat")     |  2   30     31    1           */
/*                    SMALLLEST              | print(have)                                |  2   35     34    1           */
/*     EVENT  RECORD  ABSOLUTE               | want<-sqldf('                              |                               */
/*  ID  DATE   DATE   DIFFERENCE             |   select                                   |                               */
/*                                           |     id                                     |                               */
/*   1   27     23                           |    ,event_date                             |                               */
/*   1   27     25     *  2                  |    ,record_date                            |                               */
/*   1   27     33                           |    ,abs(event_date - record_date) as dif   |                               */
/*   1   27     34                           |   from                                     |                               */
/*                                           |     have                                   |                               */
/*   1   33     23                           |   group                                    |                               */
/*   1   33     25                           |     by id, event_date                      |                               */
/*   1   33     33     *  0                  |   having                                   |                               */
/*   1   33     34                           |     abs(event_date - record_date)=         |                               */
/*                                           |       min(abs(event_date - record_date))   |                               */
/*   2   30     27                           | ')                                         |                               */
/*   2   30     31     *  1                  | want                                       |                               */
/*   2   30     33                           | fn_tosas9x(                                |                               */
/*   2   30     34                           |       inp    = want                        |                               */
/*                                           |      ,outlib ="d:/sd1/"                    |                               */
/*   2   35     27                           |      ,outdsn ="want"                       |                               */
/*   2   35     31                           |      )                                     |                               */
/*   2   35     33                           | ;;;;                                       |                               */
/*   2   35     34     *  1                  | %utl_rendx;                                |                               */
/*   2   35     36                           |                                            |                               */
/*                                           | proc print data=sd1.want;                  |                               */
/*                                           | run;quit;                                  |                               */
/*  options validvarname=upcase;             |----------------------------------------------------------------------------*/
/*  libname sd1 "d:/sd1";                    |                                            |                               */
/*  data sd1.have;                           | 3 PYTHON SQL                               | PYTHON  EVENT  RECORD         */
/*  input id (event_date                     | ------------                               |     ID   DATE     DATE dif    */
/*          record_date) (:e8601da.);        |                                            | 0  1.0     27       25   2    */
/*  format event_date                        | %utl_pybeginx;                             | 1  1.0     33       33   0    */
/*         record_date e8601da.;             | parmcards4;                                | 2  2.0     30       31   1    */
/*  cards4;                                  | import pandas as pd                        | 3  2.0     35       34   1    */
/*  1 1960-01-28 1960-01-24                  | from datetime import datetime              |                               */
/*  1 1960-01-28 1960-01-26                  | exec(open('c:/oto/fn_pythonx.py').read()); | SAS                           */
/*  1 1960-01-28 1960-02-03                  | have,meta = ps.read_sas7bdat( \            | ID EVENT_DATE RECORD_DATE DIF */
/*  1 1960-01-28 1960-02-04                  | 'd:/sd1/have.sas7bdat');                   |  1 1960-01-28  1960-01-26   2 */
/*  1 1960-02-03 1960-01-24                  | have['EVENT_DATE']=  \                     |  1 1960-02-03  1960-02-03   0 */
/*  1 1960-02-03 1960-01-26                  | (pd.to_datetime(have['EVENT_DATE'])  \     |  2 1960-01-31  1960-02-01   1 */
/*  1 1960-02-03 1960-02-03                  | - pd.Timestamp('1960-01-01')).dt.days      |  2 1960-02-05  1960-02-04   1 */
/*  1 1960-02-03 1960-02-04                  | have['RECORD_DATE']=  \                    |                               */
/*  2 1960-01-31 1960-01-28                  | (pd.to_datetime(have['RECORD_DATE'])  \    |                               */
/*  2 1960-01-31 1960-02-01                  | - pd.Timestamp('1960-01-01')).dt.days      |                               */
/*  2 1960-01-31 1960-02-03                  | print(have)                                |                               */
/*  2 1960-01-31 1960-02-04                  | want = pdsql('''                           |                               */
/*  2 1960-02-05 1960-01-28                  |  select                                    |                               */
/*  2 1960-02-05 1960-02-01                  |    id                                      |                               */
/*  2 1960-02-05 1960-02-03                  |   ,event_date                              |                               */
/*  2 1960-02-05 1960-02-04                  |   ,record_date                             |                               */
/*  ;;;;                                     |   ,abs(event_date - record_date) as dif    |                               */
/*  run;quit;                                |  from                                      |                               */
/*                                           |    have                                    |                               */
/*                                           |  group                                     |                               */
/*                                           |    by id, event_date                       |                               */
/*                                           |  having                                    |                               */
/*                                           |    abs(event_date - record_date)=          |                               */
/*                                           |      min(abs(event_date - record_date))    |                               */
/*                                           | ''')                                       |                               */
/*                                           | print(want)                                |                               */
/*                                           |                                            |                               */
/*                                           | fn_tosas9x(want,outlib='d:/sd1/' \         |                               */
/*                                           | ,outdsn='pywant',timeest=3);               |                               */
/*                                           | ;;;;                                       |                               */
/*                                           | %utl_pyendx;                               |                               */
/*                                           |                                            |                               */
/*                                           | proc print data=sd1.pywant;                |                               */
/*                                           | format event_date record_date e8601da.;    |                               */
/*                                           | run;quit; * python not handling dates?;    |                               */
/*                                           |                                            |                               */
/*                                           |----------------------------------------------------------------------------*/
/*                                           | 4 sql excel matlab spss                    |                               */
/*                                           | -----------------------                    |                               */
/*                                           |                                            |                               */
/*                                           | (not a direct soultion to this problem)    |                               */
/*                                           | matlab https://tinyurl.com/bded7jc6        |                               */
/*                                           | spss https://tinyurl.com/yrzh99mt          |                               */
/*                                           | excel https://tinyurl.com/4e6yaap8         |                               */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
input id (event_date
        record_date) (:e8601da.);
format event_date
       record_date e8601da.;
cards4;
1 1960-01-28 1960-01-24
1 1960-01-28 1960-01-26
1 1960-01-28 1960-02-03
1 1960-01-28 1960-02-04
1 1960-02-03 1960-01-24
1 1960-02-03 1960-01-26
1 1960-02-03 1960-02-03
1 1960-02-03 1960-02-04
2 1960-01-31 1960-01-28
2 1960-01-31 1960-02-01
2 1960-01-31 1960-02-03
2 1960-01-31 1960-02-04
2 1960-02-05 1960-01-28
2 1960-02-05 1960-02-01
2 1960-02-05 1960-02-03
2 1960-02-05 1960-02-04
;;;;
run;quit;

/**************************************************************************************************************************/
/*FORMATTED             RECORD_       |  UNFORMATTED  EVENT_    RECORD                                                    */
/* ID    EVENT_DATE       DATE        |         ID     DATE       DATE                                                    */
/*                                    |                                                                                   */
/*  1    1960-01-28    1960-01-24     |          1      27         23                                                     */
/*  1    1960-01-28    1960-01-26     |          1      27         25                                                     */
/*  1    1960-01-28    1960-02-03     |          1      27         33                                                     */
/*  1    1960-01-28    1960-02-04     |          1      27         34                                                     */
/*  1    1960-02-03    1960-01-24     |          1      33         23                                                     */
/*  1    1960-02-03    1960-01-26     |          1      33         25                                                     */
/*  1    1960-02-03    1960-02-03     |          1      33         33                                                     */
/*  1    1960-02-03    1960-02-04     |          1      33         34                                                     */
/*  2    1960-01-31    1960-01-28     |          2      30         27                                                     */
/*  2    1960-01-31    1960-02-01     |          2      30         31                                                     */
/*  2    1960-01-31    1960-02-03     |          2      30         33                                                     */
/*  2    1960-01-31    1960-02-04     |          2      30         34                                                     */
/*  2    1960-02-05    1960-01-28     |          2      35         27                                                     */
/*  2    1960-02-05    1960-02-01     |          2      35         31                                                     */
/*  2    1960-02-05    1960-02-03     |          2      35         33                                                     */
/*  2    1960-02-05    1960-02-04     |          2      35         34                                                     */
/**************************************************************************************************************************/

/*             _
/ |  ___  __ _| |
| | / __|/ _` | |
| | \__ \ (_| | |
|_| |___/\__, |_|
            |_|
*/

proc datasets lib=work
 nolist nodetails;
 delete want;
run;quit;

proc sql;
  create
    table want as
  select
    id
   ,event_date
   ,record_date
   ,abs(event_date - record_date) as dif
  from
    have
  group
    by id, event_date
  having
    abs(event_date - record_date)=
      min(abs(event_date - record_date))
;quit;

/**************************************************************************************************************************/
/* FORMATTED                            |    UNFORMATTED                                                                  */
/*        EVENT_       RECORD_          |          EVENT_    RECORD_                                                      */
/* ID      DATE         DATE       DIF  |    ID     DATE       DATE     DIF                                               */
/*                                      |                                                                                 */
/*  1    28JAN1960    26JAN1960     2   |     1      27         25       2                                                */
/*  1    03FEB1960    03FEB1960     0   |     1      33         33       0                                                */
/*  2    31JAN1960    01FEB1960     1   |     2      30         31       1                                                */
/*  2    05FEB1960    04FEB1960     1   |     2      35         34       1                                                */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/
proc datasets lib=sd1
 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll = "d:/dll/sqlean.dll")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
  select
    id
   ,event_date
   ,record_date
   ,abs(event_date - record_date) as dif
  from
    have
  group
    by id, event_date
  having
    abs(event_date - record_date)=
      min(abs(event_date - record_date))
')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* > want                          |         EVENT_     RECORD_                                                           */
/*   ID EVENT_DATE RECORD_DATE dif |  D        DATE        DATE    DIF                                                    */
/*                                 |                                                                                      */
/* 1  1 1960-01-28  1960-01-26   2 |  1    01/28/60    01/26/60     2                                                     */
/* 2  1 1960-02-03  1960-02-03   0 |  1    02/03/60    02/03/60     0                                                     */
/* 3  2 1960-01-31  1960-02-01   1 |  2    01/31/60    02/01/60     1                                                     */
/* 4  2 1960-02-05  1960-02-04   1 |  2    02/05/60    02/04/60     1                                                     */
/**************************************************************************************************************************/

/*____               _   _                             _
|___ /   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
  |_ \  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 ___) | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|____/  | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
        |_|    |___/                                |_|
*/

%utl_pybeginx;
parmcards4;
import pandas as pd
from datetime import datetime
exec(open('c:/oto/fn_pythonx.py').read());
have,meta = ps.read_sas7bdat( \
'd:/sd1/have.sas7bdat');
have['EVENT_DATE']=  \
(pd.to_datetime(have['EVENT_DATE'])  \
- pd.Timestamp('1960-01-01')).dt.days
have['RECORD_DATE']=  \
(pd.to_datetime(have['RECORD_DATE'])  \
- pd.Timestamp('1960-01-01')).dt.days
print(have)
want = pdsql('''
 select
   id
  ,event_date
  ,record_date
  ,abs(event_date - record_date) as dif
 from
   have
 group
   by id, event_date
 having
   abs(event_date - record_date)=
     min(abs(event_date - record_date))
''')
print(want)

fn_tosas9x(want,outlib='d:/sd1/' \
,outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
format event_date record_date e8601da.;
run;quit; * python not handling dates?;

/**************************************************************************************************************************/
/*PYTHOM                                 | SAS                   RECORD_                                                  */
/*     ID  EVENT_DATE  RECORD_DATE  dif  |  ID    EVENT_DATE       DATE       DIF                                         */
/*                                       |                                                                                */
/* 0  1.0          27           25    2  |   1    1960-01-28    1960-01-26     2                                          */
/* 1  1.0          33           33    0  |   1    1960-02-03    1960-02-03     0                                          */
/* 2  2.0          30           31    1  |   2    1960-01-31    1960-02-01     1                                          */
/* 3  2.0          35           34    1  |   2    1960-02-05    1960-02-04     1                                          */
/**************************************************************************************************************************/

/*  _                       _                   _   _       _
| || |     _____  _____ ___| |  _ __ ___   __ _| |_| | __ _| |__   _ __  ___ _ __  _ __
| || |_   / _ \ \/ / __/ _ \ | | `_ ` _ \ / _` | __| |/ _` | `_ \ | `_ \/ __| `_ \| `_ \
|__   _| |  __/>  < (_|  __/ | | | | | | | (_| | |_| | (_| | |_) || |_) \__ \ |_) | |_) |
   |_|    \___/_/\_\___\___|_| |_| |_| |_|\__,_|\__|_|\__,_|_.__/ | .__/|___/ .__/| .__/
                                                                  |_|       |_|   |_|

matlab
https://tinyurl.com/bded7jc6
https://github.com/rogerjdeangelis/utl-randomly-pick-one-player-from-the-heat-and-suns-for-captains-sql-sas-r-python-matlab

spss
https://tinyurl.com/yrzh99mt
https://github.com/rogerjdeangelis/utl-connecting-spss-pspp-to-postgresql-sample-problem-compute-mean-weight-by-sex
https://github.com/rogerjdeangelis/utl-dropping-down-to-spss-using-the-pspp-free-clone-and-running-a-spss-linear-regression

excel
https://tinyurl.com/4e6yaap8
https://github.com/rogerjdeangelis/utl-identify-changes-in-all-variable-values-between-phase1-and-phase2-trials

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
