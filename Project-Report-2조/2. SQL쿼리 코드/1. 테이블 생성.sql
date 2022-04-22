# 지역기본정보 테이블 생성
create table 지역기본정보(
지역코드 INT not null,
광역자치단체 varchar(20) not null,
기초자치단체 varchar(20) not null,
초등학교수 int not null,
유치원수 int not null,
대학교수 int not null,
학원비율 float not null,
고령인구비율 float not null,
독거노인비율 float not null,
양로원수 int not null,
primary key(지역코드)
);

# 지역좌표정보 테이블 생성
create table 지역좌표정보(
지역코드 int not null,
위도 float not null,
경도 float not null,
primary key (지역코드),
foreign key (지역코드) references 지역기본정보 (지역코드)
);

#감염유형정보 테이블 생성
create table 감염유형정보(
소분류 varchar(20) not null,
대분류 varchar(20) not null,
primary key (소분류)
);

#연령대정보 테이블 생성
create table 연령대정보(
태어난해 int not null,
연령대 int,
primary key (태어난해)
);

#환자기본정보 테이블 생성
create table 환자기본정보(
환자ID bigint not null,
성별 varchar(20),
태어난해 int,
국적 varchar(20),
광역자치단체 varchar(20) not null,
기초자치단체 varchar(20)  not null,
기저질환여부 boolean,
감염유형 varchar(20) not null,
감염순서 int,
전염자 bigint,
접촉자수 int not null,
증상발현날짜 date,
확진날짜 date not null,
퇴원날짜 date,
사망날짜 date,
환자상태 varchar(20) not null, 
primary key (환자ID),
check (성별 = 남자 or 성별 = 여자 or 성별 = ''),
check (환자상태 = 입원 or 환자상태 = 퇴원 or 환자상태 = 사망),
foreign key (감염유형) references 감염유형정보 (소분류),
foreign key (태어난해) references 연령대정보 (태어난해)
);

#병원정보 테이블 생성
create table 병원정보(
세부주소 varchar(20) not null,
병원명 varchar(20) not null,
광역자치단체 varchar(20) not null,
기초자치단체 varchar(20) not null,
진료과수 int not null,
병상수 int not null,
primary key (병원명, 세부주소)
);

#병원전화번호 테이블 생성
create table 병원전화번호(
전화번호 varchar(20) not null,
병원명 varchar(20) not null,
primary key(전화번호),
foreign key (병원명) references 병원정보 (병원명)
);

#통행량 테이블 생성
create table 통행량(
기점_광역 varchar(20) not null,
기점_기초 varchar(20) not null,
종점_광역 varchar(20) not null,
종점_기초 varchar(20) not null,
통행량 int not null
);

#환자이동경로 테이블 생성
create table 환자이동경로(
환자ID bigint not null,
환자별순서 int not null,
날짜 date not null,
광역자치단체 varchar(20) not null,
기초자치단체 varchar(20) not null,
장소유형 varchar(20) not null,
장소위도 float not null,
장소경도 float not null,
primary key(환자ID, 환자별순서),
foreign key (환자ID) references 환자기본정보 (환자ID)
);

#감염경로라벨 테이블 생성
create table 감염경로라벨(
경로라벨링값 INT NOT NULL,
종류 VARCHAR(20) not null,
Primary key (경로라벨링값)
);

#위험라벨 테이블 생성
create table 위험라벨(
확진자수 int not null,
위험라벨링값 int not null,
primary key (확진자수)
);