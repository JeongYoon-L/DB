# update를 where 없이 사용할 때 다음 문장을 실행시키지 않으면 보호 모드에 의해 진행되지 않는다.
set sql_safe_updates = 0;

#환자기본정보 광역, 기초 -> 지역코드, 지역코드 외래키 설정
alter table 환자기본정보 add 지역코드 int;

update 환자기본정보 p
join 지역기본정보 r on r.광역자치단체 = p.광역자치단체 and r.기초자치단체 = p.기초자치단체
set p.지역코드 = r.지역코드;

alter table 환자기본정보 modify 지역코드 int not null;

alter table 환자기본정보 drop 광역자치단체;
alter table 환자기본정보 drop 기초자치단체;

alter table 환자기본정보 modify 지역코드 int after 국적;

alter table 환자기본정보 add constraint 지역코드외래키
foreign key (지역코드) references 지역기본정보(지역코드);

#병원정보 광역, 기초 -> 지역코드, 지역코드 외래키 설정

alter table 병원정보 add 지역코드 int;

update 병원정보 h 
join 지역기본정보 r  on r.광역자치단체 = h.광역자치단체 and r.기초자치단체 = h.기초자치단체
set h.지역코드 = r.지역코드;

alter table 병원정보 modify 지역코드 int not null;

alter table 병원정보 drop 광역자치단체;
alter table 병원정보 drop 기초자치단체;

alter table 병원정보 modify 지역코드 int after 병원명;

alter table 병원정보 add constraint 병원_지역코드외래키
foreign key (지역코드) references 지역기본정보(지역코드);

# 통행량 광역, 기초 -> 지역코드, 지역코드 외래키 설정 및 기본키 설정

alter table 통행량 add 기점_지역코드 int;
alter table 통행량 add 종점_지역코드 int;

update 통행량 t 
join 지역기본정보 r  on r.광역자치단체 = t.기점_광역 and r.기초자치단체 = t.기점_기초
set t.기점_지역코드 = r.지역코드;

update 통행량 t 
join 지역기본정보 r  on r.광역자치단체 = t.종점_광역 and r.기초자치단체 = t.종점_기초
set t.종점_지역코드 = r.지역코드;

alter table 통행량 modify 통행량 int after 종점_지역코드;

alter table 통행량 modify 기점_지역코드 int not null;
alter table 통행량 modify 종점_지역코드 int not null;

alter table 통행량 drop 기점_광역;
alter table 통행량 drop 기점_기초;
alter table 통행량 drop 종점_광역;
alter table 통행량 drop 종점_기초;

alter table 통행량 add
primary key (기점_지역코드, 종점_지역코드);

alter table 통행량 add constraint 기점외래키
foreign key (기점_지역코드) references 지역기본정보(지역코드);

alter table 통행량 add constraint 종점외래키
foreign key (종점_지역코드) references 지역기본정보(지역코드);

# 환자이동경로 지역코드 부여

alter table 환자이동경로 add 지역코드 int;

update 환자이동경로 m 
join 지역기본정보 r  on r.광역자치단체 = m.광역자치단체 and r.기초자치단체 = m.기초자치단체
set m.지역코드 = r.지역코드;

alter table 환자이동경로 modify 지역코드 int not null;

alter table  환자이동경로 drop 광역자치단체;
alter table  환자이동경로 drop 기초자치단체;

alter table 환자이동경로 modify 지역코드 int after 날짜;

alter table 환자이동경로 add constraint 경로_지역코드외래키
foreign key (지역코드) references 지역기본정보(지역코드);